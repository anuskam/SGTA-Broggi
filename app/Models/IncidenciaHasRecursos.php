<?php

namespace App\Models;

use App\Models\Recurs;
use App\Models\Afectat;
use App\Models\Incidencia;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class IncidenciaHasRecursos extends Model
{
    use HasFactory;

    protected $table = 'incidencies_has_recursos';
    public $timestamps = false;
    protected $primaryKey = ['incidencies_id', 'recursos_id', 'afectats_id'];
    public $incrementing = false;

    public function incidencia(){
        return $this->belongsTo(Incidencia::class, 'incidencies_id');
    }

    public function recurs(){
        return $this->belongsTo(Recurs::class, 'recursos_id');
    }

    public function afectat(){
        return $this->belongsTo(Afectat::class, 'afectats_id');
    }
}
