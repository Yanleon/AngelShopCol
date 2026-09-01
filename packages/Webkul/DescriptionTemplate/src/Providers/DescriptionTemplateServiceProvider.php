<?php

namespace Webkul\DescriptionTemplate\Providers;

use Illuminate\Support\ServiceProvider;

class DescriptionTemplateServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        $this->loadMigrationsFrom(__DIR__.'/../../database/migrations');
    }

    /**
     * Register services.
     */
    public function register(): void
    {
        //
    }
}
