<?php

namespace Webkul\Admin\Http\Controllers\Marketing\Communications;

use Contact\Models\Contact;
use Webkul\Admin\DataGrids\Marketing\Communications\ContactFormDataGrid;
use Webkul\Admin\Http\Controllers\Controller;

class ContactFormController extends Controller
{
    public function index()
    {
        if (request()->ajax()) {
            return datagrid(ContactFormDataGrid::class)->process();
        }

        return view('admin::marketing.communications.contact-forms.index');
    }

    public function destroy(int $id)
    {
        $contact = Contact::findOrFail($id);

        $contact->delete();

        session()->flash('success', __('admin::app.response.delete-success', ['name' => 'Contacto']));

        return redirect()->back();
    }
}
