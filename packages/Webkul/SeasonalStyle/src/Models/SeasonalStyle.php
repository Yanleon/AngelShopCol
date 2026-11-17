<?php

namespace Webkul\SeasonalStyle\Models;

use Illuminate\Database\Eloquent\Model;

class SeasonalStyle extends Model
{
    /**
     * Table name.
     *
     * @var string
     */
    protected $table = 'seasonal_styles';

    /**
     * Fillable properties.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'css',
        'is_active',
    ];

    /**
     * Casts.
     *
     * @var array
     */
    protected $casts = [
        'is_active' => 'boolean',
    ];
}
