<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

/**
 * Adds a "Descuento Black Days" dropdown (20% / 30% / 50%) right below the "Black Days" switch,
 * so each catalog rule can target only its own tier instead of every Black Days product
 * (several rules on the same product stack in Bagisto).
 */
return new class extends Migration
{
    const CODE = 'black_days_discount';

    const LABEL = 'Descuento Black Days';

    const OPTIONS = ['20%', '30%', '50%'];

    /**
     * Run the migrations.
     */
    public function up(): void
    {
        if (DB::table('attributes')->where('code', self::CODE)->exists()) {
            return;
        }

        DB::transaction(function () {
            $now = now();

            $locales = DB::table('locales')->pluck('code');

            $attributeId = DB::table('attributes')->insertGetId([
                'code'                => self::CODE,
                'admin_name'          => self::LABEL,
                'type'                => 'select',
                'position'            => (int) DB::table('attributes')->max('position') + 1,
                'is_required'         => 0,
                'is_unique'           => 0,
                'is_filterable'       => 0,
                'is_comparable'       => 0,
                'is_configurable'     => 0,
                'is_user_defined'     => 1,
                'is_visible_on_front' => 0,
                'value_per_locale'    => 0,
                'value_per_channel'   => 0,
                'enable_wysiwyg'      => 0,
                'created_at'          => $now,
                'updated_at'          => $now,
            ]);

            foreach ($locales as $locale) {
                DB::table('attribute_translations')->insert([
                    'attribute_id' => $attributeId,
                    'locale'       => $locale,
                    'name'         => self::LABEL,
                ]);
            }

            foreach (self::OPTIONS as $index => $label) {
                $optionId = DB::table('attribute_options')->insertGetId([
                    'attribute_id' => $attributeId,
                    'admin_name'   => $label,
                    'sort_order'   => $index + 1,
                ]);

                foreach ($locales as $locale) {
                    DB::table('attribute_option_translations')->insert([
                        'attribute_option_id' => $optionId,
                        'locale'              => $locale,
                        'label'               => $label,
                    ]);
                }
            }

            $blackDaysId = DB::table('attributes')->where('code', 'black_days')->value('id');

            // One "settings" group per attribute family: place it right below "Black Days".
            foreach (DB::table('attribute_groups')->where('code', 'settings')->pluck('id') as $groupId) {
                $anchorPosition = DB::table('attribute_group_mappings')
                    ->where('attribute_group_id', $groupId)
                    ->where('attribute_id', $blackDaysId)
                    ->value('position');

                if ($anchorPosition === null) {
                    $position = (int) DB::table('attribute_group_mappings')
                        ->where('attribute_group_id', $groupId)
                        ->max('position') + 1;
                } else {
                    DB::table('attribute_group_mappings')
                        ->where('attribute_group_id', $groupId)
                        ->where('position', '>', $anchorPosition)
                        ->increment('position');

                    $position = $anchorPosition + 1;
                }

                DB::table('attribute_group_mappings')->insert([
                    'attribute_id'       => $attributeId,
                    'attribute_group_id' => $groupId,
                    'position'           => $position,
                ]);
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        $attributeId = DB::table('attributes')->where('code', self::CODE)->value('id');

        if (! $attributeId) {
            return;
        }

        $optionIds = DB::table('attribute_options')->where('attribute_id', $attributeId)->pluck('id');

        DB::table('product_attribute_values')->where('attribute_id', $attributeId)->delete();
        DB::table('attribute_group_mappings')->where('attribute_id', $attributeId)->delete();
        DB::table('attribute_option_translations')->whereIn('attribute_option_id', $optionIds)->delete();
        DB::table('attribute_options')->where('attribute_id', $attributeId)->delete();
        DB::table('attribute_translations')->where('attribute_id', $attributeId)->delete();
        DB::table('attributes')->where('id', $attributeId)->delete();
    }
};
