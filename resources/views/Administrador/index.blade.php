@extends('template')

@section('title', 'Administrador')

@section('content')
    {{-- <a href="{{ url('create') }}">
        <div class="btn btn-primary">Crear Usuari</div>
    </a>
    <h1>Benvingut al panel d'Administrador, {{ Auth::user()->nom }} !</h1> --}}
    <administrador-component></administrador-component>
@endsection
