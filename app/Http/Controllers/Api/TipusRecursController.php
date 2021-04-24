<?php

namespace App\Http\Controllers\Api;

use App\Clases\Utilitat;
use App\Models\TipusRecurs;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Database\QueryException;
use App\Http\Resources\TipusRecursResource;

class TipusRecursController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tipusRecursos = TipusRecurs::all();

        return TipusRecursResource::collection($tipusRecursos);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $tipusRecurs = new TipusRecurs();

        $tipusRecurs->tipus = $request->input('tipus'); //CAMBIAMOS EL NOMBRE O DA IGUAL? PORQUE SON TODAS TIPO DE NOMBRE


        try{
            $tipusRecurs->save();
            $response = (new TipusRecursResource($tipusRecurs))->response()->setStatusCode(201);
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
     * @param  \App\Models\TipusRecurs  $tipusRecurs
     * @return \Illuminate\Http\Response
     */
    public function show(TipusRecurs $tipusRecur)
    {
        return new TipusRecursResource($tipusRecur);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\TipusRecurs  $tipusRecurs
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, TipusRecurs $tipusRecur)
    {
        $tipusRecur->tipus = $request->input('tipus'); //CAMBIAMOS EL NOMBRE O DA IGUAL? PORQUE SON TODAS TIPO DE NOMBRE

        try{
            $tipusRecur->save();
            $response = (new TipusRecursResource($tipusRecur))->response()->setStatusCode(201);
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
     * @param  \App\Models\TipusRecurs  $tipusRecurs
     * @return \Illuminate\Http\Response
     */
    public function destroy(TipusRecurs $tipusRecur)
    {
        try{
            $tipusRecur->delete();
            $response = \response()->json(['missatge' => 'Registro eliminado correctamente'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
