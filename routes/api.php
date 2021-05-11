<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AfectatController;
use App\Http\Controllers\Api\AlertantController;
use App\Http\Controllers\Api\ComarcaController;
use App\Http\Controllers\Api\IncidenciaController;
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
Route::post('afectat/update/{afectat}', [AfectatController::class, 'update']);
Route::post('afectat/delete/{afectat}', [AfectatController::class, 'destroy']);

Route::apiResource('alertant', AlertantController::class);
Route::post('alertant/update/{alertant}', [AlertantController::class, 'update']);
Route::post('alertant/delete/{alertant}', [AlertantController::class, 'destroy']);

Route::apiResource('comarca', ComarcaController::class);

Route::apiResource('incidencia', IncidenciaController::class);
Route::post('incidencia/update/{incidencium}', [IncidenciaController::class, 'update']);
Route::post('incidencia/delete/{incidencium}', [IncidenciaController::class, 'destroy']);

Route::apiResource('municipi', MunicipiController::class);
Route::apiResource('provincia', ProvinciaController::class);

Route::apiResource('recurs', RecursController::class);
Route::post('recurs/update/{recur}', [RecursController::class, 'update']);
Route::post('recurs/delete/{recur}', [RecursController::class, 'destroy']);

Route::apiResource('rol', RolController::class);
Route::apiResource('sexe', SexeController::class);
Route::apiResource('tipusAlertant', TipusAlertantController::class);
Route::apiResource('tipusIncidencia', TipusIncidenciaController::class);
Route::apiResource('tipusRecurs', TipusRecursController::class);

Route::apiResource('usuari', UsuariControllerApi::class);
Route::post('usuari/update/{usuari}', [UsuariControllerApi::class, 'update']);
Route::post('usuari/delete/{usuari}', [UsuariControllerApi::class, 'destroy']);

Route::apiResource('incidenciaHasRecursos', IncidenciaHasRecursosController::class);
Route::post('incidenciaHasRecursos/update/{incidenciaHasRecurso}', [IncidenciaHasRecursosController::class, 'update']);
Route::post('incidenciaHasRecursos/delete/{incidenciaHasRecurso}', [IncidenciaHasRecursosController::class, 'destroy']);
