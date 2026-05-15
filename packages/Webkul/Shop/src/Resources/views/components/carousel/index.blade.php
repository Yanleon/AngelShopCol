@props(['options'])

<v-carousel
    :images="{{ json_encode($options['images'] ?? []) }}"
    :mobile-overlay="{{ (int) ($options['mobile_overlay'] ?? 15) }}"
>
    <div class="hero-carousel-shell overflow-hidden bg-gradient-to-r from-rose-50 via-pink-50 to-rose-100 max-md:rounded-b-2xl">
        <div class="hero-carousel-media shimmer w-screen"></div>
    </div>
</v-carousel>

@pushOnce('styles')
    <style>
        .hero-carousel-media {
            aspect-ratio: 1.25 / 1;
            object-fit: contain;
            object-position: center;
            background: transparent;
        }

        @media (min-width: 768px) {
            .hero-carousel-media {
                aspect-ratio: 2.743 / 1;
                object-fit: cover;
                background: transparent;
            }

            .hero-carousel-shell {
                background: transparent;
                border-radius: 0;
            }
        }
    </style>
@endpushOnce

@pushOnce('scripts')
    <script
        type="text/x-template"
        id="v-carousel-template"
    >
        <div class="relative m-auto flex w-full overflow-hidden">
            <!-- Slider -->
            <div 
                class="inline-flex translate-x-0 cursor-pointer transition-transform duration-700 ease-out will-change-transform"
                ref="sliderContainer"
            >
                <div
                    class="max-h-screen w-screen bg-cover bg-center bg-no-repeat"
                    v-for="(image, index) in images"
                    @click="visitLink(image)"
                    ref="slide"
                    :style="getSlideBackgroundStyle(image)"
                >
                    <x-shop::media.images.lazy
                        class="hero-carousel-media w-full max-w-full select-none shadow-[0_14px_28px_rgba(190,24,93,0.14)] transition-transform duration-300 ease-in-out md:shadow-none"
                        ::lazy="false"
                        ::src="getImageSource(image)"
                        ::srcset="getImageSrcset(image)"
                        ::alt="image?.title"
                        tabindex="0"
                    />
                </div>
            </div>

            <!-- Navigation -->
            <span
                class="icon-arrow-left absolute left-2.5 top-1/2 -mt-[22px] hidden w-auto rounded-full bg-black/80 p-3 text-2xl font-bold text-white opacity-30 transition-all md:inline-block"
                :class="{
                    'cursor-not-allowed': direction == 'ltr' && currentIndex == 0,
                    'cursor-pointer hover:opacity-100': direction == 'ltr' ? currentIndex > 0 : currentIndex <= 0
                }"
                role="button"
                aria-label="@lang('shop::components.carousel.previous')"
                tabindex="0"
                v-if="images?.length >= 2"
                @click="navigate('prev')"
            >
            </span>

            <span
                class="icon-arrow-right absolute right-2.5 top-1/2 -mt-[22px] hidden w-auto rounded-full bg-black/80 p-3 text-2xl font-bold text-white opacity-30 transition-all md:inline-block"
                :class="{
                    'cursor-not-allowed': direction == 'rtl' && currentIndex == 0,
                    'cursor-pointer hover:opacity-100': direction == 'rtl' ? currentIndex < 0 : currentIndex >= 0
                }"
                role="button"
                aria-label="@lang('shop::components.carousel.next')"
                tabindex="0"
                v-if="images?.length >= 2"
                @click="navigate('next')"
            >
            </span>

            <!-- Pagination -->
            <div class="absolute bottom-5 left-0 flex w-full justify-center max-md:bottom-3.5 max-sm:bottom-2.5">
                <div
                    v-for="(image, index) in images"
                    class="mx-1 h-3 w-3 cursor-pointer rounded-full max-md:h-2 max-md:w-2 max-sm:h-1.5 max-sm:w-1.5"
                    :class="{ 'bg-navyBlue': index === Math.abs(currentIndex), 'opacity-30 bg-gray-500': index !== Math.abs(currentIndex) }"
                    role="button"
                    tabindex="0"
                    @click="navigateByPagination(index)"
                >
                </div>
            </div>
        </div>
    </script>

    <script type="module">
        app.component("v-carousel", {
            template: '#v-carousel-template',

            props: {
                images: {
                    type: Array,
                    default: () => [],
                },

                mobileOverlay: {
                    type: Number,
                    default: 15,
                },
            },

            data() {
                return {
                    isDragging: false,
                    startPos: 0,
                    currentTranslate: 0,
                    prevTranslate: 0,
                    animationID: 0,
                    currentIndex: 0,
                    slider: '',
                    slides: [],
                    autoPlayInterval: null,
                    direction: 'ltr',
                    startFrom: 1,
                    isMobileView: window.innerWidth < 768,
                };
            },

            mounted() {
                this.slider = this.$refs.sliderContainer;

                if (
                    this.$refs.slide
                    && typeof this.$refs.slide[Symbol.iterator] === 'function'
                ) {
                    this.slides = Array.from(this.$refs.slide);
                }

                this.init();

                this.play();
            },

            methods: {
                init() {
                    this.direction = document.dir;

                    if (this.direction == 'rtl') {
                        this.startFrom = -1;
                    }

                    this.slides.forEach((slide, index) => {
                        slide.querySelector('img')?.addEventListener('dragstart', (e) => e.preventDefault());

                        slide.addEventListener('mousedown', this.handleDragStart);

                        slide.addEventListener('touchstart', this.handleDragStart);

                        slide.addEventListener('mouseup', this.handleDragEnd);

                        slide.addEventListener('mouseleave', this.handleDragEnd);

                        slide.addEventListener('touchend', this.handleDragEnd);

                        slide.addEventListener('mousemove', this.handleDrag);

                        slide.addEventListener('touchmove', this.handleDrag, { passive: true });
                    });

                    window.addEventListener('resize', this.handleResize);
                },

                handleResize() {
                    this.isMobileView = window.innerWidth < 768;

                    this.setPositionByIndex();
                },

                handleDragStart(event) {
                    this.startPos = event.type === 'mousedown' ? event.clientX : event.touches[0].clientX;

                    this.isDragging = true;

                    this.animationID = requestAnimationFrame(this.animation);
                },

                handleDrag(event) {
                    if (! this.isDragging) {
                        return;
                    }

                    const currentPosition = event.type === 'mousemove' ? event.clientX : event.touches[0].clientX;

                    this.currentTranslate = this.prevTranslate + currentPosition - this.startPos;
                },

                handleDragEnd(event) {
                    clearInterval(this.autoPlayInterval);

                    cancelAnimationFrame(this.animationID);

                    this.isDragging = false;

                    const movedBy = this.currentTranslate - this.prevTranslate;

                    if (this.direction == 'ltr') {
                        if (
                            movedBy < -100
                            && this.currentIndex < this.slides.length - 1
                        ) {
                            this.currentIndex += 1;
                        }

                        if (
                            movedBy > 100
                            && this.currentIndex > 0
                        ) {
                            this.currentIndex -= 1;
                        }
                    } else {
                        if (
                            movedBy > 100
                            && this.currentIndex < this.slides.length - 1
                        ) {
                            if (Math.abs(this.currentIndex) != this.slides.length - 1) {
                                this.currentIndex -= 1;
                            }
                        }

                        if (
                            movedBy < -100
                            && this.currentIndex < 0
                        ) {
                            this.currentIndex += 1;
                        }
                    }

                    this.setPositionByIndex();

                    this.play();
                },

                animation() {
                    this.setSliderPosition();

                    if (this.isDragging) {
                        requestAnimationFrame(this.animation);
                    }
                },

                setPositionByIndex() {
                    this.currentTranslate = this.currentIndex * -window.innerWidth;

                    this.prevTranslate = this.currentTranslate;

                    this.setSliderPosition();
                },

                setSliderPosition() {
                    this.slider.style.transform = `translateX(${this.currentTranslate}px)`
                },

                visitLink(image) {
                    if (image.link) {
                        window.location.href = image.link;
                    }
                },

                getImageSource(image) {
                    if (this.isMobileView && image.mobile_image) {
                        return image.mobile_image;
                    }

                    return image.image;
                },

                getImageSrcset(image) {
                    const currentImage = this.getImageSource(image);

                    if (this.isMobileView && image.mobile_image) {
                        return currentImage;
                    }

                    return currentImage + ' 1920w, '
                        + currentImage.replace('storage', 'cache/large') + ' 1280w,'
                        + currentImage.replace('storage', 'cache/medium') + ' 1024w, '
                        + currentImage.replace('storage', 'cache/small') + ' 525w';
                },

                getSlideBackgroundStyle(image) {
                    if (! this.isMobileView) {
                        return {};
                    }

                    const mobileSource = image.mobile_image || image.image;
                    const overlay = Math.max(0, Math.min(40, Number(this.mobileOverlay || 0))) / 100;

                    return {
                        backgroundImage: `linear-gradient(rgba(0,0,0,${overlay}), rgba(0,0,0,${overlay})), url('${mobileSource}')`,
                    };
                },

                navigate(type) {
                    clearInterval(this.autoPlayInterval);

                    if (this.direction === 'rtl') {
                        type === 'next' ? this.prev() : this.next();
                    } else {
                        type === 'next' ? this.next() : this.prev();
                    }

                    this.setPositionByIndex();

                    this.play();
                },

                next() {
                    this.currentIndex = (this.currentIndex + this.startFrom) % this.images.length;
                },

                prev() {
                    this.currentIndex = this.direction == 'ltr'
                        ? this.currentIndex > 0 ? this.currentIndex - 1 : 0
                        : this.currentIndex < 0 ? this.currentIndex + 1 : 0;
                },

                navigateByPagination(index) {
                    this.direction == 'rtl' ? index = -index : '';

                    clearInterval(this.autoPlayInterval);

                    this.currentIndex = index;

                    this.setPositionByIndex();

                    this.play();
                },

                play() {
                    clearInterval(this.autoPlayInterval);

                    this.autoPlayInterval = setInterval(() => {
                        this.currentIndex = (this.currentIndex + this.startFrom) % this.images.length;

                        this.setPositionByIndex();
                    }, 5000);
                },
            },
        });
    </script>
@endpushOnce
