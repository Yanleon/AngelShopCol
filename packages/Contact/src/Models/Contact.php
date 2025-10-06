<?php

namespace Contact\Models;

use Illuminate\Database\Eloquent\Model;

class Contact extends Model
{
    protected $table = 'contacts';

    protected $fillable = [
        'nombre',
        'email',
        'mensaje'
    ];
}
