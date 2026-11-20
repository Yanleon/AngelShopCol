<?php

use Illuminate\Support\Facades\DB;
use Webkul\Faker\Helpers\Product as ProductFaker;

use function Pest\Laravel\get;
use function Pest\Laravel\getJson;
use function Pest\Laravel\putJson;

function blackDaysAttributeId(): int
{
    return (int) DB::table('attributes')->where('code', 'black_days')->value('id');
}

function blackDaysValue(int $productId): ?int
{
    $value = DB::table('product_attribute_values')
        ->where('product_id', $productId)
        ->where('attribute_id', blackDaysAttributeId())
        ->value('boolean_value');

    return $value === null ? null : (int) $value;
}

it('has the black days switch right below featured in the settings group', function () {
    expect(blackDaysAttributeId())->toBeGreaterThan(0);

    $codes = DB::table('attribute_group_mappings as m')
        ->join('attribute_groups as g', 'g.id', '=', 'm.attribute_group_id')
        ->join('attributes as a', 'a.id', '=', 'm.attribute_id')
        ->where('g.code', 'settings')
        ->where('g.attribute_family_id', 1)
        ->orderBy('m.position')
        ->pluck('a.code')
        ->all();

    expect(array_search('black_days', $codes))->toBe(array_search('featured', $codes) + 1);
});

it('shows the black days switch on the product edit page', function () {
    $product = (new ProductFaker)->getSimpleProductFactory()->create();

    $this->loginAsAdmin();

    get(route('admin.catalog.products.edit', $product->id))
        ->assertOk()
        ->assertSee('name="black_days"', false);
});

it('saves the black days switch and filters the store listing by it', function () {
    [$flagged, $plain] = (new ProductFaker)->getSimpleProductFactory()->count(2)->create();

    $this->loginAsAdmin();

    putJson(route('admin.catalog.products.update', $flagged->id), [
        'sku'               => $flagged->sku,
        'url_key'           => $flagged->url_key,
        'short_description' => 'Short',
        'description'       => 'Description',
        'name'              => 'Black Days product',
        'price'             => 100,
        'weight'            => 1,
        'black_days'        => 1,
        // The real form always sends these switches; missing ones are saved as off.
        'status'               => 1,
        'visible_individually' => 1,
        'channel'           => core()->getCurrentChannelCode(),
        'locale'            => app()->getLocale(),
    ])->assertRedirect(route('admin.catalog.products.index'));

    expect(blackDaysValue($flagged->id))->toBe(1);

    // Browse the store as a guest, not with the admin session.
    $this->app['auth']->forgetGuards();

    $ids = getJson(route('shop.api.products.index', ['black_days' => 1, 'limit' => 100]))
        ->assertOk()
        ->collect('data')
        ->pluck('id');

    expect($ids)->toContain($flagged->id)
        ->and($ids)->not->toContain($plain->id);
});

it('offers black days as a filter key when editing a product carousel', function () {
    $theme = \Webkul\Theme\Models\ThemeCustomization::factory()->create([
        'type' => 'product_carousel',
    ]);

    $this->loginAsAdmin();

    get(route('admin.settings.themes.edit', $theme->id))
        ->assertOk()
        ->assertSee("code: 'black_days'", false);
});
