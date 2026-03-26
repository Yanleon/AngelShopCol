<?php

namespace Webkul\Epayco\Payment;

use Illuminate\Support\Facades\Storage;
use Webkul\Payment\Payment\Payment;

class Epayco extends Payment
{
    protected $code = 'epayco';

    public function getImage()
    {
        $uploaded = $this->getConfigData('image');

        if ($uploaded) {
            return Storage::url($uploaded);
        }

        return null;
    }

    public function getRedirectUrl()
    {
        return route('epayco.standard.set-order');
    }

    public function getOrder()
    {
        return $this->order;
    }

    public function process()
    {
        // Handled by JS checkout, no server-side process needed
        return true;
    }
}
