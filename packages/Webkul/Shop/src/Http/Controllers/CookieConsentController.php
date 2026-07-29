<?php

namespace Webkul\Shop\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Validation\Rule;

class CookieConsentController extends Controller
{
    /**
     * Persist the visitor's cookie preferences.
     */
    public function store(Request $request): JsonResponse
    {
        abort_unless(config('cookie-consent.enabled'), 404);

        $validated = $request->validate([
            'action' => ['required', Rule::in(['accept_all', 'reject_all', 'custom'])],
        ]);

        $categories = match ($validated['action']) {
            'accept_all' => [
                'analytics' => true,
                'marketing' => true,
            ],
            'reject_all' => [
                'analytics' => false,
                'marketing' => false,
            ],
            default => $request->validate([
                'analytics' => ['required', 'boolean'],
                'marketing' => ['required', 'boolean'],
            ]),
        };

        if ($request->header('Sec-GPC') === '1') {
            $categories['marketing'] = false;
        }

        if ($orderId = $request->session()->pull('cookie_consent.checkout_order_id')) {
            $request->session()->flash('order_id', $orderId);
        }

        $cookie = Cookie::make(
            cookie_consent()->cookieName(),
            cookie_consent()->encode($categories),
            max(1, (int) config('cookie-consent.lifetime_days', 180)) * 24 * 60,
            '/',
            null,
            (bool) (config('session.secure') ?? $request->isSecure()),
            true,
            false,
            'lax'
        );

        return response()
            ->json([
                'message'    => trans('shop::app.cookie-consent.saved'),
                'categories' => array_merge(['necessary' => true], $categories),
            ])
            ->withCookie($cookie);
    }
}
