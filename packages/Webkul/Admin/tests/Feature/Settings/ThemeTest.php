<?php

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Webkul\Theme\Models\ThemeCustomization;

use function Pest\Laravel\deleteJson;
use function Pest\Laravel\get;
use function Pest\Laravel\post;
use function Pest\Laravel\postJson;

it('should returns the theme index page', function () {
    // Act and Assert.
    $this->loginAsAdmin();

    get(route('admin.settings.themes.index'))
        ->assertOk()
        ->assertSeeText(trans('admin::app.settings.themes.index.title'))
        ->assertSeeText(trans('admin::app.settings.themes.index.create-btn'));
});

it('should fail the validation with errors when certain field not provided when store the theme', function () {
    // Act and Assert.
    $this->loginAsAdmin();

    postJson(route('admin.settings.themes.store'))
        ->assertJsonValidationErrorFor('name')
        ->assertJsonValidationErrorFor('sort_order')
        ->assertJsonValidationErrorFor('type')
        ->assertJsonValidationErrorFor('channel_id')
        ->assertJsonValidationErrorFor('theme_code')
        ->assertUnprocessable();
});

it('should fail the validation with errors when correct type not provided when store the theme', function () {
    // Act and Assert.
    $this->loginAsAdmin();

    postJson(route('admin.settings.themes.store'), [
        'type' => 'INVALID_TYPE',
    ])
        ->assertJsonValidationErrorFor('name')
        ->assertJsonValidationErrorFor('sort_order')
        ->assertJsonValidationErrorFor('type')
        ->assertJsonValidationErrorFor('channel_id')
        ->assertJsonValidationErrorFor('theme_code')
        ->assertUnprocessable();
});

it('should store the newly created theme', function () {
    // Arrange.
    $lastThemeId = ThemeCustomization::factory()->create()->id + 1;

    // Act and Assert.
    $this->loginAsAdmin();

    postJson(route('admin.settings.themes.store'), [
        'type'       => $type = fake()->randomElement([
            'product_carousel',
            'category_carousel',
            'image_carousel',
            'footer_links',
            'services_content',
            'footer_content',
        ]),
        'name'       => $name = fake()->name(),
        'sort_order' => $lastThemeId,
        'channel_id' => $channelId = core()->getCurrentChannel()->id,
        'theme_code' => $themeCode = core()->getCurrentChannel()->theme,
    ])
        ->assertOk()
        ->assertJsonPath('redirect_url', route('admin.settings.themes.edit', $lastThemeId));

    $this->assertModelWise([
        ThemeCustomization::class => [
            [
                'id'         => $lastThemeId,
                'type'       => $type,
                'name'       => $name,
                'channel_id' => $channelId,
                'theme_code' => $themeCode,
            ],
        ],
    ]);
});

it('should allow creating a promotional PDF theme', function () {
    $lastThemeId = ThemeCustomization::factory()->create()->id + 1;

    $this->loginAsAdmin();

    postJson(route('admin.settings.themes.store'), [
        'type'       => ThemeCustomization::PROMOTIONAL_PDF,
        'name'       => 'Promotional catalog',
        'sort_order' => $lastThemeId,
        'channel_id' => core()->getCurrentChannel()->id,
        'theme_code' => core()->getCurrentChannel()->theme,
    ])
        ->assertOk()
        ->assertJsonPath('redirect_url', route('admin.settings.themes.edit', $lastThemeId));

    $this->assertDatabaseHas('theme_customizations', [
        'id'   => $lastThemeId,
        'type' => ThemeCustomization::PROMOTIONAL_PDF,
    ]);
});

