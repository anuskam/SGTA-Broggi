<?php

namespace App\Http\Controllers;

use App\Models\Usuari;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UsuariController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $user = Auth::user();
        if (!Auth::check()) {
            $response = redirect('login');
        } else {
            /* Si usuari es Administrador */
            if ($user->rols_id == 1) {
                $response = view('Administrador.index');
            }
            /* Si usuari es CECOS */ else if ($user->rols_id == 2) {
                $response = view('CECOS.index');
            }
            /* Si usuari es Recurs */ else {
                $response = view('Recurs.index');
            }
        }

        return $response;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('Administrador.createUsuari');
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
        $findUsuari =  Usuari::where('username', $usuari->username)->get()->first();
        if(empty($findUsuari)){
            $usuari->contrasenya = Hash::make($request->input('contrasenya'));
            $usuari->email = $request->input('email');
            $usuari->nom = $request->input('nom');
            $usuari->cognoms = $request->input('cognoms');
            $usuari->rols_id = $request->input('rol');
            $usuari->save();
        }
        else{
            // Control errores
        }

        return redirect('login'); //Change redirect to home/?? for admin
    }

    public function logout()
    {
        if (Auth::check()) {
            Auth::logout();
        }

        return redirect('login');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Usuari  $usuari
     * @return \Illuminate\Http\Response
     */
    public function show(Usuari $usuari)
    {
        //
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Usuari  $usuari
     * @return \Illuminate\Http\Response
     */
    public function destroy(Usuari $usuari)
    {
        //
    }
}
