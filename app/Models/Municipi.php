<?php

namespace App\Models;

use App\Models\Comarca;
use App\Models\Alertant;
use App\Models\Incidencia;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Municipi extends Model
{
    use HasFactory;

    protected $table = 'municipis';
    public $timestamps = false;

    public function comarca(){
        return $this->belongsTo(Comarca::class, 'comarques_id');
    }

    public function alertants(){
        return $this->hasMany(Alertant::class, 'municipis_id');
    }

    public function incidencies(){
        return $this->hasMany(Incidencia::class, 'municipis_id');
    }
}
