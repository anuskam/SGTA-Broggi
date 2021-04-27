<?php

namespace App\Http\Controllers\Api;

use App\Clases\Utilitat;
use App\Models\Incidencia;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\IncidenciaHasRecursos;
use Illuminate\Database\QueryException;
use App\Http\Resources\IncidenciaHasRecursosResource;

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
    public function show($incidencia_id, $recurs_id)
    {
        $ihr = IncidenciaHasRecursos::where('incidencies_id', '=', $incidencia_id)->where('recursos_id', '=', $recurs_id)->first();
        return new IncidenciaHasRecursosResource($ihr);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\IncidenciaHasRecursos  $incidenciaHasRecursos
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $incidencia_id, $recurs_id)
    {
        $ihr = IncidenciaHasRecursos::where('incidencies_id', '=', $incidencia_id)->where('recursos_id', '=', $recurs_id)->first();

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\IncidenciaHasRecursos  $incidenciaHasRecursos
     * @return \Illuminate\Http\Response
     */
    public function destroy($incidencia_id, $recurs_id)
    {
        $ihr = IncidenciaHasRecursos::where('incidencies_id', '=', $incidencia_id)->where('recursos_id', '=', $recurs_id)->first();

        if(!empty($ihr)){
            try{
                $ihr->delete();
                $response = \response()->json(['missatge' => 'Registro eliminado correctamente'], 200);
            }
            catch(QueryException $ex){
                $mensaje = Utilitat::errorMessage($ex);
                $response = \response()->json(['error' => $mensaje], 400);
            }
        }

        return $response;
    }

    public function deleteIHR($incidencia_id, $recurs_id){
        $ihr = IncidenciaHasRecursos::where('incidencies_id', '=', $incidencia_id)->where('recursos_id', '=', $recurs_id)->first();
        if(!empty($ihr)){
            try{
                $ihr->delete();
                $response = \response()->json(['missatge' => 'Registro eliminado correctamente'], 200);
            }
            catch(QueryException $ex){
                $mensaje = Utilitat::errorMessage($ex);
                $response = \response()->json(['error' => $mensaje], 400);
            }
        }

        return $response;
    }
}
