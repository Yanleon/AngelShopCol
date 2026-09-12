<?php
    $socialNetworks = [
        'tiktok'    => 'images/social/tiktok-icon.svg',
        'instagram' => 'images/social/instagram-icon.svg',
        'facebook'  => 'images/social/facebook-icon.svg',
        'youtube'   => 'images/social/youtube-icon.svg',
        'twitter'   => 'images/social/twitter-icon.svg',
    ];
?>

<div class="flex justify-center space-x-4 mt-4">
    @php $delayStep = 0; @endphp

    @foreach ($socialNetworks as $network => $defaultIcon)
        @continue (! ($link = core()->getConfigData("general.social-media.{$network}.content")))

        @php
            $customIcon = core()->getConfigData("general.social-media.{$network}.icon");
            $iconUrl = $customIcon ? Storage::url($customIcon) : bagisto_asset($defaultIcon);
            $delayStep++;
        @endphp

        <a
            href="{{ $link }}"
            target="_blank"
            rel="noopener"
            class="social-media-icon inline-flex transition-transform duration-300 ease-out hover:-translate-y-1 hover:scale-110"
            style="animation-delay: {{ $delayStep * 80 }}ms"
        >
            <img src="{{ $iconUrl }}" alt="{{ ucfirst($network) }}" />
        </a>
    @endforeach
</div>

<style>
    .social-media-icon {
        opacity: 0;
        animation: socialMediaFadeIn .5s ease forwards;
    }

    @keyframes socialMediaFadeIn {
        from {
            opacity: 0;
            transform: translateY(10px);
        }

        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @media (prefers-reduced-motion: reduce) {
        .social-media-icon {
            animation: none;
            opacity: 1;
        }
    }
</style>
