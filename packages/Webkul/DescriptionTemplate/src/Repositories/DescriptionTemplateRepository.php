<?php

namespace Webkul\DescriptionTemplate\Repositories;

use Webkul\Core\Eloquent\Repository;
use Webkul\DescriptionTemplate\Models\DescriptionTemplate;

class DescriptionTemplateRepository extends Repository
{
    /**
     * Specify model class name.
     */
    public function model(): string
    {
        return DescriptionTemplate::class;
    }
}
