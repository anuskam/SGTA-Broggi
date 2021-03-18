<?php

namespace App\Models;

use App\Models\Rol;
use App\Models\Recurs;
use App\Models\Incidencia;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Usuari extends Authenticatable
{
    use HasFactory, Notifiable;

    protected $table = 'usuaris';
    public $timestamps = false;

    public function incidencies(){
        return $this->hasMany(Incidencia::class, 'usuaris_id');
    }

    public function recurs(){
        return $this->belongsTo(Recurs::class, 'recursos_id');
    }

    public function rol(){
        return $this->belongsTo(Rol::class, 'rols_id');
    }
}
