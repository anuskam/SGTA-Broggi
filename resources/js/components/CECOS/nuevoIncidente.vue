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
                    <option title="lleida">Lleida</option>
                    <option title="girona">Girona</option>
                    <option title="barcelona">Barcelona</option>
                    <option title="tarragona">Tarragona</option>
                  </select>
                </div>

                <label for="comarca" class="col-1 mt-1">Comarca</label>
                <div class="col-2">
                  <select class="custom-select" id="comarca" required>
                    <option selected disabled value="">Choose...</option>
                    <option>...</option>
                  </select>
                </div>

                <label for="municipio" class="col-1 mt-1">Municipio</label>
                <div class="col-2">
                  <select class="custom-select" id="municipio" required>
                    <option selected disabled value="">Choose...</option>
                    <option>...</option>
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
            <div class="custom-control custom-switch">
              <input
                type="checkbox"
                class="custom-control-input"
                id="recursoSwitch"
                :checked="isActive"
              />
              <label
                v-show="!isActive"
                class="custom-control-label"
                for="recursoSwitch"
                >Activar recurso</label
              >
              <label
                v-show="isActive"
                class="custom-control-label"
                for="recursoSwitch"
                >Desactivar recurso</label
              >
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
  },
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
