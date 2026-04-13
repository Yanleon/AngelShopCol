<?php

namespace Webkul\Admin\Http\Controllers\Marketing\Promotions;

use Webkul\Admin\DataGrids\Marketing\Promotions\CouponUsageDataGrid;
use Webkul\Admin\Http\Controllers\Controller;

class CouponUsageController extends Controller
{
    /**
     * Coupon usage report.
     */
    public function index()
    {
        if (request()->ajax()) {
            return datagrid(CouponUsageDataGrid::class)->process();
        }

        return view('admin::marketing.promotions.coupon-usage.index');
    }
}
