<template>
<main>
  <div class="alert alert-danger alert-dismissible fade show mt-2" v-if="errorMessage != ''">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    {{ errorMessage }}
  </div>

  <div class="alert alert-success alert-dismissible fade show mt-2" v-if="infoMessage != ''">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    {{ infoMessage }}
  </div>

  <div class="card mt-2 mb-1 ml-5 mr-5">
    <h2 class="card-header font-weight-bold">Usuàries</h2>
    <div class="card-body">
      <table class="table mt-2">
          <thead>
            <tr>
              <th scope="col">Nom Usuària</th>
              <th scope="col">Email</th>
              <th scope="col">Nom</th>
              <th scope="col">Cognoms</th>
              <th scope="col">Rol</th>
              <th scope="col" class="sizeBotones"></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(usuari, index) in usuaris" :key="usuari.id">
              <td>{{ usuari.username }}</td>
              <td>{{ usuari.email }}</td>
              <td>{{ usuari.nom }}</td>
              <td>{{ usuari.cognoms }}</td>
              <td>
                {{ getRol(index) }}
              </td>
              <td>
                <button type="submit" class="btn btn-sm float-right ml-2 esborrarUsuariBtn" @click="confirmDeleteUsuari(usuari)"><i class="fa fa-trash"
                    aria-hidden="true"></i>&nbsp;&nbsp;Esborrar</button>

                <button type="submit" class="btn btn-sm float-right editarUsuariBtn"  @click="editUsuari(usuari)"><i class="fa fa-edit"
                    aria-hidden="true"></i>&nbsp;&nbsp;Editar</button>
              </td>
            </tr>
          </tbody>
      </table>
    </div>
  </div>

  <!-- MODAL DE DELETE -->
  <div class="modal" tabindex="-1" id="deleteModalUsuari">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <div class="modal-title">Esborrar Usuària</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>Estàs segura d'eliminar la usuària {{ usuari.username }}?</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Tancar</button>
          <button type="button" class="btn esborrarUsuariBtn" @click="deleteUsuari()">Eliminar</button>
        </div>
      </div>
    </div>
  </div>

  <!-- MODAL DE INSERT/UPDATE  -->
  <div class="modal" tabindex="-1" id="usuariModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <div class="modal-title">Usuària</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group row">
              <label for="username" class="col-sm-2 col-form-label">Nom Usuària</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="username" name="username" autofocus
                  v-model="usuari.username">
              </div>
            </div>

            <div class="form-group row">
              <label for="email" class="col-sm-2 col-form-label">Email</label>
                <div class="col-sm-10">
                  <input type="email" class="form-control" id="email" name="email" v-model="usuari.email">
                </div>
            </div>

			<div class="form-group row">
              <label for="nomUsuari" class="col-sm-2 col-form-label">Nom</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="nomUsuari" name="nomUsuari" v-model="usuari.nom">
                </div>
            </div>

            <div class="form-group row">
              <label for="cognomsUsuari" class="col-sm-2 col-form-label">Cognoms</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="cognomsUsuari" name="cognomsUsuari" v-model="usuari.cognoms">
                </div>
            </div>

            <div class="form-group row">
              <label for="rol" class="col-sm-2 col-form-label">Rol</label>
              <div class="col-sm-10">
                <select class="custom-select" id="rol" required v-model="usuari.rols_id">
                  <option selected value="Selecciona...">Selecciona...</option>
                  <option v-for="rol in rols" :key="rol.id" :value="rol.id">
                    {{ rol.nom }}
                  </option>
                </select>
              </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Tancar</button>
          <button v-if="insert" type="button" class="btn" @click="insertUsuari()">Afegir</button>
          <button v-else type="button" class="btn editarUsuariBtn" @click="updateUsuari()">Modificar</button>
        </div>
      </div>
    </div>
  </div>

</main>
</template>

<script>
    export default {
      data() {
        return {
          usuaris: [],
          usuari: {
            username: '',
            email: '',
            nom: '',
            cognoms: '',
            rols_id: null
          },
          rols: [],
          insert: true,
          errorMessage: '',
          infoMessage: '',
        }
      },
      methods: {
        selectUsuaris() {
            let me = this;
            axios
                .get('/SGTA-Broggi/public/api/usuari')
                .then(response => {
                    me.usuaris = response.data;
                })
                .catch(error => {
                    console.log(error);
                })
        },
        confirmDeleteUsuari(usuari) {
          this.usuari = usuari;
          $('#deleteModalUsuari').modal('show');
        },
        deleteUsuari() {
          let me = this;
          axios
              .delete('/SGTA-Broggi/public/api/usuari/' + me.usuari.id)
              .then(function(response) {
                console.log(response);
                me.infoMessage = response.data.missatge;
                me.selectUsuaris();
                $('#deleteModalUsuari').modal('hide');
              }).catch(function(error) {
                  me.errorMessage = error.response.data.error;
                  $('#deleteModalUsuari').modal('hide');
              })
        },
        createUsuari() {
          this.insert = true;
          $('#usuariModal').modal('show');
        },
        insertUsuari() {
          let me = this;
          axios
              .post('/SGTA-Broggi/public/api/usuari', me.usuari)
              .then(function(response) {
                console.log(repsonse);
                me.selectUsuaris();
                $('#usuariModal').modal('hide');
              }).catch(function(error) {
                console.log(error.response.status);
                console.log(error.response.data);
                me.errorMessage = error.response.data.error;
              })
        },
        editUsuari(usuari) {
          this.insert = false;
          this.usuari = usuari;
          $('#usuariModal').modal('show');
        },
        updateUsuari() {
          let me = this;
          axios
              .put('/SGTA-Broggi/public/api/usuari/' + me.usuari.id, me.usuari)
              .then(function(response) {
                console.log(response);
                me.selectUsuaris();
                $('#usuariModal').modal('hide');
              }).catch(function(error) {
                console.log(error.response.status);
                console.log(error.response.data);
                me.errorMessage = error.response.data.error;
              })
        },
        selectRols() {
          let me = this;
          axios
              .get("/SGTA-Broggi/public/api/rol")
              .then((response) => {
                me.rols = response.data;
              }).catch((error) => {
                console.log(error);
              })
              .finally(() => (this.loading = false));
        },
        getRol(index) {
          let rol = this.rols.find(obj => obj.id == this.usuaris[index].rols_id);
          let rol_nom;
          if (rol != null){
            rol_nom = rol.nom;
          }
          else{
            rol_nom = this.rols.find(obj => obj.id == 1);
          }


          return rol_nom;
        },
      },
      created() {
        this.selectUsuaris(), this.selectRols();
      },
      mounted() {
        console.log('Component mounted.')
      }
    }
</script>

<style>
.sizeBotones {
    width: 14vw;
}

.esborrarUsuariBtn {
  background-color: #e3177d !important;
  color: white !important;
}

.editarUsuariBtn {
  background-color: #15acc4 !important;
  color: black !important;
}

.editarUsuariBtn:hover {
  color: black !important;
}


.cerrarBtn {
  background-color: #6c757d !important;
  color: white;
}

.cerrarBtn:hover {
  color: white;
}

@font-face {
  font-family: myFont;
  src: url(/SGTA-Broggi/public/fonts/Signika-Regular.ttf);
}

h2{
  font-family: myFont;
  font-size: 1.3em;
}




</style>

