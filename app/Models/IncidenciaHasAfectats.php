<?php

namespace App\Models;

use App\Models\Afectat;
use App\Models\Incidencia;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class IncidenciaHasAfectats extends Model
{
    use HasFactory;

    protected $table = 'incidencies_has_afectats';
    protected $primaryKey = ['incidencies_id', 'afectats_id'];
    public $timestamps = false;
    public $incrementing = false;

    public function incidencia(){
        return $this->belongsTo(Incidencia::class, 'incidencies_id');
    }

    public function afectat(){
        return $this->belongsTo(Afectat::class, 'afectats_id');
    }
}
