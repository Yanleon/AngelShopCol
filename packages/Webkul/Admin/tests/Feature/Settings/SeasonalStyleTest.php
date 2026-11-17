<?php

use Webkul\SeasonalStyle\Models\SeasonalStyle;
use Webkul\SeasonalStyle\Repositories\SeasonalStyleRepository;

use function Pest\Laravel\deleteJson;
use function Pest\Laravel\get;
use function Pest\Laravel\postJson;
use function Pest\Laravel\putJson;

function seasonalRepo(): SeasonalStyleRepository
{
    return app(SeasonalStyleRepository::class);
}

beforeEach(function () {
    SeasonalStyle::query()->delete();

    seasonalRepo()->forgetCache();
});

it('shows the seasonal styles index page', function () {
    $this->loginAsAdmin();

    get(route('admin.settings.seasonal_styles.index'))
        ->assertOk()
        ->assertSeeText(trans('admin::app.settings.seasonal-styles.index.title'));
});

it('requires a name when storing a style', function () {
    $this->loginAsAdmin();

    postJson(route('admin.settings.seasonal_styles.store'), [])
        ->assertJsonValidationErrorFor('name')
        ->assertUnprocessable();
});

it('stores and updates a style, inactive by default', function () {
    $this->loginAsAdmin();

    postJson(route('admin.settings.seasonal_styles.store'), [
        'name' => 'Navidad',
        'css'  => 'body { color: red; }',
    ])->assertOk();

    $style = SeasonalStyle::where('name', 'Navidad')->firstOrFail();

    expect($style->is_active)->toBeFalse();

    putJson(route('admin.settings.seasonal_styles.update'), [
        'id'   => $style->id,
        'name' => 'Navidad 2026',
        'css'  => 'body { color: green; }',
    ])->assertOk();

    expect($style->fresh()->only('name', 'css'))->toBe([
        'name' => 'Navidad 2026',
        'css'  => 'body { color: green; }',
    ]);
});

it('keeps only one style active and toggles the active one off', function () {
    $this->loginAsAdmin();

    $a = SeasonalStyle::create(['name' => 'Black Friday', 'css' => '.a{}']);
    $b = SeasonalStyle::create(['name' => 'Navidad', 'css' => '.b{}']);

    postJson(route('admin.settings.seasonal_styles.toggle', $a->id))->assertOk();
    expect(seasonalRepo()->activeCss())->toBe('.a{}');

    postJson(route('admin.settings.seasonal_styles.toggle', $b->id))->assertOk();
    expect($a->fresh()->is_active)->toBeFalse()
        ->and($b->fresh()->is_active)->toBeTrue()
        ->and(seasonalRepo()->activeCss())->toBe('.b{}');

    postJson(route('admin.settings.seasonal_styles.toggle', $b->id))->assertOk();
    expect(SeasonalStyle::where('is_active', true)->count())->toBe(0)
        ->and(seasonalRepo()->activeCss())->toBe('');
});

it('refreshes the store css when the active style is edited or deleted', function () {
    $this->loginAsAdmin();

    $style = SeasonalStyle::create(['name' => 'Amor y Amistad', 'css' => '.x{}']);

    seasonalRepo()->activate($style->id);
    expect(seasonalRepo()->activeCss())->toBe('.x{}');

    putJson(route('admin.settings.seasonal_styles.update'), [
        'id'   => $style->id,
        'name' => 'Amor y Amistad',
        'css'  => '.y{}',
    ])->assertOk();
    expect(seasonalRepo()->activeCss())->toBe('.y{}');

    deleteJson(route('admin.settings.seasonal_styles.delete', $style->id))->assertOk();
    expect(seasonalRepo()->activeCss())->toBe('');
});

it('never lets the css close the style tag', function () {
    $style = SeasonalStyle::create(['name' => 'Evil', 'css' => 'a{}</STYLE ><script>alert(1)</script>']);

    seasonalRepo()->activate($style->id);

    expect(strtolower(seasonalRepo()->activeCss()))->not->toContain('</style');
});
