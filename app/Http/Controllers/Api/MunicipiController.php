<?php

namespace App\Http\Controllers\Api;

use App\Clases\Utilitat;
use App\Models\Municipi;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Database\QueryException;
use App\Http\Resources\MunicipiResource;

class MunicipiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $municipis = Municipi::all();

        return MunicipiResource::collection($municipis);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $municipi = new Municipi();

        $municipi->nom = $request->input('nom');

        $municipi->comarques_id = $request->input('comarques_idFK');

        try{
            $municipi->save();
            $response = (new MunicipiResource($municipi))->response()->setStatusCode(201);
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
     * @param  \App\Models\Municipi  $municipi
     * @return \Illuminate\Http\Response
     */
    public function show(Municipi $municipi)
    {
        return new MunicipiResource($municipi);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Municipi  $municipi
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Municipi $municipi)
    {
        $municipi->nom = $request->input('nom');

        $municipi->comarques_id = $request->input('comarques_idFK');

        try{
            $municipi->save();
            $response = (new MunicipiResource($municipi))->response()->setStatusCode(201);
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
     * @param  \App\Models\Municipi  $municipi
     * @return \Illuminate\Http\Response
     */
    public function destroy(Municipi $municipi)
    {
        try{
            $municipi->delete();
            $response = \response()->json(['missatge' => 'Registro eliminado correctamentet'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
