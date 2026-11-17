<?php

namespace Webkul\SeasonalStyle\Providers;

use Illuminate\Support\ServiceProvider;

class SeasonalStyleServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        $this->loadMigrationsFrom(__DIR__.'/../../database/migrations');
    }
}
