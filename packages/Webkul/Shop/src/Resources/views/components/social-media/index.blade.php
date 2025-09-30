<div class="flex justify-center space-x-4 mt-4">
    @if (core()->getConfigData('general.social-media.tiktok.content'))
        <a href="{{core()->getConfigData('general.social-media.tiktok.content')}}" target="_blank">
            <img src="{{ bagisto_asset('images/social/tiktok-icon.svg') }}" alt="">
        </a>
    @endif

    @if (core()->getConfigData('general.social-media.instagram.content'))
        <a href="{{core()->getConfigData('general.social-media.instagram.content')}}" target="_blank">
            <img src="{{ bagisto_asset('images/social/instagram-icon.svg') }}" alt="">
        </a>
    @endif


    @if (core()->getConfigData('general.social-media.facebook.content'))
        <a href="{{core()->getConfigData('general.social-media.facebook.content')}}" target="_blank">
            <img src="{{ bagisto_asset('images/social/facebook-icon.svg') }}" alt="">
        </a>
    @endif

    @if (core()->getConfigData('general.social-media.youtube.content'))
    <a href="{{core()->getConfigData('general.social-media.youtube.content')}}" target="_blank">
        <img src="{{ bagisto_asset('images/social/youtube-icon.svg') }}" alt="">
    </a>
    @endif

    @if (core()->getConfigData('general.social-media.twitter.content'))
    <a href="{{core()->getConfigData('general.social-media.twitter.content')}}" target="_blank">
        <img src="{{ bagisto_asset('images/social/twitter-icon.svg') }}" alt="">
    </a>
    @endif
</div>
