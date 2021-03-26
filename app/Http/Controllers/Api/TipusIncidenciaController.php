<?php

namespace App\Http\Controllers\Api;

use App\Clases\Utilitat;
use Illuminate\Http\Request;
use App\Models\TipusIncidencia;
use App\Http\Controllers\Controller;
use Illuminate\Database\QueryException;
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
        $tipusIncidencia = new TipusIncidencia();

        $tipusIncidencia->tipus = $request->input('tipus');
        $tipusIncidencia->video = $request->input('video');

        try{
            $tipusIncidencia->save();
            $response = (new TipusIncidenciaResource($tipusIncidencia))->response()->setStatusCode(201);
        }
        catch (QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\TipusIncidencia  $tipusIncidencia
     * @return \Illuminate\Http\Response
     */
    public function show(TipusIncidencia $tipusIncidencium)
    {
        return new TipusIncidenciaResource($tipusIncidencium);
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
        $tipusIncidencia->tipus = $request->input('tipus');
        $tipusIncidencia->video = $request->input('video');

        try{
            $tipusIncidencia->save();
            $response = (new TipusIncidenciaResource($tipusIncidencia))->response()->setStatusCode(201);
        }
        catch (QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\TipusIncidencia  $tipusIncidencia
     * @return \Illuminate\Http\Response
     */
    public function destroy(TipusIncidencia $tipusIncidencia)
    {
        try{
            $tipusIncidencia->delete();
            $response = \response()->json(['missatge' => 'Registre esborrat correctament'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
