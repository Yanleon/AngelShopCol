<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

/**
 * Adds a "Black Days" yes/no switch to products, next to "Nuevo" and "Destacado"
 * in the "Configuraciones" (settings) group, so a home carousel can filter by black_days=1.
 */
return new class extends Migration
{
    const CODE = 'black_days';

    const LABEL = 'Black Days';

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

            $attributeId = DB::table('attributes')->insertGetId([
                'code'                => self::CODE,
                'admin_name'          => self::LABEL,
                'type'                => 'boolean',
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

            foreach (DB::table('locales')->pluck('code') as $locale) {
                DB::table('attribute_translations')->insert([
                    'attribute_id' => $attributeId,
                    'locale'       => $locale,
                    'name'         => self::LABEL,
                ]);
            }

            $featuredId = DB::table('attributes')->where('code', 'featured')->value('id');

            // One "settings" group per attribute family.
            foreach (DB::table('attribute_groups')->where('code', 'settings')->pluck('id') as $groupId) {
                $featuredPosition = DB::table('attribute_group_mappings')
                    ->where('attribute_group_id', $groupId)
                    ->where('attribute_id', $featuredId)
                    ->value('position');

                if ($featuredPosition === null) {
                    $position = (int) DB::table('attribute_group_mappings')
                        ->where('attribute_group_id', $groupId)
                        ->max('position') + 1;
                } else {
                    // Make room right below "Destacado".
                    DB::table('attribute_group_mappings')
                        ->where('attribute_group_id', $groupId)
                        ->where('position', '>', $featuredPosition)
                        ->increment('position');

                    $position = $featuredPosition + 1;
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

        DB::table('product_attribute_values')->where('attribute_id', $attributeId)->delete();
        DB::table('attribute_group_mappings')->where('attribute_id', $attributeId)->delete();
        DB::table('attribute_translations')->where('attribute_id', $attributeId)->delete();
        DB::table('attributes')->where('id', $attributeId)->delete();
    }
};
