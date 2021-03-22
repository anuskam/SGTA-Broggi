<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\TipusAlertant;
use App\Http\Controllers\Controller;
use App\Http\Resources\TipusAlertantResource;

class TipusAlertantController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tipusAlertants = TipusAlertant::all();

        return TipusAlertantResource::collection($tipusAlertants);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\TipusAlertant  $tipusAlertant
     * @return \Illuminate\Http\Response
     */
    public function show(TipusAlertant $tipusAlertant)
    {
        return new TipusAlertantResource($tipusAlertant);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\TipusAlertant  $tipusAlertant
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, TipusAlertant $tipusAlertant)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\TipusAlertant  $tipusAlertant
     * @return \Illuminate\Http\Response
     */
    public function destroy(TipusAlertant $tipusAlertant)
    {
        //
    }
}
