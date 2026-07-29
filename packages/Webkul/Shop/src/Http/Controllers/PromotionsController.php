<?php

namespace Webkul\Shop\Http\Controllers;

use Illuminate\Support\Facades\Storage;
use Symfony\Component\HttpFoundation\HeaderUtils;
use Webkul\Theme\Models\ThemeCustomization;

class PromotionsController extends Controller
{
    /**
     * Display the current promotional PDF.
     *
     * @return \Illuminate\View\View
     */
    public function index()
    {
        [, $options, $pdfPath] = $this->getCurrentPromotion();

        return view('shop::promotions.index', [
            'description' => $options['description'] ?? trans('shop::app.promotions.default-description'),
            'documentUrl' => route('shop.promotions.document', ['locale' => app()->getLocale()]),
            'downloadUrl' => route('shop.promotions.download', ['locale' => app()->getLocale()]),
            'pdfName'     => $options['pdf_name'] ?? basename($pdfPath),
            'title'       => $options['title'] ?? trans('shop::app.promotions.default-title'),
        ]);
    }

    /**
     * Display the current PDF inline.
     *
     * @return \Symfony\Component\HttpFoundation\BinaryFileResponse
     */
    public function document()
    {
        [, $options, $pdfPath] = $this->getCurrentPromotion();
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
     * Download the current PDF.
     *
     * @return \Symfony\Component\HttpFoundation\StreamedResponse
     */
    public function download()
    {
        [, $options, $pdfPath] = $this->getCurrentPromotion();
        $pdfName = basename(str_replace('\\', '/', $options['pdf_name'] ?? 'promociones.pdf'));

        return Storage::disk('private')->download($pdfPath, $pdfName, [
            'Content-Type' => 'application/pdf',
            'X-Robots-Tag' => 'noindex, nofollow',
        ]);
    }

    /**
     * Resolve the first active promotion with an available PDF.
     */
    private function getCurrentPromotion(): array
    {
        $customizations = ThemeCustomization::query()
            ->where('type', ThemeCustomization::PROMOTIONAL_PDF)
            ->where('status', 1)
            ->where('channel_id', core()->getCurrentChannel()->id)
            ->where('theme_code', core()->getCurrentChannel()->theme)
            ->orderBy('sort_order')
            ->orderByDesc('id')
            ->get();

        foreach ($customizations as $customization) {
            $localizedOptions = $customization->options ?? [];
            $optionCandidates = collect([$localizedOptions])
                ->concat($customization->translations->pluck('options'));

            foreach ($optionCandidates as $candidate) {
                $pdfPath = is_array($candidate) ? ($candidate['pdf_path'] ?? null) : null;

                if (
                    ! is_string($pdfPath)
                    || ! str_starts_with($pdfPath, 'theme/'.$customization->id.'/')
                    || ! Storage::disk('private')->exists($pdfPath)
                ) {
                    continue;
                }

                $options = $localizedOptions;
                $options['pdf_path'] = $pdfPath;
                $options['pdf_name'] = $candidate['pdf_name'] ?? basename($pdfPath);

                return [$customization, $options, $pdfPath];
            }
        }

        abort(404);
    }
}
