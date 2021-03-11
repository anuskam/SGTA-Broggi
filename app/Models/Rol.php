<?php

namespace App\Models;

use App\Models\Usuari;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Rol extends Model
{
    use HasFactory;

    protected $table = 'rols';
    public $timestamps = false;

    public function usuaris(){
        return $this->hasMany(Usuari::class, 'rols_id');
    }
}
