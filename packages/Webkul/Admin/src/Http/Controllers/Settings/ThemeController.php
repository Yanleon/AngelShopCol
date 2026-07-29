<?php

namespace Webkul\Admin\Http\Controllers\Settings;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;
use Symfony\Component\HttpFoundation\HeaderUtils;
use Webkul\Admin\DataGrids\Theme\ThemeDataGrid;
use Webkul\Admin\Http\Controllers\Controller;
use Webkul\Theme\Models\ThemeCustomization;
use Webkul\Theme\Repositories\ThemeCustomizationRepository;

class ThemeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(public ThemeCustomizationRepository $themeCustomizationRepository) {}

    /**
     * Display a listing resource for the available tax rates.
     *
     * @return \Illuminate\View\View
     */
    public function index()
    {
        if (request()->ajax()) {
            return datagrid(ThemeDataGrid::class)->process();
        }

        return view('admin::settings.themes.index');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function store()
    {
        if (request()->has('id')) {
            $this->validate(request(), [
                core()->getRequestedLocaleCode().'.options.*.image' => 'image|extensions:jpeg,jpg,png,svg,webp',
            ]);

            $theme = $this->themeCustomizationRepository->find(request()->input('id'));

            return $this->themeCustomizationRepository->uploadImage(request()->all(), $theme);
        }

        $validated = $this->validate(request(), [
            'name'       => 'required',
            'sort_order' => 'required|numeric',
            'type'       => 'required|in:product_carousel,category_carousel,static_content,image_carousel,footer_links,services_content,footer_content,popup_widget,promotional_pdf',
            'channel_id' => 'required|in:'.implode(',', (core()->getAllChannels()->pluck('id')->toArray())),
            'theme_code' => 'required',
        ]);

        Event::dispatch('theme_customization.create.before');

        $theme = $this->themeCustomizationRepository->create($validated);

        Event::dispatch('theme_customization.create.after', $theme);

        return new JsonResponse([
            'redirect_url' => route('admin.settings.themes.edit', $theme->id),
        ]);
    }

    /**
     * Edit the theme
     *
     * @return \Illuminate\View\View
     */
    public function edit(int $id)
    {
        $theme = $this->themeCustomizationRepository->find($id);

        return view('admin::settings.themes.edit', compact('theme'));
    }

    /**
     * Update the specified resource
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(int $id)
    {
        abort_unless(bouncer()->hasPermission('settings.themes.edit'), 403);

        $theme = $this->themeCustomizationRepository->find($id);

        abort_if(! $theme, 404);

        $this->validate(request(), [
            'name'       => 'required',
            'sort_order' => 'required|numeric',
            'type'       => 'required|in:product_carousel,category_carousel,static_content,image_carousel,footer_links,services_content,footer_content,popup_widget,promotional_pdf',
            'channel_id' => 'required|in:'.implode(',', (core()->getAllChannels()->pluck('id')->toArray())),
            'locale'     => 'required|in:'.implode(',', core()->getAllLocales()->pluck('code')->toArray()),
            'theme_code' => 'required',
        ]);

        $locale = request('locale');

        // Footer content logo upload.
        $this->validate(request(), [
            $locale.'.options.logo_file' => 'nullable|image|extensions:jpeg,jpg,png,svg,webp',
        ]);

        // Popup widget banner upload.
        $this->validate(request(), [
            $locale.'.options.banner_file' => 'nullable|image|extensions:jpeg,jpg,png,svg,webp',
        ]);

        if ($theme->type === ThemeCustomization::PROMOTIONAL_PDF) {
            $this->validate(request(), [
                $locale.'.options.title'       => 'required|string|max:160',
                $locale.'.options.description' => 'nullable|string|max:1000',
                $locale.'.options.pdf_file'    => [
                    'bail',
                    'nullable',
                    'file',
                    'mimes:pdf',
                    'extensions:pdf',
                    'max:51200',
                    function ($attribute, $file, $fail) {
                        if (! ($file instanceof UploadedFile) || ! $file->isValid()) {
                            return;
                        }

                        $header = file_get_contents($file->getRealPath(), false, null, 0, 1024);

                        if (! is_string($header) || ! str_contains($header, '%PDF-')) {
                            $fail(trans('admin::app.settings.themes.edit.promotional-pdf.invalid-pdf'));
                        }
                    },
                ],
                $locale.'.options.remove_pdf'  => 'nullable|boolean',
            ]);

            $currentOptions = $theme->translations->firstWhere('locale', $locale)?->options ?? [];
            $currentPdfPath = $currentOptions['pdf_path'] ?? null;
            $hasCurrentPdf = is_string($currentPdfPath) && Storage::disk('private')->exists($currentPdfPath);
            $hasPdfInAnotherLocale = $theme->translations
                ->where('locale', '!=', $locale)
                ->contains(function ($translation) use ($theme) {
                    $path = $translation->options['pdf_path'] ?? null;

                    return is_string($path)
                        && str_starts_with($path, 'theme/'.$theme->id.'/')
                        && Storage::disk('private')->exists($path);
                });
            $removePdf = request()->boolean($locale.'.options.remove_pdf');
            $willHavePdf = request()->hasFile($locale.'.options.pdf_file')
                || ($hasCurrentPdf && ! $removePdf)
                || $hasPdfInAnotherLocale;

            if (
                request()->input('status') === 'on'
                && ! $willHavePdf
            ) {
                throw ValidationException::withMessages([
                    $locale.'.options.pdf_file' => trans('admin::app.settings.themes.edit.promotional-pdf.pdf-required'),
                ]);
            }
        }

        $data = request()->only(
            'locale',
            'type',
            'name',
            'sort_order',
            'channel_id',
            'theme_code',
            'status',
            $locale
        );

        $data['type'] = $theme->type;

        Event::dispatch('theme_customization.update.before', $id);

        $data['status'] = request()->input('status') == 'on';

        $theme = $this->themeCustomizationRepository->update($data, $id);

        Event::dispatch('theme_customization.update.after', $theme);

        session()->flash('success', trans('admin::app.settings.themes.update-success'));

        return redirect()->route('admin.settings.themes.index');
    }

    /**
     * Preview the promotional PDF for the selected locale.
     *
     * @return \Symfony\Component\HttpFoundation\BinaryFileResponse
     */
    public function viewPromotionalPdf(int $id)
    {
        abort_unless(bouncer()->hasPermission('settings.themes.edit'), 403);

        $theme = $this->themeCustomizationRepository->find($id);
        $locale = (string) request('locale', core()->getRequestedLocaleCode());

        abort_if(
            ! $theme
            || $theme->type !== ThemeCustomization::PROMOTIONAL_PDF
            || ! core()->getAllLocales()->contains('code', $locale),
            404
        );

        $options = $theme->translations->firstWhere('locale', $locale)?->options ?? [];
        $pdfPath = $options['pdf_path'] ?? null;

        abort_if(
            ! is_string($pdfPath)
            || ! str_starts_with($pdfPath, 'theme/'.$theme->id.'/')
            || ! Storage::disk('private')->exists($pdfPath),
            404
        );

        $pdfName = basename(str_replace('\\', '/', $options['pdf_name'] ?? 'promociones.pdf'));

        return response()->file(Storage::disk('private')->path($pdfPath), [
            'Cache-Control'       => 'private, no-store',
            'Content-Disposition' => HeaderUtils::makeDisposition('inline', $pdfName, 'promociones.pdf'),
            'Content-Type'        => 'application/pdf',
            'X-Frame-Options'     => 'SAMEORIGIN',
            'X-Robots-Tag'        => 'noindex, nofollow',
        ]);
    }

    /**
     * Delete a specified theme.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(int $id)
    {
        Event::dispatch('theme_customization.delete.before', $id);

        $this->themeCustomizationRepository->delete($id);

        Storage::deleteDirectory('theme/'.$id);
        Storage::disk('private')->deleteDirectory('theme/'.$id);

        Event::dispatch('theme_customization.delete.after', $id);

        return new JsonResponse([
            'message' => trans('admin::app.settings.themes.delete-success'),
        ], 200);
    }
}
