<?php

use App\Http\Controllers\AlertantController as ControllersAlertantController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AfectatController;
use App\Http\Controllers\Api\AlertantController;
use App\Http\Controllers\Api\ComarcaController;
use App\Http\Controllers\Api\IncidenciaController;
use App\Http\Controllers\Api\IncidenciaHasAfectatsController;
use App\Http\Controllers\Api\IncidenciaHasRecursosController;
use App\Http\Controllers\Api\LoginController;
use App\Http\Controllers\Api\MunicipiController;
use App\Http\Controllers\Api\ProvinciaController;
use App\Http\Controllers\Api\RecursController;
use App\Http\Controllers\Api\RolController;
use App\Http\Controllers\Api\SexeController;
use App\Http\Controllers\Api\TipusAlertantController;
use App\Http\Controllers\Api\TipusIncidenciaController;
use App\Http\Controllers\Api\TipusRecursController;
use App\Http\Controllers\Api\UsuariControllerApi;
use App\Http\Controllers\Api\PreguntaController;
use App\Http\Controllers\ProvinciaController as ControllersProvinciaController;
use App\Http\Controllers\Api\RespostaController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::apiResource('afectat', AfectatController::class);
Route::apiResource('alertant', AlertantController::class);
Route::apiResource('comarca', ComarcaController::class);
Route::apiResource('incidencia', IncidenciaController::class);
Route::apiResource('municipi', MunicipiController::class);
Route::apiResource('provincia', ProvinciaController::class);
Route::apiResource('recurs', RecursController::class);
Route::apiResource('rol', RolController::class);
Route::apiResource('sexe', SexeController::class);
Route::apiResource('tipusAlertant', TipusAlertantController::class);
Route::apiResource('tipusIncidencia', TipusIncidenciaController::class);
Route::apiResource('tipusRecurs', TipusRecursController::class);
Route::apiResource('usuari', UsuariControllerApi::class);
Route::apiResource('incidenciaHasRecursos', IncidenciaHasRecursosController::class);
Route::apiResource('incidenciaHasAfectats', IncidenciaHasAfectatsController::class);
Route::apiResource('pregunta', PreguntaController::class);
Route::apiResource('resposta', RespostaController::class);

// Route::get('alertantPaginated', [ControllersAlertantController::class, 'indexPaginated']);

