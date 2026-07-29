<?php

namespace Webkul\Core;

use Illuminate\Http\Request;

class CookieConsent
{
    /**
     * Optional consent categories.
     */
    public const OPTIONAL_CATEGORIES = [
        'analytics',
        'marketing',
    ];

    /**
     * Determine whether consent management is enabled for the current channel.
     */
    public function isEnabled(): bool
    {
        $configuredValue = core()->getConfigData(
            'general.content.cookie_consent.enabled',
            core()->getCurrentChannelCode()
        );

        return $configuredValue === null
            ? (bool) config('cookie-consent.enabled', true)
            : (bool) $configuredValue;
    }

    /**
     * Return the current valid consent decision.
     */
    public function decision(?Request $request = null): ?array
    {
        if (! $this->isEnabled()) {
            return [
                'necessary'   => true,
                'analytics'   => true,
                'marketing'   => true,
            ];
        }

        $rawDecision = ($request ?? request())->cookie($this->cookieName());

        if (! is_string($rawDecision)) {
            return null;
        }

        $storedDecision = json_decode($rawDecision, true);

        if (
            ! is_array($storedDecision)
            || ($storedDecision['revision'] ?? null) !== $this->revision()
            || ! is_array($storedDecision['categories'] ?? null)
        ) {
            return null;
        }

        $decision = ['necessary' => true];

        foreach (self::OPTIONAL_CATEGORIES as $category) {
            $value = $storedDecision['categories'][$category] ?? null;

            if (! is_bool($value)) {
                return null;
            }

            $decision[$category] = $value;
        }

        if (($request ?? request())->header('Sec-GPC') === '1') {
            $decision['marketing'] = false;
        }

        return $decision;
    }

    /**
     * Determine whether a category is allowed.
     */
    public function allows(string $category, ?Request $request = null): bool
    {
        if ($category === 'necessary') {
            return true;
        }

        return (bool) ($this->decision($request)[$category] ?? false);
    }

    /**
     * Determine whether the visitor already made a valid choice.
     */
    public function hasDecision(?Request $request = null): bool
    {
        return $this->decision($request) !== null;
    }

    /**
     * Build the persisted cookie payload.
     */
    public function encode(array $categories): string
    {
        $normalizedCategories = [];

        foreach (self::OPTIONAL_CATEGORIES as $category) {
            $normalizedCategories[$category] = (bool) ($categories[$category] ?? false);
        }

        return json_encode([
            'revision'   => $this->revision(),
            'categories' => $normalizedCategories,
            'decided_at' => now()->toIso8601String(),
        ], JSON_THROW_ON_ERROR);
    }

    /**
     * Return a bounded cache key for the current decision.
     */
    public function cacheKey(?Request $request = null): string
    {
        if (! $this->isEnabled()) {
            return 'consent-disabled';
        }

        $decision = $this->decision($request);

        if (! $decision) {
            return 'consent-v'.$this->revision().'-pending';
        }

        return sprintf(
            'consent-v%d-a%d-m%d',
            $this->revision(),
            (int) $decision['analytics'],
            (int) $decision['marketing']
        );
    }

    /**
     * Return the configured cookie name.
     */
    public function cookieName(): string
    {
        return (string) config('cookie-consent.cookie_name', 'angelshop_cookie_consent');
    }

    /**
     * Return the active consent revision.
     */
    public function revision(): int
    {
        return max(1, (int) config('cookie-consent.revision', 1));
    }
}