it('should upload and replace the promotional PDF', function () {
    Storage::fake('private');

    $locale = core()->getRequestedLocaleCode();
    $theme = ThemeCustomization::factory()->create([
        'type' => ThemeCustomization::PROMOTIONAL_PDF,
    ]);

    $this->loginAsAdmin();

    $payload = [
        'locale'     => $locale,
        'type'       => ThemeCustomization::PROMOTIONAL_PDF,
        'name'       => 'Promotional catalog',
        'sort_order' => '1',
        'channel_id' => core()->getCurrentChannel()->id,
        'theme_code' => core()->getCurrentChannel()->theme,
        'status'     => 'on',
        $locale      => [
            'options' => [
                'title'       => 'Current promotions',
                'description' => 'Discover this month offers.',
                'pdf_file'    => UploadedFile::fake()->createWithContent(
                    'promotions-july.pdf',
                    "%PDF-1.4\n1 0 obj\n<< /Type /Catalog >>\nendobj\n%%EOF"
                ),
            ],
        ],
    ];

    post(route('admin.settings.themes.update', $theme->id), $payload)
        ->assertRedirect(route('admin.settings.themes.index'));

    $options = $theme->refresh()->translations->firstWhere('locale', $locale)->options;
    $firstPdfPath = $options['pdf_path'];

    expect($options)
        ->not->toHaveKey('pdf_file')
        ->and($options['pdf_name'])->toBe('promotions-july.pdf');

    Storage::disk('private')->assertExists($firstPdfPath);

    get(route('admin.settings.themes.promotional_pdf', [
        'id'     => $theme->id,
        'locale' => $locale,
    ]))
        ->assertOk()
        ->assertHeader('Content-Type', 'application/pdf')
        ->assertHeader('X-Frame-Options', 'SAMEORIGIN');

    $payload[$locale]['options']['pdf_file'] = UploadedFile::fake()->createWithContent(
        'promotions-august.pdf',
        "%PDF-1.4\n2 0 obj\n<< /Type /Catalog >>\nendobj\n%%EOF"
    );

    post(route('admin.settings.themes.update', $theme->id), $payload)
        ->assertRedirect(route('admin.settings.themes.index'));

    $updatedOptions = $theme->refresh()->translations->firstWhere('locale', $locale)->options;

    expect($updatedOptions['pdf_path'])->not->toBe($firstPdfPath)
        ->and($updatedOptions['pdf_name'])->toBe('promotions-august.pdf');

    Storage::disk('private')->assertMissing($firstPdfPath);
    Storage::disk('private')->assertExists($updatedOptions['pdf_path']);

    unset($payload[$locale]['options']['pdf_file']);
    $payload[$locale]['options']['remove_pdf'] = '1';

    post(route('admin.settings.themes.update', $theme->id), $payload)
        ->assertSessionHasErrors($locale.'.options.pdf_file');

    Storage::disk('private')->assertExists($updatedOptions['pdf_path']);
});

it('should reject a non PDF file from the promotional PDF editor', function () {
    Storage::fake('private');

    $locale = core()->getRequestedLocaleCode();
    $theme = ThemeCustomization::factory()->create([
        'type' => ThemeCustomization::PROMOTIONAL_PDF,
    ]);

    $this->loginAsAdmin();

    post(route('admin.settings.themes.update', $theme->id), [
        'locale'     => $locale,
        'type'       => ThemeCustomization::PROMOTIONAL_PDF,
        'name'       => 'Promotional catalog',
        'sort_order' => '1',
        'channel_id' => core()->getCurrentChannel()->id,
        'theme_code' => core()->getCurrentChannel()->theme,
        'status'     => 'on',
        $locale      => [
            'options' => [
                'title'    => 'Current promotions',
                'pdf_file' => UploadedFile::fake()->createWithContent('fake.pdf', '<script>alert(1)</script>'),
            ],
        ],
    ])->assertSessionHasErrors($locale.'.options.pdf_file');

    expect($theme->refresh()->translations)->toBeEmpty();
});

it('should reject malformed promotional PDF input without a server error', function () {
    $locale = core()->getRequestedLocaleCode();
    $theme = ThemeCustomization::factory()->create([
        'type' => ThemeCustomization::PROMOTIONAL_PDF,
    ]);

    $this->loginAsAdmin();

    post(route('admin.settings.themes.update', $theme->id), [
        'locale'     => $locale,
        'type'       => ThemeCustomization::PROMOTIONAL_PDF,
        'name'       => 'Promotional catalog',
        'sort_order' => '1',
        'channel_id' => core()->getCurrentChannel()->id,
        'theme_code' => core()->getCurrentChannel()->theme,
        'status'     => 'on',
        $locale      => [
            'options' => [
                'title'    => 'Current promotions',
                'pdf_file' => 'not-a-file',
            ],
        ],
    ])->assertSessionHasErrors($locale.'.options.pdf_file');
});

