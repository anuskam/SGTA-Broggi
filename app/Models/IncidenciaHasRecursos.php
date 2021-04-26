<?php

namespace App\Models;

use App\Models\Recurs;
use App\Models\Afectat;
use App\Models\Incidencia;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class IncidenciaHasRecursos extends Model
{
    use HasFactory;

    protected $table = 'incidencies_has_recursos';
    public $timestamps = false;
    protected $primaryKey = ['incidencies_id', 'recursos_id', 'afectats_id'];
    public $incrementing = false;

    public function incidencia(){
        return $this->belongsTo(Incidencia::class, 'incidencies_id');
    }

    public function recurs(){
        return $this->belongsTo(Recurs::class, 'recursos_id');
    }

    public function afectat(){
        return $this->belongsTo(Afectat::class, 'afectats_id');
    }

        /**
         * Set the keys for a save update query.
         *
         * @param  \Illuminate\Database\Eloquent\Builder  $query
         * @return \Illuminate\Database\Eloquent\Builder
         */
        protected function setKeysForSaveQuery($query)
        {
            $keys = $this->getKeyName();
            if(!is_array($keys)){
                return parent::setKeysForSaveQuery($query);
            }

            foreach($keys as $keyName){
                $query->where($keyName, '=', $this->getKeyForSaveQuery($keyName));
            }

            return $query;
        }

        /**
         * Get the primary key value for a save query.
         *
         * @param mixed $keyName
         * @return mixed
         */
        protected function getKeyForSaveQuery($keyName = null)
        {
            if(is_null($keyName)){
                $keyName = $this->getKeyName();
            }

            if (isset($this->original[$keyName])) {
                return $this->original[$keyName];
            }

            return $this->getAttribute($keyName);
        }
}
