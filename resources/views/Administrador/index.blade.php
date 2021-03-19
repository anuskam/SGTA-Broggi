@extends('template')

@section('stylesheet')
    <link rel="stylesheet" href="{{ asset('style.css') }}">
@endsection

@section('title', 'Administrador')

@section('content')
    <a href="{{ url('logout') }}">
        <div class="btn btn-danger">Log Out</div>
    </a>
    <a href="{{ url('create') }}">
        <div class="btn btn-primary">Crear Usuari</div>
    </a>
    <h1>Benvingut al panel d'Administrador, {{ Auth::user()->nom }} !</h1>
@endsection
