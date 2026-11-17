<x-admin::layouts>
    <!-- Page Title -->
    <x-slot:title>
        @lang('admin::app.settings.seasonal-styles.index.title')
    </x-slot>

    <v-seasonal-styles>
        <div class="flex items-center justify-between">
            <p class="text-xl font-bold text-gray-800 dark:text-white">
                @lang('admin::app.settings.seasonal-styles.index.title')
            </p>

            <div class="flex items-center gap-x-2.5">
                @if (bouncer()->hasPermission('settings.seasonal_styles.create'))
                    <button
                        type="button"
                        class="primary-button"
                    >
                        @lang('admin::app.settings.seasonal-styles.index.create.title')
                    </button>
                @endif
            </div>
        </div>

        <!-- DataGrid Shimmer -->
        <x-admin::shimmer.datagrid />
    </v-seasonal-styles>

    @pushOnce('scripts')
        <script
            type="text/x-template"
            id="v-seasonal-styles-template"
        >
            <div class="flex items-center justify-between">
                <p class="text-xl font-bold text-gray-800 dark:text-white">
                    @lang('admin::app.settings.seasonal-styles.index.title')
                </p>

                <div class="flex items-center gap-x-2.5">
                    @if (bouncer()->hasPermission('settings.seasonal_styles.create'))
                        <button
                            type="button"
                            class="primary-button"
                            @click="selectedStyle={}; isEditing=false; $refs.seasonalStyle.toggle()"
                        >
                            @lang('admin::app.settings.seasonal-styles.index.create.title')
                        </button>
                    @endif
                </div>
            </div>

            <p class="mt-2 text-sm text-gray-600 dark:text-gray-300">
                @lang('admin::app.settings.seasonal-styles.index.info')
            </p>

            <x-admin::datagrid
                :src="route('admin.settings.seasonal_styles.index')"
                ref="datagrid"
            >
                <template #body="{
                    isLoading,
                    available,
                    performAction
                }">
                    <template v-if="isLoading">
                        <x-admin::shimmer.datagrid.table.body />
                    </template>

                    <template v-else>
                        <div
                            v-for="record in available.records"
                            class="row grid items-center gap-2.5 border-b px-4 py-4 text-gray-600 transition-all hover:bg-gray-50 dark:border-gray-800 dark:text-gray-300 dark:hover:bg-gray-950"
                            :style="`grid-template-columns: repeat(${gridsCount}, minmax(0, 1fr))`"
                        >
                            <!-- Name -->
                            <p class="font-semibold">@{{ record.name }}</p>

                            <!-- Status -->
                            <p>
                                <span
                                    v-if="record.is_active == 1"
                                    class="label-active"
                                >
                                    @lang('admin::app.settings.seasonal-styles.index.datagrid.active')
                                </span>

                                <span
                                    v-else
                                    class="label-info"
                                >
                                    @lang('admin::app.settings.seasonal-styles.index.datagrid.inactive')
                                </span>
                            </p>

                            <!-- Updated At -->
                            <p>@{{ record.updated_at }}</p>

                            <!-- Actions -->
                            <div class="flex items-center justify-end gap-1">
                                @if (bouncer()->hasPermission('settings.seasonal_styles.edit'))
                                    <button
                                        type="button"
                                        class="secondary-button"
                                        style="padding: 4px 12px; font-size: 12px;"
                                        @click="toggleStyle(record.actions.find(action => action.index === 'toggle')?.url)"
                                    >
                                        <span v-if="record.is_active == 1">
                                            @lang('admin::app.settings.seasonal-styles.index.datagrid.deactivate')
                                        </span>

                                        <span v-else>
                                            @lang('admin::app.settings.seasonal-styles.index.datagrid.activate')
                                        </span>
                                    </button>

                                    <a @click="isEditing=true; editModal(record.actions.find(action => action.index === 'edit')?.url)">
                                        <span
                                            :class="record.actions.find(action => action.index === 'edit')?.icon"
                                            class="cursor-pointer rounded-md p-1.5 text-2xl transition-all hover:bg-gray-200 dark:hover:bg-gray-800 max-sm:place-self-center"
                                        >
                                        </span>
                                    </a>
                                @endif

                                @if (bouncer()->hasPermission('settings.seasonal_styles.delete'))
                                    <a @click="performAction(record.actions.find(action => action.index === 'delete'))">
                                        <span
                                            :class="record.actions.find(action => action.index === 'delete')?.icon"
                                            class="cursor-pointer rounded-md p-1.5 text-2xl transition-all hover:bg-gray-200 dark:hover:bg-gray-800 max-sm:place-self-center"
                                        >
                                        </span>
                                    </a>
                                @endif
                            </div>
                        </div>
                    </template>
                </template>
            </x-admin::datagrid>

            <!-- Modal Form -->
            <x-admin::form
                v-slot="{ errors, handleSubmit }"
                as="div"
                ref="modalForm"
            >
                <form
                    @submit="handleSubmit($event, updateOrCreate)"
                    ref="seasonalStyleForm"
                >
                    <x-admin::modal ref="seasonalStyle">
                        <!-- Modal Header -->
                        <x-slot:header>
                            <p class="text-lg font-bold text-gray-800 dark:text-white">
                                <span v-if="isEditing">
                                    @lang('admin::app.settings.seasonal-styles.index.edit.title')
                                </span>

                                <span v-else>
                                    @lang('admin::app.settings.seasonal-styles.index.create.title')
                                </span>
                            </p>
                        </x-slot>

                        <!-- Modal Content -->
                        <x-slot:content>
                            <x-admin::form.control-group>
                                <x-admin::form.control-group.label class="required">
                                    @lang('admin::app.settings.seasonal-styles.index.create.name')
                                </x-admin::form.control-group.label>

                                <x-admin::form.control-group.control
                                    type="hidden"
                                    name="id"
                                    v-model="selectedStyle.id"
                                />

                                <x-admin::form.control-group.control
                                    type="text"
                                    id="name"
                                    name="name"
                                    rules="required"
                                    v-model="selectedStyle.name"
                                    :label="trans('admin::app.settings.seasonal-styles.index.create.name')"
                                    placeholder="Black Friday"
                                />

                                <x-admin::form.control-group.error control-name="name" />
                            </x-admin::form.control-group>

                            <x-admin::form.control-group class="!mb-0">
                                <x-admin::form.control-group.label>
                                    @lang('admin::app.settings.seasonal-styles.index.create.css')
                                </x-admin::form.control-group.label>

                                <x-admin::form.control-group.control
                                    type="textarea"
                                    id="css"
                                    name="css"
                                    v-model="selectedStyle.css"
                                    style="height: 320px; font-family: ui-monospace, Menlo, Consolas, monospace; font-size: 12px;"
                                    :label="trans('admin::app.settings.seasonal-styles.index.create.css')"
                                    placeholder="body { background: #000; }"
                                />

                                <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
                                    @lang('admin::app.settings.seasonal-styles.index.create.css-help')
                                </p>

                                <x-admin::form.control-group.error control-name="css" />
                            </x-admin::form.control-group>
                        </x-slot>

                        <!-- Modal Footer -->
                        <x-slot:footer>
                            <div class="flex items-center gap-x-2.5">
                                <button
                                    type="submit"
                                    class="primary-button"
                                >
                                    @lang('admin::app.settings.seasonal-styles.index.create.save-btn')
                                </button>
                            </div>
                        </x-slot>
                    </x-admin::modal>
                </form>
            </x-admin::form>
        </script>

        <script type="module">
            app.component('v-seasonal-styles', {
                template: '#v-seasonal-styles-template',

                data() {
                    return {
                        selectedStyle: {},

                        isEditing: false,
                    }
                },

                computed: {
                    gridsCount() {
                        let count = this.$refs.datagrid.available.columns.length;

                        if (this.$refs.datagrid.available.actions.length) {
                            ++count;
                        }

                        if (this.$refs.datagrid.available.massActions.length) {
                            ++count;
                        }

                        return count;
                    },
                },

                methods: {
                    updateOrCreate(params, { setErrors }) {
                        let formData = new FormData(this.$refs.seasonalStyleForm);

                        if (params.id) {
                            formData.append('_method', 'put');
                        }

                        this.$axios.post(params.id ? "{{ route('admin.settings.seasonal_styles.update') }}" : "{{ route('admin.settings.seasonal_styles.store') }}", formData, {
                            headers: {
                                'Content-Type': 'multipart/form-data'
                            }
                        })
                            .then((response) => {
                                this.$refs.seasonalStyle.toggle();

                                this.$refs.datagrid.get();

                                this.$emitter.emit('add-flash', { type: 'success', message: response.data.message });

                                this.selectedStyle = {};
                            })
                            .catch((error) => {
                                if (error.response.status == 422) {
                                    setErrors(error.response.data.errors);
                                }
                            });
                    },

                    editModal(url) {
                        this.$axios.get(url)
                            .then(response => {
                                this.selectedStyle = response.data.data;

                                this.$refs.seasonalStyle.toggle();
                            })
                            .catch(error => this.$emitter.emit('add-flash', {
                                type: 'error', message: error.response.data.message
                            }));
                    },

                    toggleStyle(url) {
                        this.$axios.post(url)
                            .then(response => {
                                this.$refs.datagrid.get();

                                this.$emitter.emit('add-flash', { type: 'success', message: response.data.message });
                            })
                            .catch(error => this.$emitter.emit('add-flash', {
                                type: 'error', message: error.response.data.message
                            }));
                    },
                },
            });
        </script>
    @endPushOnce
</x-admin::layouts>
