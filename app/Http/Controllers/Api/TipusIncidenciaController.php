<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\TipusIncidencia;
use App\Http\Controllers\Controller;
use App\Http\Resources\TipusIncidenciaResource;

class TipusIncidenciaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tipusIncidencies = TipusIncidencia::all();

        return TipusIncidenciaResource::collection($tipusIncidencies);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\TipusIncidencia  $tipusIncidencia
     * @return \Illuminate\Http\Response
     */
    public function show(TipusIncidencia $tipusIncidencia)
    {
        return new TipusIncidenciaResource($tipusIncidencia);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\TipusIncidencia  $tipusIncidencia
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, TipusIncidencia $tipusIncidencia)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\TipusIncidencia  $tipusIncidencia
     * @return \Illuminate\Http\Response
     */
    public function destroy(TipusIncidencia $tipusIncidencia)
    {
        //
    }
}
