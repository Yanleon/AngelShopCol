<v-image-carousel :errors="errors">
    <x-admin::shimmer.settings.themes.image-carousel />
</v-image-carousel>

<!-- Image Carousel Vue Component -->
@pushOnce('scripts')
    <script
        type="text/x-template"
        id="v-image-carousel-template"
    >
        <div class="flex flex-1 flex-col gap-2 max-xl:flex-auto">
            <div class="box-shadow rounded bg-white p-4 dark:bg-gray-900">
                <div class="flex items-center justify-between gap-x-2.5">
                    <div class="flex flex-col gap-1">
                        <p class="text-base font-semibold text-gray-800 dark:text-white">
                            @lang('admin::app.settings.themes.edit.slider')
                        </p>
                        
                        <p class="text-xs font-medium text-gray-500 dark:text-gray-300">
                            @lang('admin::app.settings.themes.edit.slider-description')
                        </p>
                    </div>

                    <!-- Add Slider Button -->
                    <div
                        class="secondary-button"
                        @click="openCreateModal"
                    >
                        @lang('admin::app.settings.themes.edit.slider-add-btn')
                    </div>
                </div>

                <template v-for="(deletedSlider, index) in deletedSliders">
                    <input
                        type="hidden"
                        :name="'{{ $currentLocale->code }}[deleted_sliders]['+ index +'][image]'"
                        :value="deletedSlider.image"
                    />

                    <input
                        v-if="deletedSlider.mobile_image"
                        type="hidden"
                        :name="'{{ $currentLocale->code }}[deleted_sliders]['+ index +'][mobile_image]'"
                        :value="deletedSlider.mobile_image"
                    />
                </template>

                <input
                    type="hidden"
                    name="{{ $currentLocale->code }}[options][mobile_overlay]"
                    :value="sliders.mobile_overlay"
                />

                <div class="mt-4 grid gap-2 rounded border border-slate-200 p-3 dark:border-gray-800">
                    <p class="text-sm font-semibold text-gray-800 dark:text-white">
                        Ajustes banner movil
                    </p>

                    <div class="flex flex-wrap items-center gap-2">
                        <label class="text-xs font-medium text-gray-600 dark:text-gray-300">
                            Intensidad fondo movil (0-40)
                        </label>

                        <input
                            type="number"
                            min="0"
                            max="40"
                            step="1"
                            v-model.number="sliders.mobile_overlay"
                            class="w-[96px] rounded border border-slate-300 px-2 py-1 text-sm dark:border-gray-700 dark:bg-gray-900 dark:text-white"
                        />
                    </div>

                    <p class="text-xs text-gray-500 dark:text-gray-300">
                        Recomendado: 10 a 20 para disimular bordes laterales.
                    </p>
                </div>

                <div
                    class="grid pt-4"
                    v-if="sliders.images.length"
                    v-for="(image, index) in sliders.images"
                >
                    <!-- Hidden Input -->
                    <input
                        type="file"
                        class="hidden"
                        :name="'{{ $currentLocale->code }}[options]['+ index +'][image]'"
                        :ref="'imageInput_' + index"
                    />

                    <input
                        type="hidden"
                        :name="'{{ $currentLocale->code }}[options]['+ index +'][title]'"
                        :value="image.title"
                    />

                    <input
                        type="hidden"
                        :name="'{{ $currentLocale->code }}[options]['+ index +'][link]'"
                        :value="image.link"
                    />

                    <input
                        type="hidden"
                        :name="'{{ $currentLocale->code }}[options]['+ index +'][image]'"
                        :value="image.image"
                    />

                    <input
                        type="file"
                        class="hidden"
                        :name="'{{ $currentLocale->code }}[options]['+ index +'][mobile_image]'"
                        :ref="'mobileImageInput_' + index"
                    />

                    <input
                        type="hidden"
                        :name="'{{ $currentLocale->code }}[options]['+ index +'][mobile_image]'"
                        :value="image.mobile_image"
                    />
                
                    <!-- Details -->
                    <div 
                        class="flex cursor-pointer justify-between gap-2.5 py-5"
                        :class="{
                            'border-b border-slate-300 dark:border-gray-800': index < sliders.images.length - 1
                        }"
                    >
                        <div class="flex gap-2.5">
                            <div class="grid place-content-start gap-1.5">
                                <p class="text-gray-600 dark:text-gray-300">
                                    @lang('admin::app.settings.themes.edit.image-title'): 

                                    <span class="text-gray-600 transition-all dark:text-gray-300">
                                        @{{ image.title }}
                                    </span>
                                </p>

                                <p class="text-gray-600 dark:text-gray-300">
                                    @lang('admin::app.settings.themes.edit.link'): 

                                    <span class="text-gray-600 transition-all dark:text-gray-300">
                                        @{{ image.link }}
                                    </span>
                                </p>

                                <p class="text-gray-600 dark:text-gray-300">
                                    @lang('admin::app.settings.themes.edit.image'): 

                                    <span class="text-gray-600 transition-all dark:text-gray-300">
                                        <a
                                            :href="'{{ config('app.url') }}/' + image.image"
                                            :ref="'image_' + index"
                                            target="_blank"
                                            class="text-blue-600 transition-all hover:underline ltr:ml-2 rtl:mr-2"
                                        >
                                            <span :ref="'imageName_' + index">
                                                @{{ image.image }}
                                            </span>
                                        </a>
                                    </span>
                                </p>

                                <p class="text-gray-600 dark:text-gray-300" v-if="image.mobile_image">
                                    Banner movil:

                                    <span class="text-gray-600 transition-all dark:text-gray-300">
                                        <a
                                            :href="'{{ config('app.url') }}/' + image.mobile_image"
                                            :ref="'mobileImage_' + index"
                                            target="_blank"
                                            class="text-blue-600 transition-all hover:underline ltr:ml-2 rtl:mr-2"
                                        >
                                            <span :ref="'mobileImageName_' + index">
                                                @{{ image.mobile_image }}
                                            </span>
                                        </a>
                                    </span>
                                </p>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="grid place-content-start gap-1 text-right">
                            <p
                                class="cursor-pointer text-blue-600 transition-all hover:underline"
                                @click="edit(image, index)"
                            >
                                Editar
                            </p>

                            <p 
                                class="cursor-pointer text-red-600 transition-all hover:underline"
                                @click="remove(image)"
                            > 
                                @lang('admin::app.settings.themes.edit.delete')
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Empty Page -->
                <div
                    class="grid justify-center justify-items-center gap-3.5 px-2.5 py-10"
                    v-else
                >
                    <img
                        class="h-[120px] w-[120px] p-2 dark:mix-blend-exclusion dark:invert"
                        src="{{ bagisto_asset('images/empty-placeholders/default.svg') }}"
                        alt="@lang('admin::app.settings.themes.edit.slider')"
                    >

                    <div class="flex flex-col items-center gap-1.5">
                        <p class="text-base font-semibold text-gray-400">
                            @lang('admin::app.settings.themes.edit.slider-add-btn')
                        </p>
                        
                        <p class="text-gray-400">
                            @lang('admin::app.settings.themes.edit.slider-description')
                        </p>
                    </div>
                </div>
            </div>

            <x-admin::form
                v-slot="{ meta, errors, handleSubmit }"
                as="div"
            >
                <form 
                    @submit="handleSubmit($event, saveSliderImage)"
                    enctype="multipart/form-data"
                    ref="createSliderForm"
                >
                    <x-admin::modal ref="addSliderModal">
                        <!-- Modal Header -->
                        <x-slot:header>
                            <p class="text-lg font-bold text-gray-800 dark:text-white">
                                @{{ editIndex === null ? 'Agregar deslizador' : 'Editar deslizador' }}
                            </p>
                        </x-slot>

                        <!-- Modal Content -->
                        <x-slot:content>
                            <div class="grid gap-3">
                                <div>
                                    <label class="required mb-1.5 block text-xs font-medium text-gray-800 dark:text-white">
                                        @lang('admin::app.settings.themes.edit.image-title')
                                    </label>

                                    <input
                                        type="text"
                                        v-model="sliderForm.title"
                                        class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm dark:border-gray-700 dark:bg-gray-900 dark:text-white"
                                        :placeholder="`{{ trans('admin::app.settings.themes.edit.image-title') }}`"
                                    />
                                </div>

                                <div>
                                    <label class="mb-1.5 block text-xs font-medium text-gray-800 dark:text-white">
                                        @lang('admin::app.settings.themes.edit.link')
                                    </label>

                                    <input
                                        type="text"
                                        v-model="sliderForm.link"
                                        class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm dark:border-gray-700 dark:bg-gray-900 dark:text-white"
                                        :placeholder="`{{ trans('admin::app.settings.themes.edit.link') }}`"
                                    />
                                </div>

                                <div>
                                    <label class="mb-1.5 block text-xs font-medium text-gray-800 dark:text-white">
                                        @lang('admin::app.settings.themes.edit.slider-image')
                                    </label>

                                    <input
                                        type="file"
                                        accept="image/*"
                                        @change="onDesktopFileChange"
                                        class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm dark:border-gray-700 dark:bg-gray-900 dark:text-white"
                                    />

                                    <p class="mt-1 text-xs text-gray-500 dark:text-gray-300" v-if="sliderForm.image">
                                        Actual: @{{ sliderForm.image }}
                                    </p>
                                </div>

                                <div>
                                    <label class="mb-1.5 block text-xs font-medium text-gray-800 dark:text-white">
                                        Banner movil
                                    </label>

                                    <input
                                        type="file"
                                        accept="image/*"
                                        @change="onMobileFileChange"
                                        class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm dark:border-gray-700 dark:bg-gray-900 dark:text-white"
                                    />

                                    <p class="mt-1 text-xs text-gray-500 dark:text-gray-300" v-if="sliderForm.mobile_image">
                                        Actual: @{{ sliderForm.mobile_image }}
                                    </p>
                                </div>
                            </div>

                            <p class="text-xs text-gray-600 dark:text-gray-300">
                                @lang('admin::app.settings.themes.edit.image-size')
                            </p>

                            <p class="text-xs text-gray-600 dark:text-gray-300">
                                Medidas recomendadas: escritorio 1920x700 (2.74:1), movil 1080x1080 (1:1) o 1080x1350 (4:5).
                            </p>

                            <p class="text-xs text-gray-600 dark:text-gray-300">
                                Deja logos y textos centrados para evitar cortes en cualquier pantalla.
                            </p>
                        </x-slot>

                        <!-- Modal Footer -->
                        <x-slot:footer>
                            <button 
                                type="submit"
                                class="cursor-pointer rounded-md border border-blue-700 bg-blue-600 px-3 py-1.5 font-semibold text-gray-50"
                            >
                                @{{ editIndex === null ? 'Agregar' : 'Guardar cambios' }}
                            </button>
                        </x-slot>
                    </x-admin::modal>
                </form>
            </x-admin::form>
        </div>
    </script>

    <script type="module">
        app.component('v-image-carousel', {
            template: '#v-image-carousel-template',

            props: ['errors'],

            data() {
                return {
                    sliders: @json($theme->translate($currentLocale->code)['options'] ?? null),

                    deletedSliders: [],

                    editIndex: null,

                    sliderForm: {
                        title: '',
                        link: '',
                        image: '',
                        mobile_image: '',
                        desktopFile: null,
                        mobileFile: null,
                    },
                };
            },
            
            created() {
                if (
                    this.sliders == null 
                    || this.sliders.length == 0
                ) {
                    this.sliders = { images: [], mobile_overlay: 15 };
                }

                if (typeof this.sliders.mobile_overlay === 'undefined' || this.sliders.mobile_overlay === null || this.sliders.mobile_overlay === '') {
                    this.sliders.mobile_overlay = 15;
                }
            },

            methods: {
                saveSliderImage(params, { resetForm ,setErrors }) {
                    try {
                        const sliderImage = this.sliderForm.desktopFile;
                        const sliderMobileImage = this.sliderForm.mobileFile;

                        if (
                            this.editIndex === null
                            && ! sliderImage
                        ) {
                            throw new Error("{{ trans('admin::app.settings.themes.edit.slider-required') }}");
                        }

                        if (this.editIndex === null) {
                            this.sliders.images.push({
                                title: this.sliderForm.title,
                                link: this.sliderForm.link,
                                slider_image: sliderImage,
                                slider_mobile_image: sliderMobileImage,
                            });

                            if (sliderImage instanceof File) {
                                this.setFile(sliderImage, this.sliders.images.length - 1);
                            }

                            if (sliderMobileImage instanceof File) {
                                this.setMobileFile(sliderMobileImage, this.sliders.images.length - 1);
                            }
                        } else {
                            const currentSlider = this.sliders.images[this.editIndex];

                            currentSlider.title = this.sliderForm.title;
                            currentSlider.link = this.sliderForm.link;

                            if (sliderImage instanceof File) {
                                this.setFile(sliderImage, this.editIndex);
                            }

                            if (sliderMobileImage instanceof File) {
                                this.setMobileFile(sliderMobileImage, this.editIndex);
                            }
                        }

                        resetForm();

                        this.resetSliderForm();

                        this.$refs.addSliderModal.toggle();
                    } catch (error) {
                        setErrors({'slider_image': [error.message]});
                    }
                },

                edit(image, index) {
                    this.editIndex = index;

                    this.sliderForm = {
                        title: image.title || '',
                        link: image.link || '',
                        image: image.image || '',
                        mobile_image: image.mobile_image || '',
                        desktopFile: null,
                        mobileFile: null,
                    };

                    this.$refs.addSliderModal.toggle();
                },

                onDesktopFileChange(event) {
                    const file = event.target.files?.[0] || null;

                    this.sliderForm.desktopFile = file;
                },

                onMobileFileChange(event) {
                    const file = event.target.files?.[0] || null;

                    this.sliderForm.mobileFile = file;
                },

                resetSliderForm() {
                    this.editIndex = null;

                    this.sliderForm = {
                        title: '',
                        link: '',
                        image: '',
                        mobile_image: '',
                        desktopFile: null,
                        mobileFile: null,
                    };
                },

                openCreateModal() {
                    this.resetSliderForm();

                    this.$refs.addSliderModal.toggle();
                },

                setFile(file, index) {
                    let dataTransfer = new DataTransfer();

                    dataTransfer.items.add(file);

                    setTimeout(() => {
                        this.$refs['image_' + index][0].href =  URL.createObjectURL(file);

                        this.$refs['imageName_' + index][0].innerHTML = file.name;

                        this.$refs['imageInput_' + index][0].files = dataTransfer.files;
                    }, 0);
                },

                setMobileFile(file, index) {
                    let dataTransfer = new DataTransfer();

                    dataTransfer.items.add(file);

                    setTimeout(() => {
                        this.$refs['mobileImageInput_' + index][0].files = dataTransfer.files;
                    }, 0);
                },

                remove(image) {
                    this.$emitter.emit('open-confirm-modal', {
                        agree: () => {
                            this.deletedSliders.push(image);
                    
                            this.sliders.images = this.sliders.images.filter(item => {
                                return (
                                    item.title !== image.title || 
                                    item.link !== image.link || 
                                    item.image !== image.image
                                );
                            });
                        }
                    });
                },
            },
        });
    </script>
@endPushOnce    
