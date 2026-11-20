<?php

use Illuminate\Support\Facades\DB;
use Webkul\CatalogRule\Models\CatalogRule;
use Webkul\Faker\Helpers\Product as ProductFaker;

function blackDaysTierOption(string $label): int
{
    return (int) DB::table('attribute_options as o')
        ->join('attributes as a', 'a.id', '=', 'o.attribute_id')
        ->where('a.code', 'black_days_discount')
        ->where('o.admin_name', $label)
        ->value('o.id');
}

function blackDaysTierRule(string $label, int $percent, int $priority): CatalogRule
{
    return CatalogRule::factory()->afterCreating(function (CatalogRule $rule) {
        $rule->channels()->sync([1]);

        $rule->customer_groups()->sync([1]);
    })->create([
        'name'            => "Black Days {$label}",
        'status'          => 1,
        'sort_order'      => $priority,
        'starts_from'     => null,
        'ends_till'       => null,
        'condition_type'  => 1,
        'conditions'      => [[
            'attribute'      => 'product|black_days_discount',
            'operator'       => '==',
            'value'          => blackDaysTierOption($label),
            'attribute_type' => 'select',
        ]],
        'action_type'     => 'by_percent',
        'discount_amount' => $percent,
        'end_other_rules' => 1,
    ]);
}

function blackDaysProduct(?string $tierLabel)
{
    $attributeIds = DB::table('attributes')->whereIn('code', ['price', 'black_days_discount'])->pluck('id', 'code');

    $attributes = [$attributeIds['price'] => 'price'];
    $values = ['price' => ['float_value' => 1000]];

    if ($tierLabel) {
        $attributes[$attributeIds['black_days_discount']] = 'black_days_discount';
        $values['black_days_discount'] = ['integer_value' => blackDaysTierOption($tierLabel)];
    }

    return (new ProductFaker([
        'attributes'      => $attributes,
        'attribute_value' => $values,
    ]))->getSimpleProductFactory()->create();
}

it('has the 20/30/50 dropdown right below the black days switch', function () {
    expect([blackDaysTierOption('20%'), blackDaysTierOption('30%'), blackDaysTierOption('50%')])
        ->each->toBeGreaterThan(0);

    $codes = DB::table('attribute_group_mappings as m')
        ->join('attribute_groups as g', 'g.id', '=', 'm.attribute_group_id')
        ->join('attributes as a', 'a.id', '=', 'm.attribute_id')
        ->where('g.code', 'settings')
        ->where('g.attribute_family_id', 1)
        ->orderBy('m.position')
        ->pluck('a.code')
        ->all();

    expect(array_search('black_days_discount', $codes))->toBe(array_search('black_days', $codes) + 1);
});

it('applies only its own tier to each product, never stacking the three rules', function () {
    blackDaysTierRule('20%', 20, 1);
    blackDaysTierRule('30%', 30, 2);
    blackDaysTierRule('50%', 50, 3);

    $prices = collect(['20%', '30%', '50%', null])->map(
        fn ($tier) => (float) blackDaysProduct($tier)->getTypeInstance()->getMinimalPrice()
    )->all();

    expect($prices)->toBe([800.0, 700.0, 500.0, 1000.0]);
});
