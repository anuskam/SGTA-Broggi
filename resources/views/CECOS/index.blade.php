@extends('template')

@section('stylesheet')
    <link rel="stylesheet" href="{{ asset('style.css') }}">
@endsection

@section('title', 'CECOS')

@section('content')
    <a href="{{ url('logout') }}">
        <div class="btn btn-danger">Log Out</div>
    </a>
    <h1>Benvingut al panel de CECOS, {{ Auth::user()->nom }} !</h1>
@endsection

