@extends('template')

@section('stylesheet')
    <link rel="stylesheet" href="{{ asset('style.css') }}">
@endsection

@section('title', 'CECOS')

@section('content')
    {{-- <h1>Benvingut al panel de CECOS, {{ Auth::user()->nom }} !</h1> --}}
    <cecosnav-component :userid={{ Auth::user()->id }}></cecosnav-component>

@endsection

