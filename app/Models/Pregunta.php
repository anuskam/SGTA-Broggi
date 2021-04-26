<?php

namespace App\Models;

use App\Models\Resposta;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Pregunta extends Model
{
    use HasFactory;

    protected $table = 'preguntes';
    public $timestamps = false;

    public function respostes(){
        return $this->hasMany(Resposta::class, 'preguntes_id');
    }

}
