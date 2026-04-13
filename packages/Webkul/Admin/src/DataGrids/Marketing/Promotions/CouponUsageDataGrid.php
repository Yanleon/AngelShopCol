<?php

namespace Webkul\Admin\DataGrids\Marketing\Promotions;

use Illuminate\Support\Facades\DB;
use Webkul\DataGrid\DataGrid;

class CouponUsageDataGrid extends DataGrid
{
    /**
     * Prepare query builder.
     */
    public function prepareQueryBuilder()
    {
        $queryBuilder = DB::table('orders')
            ->select(
                'orders.id',
                'orders.increment_id',
                'orders.coupon_code',
                'orders.customer_email',
                'orders.customer_first_name',
                'orders.customer_last_name',
                'orders.channel_name',
                'orders.base_grand_total',
                'orders.base_discount_amount',
                'orders.created_at'
            )
            ->whereNotNull('orders.coupon_code');

        $this->addFilter('increment_id', 'orders.increment_id');
        $this->addFilter('coupon_code', 'orders.coupon_code');
        $this->addFilter('customer_email', 'orders.customer_email');
        $this->addFilter('channel_name', 'orders.channel_name');
        $this->addFilter('created_at', 'orders.created_at');

        return $queryBuilder;
    }

    /**
     * Add columns.
     */
    public function prepareColumns()
    {
        $this->addColumn([
            'index'      => 'coupon_code',
            'label'      => __('admin::app.marketing.promotions.coupon-usage.coupon-code'),
            'type'       => 'string',
            'searchable' => true,
            'filterable' => true,
            'sortable'   => true,
        ]);

        $this->addColumn([
            'index'      => 'increment_id',
            'label'      => __('admin::app.marketing.promotions.coupon-usage.order-id'),
            'type'       => 'string',
            'searchable' => true,
            'filterable' => true,
            'sortable'   => true,
        ]);

        $this->addColumn([
            'index'      => 'customer_email',
            'label'      => __('admin::app.marketing.promotions.coupon-usage.customer'),
            'type'       => 'string',
            'searchable' => true,
            'filterable' => true,
            'sortable'   => true,
            'closure'    => function ($row) {
                return trim(($row->customer_first_name ?? '').' '.($row->customer_last_name ?? '')) ?: $row->customer_email;
            },
        ]);

        $this->addColumn([
            'index'      => 'channel_name',
            'label'      => __('admin::app.marketing.promotions.coupon-usage.channel'),
            'type'       => 'string',
            'filterable' => true,
            'sortable'   => true,
        ]);

        $this->addColumn([
            'index'      => 'base_grand_total',
            'label'      => __('admin::app.marketing.promotions.coupon-usage.grand-total'),
            'type'       => 'string',
            'sortable'   => true,
            'closure'    => function ($row) {
                return core()->formatBasePrice($row->base_grand_total);
            },
        ]);

        $this->addColumn([
            'index'      => 'base_discount_amount',
            'label'      => __('admin::app.marketing.promotions.coupon-usage.discount'),
            'type'       => 'string',
            'sortable'   => true,
            'closure'    => function ($row) {
                return core()->formatBasePrice($row->base_discount_amount);
            },
        ]);

        $this->addColumn([
            'index'      => 'created_at',
            'label'      => __('admin::app.marketing.promotions.coupon-usage.placed-at'),
            'type'       => 'datetime',
            'filterable' => true,
            'sortable'   => true,
        ]);
    }
}
