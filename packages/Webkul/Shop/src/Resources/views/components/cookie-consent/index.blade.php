@props(['stylesOnly' => false])

@if (config('cookie-consent.enabled'))
    @unless ($stylesOnly)
        @php
            $cookieDecision = cookie_consent()->decision();
            $initialCookiePreferences = [
                'analytics' => (bool) ($cookieDecision['analytics'] ?? false),
                'marketing' => (bool) ($cookieDecision['marketing'] ?? false),
            ];
            $isLegalPage = request()->routeIs('shop.cms.page')
                && in_array(request()->route('slug'), [
                    config('cookie-consent.privacy_policy_slug'),
                    config('cookie-consent.terms_slug'),
                ]);
        @endphp

        <v-cookie-consent
            :has-decision="@json(cookie_consent()->hasDecision())"
            :initially-open="@json(! cookie_consent()->hasDecision() && ! $isLegalPage)"
            :initial-preferences='@json($initialCookiePreferences)'
            save-url="{{ route('shop.cookie_consent.store') }}"
            csrf-token="{{ csrf_token() }}"
        ></v-cookie-consent>

        <noscript>
            <div class="cookie-consent-noscript">
                @lang('shop::app.cookie-consent.noscript')
            </div>
        </noscript>
    @endunless

    @pushOnce('styles')
        <style>
            [v-cloak] {
                display: none !important;
            }

            html.cookie-consent-is-open {
                overflow: hidden;
            }

            .cookie-consent-layer {
                align-items: center;
                background: rgba(17, 24, 39, .42);
                display: flex;
                inset: 0;
                justify-content: center;
                padding: 20px;
                position: fixed;
                z-index: 100000;
            }

            .cookie-consent-card {
                background: #fff;
                border: 1px solid rgba(15, 23, 42, .08);
                border-radius: 18px;
                box-shadow: 0 28px 80px rgba(15, 23, 42, .25);
                color: #1f2937;
                max-height: calc(100vh - 40px);
                max-width: 680px;
                overflow-y: auto;
                position: relative;
                width: 100%;
            }

            .cookie-consent-header {
                display: flex;
                gap: 16px;
                padding: 26px 28px 18px;
            }

            .cookie-consent-mark {
                background: #f3e8ff;
                border-radius: 50%;
                flex: 0 0 46px;
                height: 46px;
                position: relative;
                width: 46px;
            }

            .cookie-consent-mark::before {
                background: var(--theme-button, #7c3aed);
                border-radius: 50%;
                box-shadow: 13px 4px 0 -2px var(--theme-button, #7c3aed), 5px 15px 0 -3px var(--theme-button, #7c3aed);
                content: '';
                height: 8px;
                left: 11px;
                position: absolute;
                top: 10px;
                width: 8px;
            }

            .cookie-consent-title {
                color: #111827;
                font-size: 21px;
                font-weight: 700;
                line-height: 1.25;
                margin: 0;
            }

            .cookie-consent-copy {
                color: #596273;
                font-size: 14px;
                line-height: 1.65;
                margin: 8px 0 0;
            }

            .cookie-consent-close {
                align-items: center;
                background: transparent;
                border: 0;
                color: #6b7280;
                cursor: pointer;
                display: flex;
                font-size: 28px;
                height: 40px;
                justify-content: center;
                line-height: 1;
                position: absolute;
                right: 12px;
                top: 10px;
                width: 40px;
            }

            .cookie-consent-actions {
                border-top: 1px solid #e5e7eb;
                display: grid;
                gap: 10px;
                grid-template-columns: 1fr 1fr;
                padding: 18px 28px 12px;
            }

            .cookie-consent-action {
                align-items: center;
                border: 1px solid #d1d5db;
                border-radius: 11px;
                cursor: pointer;
                display: inline-flex;
                font-size: 14px;
                font-weight: 700;
                justify-content: center;
                min-height: 48px;
                padding: 10px 16px;
                transition: transform .2s ease, box-shadow .2s ease, background-color .2s ease;
            }

            .cookie-consent-action:hover {
                transform: translateY(-1px);
            }

            .cookie-consent-action:focus-visible,
            .cookie-consent-close:focus-visible,
            .cookie-consent-reopen:focus-visible {
                outline: 3px solid rgba(124, 58, 237, .3);
                outline-offset: 2px;
            }

            .cookie-consent-action--primary {
                background: var(--theme-button, #7c3aed);
                border-color: var(--theme-button, #7c3aed);
                color: #fff;
            }

            .cookie-consent-action--secondary {
                background: #fff;
                color: #1f2937;
            }

            .cookie-consent-action--settings {
                background: #eef2f5;
                border-color: #eef2f5;
                color: #26313f;
                grid-column: 1 / -1;
            }

            .cookie-consent-footer {
                align-items: center;
                background: #f8fafc;
                display: flex;
                flex-wrap: wrap;
                gap: 12px 24px;
                justify-content: center;
                padding: 12px 24px 14px;
            }

            .cookie-consent-footer a {
                color: #596273;
                font-size: 12px;
                font-weight: 600;
                text-decoration: none;
            }

            .cookie-consent-footer a:hover {
                text-decoration: underline;
            }

            .cookie-consent-settings {
                padding: 24px 28px 8px;
            }

            .cookie-consent-settings__back {
                background: transparent;
                border: 0;
                color: var(--theme-link, #1b4db3);
                cursor: pointer;
                font-size: 13px;
                font-weight: 700;
                margin-bottom: 14px;
                padding: 0;
            }

            .cookie-consent-category {
                align-items: flex-start;
                border-top: 1px solid #e5e7eb;
                display: flex;
                gap: 18px;
                justify-content: space-between;
                padding: 18px 0;
            }

            .cookie-consent-category:first-of-type {
                margin-top: 18px;
            }

            .cookie-consent-category__title {
                color: #111827;
                font-size: 15px;
                font-weight: 700;
                margin: 0;
            }

            .cookie-consent-category__copy {
                color: #6b7280;
                font-size: 13px;
                line-height: 1.55;
                margin: 5px 0 0;
                max-width: 470px;
            }

            .cookie-consent-toggle {
                flex: 0 0 auto;
                height: 26px;
                position: relative;
                width: 46px;
            }

            .cookie-consent-toggle input {
                height: 1px;
                opacity: 0;
                position: absolute;
                width: 1px;
            }

            .cookie-consent-toggle__track {
                background: #d1d5db;
                border-radius: 999px;
                cursor: pointer;
                inset: 0;
                position: absolute;
                transition: background-color .2s ease;
            }

            .cookie-consent-toggle__track::after {
                background: #fff;
                border-radius: 50%;
                box-shadow: 0 1px 4px rgba(0, 0, 0, .2);
                content: '';
                height: 20px;
                left: 3px;
                position: absolute;
                top: 3px;
                transition: transform .2s ease;
                width: 20px;
            }

            .cookie-consent-toggle input:checked + .cookie-consent-toggle__track {
                background: var(--theme-button, #7c3aed);
            }

            .cookie-consent-toggle input:checked + .cookie-consent-toggle__track::after {
                transform: translateX(20px);
            }

            .cookie-consent-toggle input:focus-visible + .cookie-consent-toggle__track {
                outline: 3px solid rgba(124, 58, 237, .3);
                outline-offset: 2px;
            }

            .cookie-consent-toggle input:disabled + .cookie-consent-toggle__track {
                cursor: not-allowed;
                opacity: .65;
            }

            .cookie-consent-settings__save {
                padding: 4px 28px 22px;
            }

            .cookie-consent-settings__save .cookie-consent-action {
                width: 100%;
            }

            .cookie-consent-error {
                color: #b91c1c;
                font-size: 13px;
                margin: 0 28px 14px;
                text-align: center;
            }

            .cookie-consent-reopen {
                align-items: center;
                background: #fff;
                border: 1px solid #d1d5db;
                border-radius: 999px;
                bottom: 16px;
                box-shadow: 0 8px 24px rgba(15, 23, 42, .14);
                color: #283444;
                cursor: pointer;
                display: inline-flex;
                font-size: 12px;
                font-weight: 700;
                gap: 7px;
                left: 16px;
                min-height: 42px;
                padding: 8px 14px;
                position: fixed;
                z-index: 99990;
            }

            .cookie-consent-reopen__dot {
                background: var(--theme-button, #7c3aed);
                border-radius: 50%;
                height: 9px;
                width: 9px;
            }

            .cookie-consent-noscript {
                background: #fff7ed;
                border-bottom: 1px solid #fed7aa;
                color: #9a3412;
                font-size: 13px;
                padding: 10px 16px;
                text-align: center;
            }

            @media (max-width: 640px) {
                .cookie-consent-layer {
                    align-items: flex-end;
                    padding: 0;
                }

                .cookie-consent-card {
                    border-bottom-left-radius: 0;
                    border-bottom-right-radius: 0;
                    max-height: 92vh;
                    max-width: none;
                }

                .cookie-consent-header {
                    padding: 24px 20px 17px;
                }

                .cookie-consent-mark {
                    display: none;
                }

                .cookie-consent-title {
                    font-size: 19px;
                    padding-right: 28px;
                }

                .cookie-consent-actions {
                    grid-template-columns: 1fr;
                    padding: 16px 20px 12px;
                }

                .cookie-consent-action--settings {
                    grid-column: auto;
                }

                .cookie-consent-footer {
                    gap: 9px 18px;
                }

                .cookie-consent-settings {
                    padding: 22px 20px 6px;
                }

                .cookie-consent-settings__save {
                    padding: 4px 20px 20px;
                }

                .cookie-consent-category__copy {
                    max-width: 260px;
                }

                .cookie-consent-reopen {
                    bottom: 12px;
                    left: 12px;
                }
            }
        </style>
    @endPushOnce

    @unless ($stylesOnly)
        @pushOnce('scripts')
        <script type="text/x-template" id="v-cookie-consent-template">
            <div v-cloak>
                <div
                    v-if="isOpen"
                    class="cookie-consent-layer"
                    role="presentation"
                >
                    <section
                        ref="dialog"
                        class="cookie-consent-card"
                        role="dialog"
                        aria-modal="true"
                        :aria-labelledby="showSettings ? 'cookie-settings-title' : 'cookie-consent-title'"
                    >
                        <button
                            type="button"
                            class="cookie-consent-close"
                            aria-label="@lang('shop::app.cookie-consent.close')"
                            @click="close"
                        >
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <template v-if="! showSettings">
                            <header class="cookie-consent-header">
                                <span class="cookie-consent-mark" aria-hidden="true"></span>

                                <div>
                                    <h2 id="cookie-consent-title" class="cookie-consent-title">
                                        @lang('shop::app.cookie-consent.title')
                                    </h2>

                                    <p class="cookie-consent-copy">
                                        @lang('shop::app.cookie-consent.description')
                                    </p>
                                </div>
                            </header>

                            <div class="cookie-consent-actions">
                                <button
                                    ref="acceptButton"
                                    type="button"
                                    class="cookie-consent-action cookie-consent-action--primary"
                                    :disabled="isSaving"
                                    @click="acceptAll"
                                >
                                    @lang('shop::app.cookie-consent.accept-all')
                                </button>

                                <button
                                    type="button"
                                    class="cookie-consent-action cookie-consent-action--secondary"
                                    :disabled="isSaving"
                                    @click="rejectAll"
                                >
                                    @lang('shop::app.cookie-consent.reject-all')
                                </button>

                                <button
                                    type="button"
                                    class="cookie-consent-action cookie-consent-action--settings"
                                    :disabled="isSaving"
                                    @click="openSettings"
                                >
                                    @lang('shop::app.cookie-consent.settings')
                                </button>
                            </div>
                        </template>

                        <template v-else>
                            <div class="cookie-consent-settings">
                                <button
                                    ref="backButton"
                                    type="button"
                                    class="cookie-consent-settings__back"
                                    @click="closeSettings"
                                >
                                    @lang('shop::app.cookie-consent.back')
                                </button>

                                <h2 id="cookie-settings-title" class="cookie-consent-title">
                                    @lang('shop::app.cookie-consent.settings-title')
                                </h2>

                                <p class="cookie-consent-copy">
                                    @lang('shop::app.cookie-consent.settings-description')
                                </p>

                                <div class="cookie-consent-category">
                                    <div>
                                        <h3 class="cookie-consent-category__title">@lang('shop::app.cookie-consent.necessary-title')</h3>
                                        <p class="cookie-consent-category__copy">@lang('shop::app.cookie-consent.necessary-description')</p>
                                    </div>

                                    <label class="cookie-consent-toggle">
                                        <input type="checkbox" checked disabled>
                                        <span class="cookie-consent-toggle__track" aria-hidden="true"></span>
                                        <span class="sr-only">@lang('shop::app.cookie-consent.always-active')</span>
                                    </label>
                                </div>

                                <div class="cookie-consent-category">
                                    <div>
                                        <h3 class="cookie-consent-category__title">@lang('shop::app.cookie-consent.analytics-title')</h3>
                                        <p class="cookie-consent-category__copy">@lang('shop::app.cookie-consent.analytics-description')</p>
                                    </div>

                                    <label class="cookie-consent-toggle">
                                        <input
                                            ref="analyticsToggle"
                                            type="checkbox"
                                            v-model="preferences.analytics"
                                            aria-label="@lang('shop::app.cookie-consent.analytics-title')"
                                        >
                                        <span class="cookie-consent-toggle__track" aria-hidden="true"></span>
                                    </label>
                                </div>

                                <div class="cookie-consent-category">
                                    <div>
                                        <h3 class="cookie-consent-category__title">@lang('shop::app.cookie-consent.marketing-title')</h3>
                                        <p class="cookie-consent-category__copy">@lang('shop::app.cookie-consent.marketing-description')</p>
                                    </div>

                                    <label class="cookie-consent-toggle">
                                        <input
                                            type="checkbox"
                                            v-model="preferences.marketing"
                                            aria-label="@lang('shop::app.cookie-consent.marketing-title')"
                                        >
                                        <span class="cookie-consent-toggle__track" aria-hidden="true"></span>
                                    </label>
                                </div>
                            </div>

                            <div class="cookie-consent-settings__save">
                                <button
                                    ref="saveButton"
                                    type="button"
                                    class="cookie-consent-action cookie-consent-action--primary"
                                    :disabled="isSaving"
                                    @click="saveCustom"
                                >
                                    @lang('shop::app.cookie-consent.save-settings')
                                </button>
                            </div>
                        </template>

                        <p v-if="errorMessage" class="cookie-consent-error" role="alert">
                            @{{ errorMessage }}
                        </p>

                        <footer class="cookie-consent-footer">
                            <a href="{{ route('shop.cms.page', ['slug' => config('cookie-consent.privacy_policy_slug')]) }}">
                                @lang('shop::app.cookie-consent.privacy-policy')
                            </a>

                            <a href="{{ route('shop.cms.page', ['slug' => config('cookie-consent.terms_slug')]) }}">
                                @lang('shop::app.cookie-consent.terms')
                            </a>
                        </footer>
                    </section>
                </div>

                <button
                    v-if="! isOpen"
                    ref="reopenButton"
                    type="button"
                    class="cookie-consent-reopen"
                    @click="open"
                >
                    <span class="cookie-consent-reopen__dot" aria-hidden="true"></span>
                    @lang('shop::app.cookie-consent.reopen')
                </button>
            </div>
        </script>

        <script type="module">
            app.component('v-cookie-consent', {
                template: '#v-cookie-consent-template',

                props: {
                    hasDecision: {
                        type: Boolean,
                        required: true,
                    },

                    initiallyOpen: {
                        type: Boolean,
                        required: true,
                    },

                    initialPreferences: {
                        type: Object,
                        required: true,
                    },

                    saveUrl: {
                        type: String,
                        required: true,
                    },

                    csrfToken: {
                        type: String,
                        required: true,
                    },
                },

                data() {
                    return {
                        isOpen: this.initiallyOpen,
                        showSettings: false,
                        isSaving: false,
                        errorMessage: '',
                        lastFocusedElement: null,
                        preferences: {
                            analytics: Boolean(this.initialPreferences.analytics),
                            marketing: Boolean(this.initialPreferences.marketing),
                        },
                    };
                },

                mounted() {
                    document.addEventListener('keydown', this.handleKeydown);
                    this.setModalState(this.isOpen);

                    if (! this.hasDecision && navigator.globalPrivacyControl === true) {
                        this.rejectAll();

                        return;
                    }

                    if (this.isOpen) {
                        this.$nextTick(() => this.$refs.acceptButton?.focus());
                    }
                },

                beforeUnmount() {
                    this.setModalState(false);
                    document.removeEventListener('keydown', this.handleKeydown);
                },

                methods: {
                    open() {
                        this.lastFocusedElement = document.activeElement;
                        this.showSettings = false;
                        this.errorMessage = '';
                        this.isOpen = true;
                        this.setModalState(true);
                        this.$nextTick(() => this.$refs.acceptButton?.focus());
                    },

                    close() {
                        this.isOpen = false;
                        this.setModalState(false);
                        this.$nextTick(() => {
                            const focusTarget = this.$refs.reopenButton || this.lastFocusedElement;

                            focusTarget?.focus?.();
                        });
                    },

                    openSettings() {
                        this.showSettings = true;
                        this.errorMessage = '';
                        this.$nextTick(() => this.$refs.analyticsToggle?.focus());
                    },

                    closeSettings() {
                        this.showSettings = false;
                        this.$nextTick(() => this.$refs.acceptButton?.focus());
                    },

                    acceptAll() {
                        this.persist('accept_all');
                    },

                    rejectAll() {
                        this.persist('reject_all');
                    },

                    saveCustom() {
                        this.persist('custom', this.preferences);
                    },

                    handleKeydown(event) {
                        if (event.key === 'Escape' && this.isOpen) {
                            this.close();

                            return;
                        }

                        if (event.key !== 'Tab' || ! this.isOpen) {
                            return;
                        }

                        const focusableElements = this.getFocusableElements();

                        if (! focusableElements.length) {
                            event.preventDefault();

                            return;
                        }

                        const firstElement = focusableElements[0];
                        const lastElement = focusableElements[focusableElements.length - 1];

                        if (event.shiftKey && document.activeElement === firstElement) {
                            event.preventDefault();
                            lastElement.focus();
                        } else if (! event.shiftKey && document.activeElement === lastElement) {
                            event.preventDefault();
                            firstElement.focus();
                        }
                    },

                    getFocusableElements() {
                        if (! this.$refs.dialog) {
                            return [];
                        }

                        return Array.from(this.$refs.dialog.querySelectorAll(
                            'a[href], button:not([disabled]), input:not([disabled]), [tabindex]:not([tabindex="-1"])'
                        )).filter(element => element.offsetParent !== null);
                    },

                    setModalState(isOpen) {
                        document.documentElement.classList.toggle('cookie-consent-is-open', isOpen);

                        const appRoot = document.getElementById('app');

                        if (! appRoot) {
                            return;
                        }

                        Array.from(appRoot.children).forEach(element => {
                            if (element !== this.$el) {
                                element.inert = isOpen;
                            }
                        });
                    },

                    clearMarketingState() {
                        ['localStorage', 'sessionStorage'].forEach(storageName => {
                            try {
                                const storage = window[storageName];

                                Object.keys(storage)
                                    .filter(key => key.includes('popup_widget'))
                                    .forEach(key => storage.removeItem(key));
                            } catch (error) {
                                // Storage may be unavailable in privacy-focused browsers.
                            }
                        });

                        document.cookie.split(';').forEach(cookie => {
                            const name = cookie.split('=')[0].trim();

                            if (
                                name === '_fbp'
                                || name === '_fbc'
                                || name.startsWith('bagisto_popup_widget_')
                            ) {
                                document.cookie = `${encodeURIComponent(name)}=; Max-Age=0; path=/; SameSite=Lax`;
                            }
                        });
                    },

                    async persist(action, preferences = {}) {
                        if (this.isSaving) {
                            return;
                        }

                        this.isSaving = true;
                        this.errorMessage = '';

                        try {
                            const response = await fetch(this.saveUrl, {
                                method: 'POST',
                                credentials: 'same-origin',
                                headers: {
                                    'Accept': 'application/json',
                                    'Content-Type': 'application/json',
                                    'X-CSRF-TOKEN': this.csrfToken,
                                },
                                body: JSON.stringify({ action, ...preferences }),
                            });

                            if (! response.ok) {
                                throw new Error('Consent could not be saved.');
                            }

                            const result = await response.json();

                            this.preferences.analytics = Boolean(result.categories.analytics);
                            this.preferences.marketing = Boolean(result.categories.marketing);

                            if (! this.preferences.marketing) {
                                this.clearMarketingState();
                            }

                            window.location.reload();
                        } catch (error) {
                            this.errorMessage = @json(trans('shop::app.cookie-consent.save-error'));
                            this.isSaving = false;
                        }
                    },
                },
            });
        </script>
        @endPushOnce
    @endunless
@endif
