<?php

use Illuminate\Support\Facades\Storage;
use Webkul\Theme\Models\ThemeCustomization;

use function Pest\Laravel\get;
use function Pest\Laravel\postJson;

it('displays the active promotional PDF page', function () {
    Storage::fake('private');

    $locale = core()->getRequestedLocaleCode();
    $theme = ThemeCustomization::factory()->create([
        'type'       => ThemeCustomization::PROMOTIONAL_PDF,
        'status'     => 1,
        'channel_id' => core()->getCurrentChannel()->id,
        'theme_code' => core()->getCurrentChannel()->theme,
    ]);
    $pdfPath = 'theme/'.$theme->id.'/promotions.pdf';

    Storage::disk('private')->put($pdfPath, '%PDF-1.4 promotional catalog');

    $theme->translateOrNew($locale)->options = [
        'title'       => 'July Promotions',
        'description' => 'Limited offers for this month.',
        'pdf_path'    => $pdfPath,
        'pdf_name'    => 'july-promotions.pdf',
    ];
    $theme->save();

    get(route('shop.promotions.index'))
        ->assertOk()
        ->assertSeeText('July Promotions')
        ->assertSeeText('Limited offers for this month.')
        ->assertSee(route('shop.promotions.document', ['locale' => $locale]), false);

    get(route('shop.promotions.document', ['locale' => $locale]))
        ->assertOk()
        ->assertHeader('Content-Type', 'application/pdf')
        ->assertHeader('X-Frame-Options', 'SAMEORIGIN');

    get(route('shop.promotions.download', ['locale' => $locale]))
        ->assertOk()
        ->assertDownload('july-promotions.pdf');
});

it('returns not found when there is no active promotional PDF', function () {
    get(route('shop.promotions.index'))->assertNotFound();
});

it('preserves the original HTTP status for unsupported methods', function () {
    postJson(route('shop.promotions.index'))->assertStatus(405);
});

it('returns not found when the configured PDF file is missing', function () {
    Storage::fake('private');

    $locale = core()->getRequestedLocaleCode();
    $theme = ThemeCustomization::factory()->create([
        'type'       => ThemeCustomization::PROMOTIONAL_PDF,
        'status'     => 1,
        'channel_id' => core()->getCurrentChannel()->id,
        'theme_code' => core()->getCurrentChannel()->theme,
    ]);

    $theme->translateOrNew($locale)->options = [
        'title'    => 'Promotions',
        'pdf_path' => 'theme/'.$theme->id.'/missing.pdf',
    ];
    $theme->save();

    get(route('shop.promotions.index'))->assertNotFound();
});

it('uses a PDF from another locale as a fallback', function () {
    Storage::fake('private');

    $requestedLocale = core()->getRequestedLocaleCode();
    $fallbackLocale = $requestedLocale === 'es' ? 'en' : 'es';

    $theme = ThemeCustomization::factory()->create([
        'type'       => ThemeCustomization::PROMOTIONAL_PDF,
        'status'     => 1,
        'channel_id' => core()->getCurrentChannel()->id,
        'theme_code' => core()->getCurrentChannel()->theme,
    ]);
    $pdfPath = 'theme/'.$theme->id.'/fallback.pdf';

    Storage::disk('private')->put($pdfPath, '%PDF-1.4 fallback catalog');

    $theme->translateOrNew($fallbackLocale)->options = [
        'title'    => 'Fallback promotions',
        'pdf_path' => $pdfPath,
        'pdf_name' => 'fallback.pdf',
    ];
    $theme->save();

    get(route('shop.promotions.index', ['locale' => $requestedLocale]))->assertOk();
    get(route('shop.promotions.document', ['locale' => $requestedLocale]))
        ->assertOk()
        ->assertHeader('Content-Type', 'application/pdf');
});
