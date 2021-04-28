<template>
<main class="col-11">
  <table class="table mt-5">
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
          <button type="button" class="btn esborrarRecursBtn" @click="deleteIncidencia()">Eliminar</button>
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
        updateIncidenteAsignado(){
          // modificar con todo el contenido
        },
        editIncidencia(incidencia){
          this.insert = false;
          this.incidencia = incidencia;
          $('#incidenciaModal').modal('show');
        },
        convertDateFormat(string) {
        var info = string.split('-').reverse().join('-');
        return info;
        }
      },
      created(){
        this.selectIncidencies();
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
