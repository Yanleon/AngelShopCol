<?php

use Webkul\SeasonalStyle\Models\SeasonalStyle;
use Webkul\SeasonalStyle\Repositories\SeasonalStyleRepository;

use function Pest\Laravel\get;

beforeEach(function () {
    SeasonalStyle::query()->delete();

    app(SeasonalStyleRepository::class)->forgetCache();
});

it('renders the store normally when there are no seasonal styles', function () {
    get(route('shop.home.index'))->assertOk();
});

it('prints the active seasonal style css on the store', function () {
    $style = SeasonalStyle::create(['name' => 'Navidad', 'css' => '.seasonal-test-marker{color:red}']);

    app(SeasonalStyleRepository::class)->activate($style->id);

    get(route('shop.home.index'))
        ->assertOk()
        ->assertSee('.seasonal-test-marker{color:red}', false);
});
