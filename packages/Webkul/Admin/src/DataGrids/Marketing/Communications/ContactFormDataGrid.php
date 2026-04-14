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

                $whatsAppIcon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" class="h-5 w-5 fill-current"><path d="M16 3a13 13 0 0 0-11.03 20.13L3 29l6.07-1.92A13 13 0 1 0 16 3Zm0 2a11 11 0 0 1 9.36 16.72l-.27.43.2 1.18-1.18-.32-.5-.14-.47.29A11 11 0 1 1 5 16 11 11 0 0 1 16 5Zm-4.64 5.38c-.18-.41-.37-.42-.54-.43h-.46c-.16 0-.42.06-.64.3-.22.23-.85.83-.85 2s.87 2.3 1 2.46c.12.16 1.68 2.7 4.1 3.8 2.03.9 2.44.72 2.88.68.44-.04 1.42-.58 1.62-1.13.2-.55.2-1.02.14-1.13-.06-.11-.22-.18-.46-.3-.24-.12-1.42-.7-1.64-.78-.22-.08-.38-.12-.54.12-.16.24-.62.78-.76.94-.14.16-.28.18-.52.06-.24-.12-1-.37-1.9-1.17-.7-.62-1.17-1.38-1.3-1.62-.14-.24-.01-.37.1-.49.1-.1.24-.26.36-.39.12-.13.16-.22.24-.38.08-.16.04-.3-.02-.42-.06-.12-.54-1.3-.74-1.78Z"/></svg>';

                $trashIcon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="h-5 w-5 fill-current"><path d="M9 3a1 1 0 0 0-1 1v1H4a1 1 0 1 0 0 2h1v11a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7h1a1 1 0 1 0 0-2h-4V4a1 1 0 0 0-1-1H9Zm0 3h6V4H9v2Zm-1 2v10h10V8H8Zm2 2a1 1 0 0 1 2 0v6a1 1 0 1 1-2 0v-6Zm5 0a1 1 0 0 1 2 0v6a1 1 0 1 1-2 0v-6Z"/></svg>';

                $whatsAppBtn = $waUrl
                    ? '<a href="'.$waUrl.'" target="_blank" class="inline-flex items-center rounded p-1.5 text-gray-600 hover:bg-gray-100" title="WhatsApp">'.$whatsAppIcon.'</a>'
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
