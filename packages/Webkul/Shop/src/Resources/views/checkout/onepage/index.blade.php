{{-- index.blade.php --}}
@push('meta')
    <meta name="description" content="@lang('shop::app.checkout.onepage.index.checkout')"/>
    <meta name="keywords" content="@lang('shop::app.checkout.onepage.index.checkout')"/>
@endPush

<x-shop::layouts
    :has-header="false"
    :has-feature="false"
    :has-footer="false"
>
    <x-slot:title>
        @lang('shop::app.checkout.onepage.index.checkout')
    </x-slot>

    {!! view_render_event('bagisto.shop.checkout.onepage.header.before') !!}

    <div class="flex-wrap">
        <div class="flex w-full justify-between border border-b border-l-0 border-r-0 border-t-0 px-[60px] py-4 max-lg:px-8 max-sm:px-4">
            <div class="flex items-center gap-x-14 max-[1180px]:gap-x-9">
                
                    <img
                        src="{{ core()->getCurrentChannel()->logo_url ?? bagisto_asset('images/logo.svg') }}"
                        alt="{{ config('app.name') }}"
                        width="131"
                        height="29"
                    >
                </a>
            </div>

            @guest('customer')
                @include('shop::checkout.login')
            @endguest
        </div>
    </div>

    {!! view_render_event('bagisto.shop.checkout.onepage.header.after') !!}

    <div class="container px-[60px] max-lg:px-8 max-sm:px-4">

        {!! view_render_event('bagisto.shop.checkout.onepage.breadcrumbs.before') !!}

        @if ((core()->getConfigData('general.general.breadcrumbs.shop')))
            <x-shop::breadcrumbs name="checkout" />
        @endif

        {!! view_render_event('bagisto.shop.checkout.onepage.breadcrumbs.after') !!}

        <v-checkout>
            <x-shop::shimmer.checkout.onepage />
        </v-checkout>
    </div>

    @pushOnce('scripts')
        {{-- Bold Payment Button library --}}
        <script src="https://checkout.bold.co/library/boldPaymentButton.js"></script>

        <script
            type="text/x-template"
            id="v-checkout-template"
        >
            <template v-if="! cart">
                <x-shop::shimmer.checkout.onepage />
            </template>

            <template v-else>
                <div class="grid grid-cols-[1fr_auto] gap-8 max-lg:grid-cols-[1fr] max-md:gap-5">
                    <div class="hidden max-md:block">
                        @include('shop::checkout.onepage.summary')
                    </div>

                    <div
                        class="overflow-y-auto max-md:grid max-md:gap-4"
                        id="steps-container"
                    >
                        <template v-if="['address', 'shipping', 'payment', 'review'].includes(currentStep)">
                            @include('shop::checkout.onepage.address')
                        </template>

                        <template v-if="cart.have_stockable_items && ['shipping', 'payment', 'review'].includes(currentStep)">
                            @include('shop::checkout.onepage.shipping')
                        </template>

                        <template v-if="['payment', 'review'].includes(currentStep)">
                            @include('shop::checkout.onepage.payment')
                        </template>
                    </div>

                    <div class="sticky top-8 block h-max w-[442px] max-w-full max-lg:w-auto max-lg:max-w-[442px] ltr:pl-8 max-lg:ltr:pl-0 rtl:pr-8 max-lg:rtl:pr-0">
                        <div class="block max-md:hidden">
                            @include('shop::checkout.onepage.summary')
                        </div>

                        <div
                            class="flex justify-end"
                            v-if="canPlaceOrder"
                        >
                            <template v-if="cart.payment_method == 'paypal_smart_button'">
                                {!! view_render_event('bagisto.shop.checkout.onepage.summary.paypal_smart_button.before') !!}
                                <v-paypal-smart-button></v-paypal-smart-button>
                                {!! view_render_event('bagisto.shop.checkout.onepage.summary.paypal_smart_button.after') !!}
                            </template>

                            <template v-else-if="cart.payment_method == 'epayco'">
                                <v-epayco-button></v-epayco-button>
                            </template>

                            <template v-else-if="cart.payment_method == 'boldpayment'">
                                <v-bold-button></v-bold-button>
                            </template>

                            <template v-else>
                                <x-shop::button
                                    type="button"
                                    class="primary-button w-max rounded-2xl bg-navyBlue px-11 py-3 max-md:mb-4 max-md:w-full max-md:max-w-full max-md:rounded-lg max-sm:py-1.5"
                                    :title="trans('shop::app.checkout.onepage.summary.place-order')"
                                    ::disabled="isPlacingOrder"
                                    ::loading="isPlacingOrder"
                                    @click="placeOrder"
                                />
                            </template>
                        </div>
                    </div>
                </div>
            </template>
        </script>

        <script type="module">
            app.component('v-checkout', {
                template: '#v-checkout-template',

                data() {
                    return {
                        cart: null,

                        displayTax: {
                            prices:   "{{ core()->getConfigData('sales.taxes.shopping_cart.display_prices') }}",
                            subtotal: "{{ core()->getConfigData('sales.taxes.shopping_cart.display_subtotal') }}",
                            shipping: "{{ core()->getConfigData('sales.taxes.shopping_cart.display_shipping_amount') }}",
                        },

                        isPlacingOrder: false,
                        currentStep:    'address',
                        shippingMethods: null,
                        paymentMethods:  null,
                        canPlaceOrder:   false,
                    };
                },

                mounted() {
                    this.getCart();
                },

                methods: {
                    getCart() {
                        this.$axios.get("{{ route('shop.checkout.onepage.summary') }}")
                            .then(response => {
                                this.cart = response.data.data;
                                this.scrollToCurrentStep();
                            })
                            .catch(() => {});
                    },

                    stepForward(step) {
                        this.currentStep = step;

                        if (step === 'review') {
                            this.canPlaceOrder = true;
                            return;
                        }

                        this.canPlaceOrder = false;

                        if (this.currentStep === 'shipping') {
                            this.shippingMethods = null;
                        } else if (this.currentStep === 'payment') {
                            this.paymentMethods = null;
                        }
                    },

                    stepProcessed(data) {
                        if (this.currentStep === 'shipping') {
                            this.shippingMethods = data;
                        } else if (this.currentStep === 'payment') {
                            this.paymentMethods = data;
                        }

                        this.getCart();
                    },

                    scrollToCurrentStep() {
                        const container = document.getElementById('steps-container');
                        if (! container) return;
                        container.scrollIntoView({ behavior: 'smooth', block: 'end' });
                    },

                    placeOrder() {
                        this.isPlacingOrder = true;

                        this.$axios.post('{{ route('shop.checkout.onepage.orders.store') }}')
                            .then(response => {
                                if (response.data.data.redirect) {
                                    window.location.href = response.data.data.redirect_url;
                                } else {
                                    window.location.href = '{{ route('shop.checkout.onepage.success') }}';
                                }
                                this.isPlacingOrder = false;
                            })
                            .catch(error => {
                                this.isPlacingOrder = false;
                                this.$emitter.emit('add-flash', {
                                    type:    'error',
                                    message: error.response.data.message,
                                });
                            });
                    },
                },
            });

            app.component('v-bold-button', {
                template: `
                    <div>
                        <div id="bold-button-container" class="flex justify-center min-h-[48px]">
                            <span v-if="loading" class="text-sm text-gray-400 animate-pulse mt-3">
                                Cargando pago con Bold…
                            </span>
                            <span v-if="errorMsg" class="text-sm text-red-500 mt-3">
                                @{{ errorMsg }}
                            </span>
                        </div>
                    </div>
                `,

                data() {
                    return {
                        loading:    true,
                        errorMsg:   null,
                        boldConfig: null,
                    };
                },

                mounted() {
                    this.loadBoldConfig();
                },

                methods: {
                    loadBoldConfig() {
                        this.$axios.get('{{ route('bold.config') }}')
                            .then(response => {
                                this.boldConfig = response.data;
                                this.loading    = false;
                                this.$nextTick(() => this.injectBoldScript());
                            })
                            .catch(error => {
                                this.loading  = false;
                                this.errorMsg = error?.response?.data?.message
                                    ?? 'No se pudo cargar el botón de Bold.';
                            });
                    },

                    injectBoldScript() {
                        const cfg       = this.boldConfig;
                        const container = document.getElementById('bold-button-container');

                        if (! cfg || ! container) return;

                        container.innerHTML = '';

                        const script = document.createElement('script');

                        script.src = 'https://checkout.bold.co/library/boldPaymentButton.js';

                        const buttonStyle = cfg.buttonStyle || 'dark-L';
                        script.setAttribute('data-bold-button',         buttonStyle);
                        script.setAttribute('data-api-key',             cfg.apiKey);
                        script.setAttribute('data-order-id',            cfg.orderId);
                        script.setAttribute('data-currency',            cfg.currency);
                        script.setAttribute('data-amount',              String(cfg.amount));
                        script.setAttribute('data-integrity-signature', cfg.integritySignature);
                        script.setAttribute('data-description',         cfg.description);
                        script.setAttribute('data-redirection-url',     cfg.redirectionUrl);
                        script.setAttribute('data-render-mode',         cfg.renderMode || 'embedded');

                        if (cfg.originUrl)      script.setAttribute('data-origin-url',      cfg.originUrl);
                        if (cfg.customerData)   script.setAttribute('data-customer-data',   cfg.customerData);
                        if (cfg.billingAddress) script.setAttribute('data-billing-address', cfg.billingAddress);
                        if (cfg.extraData1)     script.setAttribute('data-extra-data-1',    cfg.extraData1);
                        if (cfg.extraData2)     script.setAttribute('data-extra-data-2',    cfg.extraData2);
                        if (cfg.tax)            script.setAttribute('data-tax',             cfg.tax);
                        if (cfg.expirationDate) script.setAttribute('data-expiration-date', cfg.expirationDate);

                        container.appendChild(script);
                    },
                },
            });
        </script>
    @endPushOnce
</x-shop::layouts>