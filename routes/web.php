<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\UsuariController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::resource('/', UsuariController::class);


Route::resource('login', LoginController::class);
// Route::get('login', function () {
//     return view('login');
// });

/* Routes that require the user to be logged in */
// Route::middleware(['auth'])->group(function () {

// });

/* Routes that require the user to be admin or CECOS */
Route::middleware(['role:1,2'])->group(function () {
    Route::get('home', function(){
        return view('CECOS.index');
    });
});

/* Routes that require the user to be admin or Recurs */
Route::middleware(['role:1,3'])->group(function () {
    Route::get('home', function(){
        return view('Recurs.index');
    });
});

/* Routes that require the user to be admin */
Route::middleware(['role:1'])->group(function () {
    Route::get('home', function(){
        return view('home');
    });
});

