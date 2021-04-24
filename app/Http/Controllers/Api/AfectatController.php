<?php

namespace App\Http\Controllers\Api;

use App\Models\Afectat;
use App\Clases\Utilitat;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\AfectatResource;
use Illuminate\Database\QueryException;

class AfectatController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $afectats = Afectat::all();

        return AfectatResource::collection($afectats);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $afectat = new Afectat();

        $afectat->cip = $request->input('cip');
        $afectat->nom = $request->input('nom');
        $afectat->cognoms = $request->input('cognoms');
        $afectat->edat = $request->input('edat');

        $afectat->te_cip = ($request->input('te_cip') == 'te_cip');

        $afectat->sexes_id = $request->input('sexes_id');

        try{
            $afectat->save();
            $response = (new AfectatResource($afectat))->response()->setStatusCode(201);
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
     * @param  \App\Models\Afectat  $afectat
     * @return \Illuminate\Http\Response
     */
    public function show(Afectat $afectat)
    {
        return new AfectatResource($afectat);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Afectat  $afectat
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Afectat $afectat)
    {
        $afectat->telefon = $request->input('telefon');
        $afectat->cip = $request->input('cip');
        $afectat->nom = $request->input('nom');
        $afectat->cognoms = $request->input('cognoms');
        $afectat->edat = $request->input('edat');

        $afectat->te_cip = ($request->input('te_cip') == 'te_cip');

        $afectat->sexes_id = $request->input('sexes_id');

        try{
            $afectat->save();
            $response = (new AfectatResource($afectat))->response()->setStatusCode(201);
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
     * @param  \App\Models\Afectat  $afectat
     * @return \Illuminate\Http\Response
     */
    public function destroy(Afectat $afectat)
    {
        try{
            $afectat->delete();
            $response = \response()->json(['missatge' => 'Registro eliminado correctamente'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
