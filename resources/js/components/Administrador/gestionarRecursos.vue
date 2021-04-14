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
    <h2 class="card-header font-weight-bold">Recursos</h2>
    <div class="card-body">
      <table class="table mt-2">
          <thead>
            <tr>
              <th scope="col">Codi</th>
              <th scope="col">Actiu</th>
              <th scope="col">Tipus de Recurs</th>
              <th scope="col" class="sizeBotones"></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(recurs, index) in recursos" :key="recurs.id">
              <td>{{ recurs.codi }}</td>
              <td>
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" name="actius[]" value="actiu" :checked="recurs.actiu">
                  <label class="custom-control-label" for="actiu"></label>
                </div>
              </td>
              <td>
                {{ getTipusRecurs(index) }}
              </td>
              <td>
                <button type="submit" class="btn btn-sm float-right ml-2 esborrarRecursBtn" @click="confirmDeleteRecurs(recurs)"><i class="fa fa-trash"
                    aria-hidden="true"></i>&nbsp;&nbsp;Esborrar</button>

                <button type="submit" class="btn btn-sm float-right editarRecursBtn"  @click="editRecurs(recurs)"><i class="fa fa-edit"
                    aria-hidden="true"></i>&nbsp;&nbsp;Editar</button>
              </td>
            </tr>
          </tbody>
      </table>
    </div>
  </div>

  <!-- MODAL DE DELETE -->
  <div class="modal" tabindex="-1" id="deleteModalRecurs">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Eliminar Recurs</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>Estàs segura d'eliminar el recurs {{ recurs.codi }}?</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Cerrar</button>
          <button type="button" class="btn" @click="deleteRecurs()">Eliminar</button>
        </div>
      </div>
    </div>
  </div>

  <!-- MODAL DE INSERT/UPDATE  -->
  <div class="modal" tabindex="-1" id="recursModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Recurs</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group row">
              <label for="codi" class="col-sm-2 col-form-label">Codi</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="codi" name="codi" autofocus
                  v-model="recurs.codi">
              </div>
            </div>

            <div class="form-group row">
              <label for="actiu" class="col-sm-2 col-form-label">Actiu</label>
              <div class="col-sm-10">
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" id="actiu" name="actiu" v-model="recurs.actiu">
                  <label for="actiu" class="custom-control-label"></label>
                </div>
              </div>
            </div>

            <div class="form-group row">
              <label for="tipusRecurs" class="col-sm-2 col-form-label">Municipi</label>
              <div class="col-sm-10">
                  <select class="custom-select" id="tipusRecurs" required v-model="recurs.tipus_recursos_id">
                    <option selected value="Selecciona...">Selecciona...</option>
                    <option v-for="tipusRecurs in tipusRecursos" :key="tipusRecurs.id" :value="tipusRecurs.id">
                      {{ tipusRecurs.tipus }}
                    </option>
                  </select>
              </div>
            </div>

          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Tancar</button>
          <button v-if="insert" type="button" class="btn" @click="insertRecurs()">Afegir</button>
          <button v-else type="button" class="btn editarRecursBtn" @click="updateRecurs()">Modificar</button>
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
          recursos: [],
          recurs: {
            codi: '',
            actiu: true,
            tipus_recursos_id: ''
          },
          tipusRecursos: [],
          insert: true,
          errorMessage: '',
          infoMessage: '',
        }
      },
      methods: {
        selectRecursos() {
            let me = this;
            axios
                .get('/SGTA-Broggi/public/api/recurs')
                .then(response => {
                    me.recursos = response.data;
                })
                .catch(error => {
                    console.log(error);
                })
        },
        confirmDeleteRecurs(recurs) {
          this.recurs = recurs;
          $('#deleteModalRecurs').modal('show');
        },
        deleteRecurs() {
          let me = this;
          axios
              .delete('/SGTA-Broggi/public/api/recurs/' + me.recurs.id)
              .then(function(response) {
                console.log(response);
                me.infoMessage = response.data.missatge;
                me.selectRecursos();
                $('#deleteModalRecurs').modal('hide');
              }).catch(function(error) {
                  me.errorMessage = error.response.data.error;
                  $('#deleteModalRecurs').modal('hide');
              })
        },
        createRecurs() {
          this.insert = true;
          $('#recursModal').modal('show');
        },
        insertRecurs() {
          let me = this;
          axios
              .post('/SGTA-Broggi/public/api/recurs', me.recurs)
              .then(function(response) {
                console.log(repsonse);
                me.selectRecursos();
                $('#recursModal').modal('hide');
              }).catch(function(error) {
                console.log(error.response.status);
                console.log(error.response.data);
                me.errorMessage = error.response.data.error;
              })
        },
        editRecurs(recurs) {
          this.insert = false;
          this.recurs = recurs;
          $('#recursModal').modal('show');
        },
        updateRecurs() {
          let me = this;
          axios
              .put('/SGTA-Broggi/public/api/recurs/' + me.recurs.id, me.recurs)
              .then(function(response) {
                console.log(response);
                me.selectRecursos();
                $('#recursModal').modal('hide');
              }).catch(function(error) {
                console.log(error.response.status);
                console.log(error.response.data);
                me.errorMessage = error.response.data.error;
              })
        },
        selectTipusRecursos() {
          let me = this;
          axios
              .get("/SGTA-Broggi/public/api/tipusRecurs")
              .then((response) => {
                me.tipusRecursos = response.data;
              }).catch((error) => {
                console.log(error);
              })
              .finally(() => (this.loading = false));
        },
        getTipusRecurs(index) {
          let tipusRecurs = this.tipusRecursos.find(obj => obj.id == this.recursos[index].tipus_recursos_id);
          let tipusRecursos_tipus;
          if (tipusRecurs != null){
            tipusRecursos_tipus = tipusRecurs.tipus;
          }
          else{
            tipusRecursos_tipus = this.tipusRecursos.find(obj => obj.id == 1);
          }


          return tipusRecursos_tipus;
        },
      },
      created() {
        this.selectRecursos(), this.selectTipusRecursos();
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

.esborrarRecursBtn {
  background-color: #e3177d !important;
  color: white !important;
}

.editarRecursBtn {
  background-color: #15acc4 !important;
  color: black !important;
}

.editarRecursBtn:hover {
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

