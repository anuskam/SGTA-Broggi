<?php

namespace App\Http\Controllers\Api;

use App\Models\Usuari;
use App\Clases\Utilitat;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use App\Http\Resources\UsuariResource;
use Illuminate\Database\QueryException;

class UsuariController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $usuaris = Usuari::all();

        return UsuariResource::collection($usuaris);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $usuari = new Usuari();

        $usuari->username = $request->input('username');
        $usuari->contrasenya = Hash::make($request->input('contrasenya'));
        $usuari->email = $request->input('email');
        $usuari->nom = $request->input('nom');
        $usuari->cognoms = $request->input('cognoms');


        $usuari->rols_id = $request->input('rols_id');
        $usuari->recursos_id = $request->input('recursos_id');

        try{
            $usuari->save();
            $response = (new UsuariResource($usuari))->response()->setStatusCode(201);
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
     * @param  \App\Models\Usuari  $usuari
     * @return \Illuminate\Http\Response
     */
    public function show(Usuari $usuari)
    {
        return new UsuariResource($usuari);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Usuari  $usuari
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Usuari $usuari)
    {
        $usuari->username = $request->input('username');
        $usuari->email = $request->input('email');
        $usuari->nom = $request->input('nom');
        $usuari->cognoms = $request->input('cognoms');


        $usuari->rols_id = $request->input('rols_id');
        $usuari->recursos_id = $request->input('recursos_id');

        try{
            $usuari->save();
            $response = (new UsuariResource($usuari))->response()->setStatusCode(201);
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
     * @param  \App\Models\Usuari  $usuari
     * @return \Illuminate\Http\Response
     */
    public function destroy(Usuari $usuari)
    {
        try{
            $usuari->delete();
            $response = \response()->json(['missatge' => 'Registre esborrat correctament'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
