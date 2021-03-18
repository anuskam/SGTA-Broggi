<?php

use Illuminate\Support\Facades\Route;

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

Route::get('/', function () {
    return view('home');
});

Route::get('login', function () {
    return view('login');
});

/* Routes that require the user to be logged in */
Route::middleware(['auth'])->group(function () {

});

/* Routes that require the user to be admin or CECOS */
Route::middleware(['role:1,2'])->group(function () {

});

/* Routes that require the user to be admin or Recurs */
Route::middleware(['role:1,3'])->group(function () {

});

/* Routes that require the user to be admin */
Route::middleware(['role:1'])->group(function () {

});

