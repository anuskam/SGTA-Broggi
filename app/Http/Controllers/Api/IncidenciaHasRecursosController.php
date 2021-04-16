<?php

namespace App\Http\Controllers\Api;

use App\Models\IncidenciaHasRecursos;
use App\Http\Controllers\Controller;
use App\Http\Resources\IncidenciaHasRecursosResource;
use Illuminate\Http\Request;

class IncidenciaHasRecursosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $recursos = IncidenciaHasRecursos::all();

        return IncidenciaHasRecursosResource::collection($recursos);
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
     * @param  \App\Models\IncidenciaHasRecursos  $incidenciaHasRecursos
     * @return \Illuminate\Http\Response
     */
    public function show(IncidenciaHasRecursos $incidenciaHasRecurso)
    {
        return new IncidenciaHasRecursosResource($incidenciaHasRecurso);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\IncidenciaHasRecursos  $incidenciaHasRecursos
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, IncidenciaHasRecursos $incidenciaHasRecurso)
    {

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\IncidenciaHasRecursos  $incidenciaHasRecursos
     * @return \Illuminate\Http\Response
     */
    public function destroy(IncidenciaHasRecursos $incidenciaHasRecurso)
    {
        //
    }
}
