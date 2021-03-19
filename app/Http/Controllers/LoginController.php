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

    // public static function redirectHome()
    // {
    //     $role = Auth::user()->rols_id;
    //     switch ($role) {
    //         case '1':
    //             $response = view('Administrador/index');
    //             break;
    //         case '2':
    //             $response = view('CECOS/index');
    //             break;
    //         case '3':
    //             $response = view('Recurs/index');
    //             break;
    //         default:
    //             $response = view('login');
    //     }
    //     return $response;
    // }

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
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
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

            $usuari = Usuari::where('email', $username)->get()->first();
            if (!empty($usuari)) {
                $userPassword = $usuari->contrasenya;
                $passwordMatch = Hash::check($password, $userPassword);
                if ($passwordMatch) {
                    Auth::login($usuari);
                    $response = redirect('home');
                } else {
                    $response = redirect('login');
                }
            } else {
                $response = redirect('login');
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
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
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
