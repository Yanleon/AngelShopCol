<?php

namespace Webkul\Admin\DataGrids\Marketing\Communications;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Webkul\DataGrid\DataGrid;

class ContactFormDataGrid extends DataGrid
{
    public function prepareQueryBuilder()
    {
        $queryBuilder = DB::table('contacts')->select(
            'contacts.id',
            'contacts.name',
            'contacts.email',
            'contacts.phone',
            'contacts.message_title',
            'contacts.message_body',
            'contacts.message_reply',
            'contacts.created_at'
        );

        $this->addFilter('id', 'contacts.id');
        $this->addFilter('name', 'contacts.name');
        $this->addFilter('email', 'contacts.email');
        $this->addFilter('phone', 'contacts.phone');
        $this->addFilter('message_title', 'contacts.message_title');
        $this->addFilter('created_at', 'contacts.created_at');

        return $queryBuilder;
    }

    public function prepareColumns()
    {
        $this->addColumn([
            'index'      => 'id',
            'label'      => __('admin::app.marketing.communications.contact-forms.id'),
            'type'       => 'integer',
            'sortable'   => true,
        ]);

        $this->addColumn([
            'index'      => 'name',
            'label'      => __('admin::app.marketing.communications.contact-forms.name'),
            'type'       => 'string',
            'searchable' => true,
            'filterable' => true,
            'sortable'   => true,
        ]);

        $this->addColumn([
            'index'      => 'email',
            'label'      => __('admin::app.marketing.communications.contact-forms.email'),
            'type'       => 'string',
            'searchable' => true,
            'filterable' => true,
            'sortable'   => true,
        ]);

        $this->addColumn([
            'index'      => 'phone',
            'label'      => __('admin::app.marketing.communications.contact-forms.phone'),
            'type'       => 'string',
            'searchable' => true,
            'filterable' => true,
            'sortable'   => true,
        ]);

        $this->addColumn([
            'index'      => 'message_title',
            'label'      => __('admin::app.marketing.communications.contact-forms.subject'),
            'type'       => 'string',
            'searchable' => true,
            'filterable' => false,
            'sortable'   => false,
        ]);

        $this->addColumn([
            'index'      => 'message_body',
            'label'      => __('admin::app.marketing.communications.contact-forms.message'),
            'type'       => 'string',
            'searchable' => true,
            'filterable' => false,
            'sortable'   => false,
            'closure'    => function ($row) {
                return Str::limit($row->message_body, 120);
            },
        ]);

        $this->addColumn([
            'index'      => 'message_reply',
            'label'      => __('admin::app.marketing.communications.contact-forms.reply'),
            'type'       => 'string',
            'searchable' => false,
            'filterable' => false,
            'sortable'   => false,
            'closure'    => function ($row) {
                return Str::limit((string) $row->message_reply, 120);
            },
        ]);

        $this->addColumn([
            'index'      => 'created_at',
            'label'      => __('admin::app.marketing.communications.contact-forms.created-at'),
            'type'       => 'datetime',
            'sortable'   => true,
            'filterable' => true,
        ]);

        $this->addColumn([
            'index'      => 'contact_actions',
            'label'      => 'Acciones',
            'type'       => 'string',
            'searchable' => false,
            'filterable' => false,
            'sortable'   => false,
            'escape'     => false,
            'closure'    => function ($row) {
                $phoneDigits = $row->phone ? preg_replace('/\D+/', '', $row->phone) : null;
                $waUrl = $phoneDigits
                    ? 'https://wa.me/'.$phoneDigits.'?text='.urlencode('Hola '.$row->name.', respecto a tu consulta: '.$row->message_title)
                    : null;

                $pencilIcon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="h-5 w-5 fill-current"><path d="m3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25Zm2.92 2.33H5v-.92l9.06-9.05.92.92-9.06 9.05ZM20.71 7.04a1 1 0 0 0 0-1.41l-2.34-2.34a1 1 0 0 0-1.41 0l-1.82 1.82 3.75 3.75 1.82-1.82Z"/></svg>';

                $trashIcon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="h-5 w-5 fill-current"><path d="M9 3a1 1 0 0 0-1 1v1H4a1 1 0 1 0 0 2h1v11a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7h1a1 1 0 1 0 0-2h-4V4a1 1 0 0 0-1-1H9Zm0 3h6V4H9v2Zm-1 2v10h10V8H8Zm2 2a1 1 0 0 1 2 0v6a1 1 0 1 1-2 0v-6Zm5 0a1 1 0 0 1 2 0v6a1 1 0 1 1-2 0v-6Z"/></svg>';

                $whatsAppBtn = $waUrl
                    ? '<a href="'.$waUrl.'" target="_blank" class="inline-flex items-center rounded p-1.5 text-gray-600 hover:bg-gray-100" title="WhatsApp">'.$pencilIcon.'</a>'
                    : '<span class="text-xs text-gray-400">Sin teléfono</span>';

                $deleteForm = '<form method="POST" action="'.route('admin.marketing.communications.contact_forms.delete', $row->id).'" style="display:inline" onsubmit="return confirm(\'¿Eliminar este mensaje?\')">'
                    .csrf_field()
                    .method_field('DELETE')
                    .'<button type="submit" class="ml-2 inline-flex items-center rounded p-1.5 text-gray-600 hover:bg-gray-100" title="Eliminar">'.$trashIcon.'</button>'
                    .'</form>';

                return '<div class="flex items-center">'.$whatsAppBtn.$deleteForm.'</div>';
            },
        ]);
    }
}
