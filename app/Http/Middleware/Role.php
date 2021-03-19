<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class Role
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next, ...$roles)
    {
        if (!Auth::check()) {
            $response = redirect('login');
        }
        else {
            // $roles = array_slice(func_get_args(), 2);
            $userRole = Auth::user()->rols_id;
            $response = redirect('home');
            foreach ($roles as $role) {
                if ($userRole == $role){
                    $response = $next($request);
                }
            }
        }
        return $response;
    }
}
