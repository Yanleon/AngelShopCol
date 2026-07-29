<?php

use Illuminate\Support\Facades\Bus;
use Webkul\Core\Jobs\UpdateCreateVisitIndex;
use Webkul\Faker\Helpers\Product as ProductFaker;
use Webkul\Sales\Models\Order;

use function Pest\Laravel\get;
use function Pest\Laravel\postJson;

beforeEach(function () {
    config([
        'cookie-consent.enabled'           => true,
        'cookie-consent.revision'          => 1,
        'services.facebook.pixel_id'       => 'test-pixel-id',
        'responsecache.enabled'            => false,
    ]);
});

it('blocks optional tracking and displays the consent dialog before a decision', function () {
    Bus::fake();

    get(route('shop.home.index'))
        ->assertOk()
        ->assertSeeText(trans('shop::app.cookie-consent.title'))
        ->assertSeeText(trans('shop::app.cookie-consent.accept-all'))
        ->assertSeeText(trans('shop::app.cookie-consent.reject-all'))
        ->assertSee('.cookie-consent-layer {', false)
        ->assertSee(':initially-open="true"', false)
        ->assertSee('window.location.reload()', false)
        ->assertDontSee('connect.facebook.net/en_US/fbevents.js', false)
        ->assertDontSee("fbq('track', 'PageView')", false);

    Bus::assertNotDispatched(UpdateCreateVisitIndex::class);
});

it('stores an encrypted HttpOnly rejection cookie and keeps tracking blocked', function () {
    Bus::fake();

    $response = postJson(route('shop.cookie_consent.store'), [
        'action' => 'reject_all',
    ])->assertOk();

    $cookieName = cookie_consent()->cookieName();
    $decryptedCookie = $response->getCookie($cookieName);
    $encryptedCookie = $response->getCookie($cookieName, false);
    $decision = json_decode($decryptedCookie->getValue(), true);

    expect($encryptedCookie->isHttpOnly())->toBeTrue()
        ->and($encryptedCookie->getSameSite())->toBe('lax')
        ->and($decision['categories'])->toBe([
            'analytics' => false,
            'marketing' => false,
        ]);

    $this->withCookie($cookieName, $decryptedCookie->getValue())
        ->get(route('shop.home.index'))
        ->assertOk()
        ->assertDontSee('connect.facebook.net/en_US/fbevents.js', false)
        ->assertSeeText(trans('shop::app.cookie-consent.reopen'));

    Bus::assertNotDispatched(UpdateCreateVisitIndex::class);
});

it('loads analytics and marketing only after accepting all cookies', function () {
    Bus::fake();

    $response = postJson(route('shop.cookie_consent.store'), [
        'action' => 'accept_all',
    ])->assertOk();

    $cookieName = cookie_consent()->cookieName();
    $decryptedCookie = $response->getCookie($cookieName);

    $this->withCookie($cookieName, $decryptedCookie->getValue())
        ->get(route('shop.home.index'))
        ->assertOk()
        ->assertSee('connect.facebook.net/en_US/fbevents.js', false)
        ->assertSee("fbq('track', 'PageView')", false);

    Bus::assertDispatched(UpdateCreateVisitIndex::class);
});

it('supports granular settings and validates malformed choices', function () {
    Bus::fake();

    postJson(route('shop.cookie_consent.store'), [
        'action' => 'custom',
    ])
        ->assertJsonValidationErrorFor('analytics')
        ->assertJsonValidationErrorFor('marketing');

    $response = postJson(route('shop.cookie_consent.store'), [
        'action'    => 'custom',
        'analytics' => true,
        'marketing' => false,
    ])->assertOk();

    $cookieName = cookie_consent()->cookieName();
    $decryptedCookie = $response->getCookie($cookieName);

    $this->withCookie($cookieName, $decryptedCookie->getValue())
        ->get(route('shop.home.index'))
        ->assertOk()
        ->assertDontSee('connect.facebook.net/en_US/fbevents.js', false);

    Bus::assertDispatched(UpdateCreateVisitIndex::class);

    postJson(route('shop.cookie_consent.store'), [
        'action' => 'invalid',
    ])->assertJsonValidationErrorFor('action');
});

it('keeps legal pages readable before the visitor makes a decision', function () {
    get(route('shop.cms.page', ['slug' => config('cookie-consent.privacy_policy_slug')]))
        ->assertOk()
        ->assertSee(':initially-open="false"', false)
        ->assertSeeText(trans('shop::app.cookie-consent.reopen'));
});

it('preserves the checkout success page across the consent reload', function () {
    $order = Order::factory()->create();

    $this->withSession([
        'order_id'   => $order->id,
        '_flash.old' => ['order_id'],
        '_flash.new' => [],
    ])->get(route('shop.checkout.onepage.success'))
        ->assertOk()
        ->assertSeeText($order->increment_id)
        ->assertDontSee("fbq('track', 'Purchase'", false);

    $response = postJson(route('shop.cookie_consent.store'), [
        'action' => 'accept_all',
    ])->assertOk();

    $cookieName = cookie_consent()->cookieName();
    $decryptedCookie = $response->getCookie($cookieName);

    $this->withCookie($cookieName, $decryptedCookie->getValue())
        ->get(route('shop.checkout.onepage.success'))
        ->assertOk()
        ->assertSeeText($order->increment_id)
        ->assertSee("fbq('track', 'Purchase'", false);

    postJson(route('shop.cookie_consent.store'), [
        'action' => 'accept_all',
    ])->assertOk();

    get(route('shop.checkout.onepage.success'))
        ->assertOk()
        ->assertDontSee("fbq('track', 'Purchase'", false);

    get(route('shop.checkout.onepage.success'))
        ->assertRedirect(route('shop.checkout.cart.index'));
});

it('honors the global privacy control signal for marketing', function () {
    $response = $this->withHeader('Sec-GPC', '1')
        ->postJson(route('shop.cookie_consent.store'), [
            'action' => 'accept_all',
        ])
        ->assertOk()
        ->assertJsonPath('categories.marketing', false);

    $cookieName = cookie_consent()->cookieName();
    $decryptedCookie = $response->getCookie($cookieName);
    $decision = json_decode($decryptedCookie->getValue(), true);

    expect($decision['categories']['marketing'])->toBeFalse();

    $this->withHeader('Sec-GPC', '1')
        ->withCookie($cookieName, $decryptedCookie->getValue())
        ->get(route('shop.home.index'))
        ->assertOk()
        ->assertDontSee('connect.facebook.net/en_US/fbevents.js', false);
});

it('renders the product marketing event in the executable script stack', function () {
    $product = (new ProductFaker())->getSimpleProductFactory()->create();
    $response = postJson(route('shop.cookie_consent.store'), [
        'action' => 'accept_all',
    ])->assertOk();

    $cookieName = cookie_consent()->cookieName();
    $decryptedCookie = $response->getCookie($cookieName);

    $this->withCookie($cookieName, $decryptedCookie->getValue())
        ->get('/'.$product->url_key)
        ->assertOk()
        ->assertSee("fbq('track', 'ViewContent'", false);
});
