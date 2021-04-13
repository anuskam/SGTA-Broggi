<?php

namespace App\Models;

use App\Models\Sexe;
use App\Models\Incidencia;
use App\Models\IncidenciaHasRecursos;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Afectat extends Model
{
    use HasFactory;

    protected $table = 'afectats';
    public $timestamps = false;

    public function sexe(){
        return $this->belongsTo(Sexe::class, 'sexes_id');
    }

    public function incidencies(){
        return $this->belongsToMany(Incidencia::class, 'incidencies_has_afectats', 'afectats_id', 'incidencies_id')->as('incidencies_has_afectats');
    }

    public function incidencies_has_recursos(){
        return $this->hasMany(IncidenciaHasRecursos::class, 'afectats_id');
    }
}
