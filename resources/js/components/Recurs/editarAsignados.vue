<template>
<main class="col-11">
  <table v-if="incidencies.length > 0" class="table mt-5">
    <thead>
      <tr>
        <th scope="col">Fecha</th>
        <th scope="col">Municipio</th>
        <th scope="col">Tipo de incidente</th>
        <th scope="col">Tipo de alertante</th>
        <th scope="col">Teléfono</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(incidencia, index) in incidencies" :key="incidencia.id">
        <td>{{ convertDateFormat(incidencia.data) }}</td>
        <td>
          {{ getMunicipi(index) }}
        </td>
        <td>
          {{ getTipusIncidencia(index) }}
        </td>
        <td>
          {{ getTipusAlertant(index) }}
        </td>
        <td>{{ incidencia.telefon_alertant }}</td>
        <td>
          <button type="submit" class="btn btn-sm float-right ml-2 esborrarRecursBtn" @click="confirmDeleteAsignat(incidencia)"><i class="fa fa-trash"
            aria-hidden="true"></i>&nbsp;&nbsp;Eliminar</button>

          <button type="submit" class="btn btn-sm float-right editarRecursBtn" @click="editIncidencia(incidencia)"><i class="fa fa-edit"
            aria-hidden="true"></i>&nbsp;&nbsp;Editar</button>
        </td>
      </tr>
    </tbody>
</table>

<div v-else class="alert mt-3 alertaSinRecursos" role="alert">
  Este recurso no tiene ninguna incidencia en su historial
</div>

  <!-- MODAL DE DELETE -->
  <div class="modal" tabindex="-1" id="deleteModalAsignat">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header d-flex justify-content-center">
          <div class="modal-title">Eliminar Incidencia Asignada</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>¿Estás segura de liminar la incidencia {{ incidencia.data }}?</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Cerrar</button>
          <button type="button" class="btn esborrarRecursBtn" @click="deleteAsignat()">Eliminar</button>
        </div>
      </div>
    </div>
  </div>

    <!-- MODAL DE INSERT/UPDATE  -->
  <div class="modal" tabindex="-1" id="asignatModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header d-flex justify-content-center">
          <div class="modal-title">Incidente Asignado</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <!-- Contenido para editar incidente asignado -->

          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Cerrar</button>
          <button type="button" class="btn editarRecursBtn" @click="updateIncidenteAsignado()">Modificar</button>
        </div>
      </div>
    </div>
  </div>




</main>
</template>

