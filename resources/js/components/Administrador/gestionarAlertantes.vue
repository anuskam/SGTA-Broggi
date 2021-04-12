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
    <div class="card-body">
      <h5 class="card-title">Alertantes</h5>
      <table class="table mt-2">
          <thead>
            <tr>
              <th scope="col">Telèfon</th>
              <th scope="col">Nom</th>
              <th scope="col">Cognoms</th>
              <th scope="col">Adreça</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="alertant in alertants" :key="alertant.id">
              <td>{{ alertant.telefon }}</td>
              <td>{{ alertant.nom }}</td>
              <td>{{ alertant.cognom }}</td>
              <td>{{ alertant.adreca }}</td>
              <td>
                <button type="submit" class="btn btn-sm btn-danger" @click="confirmDeleteAlertant(alertant)"><i class="fa fa-trash"
                    aria-hidden="true"></i> Esborrar</button>

                <button type="submit" class="btn btn-sm btn-secondary" @click="editAlertant(alertant)"><i class="fa fa-edit"
                    aria-hidden="true"></i> Editar</button>
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
          <h5 class="modal-title">Borrar Alertante</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>¿Estás seguro de querer eliminar al alertante {{ alertant.nom }}?</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
          <button type="button" class="btn btn-danger" @click="deleteAlertant()">Eliminar</button>
        </div>
      </div>
    </div>
  </div>

  <!-- MODAL DE INSERT/UPDATE  -->
  <div class="modal" tabindex="-1" id="alertantModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Alertante</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group row">
              <label for="sigles" class="col-sm-2 col-form-label">Telèfon</label>
              <div class="col-sm-10">
                <input type="number" class="form-control" id="telefon" name="telefon" autofocus
                  v-model="alertant.telefon">
              </div>
            </div>

			<div class="form-group row">
              <label for="nom" class="col-sm-2 col-form-label">Nom</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="nom" name="nom" v-model="alertant.nom">
                </div>
            </div>

            <div class="form-group row">
              <label for="nom" class="col-sm-2 col-form-label">Cognoms</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="cognoms" name="cognoms" v-model="alertant.cognoms">
                </div>
            </div>

            <div class="form-group row">
              <label for="descripcio" class="col-sm-2 col-form-label">Adreça</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="adreca" name="adreca" v-model="alertant.adreca">
              </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Tancar</button>
          <button v-if="insert" type="button" class="btn btn-primary" @click="insertAlertant()">Afegir</button>
          <button v-else type="button" class="btn btn-primary" @click="updateAlertant()">Modificar</button>
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
          alertants: [],
          alertant: {
            telefon: '',
            nom: '',
            cognoms: '',
            adreca: ''
          },
          insert: true,
          errorMessage: '',
          infoMessage: '',
          page: 1,
          pages: 1
        }
      },
      methods: {
        selectAlertants() {
            let me = this;
            axios
                .get('/alertant')
                .then(response => {
                    me.alertants = response.data;
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
          let me = this;
          axios
              .delete('/alertant/' + me.alertant.id)
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
              .post('/alertant', me.alertant)
              .then(function(response) {
                console.log(repsonse);
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
          let me = this;
          axios
              .put('/alertant/' + me.alertant.id, me.alertant)
              .then(function(response) {
                console.log(response);
                me.selectAlertants();
                $('#alertantModal').modal('hide');
              }).catch(function(error) {
                console.log(error.response.status);
                console.log(error.response.data);
                me.errorMessage = error.response.data.error;
              })
        }
      },
      created() {
        this.selectAlertants();
      },
      mounted() {
        console.log('Component mounted.')
      }
    }
</script>