it('should fail the validation with errors when correct type not provided when update the theme', function () {
    // Arrange.
    $theme = ThemeCustomization::factory()->create();

    // Act and Assert.
    $this->loginAsAdmin();

    postJson(route('admin.settings.themes.update', $theme->id))
        ->assertJsonValidationErrorFor('name')
        ->assertJsonValidationErrorFor('sort_order')
        ->assertJsonValidationErrorFor('type')
        ->assertJsonValidationErrorFor('channel_id')
        ->assertJsonValidationErrorFor('theme_code')
        ->assertUnprocessable();
});

it('should update the theme customizations', function () {
    $theme = ThemeCustomization::factory()->create();

    $data = [];

    switch ($theme->type) {
        case ThemeCustomization::PRODUCT_CAROUSEL:
            $data[app()->getLocale()] = [
                'options' => [
                    'title'   => fake()->title(),
                    'filters' => [
                        'sort'  => 'name-desc',
                        'limit' => '12',
                        'new'   => '1',
                    ],
                ],
            ];

            break;

        case ThemeCustomization::CATEGORY_CAROUSEL:
            $data[app()->getLocale()] = [
                'options' => [
                    'title'   => fake()->title(),
                    'filters' => [
                        'sort'      => 'desc',
                        'limit'     => '10',
                        'parent_id' => '1',
                    ],
                ],
            ];

            break;

        case ThemeCustomization::IMAGE_CAROUSEL:
            $data[app()->getLocale()] = [
                'options' => [
                    [
                        'title' => fake()->title(),
                        'link'  => fake()->url(),
                        'image' => UploadedFile::fake()->image(fake()->word().'.png', 640, 480, 'png'),
                    ],
                ],
            ];

            break;

        case ThemeCustomization::FOOTER_LINKS:
            $data[app()->getLocale()] = [
                'options' => [
                    'column_1' => [
                        [
                            'url'        => fake()->url(),
                            'title'      => fake()->title(),
                            'sort_order' => '1',
                        ],
                    ],
                ],
            ];

            break;

        case ThemeCustomization::SERVICES_CONTENT:
            $data[app()->getLocale()] = [
                'options' => [
                    [
                        'title'        => fake()->title(),
                        'description'  => fake()->paragraph(),
                        'service_icon' => 'icon-truck',
                    ],
                ],
            ];

            break;

        case ThemeCustomization::FOOTER_CONTENT:
            $data[app()->getLocale()] = [
                'options' => [
                    'show_logo'       => '1',
                    'about_heading'   => fake()->sentence(3),
                    'about_text'      => fake()->sentence(12),
                    'show_contacts'   => '1',
                    'contacts'        => [
                        [
                            'label'      => 'Email',
                            'value'      => fake()->email(),
                            'url'        => 'mailto:'.fake()->email(),
                            'sort_order' => '1',
                        ],
                    ],
                    'show_links'      => '1',
                    'show_newsletter' => '1',
                    'show_social'     => '1',
                    'bottom_text'     => 'Copyright',
                ],
            ];

            break;
    }

    $data['locale'] = app()->getLocale();
    $data['type'] = $theme->type;
    $data['name'] = $name = fake()->name();
    $data['sort_order'] = '1';
    $data['channel_id'] = core()->getCurrentChannel()->id;
    $data['theme_code'] = core()->getCurrentChannel()->theme;
    $data['status'] = 'on';

    // Act and Assert.
    $this->loginAsAdmin();

    postJson(route('admin.settings.themes.update', $theme->id), $data)
        ->assertRedirect(route('admin.settings.themes.index'))
        ->isRedirection();

    $this->assertModelWise([
        ThemeCustomization::class => [
            [
                'id'   => $theme->id,
                'type' => $theme->type,
                'name' => $name,
            ],
        ],
    ]);
});

it('should delete the theme', function () {
    // Arrange.
    $theme = ThemeCustomization::factory()->create();

    // Act and Assert.
    $this->loginAsAdmin();

    deleteJson(route('admin.settings.themes.delete', $theme->id))
        ->assertOk()
        ->assertJsonPath('message', trans('admin::app.settings.themes.delete-success'));

    $this->assertDatabaseMissing('theme_customizations', [
        'id' => $theme->id,
    ]);

    $this->assertDatabaseMissing('theme_customization_translations', [
        'theme_customization_id' => $theme->id,
    ]);
});
