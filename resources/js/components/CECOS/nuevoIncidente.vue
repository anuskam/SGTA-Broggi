<template>
  <div>
    <div id="tabButtons" class="mt-2">
      <button
        :disabled="currentTab == 1"
        @click="prev()"
        class="btn btn-sm mr-3 float-left ml-3"
        id="btn"
      >
        <i class="fas fa-arrow-left fa-2x" aria-hidden="true"></i>
      </button>

      <button @click="selectTab(1)" class="btn btn-sm mr-3">
        <i class="fas fa-phone-alt fa-2x mr-2 ml-2" aria-hidden="true"></i>
      </button>
      |
      <button @click="selectTab(2)" class="btn btn-sm mr-3 ml-3">
        <i class="fas fa-user-injured fa-2x mr-2 ml-2" aria-hidden="true"></i>
      </button>
      |
      <button @click="selectTab(3)" class="btn btn-sm ml-3">
        <i class="fas fa-ambulance fa-2x mr-2 ml-2" aria-hidden="true"></i>
      </button>

      <button
        :disabled="currentTab == 3"
        @click="next()"
        class="btn btn-sm mr-3 float-right mr-3"
      >
        <i class="fas fa-arrow-right fa-2x"></i>
      </button>
    </div>

    <div v-if="currentTab == 1">
      <div class="container-fluid mt-5">
        <div class="card ml-5 mr-5">
          <div class="card-header">DATOS ALERTANTE</div>
          <div class="card-body ml-5">
            <form>
              <div class="form-group row">
                <label for="tipoAlertante" class="col-2 mt-1"
                  >Tipo Alertante</label
                >
                <div
                  class="btn-group btn-group-toggle col-9"
                  data-toggle="buttons"
                >
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="centroSanitario"
                      value="centroSanitario"
                      checked
                    />
                    Centro Sanitario
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="afectada"
                      value="afectada"
                    />
                    Afectada
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="entornoAfectada"
                      value="entornoAfectada"
                    />
                    Entorno Afectada
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="vip"
                      value="vip"
                    />
                    VIP
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="accidental"
                      value="accidental"
                    />
                    Accidental
                  </label>
                </div>
              </div>

              <!-- NOMBRE MÉDICA -->
              <div class="form-group row">
                <label for="datosMedica" class="col-2 col-form-label"
                  >Datos médica</label
                >
                <label for="nombreMedica" class="col-1 col-form-label"
                  >Nombre</label
                >
                <div class="col-3">
                  <input type="text" class="form-control" id="nombreMedica" />
                </div>
                <label for="apellidoMedica" class="col-1 col-form-label"
                  >Apellidos</label
                >
                <div class="col-4">
                  <input type="text" class="form-control" id="apellidoMedica" />
                </div>
              </div>

              <!-- PROVINCIA, MUNICIPIO Y COMARCA -->
              <div class="form-group row">
                <label for="localización" class="col-2 mt-1"
                  >Localización</label
                >
                <label for="provincia" class="col-1 mt-1">Provincia</label>
                <div class="col-2">
                  <select class="custom-select" id="provincia" required>
                    <option selected disabled value="">Selecciona...</option>
                    <option v-for="provincia in provincies" :key="provincia.id">{{ provincia.nom }}</option>
                    <!-- <option title="lleida">Lleida</option>
                    <option title="girona">Girona</option>
                    <option title="barcelona">Barcelona</option>
                    <option title="tarragona">Tarragona</option> -->
                  </select>
                </div>

                <label for="comarca" class="col-1 mt-1">Comarca</label>
                <div class="col-2">
                  <select class="custom-select" id="comarca" required>
                    <option selected disabled value="">Selecciona...</option>
                    <option v-for="comarca in comarques" :key="comarca.id">{{ comarca.nom }}</option>
                  </select>
                </div>

                <label for="municipio" class="col-1 mt-1">Municipio</label>
                <div class="col-2">
                  <select class="custom-select" id="municipio" required>
                    <option selected disabled value="">Selecciona...</option>
                    <option v-for="municipi in municipis" :key="municipi.id">{{ municipi.nom }}</option>
                  </select>
                </div>
              </div>

              <!-- DIRECCIÓN -->
              <div class="form row">
                <label for="direccion" class="col-2 mt-2">Dirección</label>
                <div class="col-5">
                  <input type="text" class="form-control" />
                </div>

                <label for="numeroDireccion" class="col-2 mt-2">Número</label>
                <div class="col-2">
                  <input type="number" class="form-control" min="1" />
                </div>
              </div>

              <!-- COMPLEMENTO DIRECCIÓN -->
              <div class="form-row mt-3 mb-3">
                <label for="complementoDireccion" class="col-2"
                  >Complemento Dirección</label
                >
                <div class="col-9">
                  <textarea
                    class="form-control"
                    id="complementoDireccion"
                    rows="3"
                  ></textarea>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <div v-if="currentTab == 2">
      <div class="container-fluid mt-5">
        <div class="card ml-5 mr-5">
          <div class="card-header">DATOS AFECTADA</div>
          <div class="card-body ml-5">
            <form>
              <!-- NOMBRE AFECTADA -->
              <div class="form-group row">
                <label for="nombreAfectada" class="col-1 col-form-label"
                  >Nombre</label
                >
                <div class="col-4">
                  <input type="text" class="form-control" id="nombreAfectada" />
                </div>

                <!-- APELLIDOS AFECTADA -->
                <label for="apellidoAfectada" class="col-1 col-form-label ml-4"
                  >Apellidos</label
                >
                <div class="col-5">
                  <input
                    type="text"
                    class="form-control"
                    id="apellidoAfectada"
                  />
                </div>
              </div>

              <!-- SEXO, EDAD, TELÉFONO -->
              <div class="form-group row">
                <label for="sexoAfectada" class="col-1 mt-1">Sexo</label>
                <div
                  class="btn-group btn-group-toggle col-4"
                  data-toggle="buttons"
                >
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="sexoAfectada"
                      id="mujer"
                      value="mujer"
                      checked
                    />
                    Mujer
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="sexoAfectada"
                      id="hombre"
                      value="hombre"
                    />
                    Hombre
                  </label>
                </div>

                <label for="edadAfectada" class="col-1 mt-1 ml-4">Edad</label>
                <div class="col-2">
                  <input type="number" class="form-control" min="1" />
                </div>

                <label for="telefonoAfectada" class="col-1 mt-1"
                  >Teléfono</label
                >
                <div class="col-2">
                  <input type="number" class="form-control" />
                </div>
              </div>

              <!-- CIP -->
              <div class="form row">
                <label for="direccion" class="col-1 mt-2">CIP</label>
                <div class="col-5">
                  <input type="text" class="form-control" />
                </div>

                <!-- AÑADIR AFECTADA -->
                <div class="col-4">
                  <button type="button" class="btn btn-primary float-right">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i> AÑADIR
                    AFECTADA
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>

        <div class="card ml-5 mr-5 mt-3">
          <div class="card-header">DATOS INCIDENTE</div>
          <div class="card-body ml-5">
            <form>
              <!-- FECHA -->
              <div class="form-group row">
                <label
                  for="fechaIncidente"
                  class="col-1 col-form-label"
                  >Fecha</label
                >
                <div class="col-2">
                  <input
                    class="form-control"
                    type="date"
                    value="2020-04-01"
                    id="fechaIncidente"
                  />
                </div>

                <!-- HORA -->
                <label for="horaIncidente" class="col-1 col-form-label ml-5"
                  >Hora</label
                >
                <div class="col-2">
                  <input type="time" value="13:45:00" class="form-control" id="horaIncidente" />
                </div>
              </div>

              <!-- INCIDENCIAS -->
              <div class="form-group row">
                <label for="tipoIncidencia" class="col-1 mt-1">Sexo</label>
                <div
                  class="btn-group btn-group-toggle col-9"
                  data-toggle="buttons"
                >
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoIncidencia"
                      id="accidente"
                      value="accidente"
                      checked
                    />
                    Accidente
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoIncidencia"
                      id="traumatismo"
                      value="traumatismo"
                    />
                    Traumatismo
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoIncidencia"
                      id="publico"
                      value="publico"
                    />
                    Enfermedad en lugar público
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoIncidencia"
                      id="domicilio"
                      value="domicilio"
                    />
                    Enfermedad domiciliaria
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoIncidencia"
                      id="consulta"
                      value="domicilio"
                    />
                    Consulta médica
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="transporte"
                      value="transporte"
                    />
                    Transporte sanitario
                  </label>
                </div>
              </div>

              <!-- DESCRIPCIÓN INCIDENTE -->
              <div class="form-row mt-3 mb-3">
                <label for="descripcionIncidente" class="col-1"
                  >Descripción del incidente</label
                >
                <div class="col-9">
                  <textarea
                    class="form-control"
                    id="descripcionIncidente"
                    rows="3"
                  ></textarea>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <div v-if="currentTab == 3">
      <div class="card ml-5 mr-5 mt-3">
        <div class="card-header">RESPUESTA</div>
        <div class="card-body ml-5">
          <form>
            <!-- CONSEJOS -->
            <div class="form-group row">
              <label for="consejo" class="col-1 mt-1">Consejos</label>
              <div class="col-9">
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo1"
                  />
                  <label class="form-check-label" for="consejo1"
                    >Tiene conocimientos de primeros auxilios</label
                  >
                </div>

                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo2"
                  />
                  <label class="form-check-label" for="consejo2"
                    >Puede pedir ayuda a algún peatón, persona que le
                    acompañe...</label
                  >
                </div>
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo3"
                  />
                  <label class="form-check-label" for="consejo3"
                    >Puede señalizar la zona del accidente/incidente</label
                  >
                </div>
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo4"
                  />
                  <label class="form-check-label" for="consejo4"
                    >Aflojarse la ropa</label
                  >
                </div>
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo5"
                  />
                  <label class="form-check-label" for="consejo5"
                    >Acercarse al coche y desconectar las llaves de
                    contacto</label
                  >
                </div>
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo6"
                  />
                  <label class="form-check-label" for="consejo6"
                    >Mantener el teléfono en manos libres</label
                  >
                </div>
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo7"
                  />
                  <label class="form-check-label" for="consejo7"
                    >No mover a la persona o víctimas</label
                  >
                </div>
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo8"
                  />
                  <label class="form-check-label" for="consejo8"
                    >No dejar sola a la persona</label
                  >
                </div>
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo9"
                  />
                  <label class="form-check-label" for="consejo9"
                    >No dar de comer ni de beber</label
                  >
                </div>
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo10"
                  />
                  <label class="form-check-label" for="consejo10"
                    >Poner a la persona en posición lateral de seguridad
                    (PLS)</label
                  >
                </div>
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo11"
                  />
                  <label class="form-check-label" for="consejo11"
                    >Si sangra, comprimir la herida con la mano, ropa...</label
                  >
                </div>
                <div class="form-check">
                  <input
                    type="checkbox"
                    class="form-check-input"
                    id="consejo12"
                  />
                  <label class="form-check-label" for="consejo12"
                    >Poner cómoda a la víctima</label
                  >
                </div>

                <div class="form-check">
                  <input type="checkbox" class="form-check-input" id="other" />
                  <label class="form-check-label" for="other">Otros</label>

                  <input
                    type="text"
                    class="col-4 ml-3"
                    id="otherValue"
                    name="other"
                  />
                </div>
              </div>
            </div>

            <!-- TOGGLE -->
            <div class="form-group row mt-4">
              <div class="custom-control custom-switch">
                <input
                  type="checkbox"
                  class="custom-control-input"
                  id="recursoSwitch"
                />
                <label class="custom-control-label" for="recursoSwitch"
                  >Activar recurso</label
                >
              </div>

              <!-- AÑADIR RECURSO -->
              <div class="col-10">
                <button type="button" class="btn btn-primary float-right mr-0">
                  <i class="fa fa-plus-circle" aria-hidden="true"></i> AÑADIR
                  RECURSO
                </button>
              </div>
            </div>
            <div class="card mt-2">
              <!-- CÓDIGO RECURSO -->
              <div class="form-group row mt-3 ml-3">
                <label for="codigoRecurso" class="col-2 col-form-label"
                  >Código del recurso</label
                >
                <div class="col-2 mt-1">
                  <input type="text" class="form-control" id="codigoRecurso" />
                </div>
              </div>
              <!-- RECURSO -->
              <div class="form-group row ml-3">
                <label for="tipoRecurso" class="col-2 mt-1"
                  >Tipo de recurso</label
                >
                <div
                  class="btn-group btn-group-toggle col-9"
                  data-toggle="buttons"
                >
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoRecurso"
                      id="mike"
                      value="mike"
                      checked
                    />
                    Amb. Medicalizada-Mike
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoRecurso"
                      id="india"
                      value="india"
                    />
                    Amb. Sanitarizada-India
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoRecurso"
                      id="tango"
                      value="tango"
                    />
                    Amb. Asistencia-Tango
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoRecurso"
                      id="helicoptero"
                      value="helicoptero"
                    />
                    Helicòptero medicalizado
                  </label>
                </div>
              </div>

              <!-- PRIORIDAD -->
              <div class="form-group row ml-3">
                <label for="prioridad" class="col-2 mt-1">Prioridad</label>
                <div
                  class="btn-group btn-group-toggle col-9"
                  data-toggle="buttons"
                >
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="prioridad"
                      id="prioridad1"
                      value="prioridad1"
                      checked
                    />
                    1
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="prioridad"
                      id="prioridad2"
                      value="prioridad2"
                    />
                    2
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="prioridad"
                      id="prioridad3"
                      value="prioridad3"
                    />
                    3
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="prioridad"
                      id="prioridad4"
                      value="prioridad4"
                    />
                    4
                  </label>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      currentTab: 1,
      isActive: false,
      provincies: [],
      comarques: [],
      municipis: []
    };
  },
  methods: {
    selectTab(selectedTab) {
      this.currentTab = selectedTab;
    },
    prev() {
      if (this.currentTab === 1) return;
      this.currentTab = this.currentTab - 1;
    },
    next() {
      this.currentTab = this.currentTab + 1;
    },
    selectProvincies(){
        let me = this;
        axios.get('/provincia').then(response => {
            me.provincies = response.data;
        }).catch(error => {
            console.log(error);
        }).finally(() => this.loading = false)
    },
    selectComarques(){
        let me = this;
        axios.get('/comarca').then(response => {
            me.comarques = response.data;
        }).catch(error => {
            console.log(error);
        }).finally(() => this.loading = false)
    },
    selectMunicipis(){
        let me = this;
        axios.get('/municipi').then(response => {
            me.municipis = response.data;
        }).catch(error => {
            console.log(error);
        }).finally(() => this.loading = false)
    },
  },
  created(){
      this.selectProvincies(),
      this.selectComarques(),
      this.selectMunicipis()
  }
};
</script>


<style>
.btn-secondary:not(:disabled):not(.disabled).active,
.btn-secondary:not(:disabled):not(.disabled):active,
.show > .btn-secondary.dropdown-toggle {
  background-color: #e3177d;
  border-color: black;
}

.btn-secondary {
  border-color: black;
}
</style>
