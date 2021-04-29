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
          <div class="modal-title deleteModal">Eliminar Incidencia Asignada</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>¿Estás segura de eliminar la incidencia {{ incidencia.data }}?</p>
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
          <div class="modal-title deleteModal">Incidente Asignado</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <div class="modalEdicionRecursos">
              <div class="form-group row col-12">
                <label for="hora_mobilitzacio" class="col-sm-3 col-form-label">Hora movilización</label>
                <div class="col-sm-3">
                    <input class="form-control" type="time" id="hora_mobilitzacio" v-model="recursEditar.hora_mobilitzacio"/>
                </div>

                <label for="hora_assistencia" class="col-sm-3 col-form-label">Hora asistencia</label>
                <div class="col-sm-3">
                    <input class="form-control" type="time" id="hora_assistencia" v-model="recursEditar.hora_assistencia"/>
                </div>
              </div>


              <div class="form-group row col-12">
                <label for="hora_transport" class="col-sm-3 col-form-label">Hora transporte</label>
                <div class="col-sm-3">
                    <input class="form-control" type="time" id="hora_transport" v-model="recursEditar.hora_transport"/>
                </div>

                <label for="hora_arribada" class="col-sm-3 col-form-label">Hora llegada hospital</label>
                <div class="col-sm-3">
                    <input class="form-control" type="time" id="hora_arribada" v-model="recursEditar.hora_arribada_hospital"/>
                </div>
              </div>


              <div class="form-group row col-12">
                <label for="hora_transferencia" class="col-sm-3 col-form-label">Hora transferencia</label>
                <div class="col-sm-3">
                    <input class="form-control" type="time" id="hora_transferencia" v-model="recursEditar.hora_transferencia"/>
                </div>

                <label for="hora_finalitzacio" class="col-sm-3 col-form-label">Hora finalización</label>
                <div class="col-sm-3">
                    <input class="form-control" type="time" id="hora_finalitzacio" v-model="recursEditar.hora_finalitzacio"/>
                </div>
              </div>

              <div class="form-group row col-12">
                <label for="destinoHospitalario" class="col-sm-3 col-form-label">Destino Hospitalario</label>
                <div class="col-sm-9">
                  <select class="custom-select" id="destinoHospitalario" required v-model="recursEditar.desti">
                    <option selected value="Selecciona...">Selecciona...</option>
                    <option v-for="(address, index) in addresses" :key="index" :value="address.adreca">
                      {{ address.nom }}
                    </option>
                  </select>
                </div>
              </div>
            </div>

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
          incidencia: {},
          recursEditar: {
            hora_mobilitzacio: '',
            hora_assistencia: '',
            hora_transport: '',
            hora_arribada_hospital: '',
            hora_transferencia: '',
            hora_finalitzacio: '',
            desti: ''
          },
          municipis: [],
          alertants: [],
          tipusIncidencies: [],
          tipusAlertants: [],
          incidenciesHasRecursos: [],
          incidenciaHasRecursos: [],
          addresses: [],
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
                this.$forceUpdate();
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
            this.incidenciaHasRecursos = [];
            this.incidenciaHasRecursos = this.incidenciesHasRecursos.filter(obj => obj.recursos_id == me.recursos_id);
            this.$forceUpdate();
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
        async selectAlertant() {
          let me = this;
          return axios
              .get("/SGTA-Broggi/public/api/alertant")
              .then((response) => {
                me.alertants = response.data;
              }).catch((error) => {
                console.log(error);
              })
        },
        getHospitalsAddresses(){
            let me = this;
            return this.alertants.forEach(function (alertant){
                if(alertant.tipus_alertants_id == 1){
                    let municipi = me.municipis.find(obj => obj.id == alertant.municipis_id);
                    let nomMunicipi = municipi.nom;
                    let adreca = {
                        adreca: alertant.adreca+ ", "+nomMunicipi,
                        nom: alertant.nom,
                    };
                    me.addresses.push(adreca);
                }
            });
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
              .delete("/SGTA-Broggi/public/api/incidenciaHasRecursos/"+me.incidenciaHasRecursos[0].incidencies_id+"/"+me.incidenciaHasRecursos[0].recursos_id)
              .then((response) => {
                console.log(response.data);
              }).catch((error) => {
                console.log(error);
              });
             $('#deleteModalAsignat').modal('hide');
             this.getIncidenciaData();
             this.$forceUpdate();
             location.reload();
        },
        confirmDeleteAsignat(incidencia){
          this.incidencia = incidencia;
          $('#deleteModalAsignat').modal('show');
        },
        buscarIncidenciaEnArray(incidencia){
          let me = this;
          this.recursEditar = incidencia.incidencies_has_recursos.find(obj => obj.recursos_id == me.recursos_id);
          console.log(this.recursEditar);
          return true;
        },
        updateIncidente(){
            let me = this;
            return axios.put('/SGTA-Broggi/public/api/incidenciaHasRecursos/'+me.incidencia.id+'/'+me.recursos_id, me.recursEditar).then((response) => {
                console.log(response);
            }).catch( (error) => {
                console.log(error.response.status);
                console.log(error.response.data.error);
            });
        },
        async updateIncidenteAsignado(){
            await this.updateIncidente();
            $('#asignatModal').modal('hide');
            location.reload();
        },
        async editIncidencia(incidencia){
            await this.getHospitalsAddresses();
        //   this.recursEditar = {
        //     hora_mobilitzacio: '',
        //     hora_assistencia: '',
        //     hora_transport: '',
        //     hora_arribada_hospital: '',
        //     hora_transferencia: '',
        //     hora_finalitzacio: '',
        //     desti:''
        //   };
        this.recursEditar = {};
          await this.buscarIncidenciaEnArray(incidencia);
          this.insert = false;
          this.incidencia = incidencia;
        //   this.$forceUpdate();
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

.modalEdicionRecursos{
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-around;

}

</style>
