<?php

namespace App\Http\Controllers;

use App\Models\Usuari;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Cache\RedisStore;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class LoginController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */


    public function index()
    {
        if(!Auth::check()){
            $response = view('login');
        }
        else{
            $response = redirect('home');
        }
        return $response;
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        /* Comprobar que usuario existe en la base de datos | Si existe usuario hacer login y redirigir a home, sino redirigir a login */
        if (Auth::check()) {
            $response = redirect('home');
        } else {
            $username = $request->input('username');
            $password = $request->input('password');

            $usuari = Usuari::where('username', $username)->get()->first();
            if (!empty($usuari)) {
                $userPassword = $usuari->contrasenya;
                $passwordMatch = Hash::check($password, $userPassword);
                if ($passwordMatch) {
                    Auth::login($usuari);
                    $response = redirect('home');
                } else {
                    $response = redirect('login')->withInput()->withErrors(['La contraseña es incorrecta']);
                    // Control Error contraseña incorrecta (try catches con clase Utilitat)!
                }
            } else {
                $response = redirect('login')->withInput()->withErrors(['El usuario no existe']);
                // Control Error no Existe usuario
            }
        }

        return $response;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
