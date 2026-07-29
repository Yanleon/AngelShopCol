@php
    $promotionalPdfOptions = $theme->translations->firstWhere('locale', $currentLocale->code)?->options ?? [];
    $currentPdfPath = $promotionalPdfOptions['pdf_path'] ?? null;
    $hasCurrentPdf = is_string($currentPdfPath) && Storage::disk('private')->exists($currentPdfPath);
    $currentPdfUrl = $hasCurrentPdf
        ? route('admin.settings.themes.promotional_pdf', ['id' => $theme->id, 'locale' => $currentLocale->code])
        : null;
    $promotionChannel = $channels->firstWhere('id', $theme->channel_id) ?? $currentChannel;
    $promotionHost = trim((string) ($promotionChannel->hostname ?: config('app.url')));

    if (! preg_match('#^https?://#i', $promotionHost)) {
        $promotionHost = 'https://'.$promotionHost;
    }

    if (! filter_var($promotionHost, FILTER_VALIDATE_URL)) {
        $promotionHost = config('app.url');
    }

    $publicPromotionsUrl = rtrim($promotionHost, '/').'/promociones?'.Arr::query(['locale' => $currentLocale->code]);
    $titleField = $currentLocale->code.'.options.title';
    $descriptionField = $currentLocale->code.'.options.description';
@endphp

<div class="flex flex-1 flex-col gap-4 max-xl:flex-auto">
    <div class="box-shadow rounded bg-white p-5 dark:bg-gray-900">
        <div class="flex flex-wrap items-start justify-between gap-4 border-b border-gray-200 pb-5 dark:border-gray-800">
            <div class="max-w-2xl">
                <p class="text-lg font-semibold text-gray-800 dark:text-white">
                    @lang('admin::app.settings.themes.edit.promotional-pdf.title')
                </p>

                <p class="mt-1 text-sm text-gray-500 dark:text-gray-300">
                    @lang('admin::app.settings.themes.edit.promotional-pdf.description')
                </p>
            </div>

            <a
                href="{{ $publicPromotionsUrl }}"
                target="_blank"
                class="secondary-button"
            >
                @lang('admin::app.settings.themes.edit.promotional-pdf.open-page')
            </a>
        </div>

        <div class="mt-5 grid grid-cols-2 gap-5 max-lg:grid-cols-1">
            <div class="grid content-start gap-5">
                <div>
                    <label class="required mb-1.5 block text-sm font-medium text-gray-800 dark:text-white">
                        @lang('admin::app.settings.themes.edit.promotional-pdf.page-title')
                    </label>

                    <input
                        type="text"
                        name="{{ $currentLocale->code }}[options][title]"
                        value="{{ old($titleField, $promotionalPdfOptions['title'] ?? trans('shop::app.promotions.default-title', [], $currentLocale->code)) }}"
                        maxlength="160"
                        required
                        class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm text-gray-600 transition-all hover:border-gray-400 focus:border-gray-400 dark:border-gray-800 dark:bg-gray-900 dark:text-gray-300"
                    />

                    @error($titleField)
                        <p class="mt-1 text-xs text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <div>
                    <label class="mb-1.5 block text-sm font-medium text-gray-800 dark:text-white">
                        @lang('admin::app.settings.themes.edit.promotional-pdf.page-description')
                    </label>

                    <textarea
                        name="{{ $currentLocale->code }}[options][description]"
                        rows="5"
                        maxlength="1000"
                        class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm text-gray-600 transition-all hover:border-gray-400 focus:border-gray-400 dark:border-gray-800 dark:bg-gray-900 dark:text-gray-300"
                    >{{ old($descriptionField, $promotionalPdfOptions['description'] ?? '') }}</textarea>

                    @error($descriptionField)
                        <p class="mt-1 text-xs text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <div class="rounded-lg border border-dashed border-gray-300 bg-gray-50 p-4 dark:border-gray-700 dark:bg-gray-950">
                    <label class="mb-1.5 block text-sm font-medium text-gray-800 dark:text-white">
                        @lang('admin::app.settings.themes.edit.promotional-pdf.pdf-file')
                    </label>

                    <input
                        id="promotional-pdf-file"
                        type="file"
                        name="{{ $currentLocale->code }}[options][pdf_file]"
                        accept=".pdf,application/pdf"
                        class="w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm text-gray-600 dark:border-gray-800 dark:bg-gray-900 dark:text-gray-300"
                    />

                    <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">
                        @lang('admin::app.settings.themes.edit.promotional-pdf.pdf-hint')
                    </p>

                    @error($currentLocale->code.'.options.pdf_file')
                        <p class="mt-1 text-xs text-red-600">{{ $message }}</p>
                    @enderror

                    @if ($hasCurrentPdf)
                        <div class="mt-4 flex flex-wrap items-center justify-between gap-3 rounded-md border border-gray-200 bg-white p-3 dark:border-gray-800 dark:bg-gray-900">
                            <div>
                                <p class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">
                                    @lang('admin::app.settings.themes.edit.promotional-pdf.current-file')
                                </p>

                                <p id="promotional-pdf-name" class="mt-1 break-all text-sm font-semibold text-gray-800 dark:text-white">
                                    {{ $promotionalPdfOptions['pdf_name'] ?? basename($currentPdfPath) }}
                                </p>
                            </div>

                            <a href="{{ $currentPdfUrl }}" target="_blank" class="text-sm font-semibold text-blue-600 hover:underline">
                                @lang('admin::app.settings.themes.edit.promotional-pdf.view-file')
                            </a>
                        </div>

                        <label class="mt-4 flex cursor-pointer items-center gap-2 text-sm text-red-600">
                            <input
                                id="promotional-pdf-remove"
                                type="checkbox"
                                name="{{ $currentLocale->code }}[options][remove_pdf]"
                                value="1"
                                class="h-4 w-4 rounded border-gray-300"
                            />

                            @lang('admin::app.settings.themes.edit.promotional-pdf.remove-file')
                        </label>
                    @endif
                </div>

                <div class="rounded-lg bg-blue-50 p-4 text-sm text-blue-800 dark:bg-gray-950 dark:text-blue-300">
                    <p class="font-semibold">@lang('admin::app.settings.themes.edit.promotional-pdf.public-url')</p>
                    <a href="{{ $publicPromotionsUrl }}" target="_blank" class="mt-1 block break-all underline">
                        {{ $publicPromotionsUrl }}
                    </a>
                    <p class="mt-2 text-xs">@lang('admin::app.settings.themes.edit.promotional-pdf.edit-hint')</p>
                </div>
            </div>

            <div>
                <p class="mb-2 text-sm font-semibold text-gray-800 dark:text-white">
                    @lang('admin::app.settings.themes.edit.promotional-pdf.preview')
                </p>

                <div class="overflow-hidden rounded-xl border border-gray-200 bg-gray-100 dark:border-gray-800 dark:bg-gray-950">
                    <iframe
                        id="promotional-pdf-preview"
                        src="{{ $currentPdfUrl }}"
                        title="@lang('admin::app.settings.themes.edit.promotional-pdf.preview')"
                        sandbox="allow-same-origin"
                        class="h-[640px] w-full {{ $hasCurrentPdf ? '' : 'hidden' }}"
                    ></iframe>

                    <div
                        id="promotional-pdf-empty"
                        class="{{ $hasCurrentPdf ? 'hidden' : 'flex' }} h-[640px] flex-col items-center justify-center gap-3 px-8 text-center"
                    >
                        <span class="icon-image text-6xl text-gray-300 dark:text-gray-700"></span>
                        <p class="max-w-sm text-sm text-gray-500 dark:text-gray-400">
                            @lang('admin::app.settings.themes.edit.promotional-pdf.empty-preview')
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

