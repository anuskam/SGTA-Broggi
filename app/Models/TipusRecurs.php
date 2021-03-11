<?php

namespace App\Models;

use App\Models\Recurs;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TipusRecurs extends Model
{
    use HasFactory;

    protected $table = 'tipus_recursos';
    public $timestamps = false;

    public function recursos(){
        return $this->hasMany(Recurs::class, 'tipus_recursos_id');
    }
}
