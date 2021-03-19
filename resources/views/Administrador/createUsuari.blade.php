<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Crear Usuario</title>
</head>
<body>
    <div class="card">
        <div class="card-header">
           Nou Usuari
        </div>
        <div class="card-body">
                <form action="{{ action([App\Http\Controllers\UsuariController::class, 'store']) }}" method="POST">
                    @csrf
                <div class="form-group">
                    {{-- Username --}}
                    <div class="form-group row">
                        <label for="username" class="col-sm-2 col-form-label">Username</label>
                        <div class="col-sm-10">
                                <input class="form-control" type="text" name="username" id="username">
                        </div>
                    </div>
                    {{-- Contrasenya --}}
                    <div class="form-group row">
                        <label for="contrasenya" class="col-sm-2 col-form-label">Contrasenya</label>
                        <div class="col-sm-10">
                                <input class="form-control" type="text" name="contrasenya" id="contrasenya">
                        </div>
                    </div>
                    {{-- Email --}}
                    <div class="form-group row">
                        <label for="email" class="col-sm-2 col-form-label">Email</label>
                        <div class="col-sm-10">
                                <input class="form-control" type="text" name="email" id="email">
                        </div>
                    </div>
                    {{-- Nom --}}
                    <div class="form-group row">
                        <label for="nom" class="col-sm-2 col-form-label">Nom</label>
                        <div class="col-sm-10">
                                <input class="form-control" type="text" name="nom" id="nom">
                        </div>
                    </div>
                    {{-- Cognoms --}}
                    <div class="form-group row">
                        <label for="cognoms" class="col-sm-2 col-form-label">Cognoms</label>
                        <div class="col-sm-10">
                                <input class="form-control" type="text" name="cognoms" id="cognoms">
                        </div>
                    </div>
                    {{-- Rols_id --}}
                    <div class="form-group row">
                        <label for="rol" class="col-sm-2 col-form-label">Rols_ID</label>
                        <div class="col-sm-10">
                                <input class="form-control" type="number" name="rol" id="rol">
                        </div>
                    </div>
                </div>
                <div id="botones">
                    {{-- Cancelar --}}
                    <a class="btn btn-secondary" href="{{ url('login') }}">
                        Cancelar
                    </a>
                    {{-- Acceptar --}}
                    <button class="btn btn-primary" type="submit">
                        Acceptar
                    </button>
                </div>

            </form>
        </div>
    </div>
</body>
</html>
