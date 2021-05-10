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
            <span class="sr-only">Previous</span>
        </button>
      </li>
      <button v-for="(paginaActual, index) in paginas" :key="index" class="btn numeroPaginacion" @click="paginar(paginaActual)">{{ index+1 }}</button>
      <li class="page-item">
        <button :disabled="currentPage >= meta.last_page" class="btn numeroPaginacion" aria-label="Next" @click="paginar(currentPage+1)">
            <span aria-hidden="true">&raquo;</span>
            <span class="sr-only">Next</span>
        </button>
      </li>
    </ul> -->
    <div class="filtrar ml-5 pt-2">
        <input type="text" v-model="search"/>
            <i class="fas fa-filter"></i><label>Filtrar</label>
    </div>

    <button class="btn btn-primary mr-5 pt-2 pb-2 nuevoRecurso" @click="createRecurs()">
        <i class="fas fa-plus-circle" aria-hidden="true"></i>
        Nuevo recurso
    </button>
  </div>


  <div class="card mt-2 mb-1 ml-5 mr-5">
    <h2 class="card-header font-weight-bold">Recursos</h2>
    <!--Por si no hay resultados-->
    <div v-if="filteredList.length == 0" class="p-3">No hay resultados con estos parámetros</div>
    <div v-else class="card-body">
      <table class="table mt-2">
          <thead>
            <tr>
              <th scope="col">Código</th>
              <th scope="col">Activo</th>
              <th scope="col">Tipo de Recurso</th>
              <th scope="col" class="sizeBotones"></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(recurs, index) in filteredList" :key="recurs.id">
              <td>{{ recurs.codi }}</td>
              <td>
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" name="actius[]" value="actiu" :checked="recurs.actiu" disabled>
                  <label class="custom-control-label" for="actiu"></label>
                </div>
              </td>
              <td>
                {{ getTipusRecurs(index) }}
              </td>
              <td>
                <button type="submit" class="btn btn-sm float-right ml-2 esborrarRecursBtn" @click="confirmDeleteRecurs(recurs)"><i class="fa fa-trash"
                    aria-hidden="true"></i>&nbsp;&nbsp;Eliminar</button>

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
          <div class="modal-title deleteModal">Eliminar Recurs</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p>¿Estás segura de liminar el recurso {{ recurs.codi }}?</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Cerrar</button>
          <button type="button" class="btn esborrarRecursBtn" @click="deleteRecurs()">Eliminar</button>
        </div>
      </div>
    </div>
  </div>

  <!-- MODAL DE INSERT/UPDATE  -->
  <div class="modal" tabindex="-1" id="recursModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <div class="modal-title">Recurso</div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group row">
              <label for="codi" class="col-sm-2 col-form-label">Código</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="codi" name="codi" autofocus
                  v-model="recurs.codi">
              </div>
            </div>

            <div class="form-group row">
              <label for="actiu" class="col-sm-2 col-form-label">Activo</label>
              <div class="col-sm-10">
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" class="custom-control-input" id="actiu" name="actiu" v-model="recurs.actiu">
                  <label for="actiu" class="custom-control-label"></label>
                </div>
              </div>
            </div>

            <div class="form-group row">
              <label for="tipusRecurs" class="col-sm-2 col-form-label">Tipo de recurso</label>
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
          <button type="button" class="btn cerrarBtn" data-dismiss="modal">Cerrar</button>
          <button v-if="insert" type="button" class="btn afegirRecursBtn" @click="insertRecurs()">Añadir</button>
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
          recursosDB: [],
          recurs: {
            codi: '',
            actiu: true,
            tipus_recursos_id: null
          },
          tipusRecursos: [],
          insert: true,
          errorMessage: '',
          infoMessage: '',
          meta: {},
          paginas: [],
          pagina: 0,
          currentPage: 0,
          search: '',
        }
      },
      methods: {
        paginar(pagina){
          let me = this;
          axios
              .get('/SGTA-Broggi/public/recursPaginated' + '?page=' + pagina)
              .then(response => {
                  me.recursos = response.data.data;
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
              .get('/SGTA-Broggi/public/recursPaginated' + '?page=' + 1)
              .then(response => {
                  me.recursos = response.data.data;
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
        selectRecursos() {
            let me = this;
            axios
                .get('/SGTA-Broggi/public/api/recurs')
                .then(response => {
                    me.recursosDB = response.data;
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
        //   $('#toastInfo').toast('show')
        //   $('#toastError').toast('show')
          let me = this;
          axios
              .delete('/SGTA-Broggi/public/api/recurs/' + me.recurs.id)
              .then(function(response) {
                console.log(response);
                me.infoMessage = response.data.missatge;
                me.selectRecursos();
                me.paginarFirst();

                $('#deleteModalRecurs').modal('hide');
              }).catch(function(error) {
                  me.errorMessage = error.response.data.error;
                  $('#deleteModalRecurs').modal('hide');
              })
              //this.$forceUpdate();
        },
        createRecurs() {
          this.insert = true;
          this.recurs= {
            codi: '',
            actiu: true,
            tipus_recursos_id: ''
          },
          $('#recursModal').modal('show');
        },
        insertRecurs() {
          let me = this;
          axios
              .post('/SGTA-Broggi/public/api/recurs', me.recurs)
              .then(function(response) {
                console.log(response);
                me.selectRecursos();
                me.paginarFirst();
                $('#recursModal').modal('hide');
                me.infoMessage = 'Registro insertado correctamente';
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
        //   $('#toastInfo').toast('show')
        //   $('#toastError').toast('show')
          let me = this;
          axios
              .put('/SGTA-Broggi/public/api/recurs/' + me.recurs.id, me.recurs)
              .then(function(response) {
                console.log(response);
                me.selectRecursos();
                $('#recursModal').modal('hide');
                me.infoMessage = 'Registro modificado correctamente';
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
          let tipusRecurs = this.tipusRecursos.find(obj => obj.id == this.filteredList[index].tipus_recursos_id);
          let tipusRecursos_tipus;
          if (tipusRecurs != null){
            tipusRecursos_tipus = tipusRecurs.tipus;
          }
          else{
            tipusRecursos_tipus = this.tipusRecursos.find(obj => obj.id == 1);
          }


          return tipusRecursos_tipus;
        },
        // getTipusRecursName(id){
        //   let tipusRecursNom = this.tipusRecursos.find(obj => obj.id == id);
        //   return tipusRecursNom.tipus;
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
          return this.recursosDB.filter(recurs => {
            //   let tipusRecursNom = this.getTipusRecursName(recurs.tipus_recursos_id);
            return recurs.codi.toLowerCase().includes(this.search.toLowerCase())
            // || tipusRecursNom.toLowerCase().includes(this.search.toLocaleLowerCase())
          })
        }
      },
      created() {
        this.paginarFirst(), this.selectTipusRecursos(), this.selectRecursos();
      },
      mounted() {
      }
    }
</script>

<style>
.sizeBotones {
    width: 14vw;
}

.esborrarRecursBtn, .afegirRecursBtn {
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

.nuevoRecurso{
  padding-top: 0;
  padding-bottom: 0;
  margin-bottom: 15px; /*cambiarlo a vh*/
}


/* .modal-header{
    font-weight: bold;
    background-color: #15acc4;
} */

/* h2{
  font-family: myFont;
  font-size: 1.3em;
} */

/*NO SE BORRAN LOS MENSAJES Y AL CAMBIAR EL NOMBRE DE UN CÓDIGO, SE QUITA EL CHECKED*/
</style>

