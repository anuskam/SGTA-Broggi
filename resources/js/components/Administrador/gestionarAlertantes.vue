<template>
<main>
  <div v-show="errorMessage!= ''" class="alert alert-danger fade show mt-2">
    <button type="button" class="close" @click="cerrarErrorAlert()">&times;</button>
    {{ errorMessage }}
  </div>

  <div v-show="infoMessage != ''" class="alert alert-success fade show mt-2">
    <button type="button" class="close" @click="cerrarInfoAlert()">&times;</button>
    {{ infoMessage }}
  </div>


  <div aria-label="paginacion" class="paginacionNav">
    <!-- <ul class="pagination">
      <li class="page-item">
        <button :disabled="currentPage <= 1" class="btn numeroPaginacion" aria-label="Previous" @click="paginar(currentPage-1)">
            <span aria-hidden="true">&laquo;</span>
            <span class="sr-only">Anterior</span>
        </button>
      </li>
      <button v-for="(paginaActual, index) in paginas" :key="index" class="btn numeroPaginacion" @click="paginar(paginaActual)">{{ index+1 }}</button>
      <li class="page-item">
        <button :disabled="currentPage >= meta.last_page" class="btn numeroPaginacion" aria-label="Next" @click="paginar(currentPage+1)">
            <span aria-hidden="true">&raquo;</span>
            <span class="sr-only">Siguiente</span>
        </button>
      </li>
    </ul> -->
    <div class="filtrar ml-5 pt-2">
        <input type="text" v-model="search"/>
            <i class="fas fa-filter"></i><label>Filtrar</label>
    </div>

    <button class="btn btn-primary mr-5 nuevaAlertante pt-2 pb-2" @click="createAlertant()">
        <i class="fas fa-plus-circle" aria-hidden="true"></i>
        Nueva alertante
    </button>
  </div>



  <div class="card mt-2 mb-1 ml-5 mr-5">
    <h2 class="card-header font-weight-bold">Alertantes</h2>
    <!--Por si no hay resultados-->
    <div v-if="filteredList.length == 0" class="p-3">No hay resultados con estos parámetros</div>
    <div v-else class="card-body">
      <table class="table mt-2">
          <thead>
            <tr>
              <th scope="col" class="sizeNom">Nombre</th>
              <th scope="col" class="sizeCognom">Apellidos</th>
              <th scope="col">Teléfono</th>
              <th scope="col">Dirección</th>
              <th scope="col" class="sizeMunicipi">Municipio</th>
              <th scope="col">Tipo Alertante</th>
              <th scope="col" class="sizeBotones"></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(alertant, index) in filteredList" :key="alertant.id">
              <td>{{ alertant.nom }}</td>
              <td>{{ alertant.cognom }}</td>
              <td>{{ alertant.telefon }}</td>
              <td>{{ alertant.adreca }}</td>
              <td>
                {{ getMunicipi(index) }}
              </td>
              <td>
                {{ getTipusAlertant(index) }}
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
          <div class="modal-title deleteModal">Eliminar Alertante</div>
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

            <div class="form-group row">
              <label for="tipoAlertante" class="col-sm-2 col-form-label">Tipo Alertante</label>
              <div class="col-sm-10">
                  <select class="custom-select" id="tipoAlertante" required v-model="alertant.tipus_alertant_id">
                    <option selected value="Selecciona...">Selecciona...</option>
                    <option v-for="tipus in tipusAlertants" :key="tipus.id" :value="tipus.id">
                      {{ tipus.tipus }}
                    </option>
                  </select>
              </div>
            </div>

          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Cerrar</button>
          <button v-if="insert" type="button" class="btn afegirAlertantBtn" @click="insertAlertant()">Añadir</button>
          <button v-else type="button" class="btn editarAlertantBtn" @click="updateAlertant()">Modificar</button>
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
          alertantsDB: [],
          tipusAlertants: [],
          alertant: {
            telefon: '',
            nom: '',
            cognoms: '',
            adreca: '',
            municipis_id: null,
            tipus_alertant_id: null
          },
          meta: {},
          paginas: [],
          pagina: 0,
          currentPage: 0,
          municipis: [],
          insert: true,
          errorMessage: '',
          infoMessage: '',
          search: ''
        }
      },
      methods: {
        paginar(pagina){
          let me = this;
          axios
              .get('/daw2a02/SGTA-Broggi/public/alertantPaginated' + '?page=' + pagina)
              .then(response => {
                  me.alertants = response.data.data;
                  me.meta = response.data.meta;
                  me.currentPage = pagina;
              })
              .catch(error => {
                    console.log(error);
              })
        },
        paginarFirst(){
          let me = this;
          axios
              .get('/daw2a02/SGTA-Broggi/public/alertantPaginated' + '?page=' + 1)
              .then(response => {
                  me.alertants = response.data.data;
                  me.meta = response.data.meta;
                  me.currentPage = 1;
                  for(let index = 0; index < me.meta.last_page; index++){
                        me.paginas[index] = index + 1;
                  }
              })
              .catch(error => {
                    console.log(error);
              })
        },
        selectAlertants() {
            let me = this;
            axios
                .get('/daw2a02/SGTA-Broggi/public/api/alertant')
                .then(response => {
                    me.alertantsDB = response.data;
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
              .post('/daw2a02/SGTA-Broggi/public/api/alertant/delete/' + me.alertant.id)
              .then(function(response) {
                console.log(response);
                me.infoMessage = response.data.missatge;
                me.selectAlertants();
                me.paginarFirst();
                $('#deleteModalAlertant').modal('hide');
              }).catch(function(error) {
                  me.errorMessage = error.response.data.error;
                  $('#deleteModalAlertant').modal('hide');
              })
        },
        createAlertant() {
          this.insert = true;
          this.alertant= {
            telefon: '',
            nom: '',
            cognoms: '',
            adreca: '',
            municipis_id: null,
            tipus_alertant_id: null
          }
          $('#alertantModal').modal('show');
        },
        insertAlertant() {
          let me = this;
          axios
              .post('/daw2a02/SGTA-Broggi/public/api/alertant/', me.alertant)
              .then(function(response) {
                console.log(response);
                me.selectAlertants();
                $('#alertantModal').modal('hide');
                me.infoMessage = 'Registro insertado correctamente';
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
              .post('/daw2a02/SGTA-Broggi/public/api/alertant/update/' + me.alertant.id, me.alertant)
              .then(function(response) {
                console.log(response);
                me.selectAlertants();
                me.paginarFirst();
                $('#alertantModal').modal('hide');
                me.infoMessage = 'Registro modificado correctamente';
              }).catch(function(error) {
                console.log(error.response.status);
                console.log(error.response.data);
                me.errorMessage = error.response.data.error;
              })
        },
        selectMunicipis() {
          let me = this;
          axios
              .get("/daw2a02/SGTA-Broggi/public/api/municipi")
              .then((response) => {
                me.municipis = response.data;
              }).catch((error) => {
                console.log(error);
              })
        },
        getMunicipi(index) {
          let me = this;
          let municipi = this.municipis.find(obj => obj.id == me.alertantsDB[index].municipis_id);
          let municipi_nom;
          if (municipi != null){
            municipi_nom = municipi.nom;
          }
          else{
            municipi_nom = this.municipis.find(obj => obj.id == 1);
          }

          return municipi_nom;
        },
        selectTipusAlertant() {
          let me = this;
          axios
              .get("/daw2a02/SGTA-Broggi/public/api/tipusAlertant")
              .then((response) => {
                me.tipusAlertants = response.data;
              }).catch((error) => {
                console.log(error);
              })
        },
        getTipusAlertant(index){
            let me = this;
            let tipusAlertant = this.tipusAlertants.find(obj => obj.id == me.alertantsDB[index].tipus_alertants_id);
            let tipusAlertant_nom;
            if (tipusAlertant != null){
                tipusAlertant_nom = tipusAlertant.tipus;
            }
            else{
                tipusAlertant_nom = this.tipusAlertants.find(obj => obj.id == 1);
            }

            return tipusAlertant_nom;
        },
        // getMunicipiName(id){
        //   let municipi = this.municipis.find(obj => obj.id == id);
        //   return municipi.nom;
        // },
        // getTipusAlertantName(id){

        //   let tipusAlertant = this.tipusAlertants.find.bind(this,obj => obj.id == id);

        //   return tipusAlertant.tipus;
        // },
        cerrarInfoAlert(){
          this.infoMessage = '';
        },
        cerrarErrorAlert() {
          this.errorMessage = '';
        }
      },
      computed: {
        filteredList: function() {
          return this.alertantsDB.filter(alertant => {
            //   let municipi = this.getMunicipiName(alertant.municipis_id);
            //   let tipusAlertant = await this.getTipusAlertantName(alertant.tipus_alertant_id);
            return alertant.nom.toLowerCase().includes(this.search.toLowerCase())
            // || alertant.cognoms.toLowerCase().includes(this.search.toLowerCase())
            || (alertant.telefon).toString().includes(this.search)
            || alertant.adreca.toLowerCase().includes(this.search.toLowerCase())
            // || municipi.toLowerCase().includes(this.search.toLowerCase())
            // || tipusAlertant.toLowerCase().includes(this.search.toLowerCase())
          })
        }
      },
      created() {
       this.selectMunicipis(), this.selectAlertants(), this.selectTipusAlertant();
      },
      mounted() {
        this.paginarFirst();
      }
    }
</script>

<style>
.sizeNom {
    width: 20vw;
}

.sizeCognom {
    width: 13vw;
}

.sizeMunicipi{
    width: 13vh;
}

.sizeBotones {
    width: 14vw;
}

.esborrarAlertantBtn, .afegirAlertantBtn {
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
  src: url(/daw2a02/SGTA-Broggi/public/fonts/Signika-Regular.ttf);
}

h2{
  font-family: myFont;
  font-size: 1.3em;
}
.modal-header{
  font-weight: bold;
  background-color: #15acc4;
}

.pagination{
  padding-left: 48px;
}

.numeroPaginacion {
  color: white;
}

.nuevaAlertante{
  padding-top: 0;
  padding-bottom: 0;
  margin-bottom: 15px; /*cambiarlo a vh*/
}

</style>

