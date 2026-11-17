<?php

use Webkul\Shop\Http\Resources\ProductResource;

it('computes the whole-number discount shown on the sale badge', function () {
    expect(ProductResource::discountPercent(45000, 38250))->toBe(15)
        ->and(ProductResource::discountPercent(100, 66.6))->toBe(33)
        ->and(ProductResource::discountPercent(100, 100))->toBe(0)
        ->and(ProductResource::discountPercent(1000, 999))->toBe(0)
        ->and(ProductResource::discountPercent(0, 0))->toBe(0)
        ->and(ProductResource::discountPercent(null, 10))->toBe(0);
});

it('includes discount_percent in the product payload', function () {
    $product = (new \Webkul\Faker\Helpers\Product())->getSimpleProductFactory()->create();

    $item = (new ProductResource($product))->toArray(request());

    expect($item)->toHaveKey('discount_percent')
        ->and($item['discount_percent'])->toBe(0);
});
