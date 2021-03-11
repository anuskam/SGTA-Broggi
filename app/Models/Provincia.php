<?php

namespace App\Models;

use App\Models\Comarca;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Provincia extends Model
{
    use HasFactory;

    protected $table = 'provincies';
    public $timestamps = false;

    public function comarques(){
        return $this->hasMany(Comarca::class, 'provincies_id');
    }
}
