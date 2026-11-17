<?php

namespace Webkul\SeasonalStyle\Repositories;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Spatie\ResponseCache\Facades\ResponseCache;
use Webkul\Core\Eloquent\Repository;
use Webkul\SeasonalStyle\Models\SeasonalStyle;

class SeasonalStyleRepository extends Repository
{
    /**
     * Cache key holding the active style's CSS.
     */
    const CACHE_KEY = 'seasonal_style.active_css';

    /**
     * Specify model class name.
     */
    public function model(): string
    {
        return SeasonalStyle::class;
    }

    /**
     * Toggle a style: activating it turns every other style off,
     * activating the one already active turns it off.
     */
    public function activate(int $id): void
    {
        $style = $this->findOrFail($id);

        DB::transaction(function () use ($style) {
            $wasActive = $style->is_active;

            $this->model->newQuery()->where('is_active', true)->update(['is_active' => false]);

            if (! $wasActive) {
                $style->update(['is_active' => true]);
            }
        });

        $this->forgetCache();
    }

    /**
     * CSS of the active style, safe to print inside a <style> tag.
     */
    public function activeCss(): string
    {
        return Cache::rememberForever(self::CACHE_KEY, function () {
            $css = (string) $this->model->newQuery()->where('is_active', true)->value('css');

            // Keep the CSS from closing the <style> tag and injecting HTML.
            return preg_replace('#</\s*style#i', '<\/style', $css);
        });
    }

    /**
     * Drop the cached active CSS and any cached store pages that embed it.
     */
    public function forgetCache(): void
    {
        Cache::forget(self::CACHE_KEY);

        // The CSS is printed in every store page, so full-page cache must go too.
        if (config('responsecache.enabled')) {
            ResponseCache::clear();
        }
    }
}
