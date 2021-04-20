<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\IncidenciaHasAfectatsResource;
use App\Models\IncidenciaHasAfectats;
use Illuminate\Http\Request;

class IncidenciaHasAfectatsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $recursos = IncidenciaHasAfectats::all();

        return IncidenciaHasAfectatsResource::collection($recursos);
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
    public function show(IncidenciaHasAfectats $incidenciaHasRecurso)
    {
        return new IncidenciaHasAfectatsController($incidenciaHasRecurso);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\IncidenciaHasRecursos  $incidenciaHasRecursos
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, IncidenciaHasAfectats $incidenciaHasRecurso)
    {

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\IncidenciaHasRecursos  $incidenciaHasRecursos
     * @return \Illuminate\Http\Response
     */
    public function destroy(IncidenciaHasAfectats $incidenciaHasRecurso)
    {
        //
    }
}
