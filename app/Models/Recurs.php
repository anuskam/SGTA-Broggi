<?php

namespace App\Models;

use App\Models\Usuari;
use App\Models\Incidencia;
use App\Models\TipusRecurs;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Recurs extends Model
{
    use HasFactory;

    protected $table = 'recursos';
    public $timestamps = false;

    public function incidencies(){
        return $this->belongsToMany(Incidencia::class, 'incidencies_has_recursos', 'recursos_id', 'incidencies_id')->as('incidencies_has_recursos');
    }

    public function usuaris(){
        return $this->hasMany(Usuari::class, 'recursos_id');
    }

    public function tipusRecurs(){
        return $this->belongsTo(TipusRecurs::class, 'tipus_recursos_id');
    }
}
