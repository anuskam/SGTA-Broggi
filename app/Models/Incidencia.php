<?php

namespace App\Models;

use App\Models\Recurs;
use App\Models\Usuari;
use App\Models\Afectat;
use App\Models\Alertant;
use App\Models\Municipi;
use App\Models\TipusIncidencia;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Incidencia extends Model
{
    use HasFactory;

    protected $table = 'incidencies';
    public $timestamps = false;

    public function afectats(){
        return $this->belongsToMany(Afectat::class, 'incidencies_has_afectats', 'incidencies_id', 'afectats_id')->as('incidencies_has_afectats');
    }

    public function tipusIncidencia(){
        return $this->belongsTo(TipusIncidencia::class, 'tipus_incidencies_id');
    }

    public function municipi(){
        return $this->belongsTo(Municipi::class, 'municipis_id');
    }

    public function alertant(){
        return $this->belongsTo(Alertant::class, 'alertants_id');
    }

    public function usuari(){
        return $this->belongsTo(Usuari::class, 'usuaris_id');
    }

    public function recursos(){
        return $this->belongsToMany(Recurs::class, 'incidencies_has_recursos', 'incidencies_id', 'recursos_id')->as('incidencies_has_recursos');
    }
}
