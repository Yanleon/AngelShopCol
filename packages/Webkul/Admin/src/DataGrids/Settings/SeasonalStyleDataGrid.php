<?php

namespace Webkul\Admin\DataGrids\Settings;

use Illuminate\Support\Facades\DB;
use Webkul\DataGrid\DataGrid;

class SeasonalStyleDataGrid extends DataGrid
{
    /**
     * Prepare query builder.
     *
     * @return \Illuminate\Database\Query\Builder
     */
    public function prepareQueryBuilder()
    {
        return DB::table('seasonal_styles')
            ->select(
                'id',
                'name',
                'is_active',
                'updated_at'
            );
    }

    /**
     * Add Columns.
     *
     * @return void
     */
    public function prepareColumns()
    {
        $this->addColumn([
            'index'      => 'name',
            'label'      => trans('admin::app.settings.seasonal-styles.index.datagrid.name'),
            'type'       => 'string',
            'searchable' => true,
            'filterable' => true,
            'sortable'   => true,
        ]);

        $this->addColumn([
            'index'      => 'is_active',
            'label'      => trans('admin::app.settings.seasonal-styles.index.datagrid.status'),
            'type'       => 'boolean',
            'filterable' => true,
            'sortable'   => true,
        ]);

        $this->addColumn([
            'index'      => 'updated_at',
            'label'      => trans('admin::app.settings.seasonal-styles.index.datagrid.updated-at'),
            'type'       => 'datetime',
            'sortable'   => true,
        ]);
    }

    /**
     * Prepare actions.
     *
     * @return void
     */
    public function prepareActions()
    {
        if (bouncer()->hasPermission('settings.seasonal_styles.edit')) {
            $this->addAction([
                'index'  => 'toggle',
                'icon'   => 'icon-checkbox-select',
                'title'  => trans('admin::app.settings.seasonal-styles.index.datagrid.toggle'),
                'method' => 'POST',
                'url'    => function ($row) {
                    return route('admin.settings.seasonal_styles.toggle', $row->id);
                },
            ]);

            $this->addAction([
                'index'  => 'edit',
                'icon'   => 'icon-edit',
                'title'  => trans('admin::app.settings.seasonal-styles.index.datagrid.edit'),
                'method' => 'GET',
                'url'    => function ($row) {
                    return route('admin.settings.seasonal_styles.edit', $row->id);
                },
            ]);
        }

        if (bouncer()->hasPermission('settings.seasonal_styles.delete')) {
            $this->addAction([
                'index'  => 'delete',
                'icon'   => 'icon-delete',
                'title'  => trans('admin::app.settings.seasonal-styles.index.datagrid.delete'),
                'method' => 'DELETE',
                'url'    => function ($row) {
                    return route('admin.settings.seasonal_styles.delete', $row->id);
                },
            ]);
        }
    }
}
