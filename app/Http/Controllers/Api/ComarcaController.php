<?php

namespace App\Http\Controllers\Api;

use App\Models\Comarca;
use App\Clases\Utilitat;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\ComarcaResource;
use Illuminate\Database\QueryException;

class ComarcaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $comarques = Comarca::all();

        return ComarcaResource::collection($comarques);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $comarca = new Comarca();

        $comarca->nom = $request->input('nom');

        $comarca->provincies_id = $request->input('provincies_idFK');

        try{
            $comarca->save();
            $response = (new ComarcaResource($comarca))->response()->setStatusCode(201);
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
     * @param  \App\Models\Comarca  $comarca
     * @return \Illuminate\Http\Response
     */
    public function show(Comarca $comarca)
    {
        return new ComarcaResource($comarca);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Comarca  $comarca
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Comarca $comarca)
    {
        $comarca->nom = $request->input('nom');

        $comarca->provincies_id = $request->input('provincies_idFK');

        try{
            $comarca->save();
            $response = (new ComarcaResource($comarca))->response()->setStatusCode(201);
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
     * @param  \App\Models\Comarca  $comarca
     * @return \Illuminate\Http\Response
     */
    public function destroy(Comarca $comarca)
    {
        try{
            $comarca->delete();
            $response = \response()->json(['missatge' => 'Registro eliminado correctamente'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
