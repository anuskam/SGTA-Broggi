@extends('template')

@section('stylesheet')
    <link rel="stylesheet" href="{{ asset('style.css') }}">
@endsection

@section('title', 'Recurs')

@section('content')
    {{-- <h1>Benvingut al panel de Recurs, {{ Auth::user()->nom }} !</h1> --}}
    <recursos-component></recursos-component>
@endsection