@pushOnce('scripts')
    <script>
        (() => {
            const initializePromotionalPdfPreview = () => {
                const fileInput = document.getElementById('promotional-pdf-file');
                const removeInput = document.getElementById('promotional-pdf-remove');
                const preview = document.getElementById('promotional-pdf-preview');
                const empty = document.getElementById('promotional-pdf-empty');
                const fileName = document.getElementById('promotional-pdf-name');
                let objectUrl = null;

                if (! fileInput || ! preview || ! empty) {
                    return;
                }

                fileInput.addEventListener('change', (event) => {
                    const file = event.target.files?.[0];

                    if (! file) {
                        return;
                    }

                    const hasPdfExtension = file.name.toLowerCase().endsWith('.pdf');
                    const hasPdfMime = ! file.type || file.type === 'application/pdf';

                    if (! hasPdfExtension || ! hasPdfMime) {
                        fileInput.value = '';
                        window.alert(@json(trans('admin::app.settings.themes.edit.promotional-pdf.invalid-pdf')));

                        return;
                    }

                    if (objectUrl) {
                        URL.revokeObjectURL(objectUrl);
                    }

                    objectUrl = URL.createObjectURL(file.slice(0, file.size, 'application/pdf'));
                    preview.src = objectUrl;
                    preview.classList.remove('hidden');
                    empty.classList.add('hidden');

                    if (fileName) {
                        fileName.textContent = file.name;
                    }

                    if (removeInput) {
                        removeInput.checked = false;
                    }
                });

                removeInput?.addEventListener('change', (event) => {
                    if (! event.target.checked) {
                        return;
                    }

                    fileInput.value = '';
                    preview.classList.add('hidden');
                    empty.classList.remove('hidden');
                });

                window.addEventListener('beforeunload', () => {
                    if (objectUrl) {
                        URL.revokeObjectURL(objectUrl);
                    }
                }, { once: true });
            };

            window.addEventListener('load', () => {
                setTimeout(initializePromotionalPdfPreview, 0);
            }, { once: true });
        })();
    </script>
@endPushOnce
