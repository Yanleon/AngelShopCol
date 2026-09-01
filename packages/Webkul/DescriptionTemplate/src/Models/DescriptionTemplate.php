<?php

namespace Webkul\DescriptionTemplate\Models;

use Illuminate\Database\Eloquent\Model;

class DescriptionTemplate extends Model
{
    /**
     * Table name.
     *
     * @var string
     */
    protected $table = 'description_templates';

    /**
     * Fillable properties.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'content',
    ];
}
