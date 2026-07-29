@push('meta')
    <meta name="title" content="{{ $title }}" />
    <meta name="description" content="{{ $description }}" />
@endPush

@pushOnce('styles')
    <style>
        .promotions-page {
            background: linear-gradient(180deg, #fff7fa 0, #ffffff 420px);
            padding: 52px 24px 72px;
        }

        .promotions-page__container {
            margin: 0 auto;
            max-width: 1280px;
        }

        .promotions-page__intro {
            align-items: end;
            display: grid;
            gap: 28px;
            grid-template-columns: minmax(0, 1fr) auto;
            margin-bottom: 32px;
        }

        .promotions-page__eyebrow {
            color: #be185d;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: .16em;
            margin-bottom: 12px;
            text-transform: uppercase;
        }

        .promotions-page__title {
            color: #18181b;
            font-size: clamp(34px, 5vw, 64px);
            font-weight: 600;
            letter-spacing: -.035em;
            line-height: 1.02;
            max-width: 850px;
        }

        .promotions-page__description {
            color: #52525b;
            font-size: 17px;
            line-height: 1.7;
            margin-top: 18px;
            max-width: 760px;
        }

        .promotions-page__actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: flex-end;
        }

        .promotions-page__button {
            align-items: center;
            border: 1px solid #18181b;
            border-radius: 999px;
            display: inline-flex;
            font-size: 14px;
            font-weight: 600;
            gap: 8px;
            justify-content: center;
            min-height: 46px;
            padding: 0 20px;
            transition: background-color .2s ease, color .2s ease, transform .2s ease;
        }

        .promotions-page__button:hover {
            transform: translateY(-1px);
        }

        .promotions-page__button--primary {
            background: #18181b;
            color: #fff;
        }

        .promotions-page__button--primary:hover {
            background: #be185d;
            border-color: #be185d;
        }

        .promotions-page__button--secondary {
            background: #fff;
            color: #18181b;
        }

        .promotions-page__button--secondary:hover {
            background: #fce7f3;
            border-color: #be185d;
        }

        .promotions-viewer {
            background: #27272a;
            border: 1px solid rgba(24, 24, 27, .12);
            border-radius: 22px;
            box-shadow: 0 24px 70px rgba(39, 39, 42, .16);
            overflow: hidden;
        }

        .promotions-viewer__bar {
            align-items: center;
            color: #e4e4e7;
            display: flex;
            font-size: 13px;
            gap: 12px;
            justify-content: space-between;
            min-height: 54px;
            padding: 10px 18px;
        }

        .promotions-viewer__filename {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .promotions-viewer__frame {
            background: #f4f4f5;
            border: 0;
            display: block;
            height: 78vh;
            min-height: 680px;
            width: 100%;
        }

        .promotions-viewer__mobile {
            background: #fff;
            display: none;
            padding: 54px 24px;
            text-align: center;
        }

        .promotions-viewer__mobile-mark {
            align-items: center;
            background: #fce7f3;
            border-radius: 50%;
            color: #be185d;
            display: inline-flex;
            font-size: 30px;
            height: 72px;
            justify-content: center;
            margin-bottom: 18px;
            width: 72px;
        }

        .promotions-viewer__mobile-title {
            color: #18181b;
            font-size: 22px;
            font-weight: 600;
        }

        .promotions-viewer__mobile-text {
            color: #71717a;
            line-height: 1.6;
            margin: 10px auto 22px;
            max-width: 420px;
        }

        @media (max-width: 767px) {
            .promotions-page {
                padding: 34px 16px 48px;
            }

            .promotions-page__intro {
                align-items: start;
                grid-template-columns: 1fr;
            }

            .promotions-page__title {
                font-size: 38px;
            }

            .promotions-page__description {
                font-size: 15px;
            }

            .promotions-page__actions {
                justify-content: flex-start;
            }

            .promotions-page__button {
                flex: 1 1 160px;
            }

            .promotions-viewer {
                border-radius: 16px;
            }

            .promotions-viewer__frame {
                display: none;
            }

            .promotions-viewer__mobile {
                display: block;
            }
        }
    </style>
@endPushOnce

<x-shop::layouts :has-feature="false">
    <x-slot:title>
        {{ $title }}
    </x-slot>

    <div class="promotions-page">
        <div class="promotions-page__container">
            <header class="promotions-page__intro">
                <div>
                    <p class="promotions-page__eyebrow">@lang('shop::app.promotions.eyebrow')</p>
                    <h1 class="promotions-page__title">{{ $title }}</h1>

                    @if ($description)
                        <p class="promotions-page__description">{{ $description }}</p>
                    @endif
                </div>

                <div class="promotions-page__actions">
                    <a
                        href="{{ $documentUrl }}"
                        target="_blank"
                        rel="noopener"
                        class="promotions-page__button promotions-page__button--primary"
                    >
                        @lang('shop::app.promotions.open-pdf')
                        <span class="icon-arrow-right text-lg"></span>
                    </a>

                    <a
                        href="{{ $downloadUrl }}"
                        download="{{ $pdfName }}"
                        class="promotions-page__button promotions-page__button--secondary"
                    >
                        <span class="icon-download text-xl"></span>
                        @lang('shop::app.promotions.download-pdf')
                    </a>
                </div>
            </header>

            <section class="promotions-viewer" aria-label="@lang('shop::app.promotions.viewer-label')">
                <div class="promotions-viewer__bar">
                    <span class="promotions-viewer__filename">{{ $pdfName }}</span>
                    <span>@lang('shop::app.promotions.pdf-document')</span>
                </div>

                <iframe
                    src="{{ $documentUrl }}#toolbar=1&navpanes=0"
                    title="@lang('shop::app.promotions.viewer-label')"
                    class="promotions-viewer__frame"
                ></iframe>

                <div class="promotions-viewer__mobile">
                    <span class="promotions-viewer__mobile-mark icon-download"></span>
                    <h2 class="promotions-viewer__mobile-title">@lang('shop::app.promotions.mobile-title')</h2>
                    <p class="promotions-viewer__mobile-text">@lang('shop::app.promotions.mobile-description')</p>
                    <a
                        href="{{ $documentUrl }}"
                        target="_blank"
                        rel="noopener"
                        class="promotions-page__button promotions-page__button--primary"
                    >
                        @lang('shop::app.promotions.open-pdf')
                    </a>
                </div>
            </section>
        </div>
    </div>
</x-shop::layouts>
