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

Route::get('/', [UsuariController::class, 'index']);

Route::post('store', [UsuariController::class, 'store']);

Route::get('home', [UsuariController::class, 'index']);

Route::get('/', [UsuariController::class, 'index']);

Route::resource('login', LoginController::class);

Route::get('create', [UsuariController::class, 'create']); // Debe estar en el middleware de admin

/* Routes that require the user to be logged in */
Route::middleware(['auth'])->group(function () {
    Route::get('logout', [UsuariController::class, 'logout']);
});

/* Routes that require the user to be admin or CECOS */
Route::middleware(['role:1,2'])->group(function () {

});

/* Routes that require the user to be admin or Recurs */
Route::middleware(['role:1,3'])->group(function () {

});

/* Routes that require the user to be admin */
// Route::middleware(['role:1'])->group(function () {
//     Route::get('create', [UsuariController::class, 'create']);
// });


