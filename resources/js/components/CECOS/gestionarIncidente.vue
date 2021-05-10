<template>
<main class="col-11">
    <div class="alert alert-danger fade show mt-2" v-show="errorMessage != ''">
        <button type="button" class="close" @click="cerrarErrorsAlert()">&times;</button>
        {{ errorMessage }}
    </div>
  <table class="table mt-5 ml-5 pl-2">
    <thead>
      <tr>
        <th scope="col">Fecha</th>
        <th scope="col">Hora</th>
        <th scope="col">Teléfono Alertante</th>
        <th scope="col">Dirección</th>
        <th scope="col">Complemento dirección</th>
        <th scope="col">Descripción</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(incidencia) in incidencies" :key="incidencia.id">
        <td>{{ convertDateFormat(incidencia.data) }}</td>
        <td>
          {{ incidencia.hora }}
        </td>
        <td>
          {{ incidencia.telefon_alertant }}
        </td>
        <td>
          {{ incidencia.adreca }}
        </td>
        <td>{{ incidencia.adreca_complement }}</td>
        <td>{{ incidencia.descripcio }}</td>
        <td>
          <button type="submit" class="btn btn-sm float-right ml-2 esborrarRecursBtn" @click="confirmDeleteIncidencia(incidencia)"><i class="fa fa-trash"
            aria-hidden="true"></i>&nbsp;&nbsp;Eliminar</button>

          <button type="submit" class="btn btn-sm float-right editarRecursBtn" @click="editIncidencia(incidencia)"><i class="fa fa-edit"
            aria-hidden="true"></i>&nbsp;&nbsp;Editar</button>
        </td>
      </tr>
    </tbody>
</table>

  <!-- MODAL DE DELETE -->
  <div class="modal" tabindex="-1" id="deleteModalIncidencia">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <div class="modal-title">Eliminar Incidencia</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>¿Estás segura de liminar la incidencia?</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Cerrar</button>
          <button type="button" class="btn esborrarRecursBtn" @click="checkDeleteIncidencia()">Eliminar</button>
        </div>
      </div>
    </div>
  </div>

    <!-- MODAL DE INSERT/UPDATE  -->
  <div class="modal" tabindex="-1" id="incidenciaModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <div class="modal-title">Incidente Asignado</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <!-- Contenido para editar incidente asignado -->
            <div class="modalEdicionRecursos">
              <div class="form-group row col-12">
                <label for="fechaIncidente" class="col-sm-3 col-form-label">Fecha</label>
                <div class="col-sm-3">
                    <input class="form-control" type="date" id="fechaIncidente" v-model="incidenciaEditar.data"/>
                </div>

                <label for="horaIncidente" class="col-sm-3 col-form-label">Hora</label>
                <div class="col-sm-3">
                    <input class="form-control" type="time" id="horaIncidente" v-model="incidenciaEditar.hora"/>
                </div>
              </div>


              <div class="form-group row col-12">
                <label for="telAlertant" class="col-sm-3 col-form-label">Teléfono Alertante</label>
                <div class="col-sm-3">
                    <input class="form-control" type="number" id="telAlertant" v-model="incidenciaEditar.telefon_alertant"/>
                </div>
              </div>

              <div class="form-group row col-12">
                <label for="direccion" class="col-sm-3 col-form-label">Dirección</label>
                <div class="col-sm-3">
                    <input class="form-control" type="text" id="direccion" v-model="incidenciaEditar.adreca"/>
                </div>
              </div>

              <div class="form-group row col-12">
                <label for="complemento" class="col-sm-3 col-form-label">Complemento Dirección</label>
                <div class="col-sm-3">
                    <input class="form-control" type="text" id="complemento" v-model="incidenciaEditar.adreca_complement"/>
                </div>
              </div>

              <div class="form-group row col-12">
                <label for="descripcion" class="col-sm-3 col-form-label">Descripción</label>
                <div class="col-sm-3">
                    <input class="form-control" type="text" id="descripcion" v-model="incidenciaEditar.descripcio"/>
                </div>
              </div>

              <div class="form-group row col-12">
                <label for="nomMetge" class="col-sm-3 col-form-label">Nombre Alertante</label>
                <div class="col-sm-3">
                    <input class="form-control" type="text" id="nomMetge" v-model="incidenciaEditar.nom_metge"/>
                </div>
              </div>

              <div class="form-group row col-12">
                <label for="tipusIncidencia" class="col-sm-3 col.form-label">Tipo de Incidencia</label>
                <div class="col-sm-9">
                  <select class="custom-select" id="tipusIncidencia" required v-model="incidenciaEditar.tipus_incidencies_id">
                    <option selected value="Selecciona...">Selecciona...</option>
                    <option v-for="tipus in tipusIncidencies" :key="tipus.id" :value="tipus.id">
                      {{ tipus.tipus }}
                    </option>
                  </select>
                </div>
              </div>

              <div class="form-group row col-12">
                <label for="municipi" class="col-sm-3 col.form-label">Municipio</label>
                <div class="col-sm-9">
                  <select class="custom-select" id="municipi" required v-model="incidenciaEditar.municipis_id">
                    <option selected value="Selecciona...">Selecciona...</option>
                    <option v-for="municipi in municipis" :key="municipi.id" :value="municipi.id">
                      {{ municipi.nom }}
                    </option>
                  </select>
                </div>
              </div>

            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Cerrar</button>
          <button type="button" class="btn editarRecursBtn" @click="updateIncidente()">Modificar</button>
        </div>
      </div>
    </div>
  </div>




