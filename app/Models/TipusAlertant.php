<?php

namespace App\Models;

use App\Models\Alertant;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TipusAlertant extends Model
{
    use HasFactory;

    protected $table = 'tipus_alertants';
    public $timestamps = false;

    public function alertants(){
        return $this->hasMany(Alertant::class, 'tipus_alertants_id');
    }
}
