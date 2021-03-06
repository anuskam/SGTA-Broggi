@extends('loginTemplate')

@section('stylesheet')

@endsection

@section('title', 'Autenticación')

@section('content')
    <div class="row" id="header">
        <div class="col-12">
            <img src="{{ asset('media/img/prototipoLogo.png') }}" alt="logoBroggi" id="logo">
        </div>
    </div>
    <div class="row mt-5" id="loginContainer">
        <div class="card col-10 col-sm-6 col-md-6 col-lg-4 p-0" id="login-card">
            <div class="card-header text-center" id="login-card-header">Iniciar Sessión</div>
            <div class="card-body" id="login-body">
                <form action="{{ action([App\Http\Controllers\LoginController::class, 'store']) }}" method="POST">
                    @csrf
                    <div class="form-group">
                        @if($errors->any())
                            <div class="alert alert-danger" role="alert">
                                {{$errors->first()}}
                            </div>
                        @endif
                        <!-- User -->
                        <div class="form-group row mt-2 ml-1">
                            <div class="col-1 ml-1 mr-2 pt-1">
                                <i class="fas fa-user fa-lg login-icon"></i>
                            </div>
                            <div class="col-9 ml-1 mr-1">
                                @if(old('username'))
                                    <input class="form-control form-control-sm login-credentials" type="text" id="username" name="username"
                                    placeholder="Usuario" autofocus value="{{ old('username') }}">

                                @else
                                    <input class="form-control form-control-sm login-credentials" type="text" id="username" name="username"
                                    placeholder="Usuario" autofocus>
                                @endif
                            </div>
                        </div>
                        <!-- Password -->
                        <div class="form-group row mt-4 ml-1">
                            <div class="col-1 ml-1 mr-2 pt-1">
                                <i class="fas fa-key fa-lg login-icon"></i>
                            </div>
                            <div class="col-9 ml-1 mr-1">
                                @if (old('password'))
                                    <input class="form-control form-control-sm login-credentials" type="password" id="password" name="password"
                                    placeholder="Contraseña" autofocus required value="{{ old('password') }}">
                                @else
                                    <input class="form-control form-control-sm login-credentials" type="password" id="password" name="password"
                                    placeholder="Contraseña" autofocus required>
                                @endif
                            </div>
                        </div>
                        <!-- Boto d'Entrar -->
                        <div class="form-group row pt-4" id="loginButton">
                            <div class="btn-group col-md-6">
                                <input class="btn btn-block" type="submit" value="Acceder" name="login" id="login">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
