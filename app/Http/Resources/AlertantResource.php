<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class AlertantResource extends JsonResource
{
    /**
     * Transform the resource collection into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return parent::toArray($request);
        // return [
        //     "id" => $this->id,
        //     "telefon" => $this->telefon,
        //     "nom" => $this->nom,
        //     "cognoms" => $this->cognoms,
        //     "adreca" => $this->adreca
        // ];
    }
}