</main>
</template>

<script>
    export default {
      data(){
        return{
          incidencies: [],
          incidencia: {
            data: '',
            hota: '',
            telefon_alertant: '',
            adreca: '',
            adreca_complement: '',
            descripcio: '',
          },
          errorMessage: '',
          tipusIncidencies: [],
          incidenciaEditar: {},
          municipis: [],
        }
      },
      methods:{
        selectIncidencies() {
        let me = this;
        axios
            .get('/SGTA-Broggi/public/api/incidencia')
            .then(response => {
              me.incidencies = response.data;
            })
            .catch(error => {
              console.log(error);
            })
        },
        // selectIncidencia(id){
        //    let me = this;
        //    axios
        //     .get('/SGTA-Broggi/public/api/incidencia/'+ id)
        //     .then(response => {
        //       me.incidencies.push(response.data);
        //     })
        //     .catch(error => {
        //       console.log(error);
        //     });
        // },
        confirmDeleteIncidencia(incidencia){
          this.incidencia = incidencia;
          $('#deleteModalIncidencia').modal('show');
        },
        checkDeleteIncidencia(){
            this.errorMessage = '';
            let viable = true;
            this.incidencia.incidencies_has_recursos.forEach(function(ihr){
                if(ihr.recurs.actiu == false){
                    viable = false;
                }
            });
            if(viable){
                this.deleteIncidencia();
            }
            else{
                this.errorMessage = 'No es posible eliminar la incidencia ya que aún tiene recursos despachados';
                $('#deleteModalIncidencia').modal('hide');
            }
        },
        deleteIncidencia(){
          let me = this;
          axios
            .delete('/SGTA-Broggi/public/api/incidencia/' + me.incidencia.id)
            .then(function(response) {
                console.log(response);
                me.infoMessage = response.data.missatge;
                me.selectIncidencies();
                $('#deleteModalIncidencia').modal('hide');
            }).catch(function(error) {
                me.errorMessage = error.response.data.error;
                $('#deleteModalIncidencia').modal('hide');
            })
        },
        updateIncidente(){
            let me = this;
            return axios.put('/SGTA-Broggi/public/api/incidencia/'+me.incidenciaEditar.id, me.incidenciaEditar).then((response) => {
                console.log(response);
            }).catch( (error) => {
                console.log(error.response.status);
                console.log(error.response.data.error);
            }).finally(()=>{
             $('#incidenciaModal').modal('hide');
            });
        },
        editIncidencia(incidencia){
          this.incidencia = incidencia;
          this.incidenciaEditar = incidencia;
          $('#incidenciaModal').modal('show');
        },
        convertDateFormat(string) {
        var info = string.split('-').reverse().join('-');
        return info;
        },
        cerrarErrorsAlert(){
            this.errorMessage = '';
        },
        selectTipusIncidencia() {
          let me = this;
          return axios
              .get("/SGTA-Broggi/public/api/tipusIncidencia")
              .then((response) => {
                me.tipusIncidencies = response.data;
              }).catch((error) => {
                console.log(error);
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
      },
      created(){
        this.selectIncidencies(), this.selectTipusIncidencia(), this.selectMunicipis();
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
