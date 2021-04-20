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

  <!-- <div class="position: absolute; top: 0; right: auto;" style="z-index: 5; right: 0; bottom: 0;">
  <div id="toastError" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true" data-delay="4000">
    <div class="toast-header">
      <strong class="mr-auto">Bootstrap</strong>
      <small>11 mins ago</small>
      <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
    <div class="toast-body">
     {{ errorMessage }}
    </div>
  </div>
</div>


<div class="position: absolute; top: 0; right: auto;" style="z-index: 5; right: 0; bottom: 0;">
  <div id="toastInfo" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true" data-delay="4000">
    <div class="toast-header">
      <strong class="mr-auto">Bootstrap</strong>
      <small>11 mins ago</small>
      <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
    <div class="toast-body">
     {{ infoMessage }}
    </div>
  </div>
</div> -->


  <div class="card mt-2 mb-1 ml-5 mr-5">
    <h2 class="card-header font-weight-bold">Alertantes</h2>
    <div class="card-body">
      <table class="table mt-2">
          <thead>
            <tr>
              <th scope="col" class="sizeNom">Nombre</th>
              <th scope="col" class="sizeCognom">Apellidos</th>
              <th scope="col">Teléfono</th>
              <th scope="col">Dirección</th>
              <th scope="col">Municipio</th>
              <th scope="col" class="sizeBotones"></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(alertant, index) in alertants" :key="alertant.id">
              <td>{{ alertant.nom }}</td>
              <td>{{ alertant.cognom }}</td>
              <td>{{ alertant.telefon }}</td>
              <td>{{ alertant.adreca }}</td>
              <td>
                {{ getMunicipi(index) }}
              </td>
              <td>
                <button type="submit" class="btn btn-sm float-right ml-2 esborrarAlertantBtn" @click="confirmDeleteAlertant(alertant)"><i class="fa fa-trash"
                    aria-hidden="true"></i>&nbsp;&nbsp;Eliminar</button>

                <button type="submit" class="btn btn-sm float-right editarAlertantBtn"  @click="editAlertant(alertant)"><i class="fa fa-edit"
                    aria-hidden="true"></i>&nbsp;&nbsp;Editar</button>
              </td>
            </tr>
          </tbody>
      </table>
    </div>
  </div>

  <!-- MODAL DE DELETE -->
  <div class="modal" tabindex="-1" id="deleteModalAlertant">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <div class="modal-title">Eliminar Alertante</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>¿Estás segura de eliminar el alertante {{ alertant.nom }}?</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Cerrar</button>
          <button type="button" class="btn esborrarAlertantBtn" @click="deleteAlertant()">Eliminar</button>
        </div>
      </div>
    </div>
  </div>

  <!-- MODAL DE INSERT/UPDATE  -->
  <div class="modal" tabindex="-1" id="alertantModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <div class="modal-title">Alertante</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group row">
              <label for="telefon" class="col-sm-2 col-form-label">Teléfono</label>
              <div class="col-sm-10">
                <input type="number" class="form-control" id="telefon" name="telefon" autofocus
                  v-model="alertant.telefon">
              </div>
            </div>

			<div class="form-group row">
              <label for="nom" class="col-sm-2 col-form-label">Nombre</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="nom" name="nom" v-model="alertant.nom">
                </div>
            </div>

            <div class="form-group row">
              <label for="cognoms" class="col-sm-2 col-form-label">Apellidos</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="cognoms" name="cognoms" v-model="alertant.cognoms">
                </div>
            </div>

            <div class="form-group row">
              <label for="adreca" class="col-sm-2 col-form-label">Dirección</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="adreca" name="adreca" v-model="alertant.adreca">
              </div>
            </div>

            <div class="form-group row">
              <label for="municipio" class="col-sm-2 col-form-label">Municipio</label>
              <div class="col-sm-10">
                  <select class="custom-select" id="municipio" required v-model="alertant.municipis_id">
                    <option selected value="Selecciona...">Selecciona...</option>
                    <option v-for="municipi in municipis" :key="municipi.id" :value="municipi.id">
                      {{ municipi.nom }}
                    </option>
                  </select>
              </div>
            </div>

          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Tancar</button>
          <button v-if="insert" type="button" class="btn" @click="insertAlertant()">Afegir</button>
          <button v-else type="button" class="btn editarAlertantBtn" @click="updateAlertant()">Modificar</button>
        </div>
      </div>
    </div>
  </div>

  <button class="btn btn-primary btn-float-afegir" @click="createAlertant()">
    <i class="fas fa-plus-circle" aria-hidden="true"></i>
    Nueva alertante
  </button>

