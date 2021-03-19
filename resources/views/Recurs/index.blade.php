@extends('template')

@section('stylesheet')
    <link rel="stylesheet" href="{{ asset('style.css') }}">
@endsection

@section('title', 'Recurs')

@section('content')
    <a href="{{ url('logout') }}">
        <div class="btn btn-danger">Log Out</div>
    </a>
    <h1>Benvingut al panel de Recurs, {{ Auth::user()->nom }} !</h1>
@endsection
