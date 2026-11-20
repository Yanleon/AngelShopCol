<?php

use Webkul\Faker\Helpers\Product as ProductFaker;

use function Pest\Laravel\get;

it('does not show a discount or savings on a configurable product without a promotion', function () {
    $product = (new ProductFaker)->getConfigurableProductFactory()->create();

    $html = get(url($product->url_key))->assertOk()->getContent();

    expect($html)->not->toContain('class="product-savings"');
});

it('does not show a discount or savings on a simple product without a promotion', function () {
    $product = (new ProductFaker)->getSimpleProductFactory()->create();

    $html = get(url($product->url_key))->assertOk()->getContent();

    expect($html)->not->toContain('class="product-savings"');
});
