<?php

namespace App\Http\Controllers\Api;

use App\Clases\Utilitat;
use Illuminate\Http\Request;
use App\Models\TipusAlertant;
use App\Http\Controllers\Controller;
use Illuminate\Database\QueryException;
use App\Http\Resources\TipusAlertantResource;

class TipusAlertantController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tipusAlertants = TipusAlertant::all();

        return TipusAlertantResource::collection($tipusAlertants);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $tipusAlertant = new TipusAlertant();

        $tipusAlertant->tipus = $request->input('tipus');

        try{
            $tipusAlertant->save();
            $response = (new TipusAlertantResource($tipusAlertant))->response()->setStatusCode(201);
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
     * @param  \App\Models\TipusAlertant  $tipusAlertant
     * @return \Illuminate\Http\Response
     */
    public function show(TipusAlertant $tipusAlertant)
    {
        return new TipusAlertantResource($tipusAlertant);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\TipusAlertant  $tipusAlertant
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, TipusAlertant $tipusAlertant)
    {
        $tipusAlertant->tipus = $request->input('tipus');

        try{
            $tipusAlertant->save();
            $response = (new TipusAlertantResource($tipusAlertant))->response()->setStatusCode(201);
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
     * @param  \App\Models\TipusAlertant  $tipusAlertant
     * @return \Illuminate\Http\Response
     */
    public function destroy(TipusAlertant $tipusAlertant)
    {
        try{
            $tipusAlertant->delete();
            $response = \response()->json(['missatge' => 'Registro eliminado correctamente'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
