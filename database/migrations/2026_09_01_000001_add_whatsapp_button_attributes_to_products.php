<?php

use Carbon\Carbon;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        $now = Carbon::now();

        $showButtonId = DB::table('attributes')->insertGetId([
            'code'                => 'show_whatsapp_button',
            'admin_name'          => 'Mostrar botón de WhatsApp',
            'type'                => 'boolean',
            'position'            => 100,
            'is_required'         => 0,
            'is_unique'           => 0,
            'value_per_locale'    => 0,
            'value_per_channel'   => 0,
            'default_value'       => null,
            'is_filterable'       => 0,
            'is_configurable'     => 0,
            'is_user_defined'     => 1,
            'is_visible_on_front' => 0,
            'is_comparable'       => 0,
            'enable_wysiwyg'      => 0,
            'created_at'          => $now,
            'updated_at'          => $now,
        ]);

        $messageId = DB::table('attributes')->insertGetId([
            'code'                => 'whatsapp_message',
            'admin_name'          => 'Mensaje de WhatsApp',
            'type'                => 'text',
            'position'            => 101,
            'is_required'         => 0,
            'is_unique'           => 0,
            'value_per_locale'    => 0,
            'value_per_channel'   => 0,
            'default_value'       => null,
            'is_filterable'       => 0,
            'is_configurable'     => 0,
            'is_user_defined'     => 1,
            'is_visible_on_front' => 0,
            'is_comparable'       => 0,
            'enable_wysiwyg'      => 0,
            'created_at'          => $now,
            'updated_at'          => $now,
        ]);

        $translations = [];

        foreach (DB::table('locales')->pluck('code') as $locale) {
            $translations[] = [
                'attribute_id' => $showButtonId,
                'locale'       => $locale,
                'name'         => 'Mostrar botón de WhatsApp',
            ];

            $translations[] = [
                'attribute_id' => $messageId,
                'locale'       => $locale,
                'name'         => 'Mensaje de WhatsApp',
            ];
        }

        if (! empty($translations)) {
            DB::table('attribute_translations')->insert($translations);
        }

        $maxPosition = (int) DB::table('attribute_group_mappings')
            ->where('attribute_group_id', 1)
            ->max('position');

        DB::table('attribute_group_mappings')->insert([
            [
                'attribute_id'       => $showButtonId,
                'attribute_group_id' => 1,
                'position'           => $maxPosition + 1,
            ], [
                'attribute_id'       => $messageId,
                'attribute_group_id' => 1,
                'position'           => $maxPosition + 2,
            ],
        ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        $ids = DB::table('attributes')
            ->whereIn('code', ['show_whatsapp_button', 'whatsapp_message'])
            ->pluck('id');

        DB::table('attribute_group_mappings')->whereIn('attribute_id', $ids)->delete();
        DB::table('attribute_translations')->whereIn('attribute_id', $ids)->delete();
        DB::table('attributes')->whereIn('id', $ids)->delete();
    }
};
