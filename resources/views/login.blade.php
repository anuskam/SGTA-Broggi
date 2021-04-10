@extends('loginTemplate')

@section('stylesheet')

@endsection

@section('title', 'Autenticació')

@section('content')
    <div class="row" id="header">
        <div class="col-12">
            <img src="{{ asset('media/img/prototipoLogo.png') }}" alt="" id="logo">
        </div>
    </div>
    <div class="row mt-5" id="loginContainer">
        <div class="card col-10 col-sm-6 col-md-6 col-lg-4 p-0" id="login-card">
            <div class="card-header text-center" id="login-card-header">Inicia Sessió</div>
            <div class="card-body" id="login-body">
                <form action="{{ action([App\Http\Controllers\LoginController::class, 'store']) }}" method="POST">
                    @csrf
                    <div class="form-group">
                        <!-- User -->
                        <div class="form-group row mt-2 ml-1">
                            <div class="col-1 ml-1 mr-2 pt-1">
                                <i class="fas fa-user fa-lg login-icon"></i>
                            </div>
                            <div class="col-9 ml-1 mr-1">
                                <input class="form-control form-control-sm login-credentials" type="text" id="username" name="username"
                                    placeholder="Usuari" autofocus>
                            </div>
                        </div>
                        <!-- Password -->
                        <div class="form-group row mt-4 ml-1">
                            <div class="col-1 ml-1 mr-2 pt-1">
                                <i class="fas fa-key fa-lg login-icon"></i>
                            </div>
                            <div class="col-9 ml-1 mr-1">
                                <input class="form-control form-control-sm login-credentials" type="password" id="password" name="password"
                                placeholder="Contrasenya" autofocus required>
                            </div>
                        </div>
                        <!-- Boto d'Entrar -->
                        <div class="form-group row pt-4" id="loginButton">
                            <div class="btn-group col-md-6">
                                <input class="btn btn-block" type="submit" value="Accedir" name="login" id="login">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