<script>
    export default {
        props:{
            recursos_id: Number,
        },
      data(){
        return{
          incidencies: [],
          incidencia: {
            data: '',

          },
          municipis: [],
          alertants: [],
          tipusIncidencies: [],
          tipusAlertants: [],
          incidenciesHasRecursos: [],
          incidenciaHasRecursos: [],
        }
      },
      methods:{
        async getIncidenciaData(){
            await this.selectIncidenciesHasRecursos();
            await this.selectIncidenciaHasRecursos();
            await this.getIncidenciesRecursos();
        },
        getIncidenciesRecursos(){
            let me = this;
            return this.incidenciaHasRecursos.forEach((incidencia) => {
                me.selectIncidencia(incidencia.incidencies_id);
            });
        },
        selectIncidencia(id){
             let me = this;
             axios
              .get('/SGTA-Broggi/public/api/incidencia/'+id)
              .then(response => {
                me.incidencies.push(response.data);
              })
              .catch(error => {
                console.log(error);
              });
        },
        selectIncidenciesHasRecursos(){
            let me = this;
            return axios
            .get("/SGTA-Broggi/public/api/incidenciaHasRecursos")
            .then((response) => {
            me.incidenciesHasRecursos = response.data;
            })
            .catch((error) => {
            console.log(error);
            });
        },
        selectIncidenciaHasRecursos(){
            let me = this;
            this.incidenciaHasRecursos = this.incidenciesHasRecursos.filter(obj => obj.recursos_id == me.recursos_id);
            // this.incidenciaID = this.incidenciaHasRecursos[this.incidenciaHasRecursos.length-1].incidencies_id;
            return true;
        },

        // selectIncidencies() {
        //   let me = this;
        //   axios
        //       .get('/SGTA-Broggi/public/api/incidencia')
        //       .then(response => {
        //         me.incidencies = response.data;
        //       })
        //       .catch(error => {
        //         console.log(error);
        //       })
        // },
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
          let municipi = this.municipis.find(obj => obj.id == this.incidencies[index].municipis_id);
          let municipi_nom;
          if (municipi != null){
            municipi_nom = municipi.nom;
          }
          else{
            municipi_nom = this.municipis.find(obj => obj.id == 1);
          }

          return municipi_nom;
        },
        selectTipusIncidencia() {
          let me = this;
          axios
              .get("/SGTA-Broggi/public/api/tipusIncidencia")
              .then((response) => {
                me.tipusIncidencies = response.data;
              }).catch((error) => {
                console.log(error);
              })
        },
        getTipusIncidencia(index) {
          let tipusIncidencia = this.tipusIncidencies.find(obj => obj.id == this.incidencies[index].tipus_incidencies_id);
          let tipusIncidencia_nom;
          if (tipusIncidencia != null) {
            tipusIncidencia_nom = tipusIncidencia.tipus;
          }
          else {
            tipusIncidencia_nom = this.incidencies.find(obj => obj.id == 1);
          }

          return tipusIncidencia_nom;
        },
        selectTipusAlertant() {
          let me = this;
          axios
              .get("/SGTA-Broggi/public/api/tipusAlertant")
              .then((response) => {
                me.tipusAlertants = response.data;
              }).catch((error) => {
                console.log(error);
              })
        },
        selectAlertant() {
          let me = this;
          axios
              .get("/SGTA-Broggi/public/api/alertant")
              .then((response) => {
                me.alertants = response.data;
              }).catch((error) => {
                console.log(error);
              })
        },
        getTipusAlertant(index) {
          let alertant_id = this.incidencies[index].alertants_id;
          let indexAlertant = this.alertants.findIndex(obj => obj.id == alertant_id);
          let alertantTipus = this.alertants[indexAlertant].tipus_alertants_id;
          let tipusAlertant_index = this.tipusAlertants.findIndex(obj => obj.id == alertantTipus);
          let tipusAlertant_nom = this.tipusAlertants[tipusAlertant_index].tipus;
          return tipusAlertant_nom;

        },
        deleteAsignat(){
            let me = this;
          axios
              .get("/SGTA-Broggi/public/deleteIHR/"+me.incidenciaHasRecursos[0].incidencies_id+"/"+me.incidenciaHasRecursos[0].recursos_id)
              .then((response) => {
                console.log(response.data);
              }).catch((error) => {
                console.log(error);
              })
        },
        confirmDeleteAsignat(incidencia){
          this.incidencia = incidencia;
          $('#deleteModalAsignat').modal('show');
        },
        updateIncidenteAsignado(){
            // modificar con todo el contenido
        },
        editIncidencia(incidencia){
          this.insert = false;
          this.incidencia = incidencia;
          $('#asignatModal').modal('show');
        },
        convertDateFormat(string) {
        var info = string.split('-').reverse().join('-');
        return info;
        }
      },
      created(){
        this.selectMunicipis(), this.selectAlertant(), this.selectTipusAlertant(), this.selectTipusIncidencia(), this.getIncidenciaData();
      },
      mounted() {

      }
    }
</script>

<style>
.alertaSinRecursos{
    font-family: 'Rubik', sans-serif;
    font-size: 15px;
    color: black;
    background-color: rgb(21, 172, 196, .5);
    width: 90%;
}

.cerrarBtn {
  background-color: #6c757d !important;
  color: white;
}

</style>
