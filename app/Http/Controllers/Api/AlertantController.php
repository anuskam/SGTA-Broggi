<?php

namespace App\Http\Controllers\Api;

use App\Clases\Utilitat;
use App\Models\Alertant;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Database\QueryException;
use App\Http\Resources\AlertantResource;

class AlertantController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $alertants = Alertant::all();

        return AlertantResource::collection($alertants);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $alertant = new Alertant();

        $alertant->telefon = $request->input('telefon');
        $alertant->nom = $request->input('nom');
        $alertant->cognoms = $request->input('cognoms');
        $alertant->adreca = $request->input('adreca');

        $alertant->municipis_id = $request->input('municipis_idFK');
        $alertant->tipus_alertants_id = $request->input('tipus_alertants_idFK');


        try{
            $alertant->save();
            $response = (new AlertantResource($alertant))->response()->setStatusCode(201);
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
     * @param  \App\Models\Alertant  $alertant
     * @return \Illuminate\Http\Response
     */
    public function show(Alertant $alertant)
    {
        return new AlertantResource($alertant);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Alertant  $alertant
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Alertant $alertant)
    {
        $alertant->telefon = $request->input('telefon');
        $alertant->nom = $request->input('nom');
        $alertant->cognoms = $request->input('cognoms');
        $alertant->adreca = $request->input('adreca');

        $alertant->municipis_id = $request->input('municipis_idFK');
        $alertant->tipus_alertants_id = $request->input('tipus_alertants_idFK');


        try{
            $alertant->save();
            $response = (new AlertantResource($alertant))->response()->setStatusCode(201);
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
     * @param  \App\Models\Alertant  $alertant
     * @return \Illuminate\Http\Response
     */
    public function destroy(Alertant $alertant)
    {
        try{
            $alertant->delete();
            $response = \response()->json(['missatge' => 'Registre esborrat correctament'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
