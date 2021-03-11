<?php

namespace App\Models;

use App\Models\Municipi;
use App\Models\Incidencia;
use App\Models\TipusAlertant;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Alertant extends Model
{
    use HasFactory;

    protected $table = 'alertants';
    public $timestamps = false;

    public function municipi(){
        return $this->belongsTo(Municipi::class, 'municipis_id');
    }

    public function tipusAlertant(){
        return $this->belongsTo(TipusAlertant::class, 'tipus_alertants_id');
    }

    public function incidencies(){
        return $this->hasMany(Incidencia::class, 'alertants_id');
    }
}