</main>
</template>

<script>
    export default {
      data() {
        return {
          alertants: [],
          alertant: {
            telefon: '',
            nom: '',
            cognoms: '',
            adreca: '',
            municipis_id: null,
            meta: {},
            paginas: [],
            pagina: 0,
            currentPage: 0
          },
          municipis: [],
          insert: true,
          errorMessage: '',
          infoMessage: '',
        }
      },
      methods: {
        paginar(pagina){
          let me = this;
          axios
              .get('SGTA-Broggi/public/api/alertant' + '?page=' + pagina)
              .then(response => {
                  me.alertants = response.data.data;
                  me.meta = response.data.meta;
                  me.currentPage = pagina;

              })
              .catch(error => {
                    console.log(error);
              })
        },
        selectAlertants() {
            let me = this;
            axios
                .get('/SGTA-Broggi/public/api/alertant')
                .then(response => {
                    me.alertants = response.data.data;
                    me.meta = response.data.meta;

                    for(let index = 0; index < me.meta.last_page; index++){
                        me.paginas[index] = pagina + 1;
                    }

                    me.currentPage = 1;
                })
                .catch(error => {
                    console.log(error);
                })
        },
        confirmDeleteAlertant(alertant) {
          this.alertant = alertant;
          $('#deleteModalAlertant').modal('show');
        },
        deleteAlertant() {
        //   $('#toastInfo').toast('show')
        //   $('#toastError').toast('show')
          let me = this;
          axios
              .delete('/SGTA-Broggi/public/api/alertant/' + me.alertant.id)
              .then(function(response) {
                console.log(response);
                me.infoMessage = response.data.missatge;
                me.selectAlertants();
                $('#deleteModalAlertant').modal('hide');
              }).catch(function(error) {
                  me.errorMessage = error.response.data.error;
                  $('#deleteModalAlertant').modal('hide');
              })
        },
        createAlertant() {
          this.insert = true;
          $('#alertantModal').modal('show');
        },
        insertAlertant() {
          let me = this;
          axios
              .post('/SGTA-Broggi/public/api/alertant', me.alertant)
              .then(function(response) {
                console.log(response);
                me.selectAlertants();
                $('#alertantModal').modal('hide');
              }).catch(function(error) {
                console.log(error.response.status);
                console.log(error.response.data);
                me.errorMessage = error.response.data.error;
              })
        },
        editAlertant(alertant) {
          this.insert = false;
          this.alertant = alertant;
          $('#alertantModal').modal('show');
        },
        updateAlertant() {
        //   $('#toastInfo').toast('show')
        //   $('#toastError').toast('show')
          let me = this;
          axios
              .put('/SGTA-Broggi/public/api/alertant/' + me.alertant.id, me.alertant)
              .then(function(response) {
                console.log(response);
                me.selectAlertants();
                $('#alertantModal').modal('hide');
              }).catch(function(error) {
                console.log(error.response.status);
                console.log(error.response.data);
                me.errorMessage = error.response.data.error;
              })
        },
        selectMunicipis() {
          let me = this;
          axios
              .get("/SGTA-Broggi/public/api/municipi")
              .then((response) => {
                me.municipis = response.data;
              }).catch((error) => {
                console.log(error);
              })
        },
        getMunicipi(index) {
          let municipi = this.municipis.find(obj => obj.id == this.alertants[index].municipis_id);
          let municipi_nom;
          if (municipi != null){
            municipi_nom = municipi.nom;
          }
          else{
            municipi_nom = this.municipis.find(obj => obj.id == 1);
          }

          return municipi_nom;
        },
      },
      created() {
        this.selectAlertants(), this.selectMunicipis();
      },
      mounted() {
        console.log('Component mounted.')
      }
    }
</script>

<style>
.sizeNom {
    width: 20vw;
}

.sizeCognom {
    width: 20vw;
}

.sizeBotones {
    width: 14vw;
}

.esborrarAlertantBtn {
  background-color: #e3177d !important;
  color: white !important;
}

.editarAlertantBtn {
  background-color: #15acc4 !important;
  color: black !important;
}

.editarAlertantBtn:hover {
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

