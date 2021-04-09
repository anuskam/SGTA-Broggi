@extends('template')

@section('stylesheet')
    <link rel="stylesheet" href="{{ asset('style.css') }}">
    <link href='https://api.mapbox.com/mapbox-gl-js/v1.4.1/mapbox-gl.css' rel='stylesheet' />
@endsection

@section('title', 'Recurs')

@section('content')
    {{-- <h1>Benvingut al panel de Recurs, {{ Auth::user()->nom }} !</h1> --}}
    <recursos-component></recursos-component>
    <script src='https://api.mapbox.com/mapbox-gl-js/v1.4.1/mapbox-gl.js'></script>
@endsection
