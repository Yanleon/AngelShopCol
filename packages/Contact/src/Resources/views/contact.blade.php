@extends('shop::layouts.master')

@section('page_title')
Contáctanos
@endsection

@section('content')
<div class="container mt-5">
    <h2 class="mb-4 text-center">Formulario de Contacto</h2>

    @if(session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif

    <form action="{{ route('contact.store') }}" method="POST">
        @csrf
        <div class="form-group mb-3">
            <label>Nombre:</label>
            <input type="text" name="nombre" class="form-control" required>
        </div>

        <div class="form-group mb-3">
            <label>Correo electrónico:</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="form-group mb-3">
            <label>Mensaje:</label>
            <textarea name="mensaje" rows="4" class="form-control" required></textarea>
        </div>

        <button type="submit" class="btn btn-primary w-100">Enviar</button>
    </form>
</div>
@endsection
