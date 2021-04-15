<?php

namespace App\Http\Controllers\Api;

use App\Models\Afectat;
use App\Clases\Utilitat;
use App\Models\Incidencia;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\IncidenciaHasAfectats;
use App\Models\IncidenciaHasRecursos;
use Illuminate\Database\QueryException;
use App\Http\Resources\IncidenciaResource;

class IncidenciaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $incidencies = Incidencia::with(['incidencies_has_recursos.recurs', 'incidencies_has_recursos.afectat'])->get();

        return IncidenciaResource::collection($incidencies);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        DB::beginTransaction();
        $incidencia = new Incidencia();

        $incidencia->data = $request->input('data');
        $incidencia->hora = $request->input('hora');
        $incidencia->telefon_alertant = $request->input('telefon_alertant');
        $incidencia->adreca = $request->input('adreca');
        $incidencia->adreca_complement = $request->input('adreca_complement');
        $incidencia->descripcio = $request->input('descripcio');
        $incidencia->nom_metge = $request->input('nom_metge');

        $incidencia->tipus_incidencies_id = $request->input('tipus_incidencies_id');
        $incidencia->alertants_id = $request->input('alertants_id');
        $incidencia->municipis_id = $request->input('municipis_id');
        $incidencia->usuaris_id = $request->input('usuaris_id');

        $recursos = $request->input('recursos');


        try{
            $incidencia->save();
            $incidencia_id = $incidencia->id;

            foreach($recursos as $recurs){ // Incidencias con recurso asignado
                $ihr = new IncidenciaHasRecursos();
                $ihr->recursos_id = $recurs['recursos_id'];
                $ihr->afectats_id = $recurs['afectats_id'];
                $ihr->prioritat = $recurs['prioritat'];
                $ihr->hora_activacio = $recurs['hora_activacio'];

                $incidencia->incidencies_has_recursos()->save($ihr);

                $iha = new IncidenciaHasAfectats();
                $iha->afectats_id = $recurs['afectats_id']; // afectats id = 5,6 enlloc de 6,7
                $incidencia->incidencies_has_afectats()->save($iha);
            }
            if(array_key_exists("afectats", $request->input())){
                $afectats = $request->input('afectats');
                foreach($afectats as $afectat){
                    $afectatsInsert = new Afectat();
                    $afectatsInsert->cip = $afectat['cip'];
                    $afectatsInsert->nom = $afectat['nom'];
                    $afectatsInsert->cognoms = $afectat['cognoms'];
                    $afectatsInsert->edat = $afectat['edat'];
                    $afectatsInsert->te_cip = $afectat['te_cip'];
                    $afectatsInsert->sexes_id = $afectat['sexes_id'];
                    $afectatsInsert->save();

                    $iha2 = new IncidenciaHasAfectats();
                    $iha2->incidencies_id = $incidencia_id;
                    $afectatsInsert->incidencies_has_afectats()->save($iha2);
                }
            }

            DB::commit();
            $incidencia->refresh();
            $response = (new IncidenciaResource($incidencia))->response()->setStatusCode(201);
        }
        catch (QueryException $ex){
            DB::rollBack();
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }


    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Incidencia  $incidencia
     * @return \Illuminate\Http\Response
     */
    public function show(Incidencia $incidencium)
    {
        $incidencia = Incidencia::with(['incidencies_has_recursos.recurs', 'incidencies_has_recursos.afectat'])->find($incidencium->id);
        return new IncidenciaResource($incidencia);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Incidencia  $incidencia
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Incidencia $incidencium)
    {
        DB::beginTransaction();

        $incidencium->num_incident = $request->input('num_incident');
        $incidencium->data = $request->input('data');
        $incidencium->hora = $request->input('hora');
        $incidencium->telefon_alertant = $request->input('telefon_alertant');
        $incidencium->adreca = $request->input('adreca');
        $incidencium->adreca_complement = $request->input('adreca_complement');
        $incidencium->descripcio = $request->input('descripcio');
        $incidencium->nom_metge = $request->input('nom_metge');

        $incidencium->tipus_incidencies_id = $request->input('tipus_incidencies_id');
        $incidencium->alertants_id = $request->input('alertants_id');
        $incidencium->municipis_id = $request->input('municipis_id');
        $incidencium->usuaris_id = $request->input('usuaris_id');

        $hora_activacio =  $request->input('hora_activacio');
        $prioritat = $request->input('prioritat');
        $recursos = $request->input('recursos');


        try{
            $incidencium->save();

            $incidencium->incidencies_has_recursos()->delete();

            foreach($recursos as $recurs){
                $ihr = new IncidenciaHasRecursos();
                $ihr->recursos_id = $recurs['recursos_id'];
                $ihr->afectats_id = $recurs['afectats_id'];
                $ihr->prioritat = $prioritat;
                $ihr->hora_activacio = $hora_activacio;

                $incidencium->incidencies_has_recursos()->save($ihr);
            }
            DB::commit();
            $incidencium->refresh();
            $response = (new IncidenciaResource($incidencium))->response()->setStatusCode(201);
        }
        catch (QueryException $ex){
            DB::rollBack();
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Incidencia  $incidencia
     * @return \Illuminate\Http\Response
     */
    public function destroy(Incidencia $incidencium)
    {
        try{
            $incidencium->afectats()->delete();
            $incidencium->incidencies_has_recursos()->delete();
            $incidencium->delete();

            $response = \response()->json(['missatge' => 'Registre esborrat correctament'], 200);
        }
        catch(QueryException $ex){
            $mensaje = Utilitat::errorMessage($ex);
            $response = \response()->json(['error' => $mensaje], 400);
        }

        return $response;
    }
}
