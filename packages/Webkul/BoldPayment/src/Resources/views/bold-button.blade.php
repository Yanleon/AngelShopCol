@if (
    request()->routeIs('shop.checkout.onepage.index')
    && (bool) core()->getConfigData('sales.payment_methods.boldpayment.active')
)
    @pushOnce('scripts')
        <script src="https://checkout.bold.co/library/boldPaymentButton.js"></script>

        <script
            type="text/x-template"
            id="v-bold-button-template"
        >
            <div class="w-full flex justify-end">
                <div id="bold-button-inline" class="flex justify-end"></div>
            </div>
        </script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                app.component('v-bold-button', {
                    template: '#v-bold-button-template',

                    data() {
                        return {
                            isLoading: false,
                            buttonLoaded: false,
                            scriptEl: null,
                        };
                    },

                    mounted() {
                        this.loadButton();
                    },

                    unmounted() {
                        this.cleanup();
                    },

                    methods: {
                        cleanup() {
                            if (this.scriptEl && this.scriptEl.parentNode) {
                                this.scriptEl.parentNode.removeChild(this.scriptEl);
                            }

                            const container = document.getElementById('bold-button-inline');

                            if (container) {
                                container.innerHTML = '';
                            }

                            this.buttonLoaded = false;
                        },

                        async loadButton() {
                            if (this.buttonLoaded) {
                                return;
                            }

                            this.isLoading = true;

                            try {
                                const { data } = await this.$axios.get("{{ route('bold.config') }}");

                                this.renderBoldScript(data);
                                this.buttonLoaded = true;
                            } catch (error) {
                                this.$emitter.emit('add-flash', {
                                    type: 'error',
                                    message: 'No pudimos cargar el botón de Bold. Intenta nuevamente.',
                                });
                            } finally {
                                this.isLoading = false;
                            }
                        },

                        renderBoldScript(cfg) {
                            this.cleanup();

                            const container = document.getElementById('bold-button-inline');

                            if (! container) {
                                return;
                            }

                            const script = document.createElement('script');

                            script.setAttribute('data-bold-button', cfg.buttonStyle || 'dark-L');
                            script.dataset.apiKey = cfg.apiKey;
                            script.dataset.orderId = cfg.orderId;
                            script.dataset.currency = cfg.currency;
                            script.dataset.amount = cfg.amount;
                            script.dataset.integritySignature = cfg.integritySignature;
                            script.dataset.description = cfg.description;
                            script.dataset.redirectionUrl = cfg.redirectionUrl || "{{ route('bold.callback') }}";
                            script.dataset.renderMode = cfg.renderMode || 'embedded';

                            if (cfg.originUrl) script.dataset.originUrl = cfg.originUrl;
                            if (cfg.customerData) script.setAttribute('data-customer-data', cfg.customerData);
                            if (cfg.billingAddress) script.setAttribute('data-billing-address', cfg.billingAddress);
                            if (cfg.extraData1) script.dataset.extraData1 = cfg.extraData1;
                            if (cfg.extraData2) script.dataset.extraData2 = cfg.extraData2;
                            if (cfg.tax) script.dataset.tax = cfg.tax;
                            if (cfg.expirationDate) script.dataset.expirationDate = cfg.expirationDate;

                            this.scriptEl = script;

                            container.appendChild(script);
                        },
                    },
                });
            });
        </script>
    @endPushOnce
@endif
