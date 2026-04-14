<?php

namespace Contact\Http\Controllers;

use Contact\Models\Contact;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class ContactController extends Controller
{
    public function index()
    {
        return view('contact::contact');
    }

    public function store(Request $request)
    {
        $request->validate([
            'nombre'    => 'required',
            'email'     => 'required|email',
            'telefono'  => 'nullable|string|max:191',
            'mensaje'   => 'required',
            'asunto'    => 'nullable|string',
            'respuesta' => 'nullable|string',
        ]);

        $contact = Contact::create([
            'name'          => $request->nombre,
            'email'         => $request->email,
            'phone'         => $request->input('telefono'),
            'message_title' => $request->input('asunto', 'Mensaje de contacto'),
            'message_body'  => $request->mensaje,
            'message_reply' => $request->input('respuesta'),
        ]);

        $adminEmail = config('mail.from.address') ?: 'admin@example.com';

        try {
            Mail::raw(
                "Mensaje de: {$request->nombre}\nEmail: {$request->email}\nTeléfono: ".($request->input('telefono') ?: 'N/D')."\nAsunto: ".($request->input('asunto', 'Mensaje de contacto'))."\n\n{$request->mensaje}",
                function ($msg) use ($adminEmail, $request) {
                    $msg->to($adminEmail)->subject('Nuevo mensaje de contacto');
                    $msg->replyTo($request->email, $request->nombre);
                }
            );
        } catch (\Throwable $e) {
            Log::warning('No se pudo enviar correo de contacto', [
                'error'     => $e->getMessage(),
                'contactId' => $contact->id,
            ]);
        }

        return back()->with('success', '¡Tu mensaje se ha enviado correctamente!');
    }
}
