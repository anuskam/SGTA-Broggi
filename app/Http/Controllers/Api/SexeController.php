<?php

namespace App\Http\Controllers\Api;

use App\Models\Sexe;
use App\Clases\Utilitat;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\SexeResource;
use Illuminate\Database\QueryException;

class SexeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $sexes = Sexe::all();

        return SexeResource::collection($sexes);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $sexe = new Sexe();

        $sexe->sexe = $request->input('sexe');

        try{
            $sexe->save();
            $response = (new SexeResource($sexe))->response()->setStatusCode(201);
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
     * @param  \App\Models\Sexe  $sexe
     * @return \Illuminate\Http\Response
     */
    public function show(Sexe $sexe)
    {
        return new SexeResource($sexe);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Sexe  $sexe
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Sexe $sexe)
    {
        $sexe->sexe = $request->input('sexe');

        try{
            $sexe->save();
            $response = (new SexeResource($sexe))->response()->setStatusCode(201);
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
     * @param  \App\Models\Sexe  $sexe
     * @return \Illuminate\Http\Response
     */
    public function destroy(Sexe $sexe)
    {
        try{
            $sexe->delete();
            $response = \response()->json(['missatge' => 'Registro eliminado correctamente'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
