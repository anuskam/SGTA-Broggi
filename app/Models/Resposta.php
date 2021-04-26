<?php

namespace App\Models;

use App\Models\Pregunta;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Resposta extends Model
{
    use HasFactory;

    protected $table = 'respostes';
    public $timestamps = false;

    public function pregunta(){
        return $this->belongsTo(Pregunta::class, 'preguntes_id');
    }


}
