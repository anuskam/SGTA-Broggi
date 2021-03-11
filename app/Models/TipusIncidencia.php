<?php

namespace App\Models;

use App\Models\Incidencia;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TipusIncidencia extends Model
{
    use HasFactory;

    protected $table = 'tipus_incidencies';
    public $timestamps = false;

    public function incidencies(){
        return $this->hasMany(Incidencia::class, 'tipus_incidencies_id');
    }
}
