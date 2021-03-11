<?php

namespace App\Models;

use App\Models\Afectat;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Sexe extends Model
{
    use HasFactory;

    protected $table = 'sexes';
    public $timestamps = false;

    public function afectats(){
        return $this->hasMany(Afectat::class, 'sexes_id');
    }
}
