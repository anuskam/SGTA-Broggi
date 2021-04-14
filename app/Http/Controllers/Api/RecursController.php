<?php

namespace App\Http\Controllers\Api;

use App\Models\Recurs;
use App\Clases\Utilitat;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\RecursResource;
use Illuminate\Database\QueryException;

class RecursController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $recursos = Recurs::all();

        return RecursResource::collection($recursos);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $recurs = new Recurs();

        $recurs->codi = $request->input('codi');
        $recurs->actiu = ($request->input('actiu') == 'actiu');

        $recurs->tipus_recursos_id = $request->input('tipus_recursos_id');

        try{
            $recurs->save();
            $response = (new RecursResource($recurs))->response()->setStatusCode(201);
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
     * @param  \App\Models\Recurs  $recurs
     * @return \Illuminate\Http\Response
     */
    public function show(Recurs $recur)
    {
        return new RecursResource($recur);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Recurs  $recurs
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Recurs $recur)
    {
        $recur->codi = $request->input('codi');
        $recur->actiu = ($request->input('actiu') == 'actiu');

        $recur->tipus_recursos_id = $request->input('tipus_recursos_id');

        try{
            $recur->save();
            $response = (new RecursResource($recur))->response()->setStatusCode(201);
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
     * @param  \App\Models\Recurs  $recurs
     * @return \Illuminate\Http\Response
     */
    public function destroy(Recurs $recur)
    {
        try{
            $recur->delete();
            $response = \response()->json(['missatge' => 'Registre esborrat correctament'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
