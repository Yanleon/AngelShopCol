<?php

namespace Contact\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Mail;

class ContactController extends Controller
{
    public function index()
    {
        return view('contact::contact');
    }

    public function send(Request $request)
    {
        $request->validate([
            'nombre' => 'required',
            'email' => 'required|email',
            'mensaje' => 'required',
        ]);

        // Aquí podrías guardar en base de datos o enviar correo
        Mail::raw("Mensaje de: {$request->nombre}\nEmail: {$request->email}\n\n{$request->mensaje}", function ($msg) {
            $msg->to('admin@tusitio.com')->subject('Nuevo mensaje de contacto');
        });

        return back()->with('success', '¡Tu mensaje se ha enviado correctamente!');
    }
}
