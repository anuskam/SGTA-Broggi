<template>
  <div class="contenido">
    <div v-show="errors.length > 0" v-for="(error, index) in errors" :key="index" class="alert alert-danger alert-dismissable fade show" role="alert" style="color: black;">
        {{ error }}
        <button class="close" type="button" data-dismiss="alert" aria-label="Cerrar">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div id="tabButtons" class="mt-2">
      <button
        :disabled="currentTab == 1"
        @click="prev()"
        class="btn btn-sm mr-3 float-left ml-3 iconNavPrincipal arrowNav"
        :class="{ hidden: tabs.a }"
      >
        <i class="fas fa-arrow-left fa-2x" aria-hidden="true"></i>
      </button>

      <div>
        <button @click="selectTab(1)" class="btn btn-sm mr-3 tabButton" :class="{ selectedTab: tabs.a }" aria-label="Alertante">
          <i class="fas fa-phone-alt fa-2x mr-2 ml-2 iconNavPrincipal" aria-hidden="true"></i>
        </button>
        |
        <button @click="selectTab(2)" class="btn btn-sm mr-3 ml-3 tabButton" :class="{ selectedTab: tabs.b }" aria-label="Afectada">
          <i class="fas fa-user-injured fa-2x mr-2 ml-2 iconNavPrincipal" aria-hidden="true"></i>
        </button>
        |
        <button @click="selectTab(3)" class="btn btn-sm ml-3 tabButton"  :class="{ selectedTab: tabs.c }" aria-label="Respuesta">
          <i class="fas fa-ambulance fa-2x mr-2 ml-2 iconNavPrincipal" aria-hidden="true"></i>
        </button>
        <div id="titulitosTabs">
            <p>Alertante</p>
            <p>Afectada</p>
            <p>Respuesta</p>
        </div>
      </div>

      <button
        :disabled="currentTab == 3"
        @click="next()"
        class="btn btn-sm mr-3 float-right mr-4 iconNavPrincipal arrowNav"
        :class="{ hidden: tabs.c }"
      >
        <i class="fas fa-arrow-right fa-2x"></i>
      </button>
    </div>

    <div v-show="currentTab == 1">
      <div class="container-fluid mt-5">
              <!-- BUSCADOR -->
              <div class="input-group" id="buscadorTelefono">
                  <input type="number" class="form-control col-2 ml-5 mb-4" placeholder="Teléfono" aria-label="Teléfono" :value = alertantNumber>
                  <div class="input-group-append">
                  <button class="btn btn-secondary mb-4" type="button" @click="getAlertantData()">
                      <i class="fa fa-search "></i>&nbsp;&nbsp;Buscar
                  </button>
                  </div>
              </div>

        <div class="card ml-5 mr-5">
          <div class="card-header font-weight-bold" id="titulito">DATOS ALERTANTE
              <button class="float-right" @click="showHelpBox(1)"><i class="far fa-file-alt"></i></button>
          </div>
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
                      value="1"
                      v-model="alertant.tipus_alertants_id"
                    />
                    Centro Sanitario
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="afectada"
                      value="2"
                      v-model="alertant.tipus_alertants_id"
                    />
                    Afectada
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="entornoAfectada"
                      value="3"
                      v-model="alertant.tipus_alertants_id"
                    />
                    Entorno Afectada
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="vip"
                      value="4"
                      v-model="alertant.tipus_alertants_id"
                    />
                    VIP
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="accidental"
                      value="5"
                      v-model="alertant.tipus_alertants_id"
                    />
                    Accidental
                  </label>
                </div>
              </div>

              <!-- NOMBRE MÉDICA -->
              <div class="form-group row">
                <label for="datosMedica" class="col-2 col-form-label"
                  >Datos personales</label
                >
                <label for="nombreMedica" class="col-1 col-form-label"
                  >Nombre</label
                >
                <div class="col-8">
                  <input
                    type="text"
                    class="form-control"
                    id="nombreMedica"
                    v-model="incidencia.nom_metge"
                  />
                </div>
              </div>

              <!-- PROVINCIA, MUNICIPIO Y COMARCA -->
              <div class="form-group row">
                <label for="localización" class="col-2 mt-1"
                  >Localización</label
                >

                <label for="municipio" class="col-1 mt-1">Municipio</label>
                <div class="col-2">
                  <select
                    class="custom-select"
                    id="municipio"
                    required
                    v-model="municipi"
                  >
                    <option selected value="Selecciona...">
                      Selecciona...
                    </option>
                    <option
                      v-for="municipi in municipisFiltered"
                      :key="municipi.id"
                      :value="municipi"
                    >
                      {{ municipi.nom }}
                    </option>
                  </select>
                </div>

                <label for="comarca" class="col-1 mt-1">Comarca</label>
                <div class="col-2">
                  <select
                    class="custom-select"
                    id="comarca"
                    required
                    v-model="comarca"
                  >
                    <option selected value="Selecciona...">
                      Selecciona...
                    </option>
                    <option
                      v-for="comarca in comarquesFiltered"
                      :key="comarca.id"
                      :value="comarca"
                    >
                      {{ comarca.nom }}
                    </option>
                  </select>
                </div>

                <label for="provincia" class="col-1 mt-1">Provincia</label>
                <div class="col-2">
                  <select
                    class="custom-select"
                    id="provincia"
                    required
                    v-model="provincia"
                  >
                    <option selected value="Selecciona...">
                      Selecciona...
                    </option>
                    <option
                      v-for="provincia in provinciesFiltered"
                      :key="provincia.id"
                      :value="provincia"
                    >
                      {{ provincia.nom }}
                    </option>
                  </select>
                </div>
              </div>
              <!-- DIRECCIÓN -->
              <div class="form row">
                <label for="direccion" class="col-2 mt-2">Dirección</label>
                <div class="col-9">
                  <input
                    id="direccion"
                    type="text"
                    class="form-control"
                    v-model="incidencia.adreca"
                  />
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
                    v-model="incidencia.adreca_complement"
                  ></textarea>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <div v-show="currentTab == 2">
      <div class="container-fluid mt-5 mb-3">
        <div class="card ml-5 mr-5">
          <div class="card-header font-weight-bold" id="titulito">DATOS AFECTADA
              <button class="float-right" @click="showHelpBox(2)"><i class="far fa-file-alt"></i></button>
          </div>
          <div class="card-body ml-5">
            <form>
              <!-- NOMBRE AFECTADA -->
              <div class="form-group row">
                <label for="nombreAfectada" class="col-1 col-form-label"
                  >Nombre</label
                >
                <div class="col-4">
                  <input
                    type="text"
                    class="form-control"
                    id="nombreAfectada"
                    v-model="afectat.nom"
                  />
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
                    v-model="afectat.cognoms"
                  />
                </div>
              </div>

              <!-- SEXO, EDAD -->
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
                      value="2"
                      v-model="afectat.sexes_id"
                    />
                    Mujer
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="sexoAfectada"
                      id="hombre"
                      value="1"
                      v-model="afectat.sexes_id"
                    />
                    Hombre
                  </label>
                </div>

                <label for="edadAfectada" class="col-1 col-form-label mt-1 ml-4">Edad</label>
                <div class="col-2">
                  <input
                    type="number"
                    class="form-control"
                    min="1"
                    max="130"
                    v-model="afectat.edat"
                  />
                </div>
              </div>
              <!-- CIP -->
              <div class="form row">
                <label for="direccion" class="col-1 mt-2">CIP</label>
                <div class="col-5">
                  <input
                    type="text"
                    class="form-control"
                    v-model="afectat.cip"
                  />
                </div>

                <!-- AÑADIR AFECTADA -->
                <div class="col-6">
                  <button
                    type="button"
                    class="btn btn-primary float-right ml-4"
                    id="afectadasList"
                    @click="mostrarAfectades()"
                    :disabled="afectadasCount == 0"
                  >
                    <i class="fa fa-list mr-1" aria-hidden="true"></i> AFECTADAS
                    ({{ afectadasCount }})
                  </button>
                  <button
                    type="button"
                    class="btn btn-primary float-right"
                    @click="afegirAfectat()"
                  >
                    <i class="fa fa-plus-circle mr-1" aria-hidden="true"></i>
                    AÑADIR AFECTADA
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>

        <div class="card ml-5 mr-5 mt-3">
          <div class="card-header font-weight-bold" id="titulito">DATOS INCIDENTE
              <button class="float-right" @click="showHelpBox(3)"><i class="far fa-file-alt"></i></button>
          </div>
          <div class="card-body ml-5">
            <form>
              <!-- FECHA -->
              <div class="form-group row">
                <label for="fechaIncidente" class="col-1 col-form-label"
                  >Fecha</label
                >
                <div class="col-2">
                  <input
                    class="form-control"
                    type="date"
                    id="fechaIncidente"
                    v-model="incidencia.data"
                  />
                </div>

                <!-- HORA -->
                <label for="horaIncidente" class="col-1 col-form-label ml-5"
                  >Hora</label
                >
                <div class="col-2">
                  <input
                    type="time"
                    class="form-control"
                    id="horaIncidente"
                    v-model="incidencia.hora"
                  />
                </div>
              </div>

              <!-- INCIDENCIAS -->
              <div class="form-group row">
                <label for="tipoIncidencia" class="col-1 mt-1"
                  >Tipo de incidente</label
                >
                <div
                  class="btn-group btn-group-toggle col-10"
                  data-toggle="buttons"
                >
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoIncidencia"
                      id="accidente"
                      value="1"
                      v-model="incidencia.tipus_incidencies_id"
                    />
                    Accidente
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoIncidencia"
                      id="traumatismo"
                      value="2"
                      v-model="incidencia.tipus_incidencies_id"
                    />
                    Traumatismo
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoIncidencia"
                      id="publico"
                      value="3"
                      v-model="incidencia.tipus_incidencies_id"
                    />
                    Enfermedad en lugar público
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoIncidencia"
                      id="domicilio"
                      value="4"
                      v-model="incidencia.tipus_incidencies_id"
                    />
                    Enfermedad domiciliaria
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoIncidencia"
                      id="consulta"
                      value="5"
                      v-model="incidencia.tipus_incidencies_id"
                    />
                    Consulta médica
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="tipoAlertante"
                      id="transporte"
                      value="6"
                      v-model="incidencia.tipus_incidencies_id"
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
                <div class="col-10">
                  <textarea
                    class="form-control"
                    id="descripcionIncidente"
                    rows="3"
                    v-model="incidencia.descripcio"
                  ></textarea>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <div v-show="currentTab == 3">
      <div class="card ml-5 mr-5 mt-3 mb-3">
        <div class="card-header font-weight-bold" id="titulito">RESPUESTA
            <button class="float-right ml-4" @click="showHelpBox(4)"><i class="far fa-file-alt"></i></button>
            <button
                type="button"
                id="entregar"
                class="btn btn-success float-right insertarIncidencia"
                :disabled="evaluando"
                @click="evaluarIncidencia()"
            >
                <i class="fa fa-check" aria-hidden="true"></i> INSERTAR INCIDENCIA
            </button>
        </div>
        <div class="card-body ml-5">
          <form>
            <!-- CONSEJOS -->
            <div class="form-group row">
              <label for="consejo" class="col-1 mt-1">Consejos</label>
              <div class="col-9">
                <div class="parentGrid">
                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="consejo1"
                    />
                    <label class="form-check-label" for="consejo1"
                      >Tiene conocimientos de primeros auxilios</label
                    >
                  </div>

                  <div class="form-check mb-2">
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

                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="consejo3"
                    />
                    <label class="form-check-label" for="consejo3"
                      >Puede señalizar la zona del accidente/incidente</label
                    >
                  </div>

                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="consejo4"
                    />
                    <label class="form-check-label" for="consejo4"
                      >Aflojarse la ropa</label
                    >
                  </div>

                  <div class="form-check mb-2">
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

                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="consejo6"
                    />
                    <label class="form-check-label" for="consejo6"
                      >Mantener el teléfono en manos libres</label
                    >
                  </div>

                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="consejo7"
                    />
                    <label class="form-check-label" for="consejo7"
                      >No mover a la persona o víctimas</label
                    >
                  </div>

                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="consejo8"
                    />
                    <label class="form-check-label" for="consejo8"
                      >No dejar sola a la persona</label
                    >
                  </div>

                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="consejo9"
                    />
                    <label class="form-check-label" for="consejo9"
                      >No dar de comer ni de beber</label
                    >
                  </div>

                  <div class="form-check mb-2">
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

                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="consejo11"
                    />
                    <label class="form-check-label" for="consejo11"
                      >Si sangra, comprimir la herida con la mano,
                      ropa...</label
                    >
                  </div>

                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="consejo12"
                    />
                    <label class="form-check-label" for="consejo12"
                      >Poner cómoda a la víctima</label
                    >
                  </div>

                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="consejo13"
                    />
                    <label class="form-check-label" for="consejo13"
                      >Poner cómoda a la víctima</label
                    >
                  </div>

                  <div class="form-check mb-2">
                    <input
                      type="checkbox"
                      class="form-check-input"
                      id="other"
                    />
                    <label class="form-check-label" for="other">Otros</label>

                    <input
                      type="text"
                      class="col-9 ml-3"
                      id="otherValue"
                      name="other"
                    />
                  </div>
                </div>
              </div>
            </div>

            <!-- TOGGLE -->
            <div class="form-group row mt-4">
              <div class="custom-control custom-switch col-2">
                <input
                  type="checkbox"
                  class="custom-control-input"
                  id="recursoSwitch"
                  v-model="activaRecurs"
                />
                <label class="custom-control-label" for="recursoSwitch"
                  >Activar recurso</label
                >
              </div>

              <!-- AÑADIR RECURSO -->
              <div class="col-10" :class="{ hidden: !activaRecurs }">
                  <button
                    type="button"
                    class="btn btn-primary float-right ml-4"
                    id="recursosList"
                    @click="mostrarRecursos()"
                    :disabled="recursosCount == 0"
                  >
                    <i class="fa fa-list mr-1" aria-hidden="true"></i> RECURSOS
                    ({{ recursosCount }})
                  </button>
                <button
                  type="button"
                  class="btn btn-primary float-right"
                  @click="afegirRecurs()"
                >
                  <i class="fa fa-plus-circle" aria-hidden="true"></i> AÑADIR
                  RECURSO
                </button>
              </div>
            </div>
            <div class="card mt-2" :class="{ hidden: !activaRecurs }">
              <!-- RECURSOS -->
              <div class="form-group row ml-3 mt-3 pb-4">
                  <label for="recursos" class="col-2 mt-1">Recursos</label>
                <div class="col-3 ">
                    <select
                    class="custom-select"
                    id="recurso"
                    v-model="recurs"
                    >
                    <option selected value="Selecciona...">
                        Selecciona...
                    </option>
                    <option
                        v-for="recurs in recursos_select"
                        :key="recurs.id"
                        :value="recurs"
                        :class="[ recurs.actiu ? 'green' : 'red' ]"
                        :disabled="!recurs.actiu"
                    >
                        {{ recurs.codi }}
                    </option>
                    </select>
                </div>
              <!-- </div> -->
              <!-- AFECTADOS -->
              <!-- <div class="form-group row ml-3 mt-3 pb-4"> -->
                  <label for="afectadoSelect" class="col-2 mt-1">Afectados</label>
                <div class="col-4">
                    <select
                    class="custom-select"
                    id="afectadoSelect"
                    v-model="afectatSelect"
                    >
                    <option selected value="Selecciona...">
                        Selecciona...
                    </option>
                    <option
                        v-for="(afectat, index) in recursAfectats"
                        :key="index"
                        :value="afectat"
                    >
                        {{ afectat.nom }} {{ afectat.cognoms }},
                        <span v-if="afectat.sexes_id == 1"> Hombre</span>
                        <span v-else> Mujer</span>
                         ({{ afectat.edat }})
                    </option>
                    </select>
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
                      value="1"
                      v-model="incidencies_has_recursos.prioritat"
                      :disabled="!recurs.actiu"
                    />
                    1
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="prioridad"
                      id="prioridad2"
                      value="2"
                      v-model="incidencies_has_recursos.prioritat"
                      :disabled="!recurs.actiu"
                    />
                    2
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="prioridad"
                      id="prioridad3"
                      value="3"
                      v-model="incidencies_has_recursos.prioritat"
                      :disabled="!recurs.actiu"
                    />
                    3
                  </label>
                  <label class="btn btn-secondary">
                    <input
                      type="radio"
                      name="prioridad"
                      id="prioridad4"
                      value="4"
                      v-model="incidencies_has_recursos.prioritat"
                      :disabled="!recurs.actiu"
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
    <!-- Modal Lista Afectadas -->
    <div class="modal" tabindex="-1" role="dialog" id="afectadaModal">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title deleteModal">Lista de Afectadas</h5>
            <button
              type="button"
              class="close"
              data-dismiss="modal"
              aria-label="Cerrar"
            >
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <ul class="list-group">
                <li v-for="(afectada, index) in afectats" :key="index" class="list-group-item">{{ afectada.nom }} {{ afectada.cognoms }},
                    <span v-if="afectada.sexes_id == 1"> Hombre</span>
                    <span v-else> Mujer</span>
                     ({{ afectada.edat }})
                    <button class="btn btn-danger float-right" @click="eliminarAfectada(index)"><i class="fas fa-trash"></i> Borrar</button>
                </li>
            </ul>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn cerrarBtn"
              data-dismiss="modal"
            >
              Cerrar
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal Lista Recursos -->
    <div class="modal" tabindex="-1" role="dialog" id="recursModal">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title deleteModal">Lista de Recursos</h5>
            <button
              type="button"
              class="close"
              data-dismiss="modal"
              aria-label="Cerrar"
            >
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <ul class="list-group" v-if="this.recursos.length > 0">
                <li v-for="(recursProba, recurs_index) in recursos" :key="recursProba.recurs.id" class="list-group-item">{{ recursProba.recurs.codi }},
                    <span v-if="recursProba.recurs.tipus_recursos_id == 1"> Ambulancia Medicalitzada, </span>
                    <span v-else-if="recursProba.recurs.tipus_recursos_id == 2"> Ambulancia Sanitaritzada, </span>
                    <span v-else-if="recursProba.recurs.tipus_recursos_id == 3"> Ambulancia Assistencial, </span>
                    <span v-else> Helicopter Medicalitzat, </span>
                    Prioritat {{ incidencies_has_recursos_array[recurs_index].prioritat }}
                    <!-- Probar posar el loop d'afectats abans del loop de recursos (variable per controlar no repeticio de recurs_id) -->
                    <ul v-if="recursProba.afectats.length > 0">
                        <li v-for="(afectat, index) in recursProba.afectats" :key="index">
                            {{ afectat.nom }} {{ afectat.cognoms }},
                            <span v-if="afectat.sexes_id == 1"> Hombre</span>
                            <span v-else> Mujer</span>
                            ({{ afectat.edat }})
                        </li>
                    </ul>
                    <button class="btn btn-danger float-right" @click="eliminarRecurs(recurs_index)"><i class="fas fa-trash"></i> Borrar</button>
                </li>
            </ul>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn cerrarBtn"
              data-dismiss="modal"
            >
              Cerrar
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal HelpBox -->
    <div class="modal" tabindex="-1" role="dialog" id="helpbox">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">HelpBox</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="preguntesModal">
        <div v-for="(pregunta, index) in preguntes" :key="index" class="card" id="preguntaModal">
            <div class="card-header">
                {{ pregunta.pregunta }}
            </div>
            <ul class="list-group list-group-flush">
                <li v-for="(resposta, index) in pregunta.respostes" :key="index" class="list-group-item">{{ resposta.resposta }}</li>
            </ul>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn cerrarBtn" data-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>
  </div>
</template>

<script>
export default {
    props: {
        alertantNumber: Number,
        userid: Number,
    },
  data: function () {
    return {
      currentTab: 1,
      tabs: {
          a: true,
          b: false,
          c: false
      },
      isActive: false,
      provincies: [],
      provincia: {
        id: null,
        nom: "Selecciona...",
      },
      comarques: [],
      comarca: {
        id: null,
        nom: "Selecciona...",
        provincies_id: null,
      },
      municipis: [],
      municipi: {
        id: null,
        nom: "Selecciona...",
        comarques_id: null,
      },
      incidencia: {
        id: null,
        num_incident: null,
        data: new Date().toISOString().slice(0, 10),
        hora: new Date().toLocaleTimeString("en-GB", {
          hour: "numeric",
          minute: "numeric",
          second: "numeric",
        }),
        telefon_alertant: null,
        adreca: null,
        adreca_complement: null,
        descripcio: null,
        nom_metge: null,
        tipus_incidencies_id: 1,
        alertants_id: null,
        municipis_id: null,
        usuaris_id: null,
      },
      afectats: [],
      afectat: {
        id: null,
        cip: null,
        nom: null,
        cognoms: null,
        edat: null,
        te_cip: false,
        sexes_id: 2,
        recurs_id: null,
      },
      afectatSelect: {
        id: null,
        cip: null,
        nom: null,
        cognoms: null,
        edat: null,
        te_cip: false,
        sexes_id: 2,
        recurs_id: null,
      },
      afectatSelected: [],
      alertant: {
        id: null,
        telefon: null,
        nom: null,
        cognoms: null,
        adreca: null,
        municipis_id: null,
        tipus_alertants_id: 1,
      },
      alertants: [],
      incidencies_has_afectats_array: [],
      incidencies_has_afectats: {
        incidencies_id: null,
        afectats_id: null,
      },
      incidencies_has_recursos_array: [],
      incidencies_has_recursos: {
        incidencies_id: null,
        recursos_id: null,
        hora_activacio: null,
        hora_mobilitzacio: null,
        hora_assistencia: null,
        hora_transport: null,
        hora_arribada_hospital: null,
        hora_transferencia: null,
        hora_finalitzacio: null,
        prioritat: 1,
        desti: this.adreca,
      },
      recurs: {
        actiu: null,
        codi: null,
        id: null,
        tipus_recursos_id: null,
      },
      recursos: [],
      recursos_select: [],
      errors: [],
      activaRecurs: false,
      insertIncidencia: {
            "data": null,
            "hora": null,
            "telefon_alertant": null,
            "adreca": null,
            "adreca_complement": null,
            "descripcio": null,
            "tipus_incidencies_id": null,
            "alertants_id": null,
            "municipis_id": null,
            "usuaris_id": this.userid,
            "recursos": [
                // {
                //     "recursos_id": 1,
                //     "afectats_id": 1,
                //     "prioritat": 1,
                //     "hora_activacio": "15:06:51"
                // },
            ]
      },
      recursAfectats: [],
      alertanteConocido: false,
      alertantDB: null,
      afectatsDB: null,
      recursosInsert: [],
      evaluando: false,
      preguntesDB : [],
      respostesDB: [],
      preguntes: [],
      pregunta: {
          pregunta: null,
          respostes: []
      },
    };
  },
  methods: {
    showHelpBox(number){
        let me = this;
        this.preguntes = [];
        switch(number){
            case 1:
                this.preguntesDB.forEach(function(pregunta){
                    if(pregunta.id > 0 && pregunta.id < 4){
                        me.pregunta.pregunta = pregunta.pregunta;
                        me.pregunta.respostes = me.respostesDB.filter((resposta => resposta.preguntes_id == pregunta.id));
                        me.preguntes.push(me.pregunta);
                        me.pregunta = {
                            pregunta: null,
                            respostes: []
                        };
                    }
                })
                break;
            case 2:
                this.preguntesDB.forEach(function(pregunta){
                    if(pregunta.id > 3 && pregunta.id < 8){
                        me.pregunta.pregunta = pregunta.pregunta;
                        me.pregunta.respostes = me.respostesDB.filter((resposta => resposta.preguntes_id == pregunta.id));
                        me.preguntes.push(me.pregunta);
                        me.pregunta = {
                            pregunta: null,
                            respostes: []
                        };
                    }
                })
                break;
            case 3:
                this.preguntesDB.forEach(function(pregunta){
                    if(pregunta.id == 8){
                        me.pregunta.pregunta = pregunta.pregunta;
                        me.pregunta.respostes = me.respostesDB.filter((resposta => resposta.preguntes_id == pregunta.id));
                        me.preguntes.push(me.pregunta);
                        me.pregunta = {
                            pregunta: null,
                            respostes: []
                        };
                    }
                })
                break;
            case 4:
                this.preguntesDB.forEach(function(pregunta){
                    if(pregunta.id > 8){
                        me.pregunta.pregunta = pregunta.pregunta;
                        me.pregunta.respostes = me.respostesDB.filter((resposta => resposta.preguntes_id == pregunta.id));
                        me.preguntes.push(me.pregunta);
                        me.pregunta = {
                            pregunta: null,
                            respostes: []
                        };
                    }
                })
                break;
        }
        $('#helpbox').modal('show');
    },
    selectTab(selectedTab) {
      this.currentTab = selectedTab;
      switch(selectedTab){
        case 1:
            this.tabs.a = true;
            this.tabs.b = false;
            this.tabs.c = false;
            break;
        case 2:
            this.tabs.a = false;
            this.tabs.b = true;
            this.tabs.c = false;
            break;
        case 3:
            this.tabs.a = false;
            this.tabs.b = false;
            this.tabs.c = true;
            break;
      }
    },
    prev() {
      --this.currentTab;
      this.selectTab(this.currentTab);
      console.log(this.userid);
    },
    next() {
      ++this.currentTab;
      this.selectTab(this.currentTab);

    },
    selectPreguntes() {
      let me = this;
      axios
        .get("/SGTA-Broggi/public/api/pregunta")
        .then((response) => {
          me.preguntesDB = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    selectRespostes() {
      let me = this;
      axios
        .get("/SGTA-Broggi/public/api/resposta")
        .then((response) => {
          me.respostesDB = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    selectProvincies() {
      let me = this;
      axios
        .get("/SGTA-Broggi/public/api/provincia")
        .then((response) => {
          me.provincies = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    selectComarques() {
      let me = this;
      axios
        .get("/SGTA-Broggi/public/api/comarca")
        .then((response) => {
          me.comarques = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    selectMunicipis() {
      let me = this;
      axios
        .get("/SGTA-Broggi/public/api/municipi")
        .then((response) => {
          me.municipis = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    selectRecursos(){
        let me = this;
      axios
        .get("/SGTA-Broggi/public/api/recurs")
        .then((response) => {
          me.recursos_select = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    async selectAlertants(){
        let me = this;
        return axios
        .get("/SGTA-Broggi/public/api/alertant")
        .then((response) => {
          me.alertants = response.data;
        })
        .catch((error) => {
          console.log(error);
        });

    },
    async selectAfectats(){
        let me = this;
        return axios
        .get("/SGTA-Broggi/public/api/afectat")
        .then((response) => {
          me.afectatsDB = response.data;
        })
        .catch((error) => {
          console.log(error);
        });

    },
    afegirAfectat() {
        this.errors = [];
      if (this.afectat.sexes_id != null && this.afectat.nom != null && this.afectat.cognoms != null && this.afectat.edat != null) {
        if (this.afectat.cip != null) {
          this.afectat.te_cip = true;
        }
        this.afectats.push(this.afectat);
        this.recursAfectats.push(this.afectat);
        this.buidarAfectat();
      } else {
        this.errors.push("Hay que introducir nombre, apellidos, sexo y edad de la afectada");
      }
    },
    afegirRecurs() {
        this.errors=  [];
      if (this.recurs.tipus_recursos_id > 0 && this.incidencies_has_recursos.prioritat > 0 && this.afectatSelect.edat != null) {
        let pos = this.recursos_select.findIndex(x => x.codi == this.recurs.codi);
        this.afectatSelect.recurs_id = this.recurs.id;
        this.afectatSelected.push(this.afectatSelect);
        let recurs = {
            "recurs": this.recurs,
            "afectats": [],
        }
        recurs.afectats.push(this.afectatSelect);
        let borrarAfectatIndex = this.recursAfectats.findIndex(obj => (obj.sexes_id == this.afectatSelect.sexes_id) && (obj.edat == this.afectatSelect.edat) && (obj.nom == this.afectatSelect.nom) && (obj.cognoms == this.afectatSelect.cognoms));
        this.recursAfectats.splice(borrarAfectatIndex, 1);
        this.recursos.push(recurs);
        this.incidencies_has_recursos.recursos_id = this.recurs.id;
        this.buidarRecurs();
        this.buidarAfectatSelect();
        this.recursos_select[pos].actiu = false;
        this.incidencies_has_recursos.hora_activacio = new Date().toLocaleTimeString("en-GB", {
          hour: "numeric",
          minute: "numeric",
          second: "numeric",
        });
        this.incidencies_has_recursos_array.push(this.incidencies_has_recursos);
        this.buidarIncidenciaHasRecurs();
      } else {
        this.errors.push("Hay que elegir un recurso, una afectada y una prioridad");
      }
    },
    buidarAfectat() {
      this.afectat = {
        id: null,
        cip: null,
        nom: null,
        cognoms: null,
        edat: null,
        te_cip: false,
        sexes_id: 2,
        recurs_id: null,
      };
    },
    buidarAfectatSelect() {
      this.afectatSelect = {
        id: null,
        cip: null,
        nom: null,
        cognoms: null,
        edat: null,
        te_cip: false,
        sexes_id: 2,
        recurs_id: null,
      };
    },
    buidarRecurs() {
      this.recurs = {
        actiu: null,
        codi: null,
        id: null,
        tipus_recursos_id: 1,
      };
    },
    buidarIncidenciaHasRecurs(){
        this.incidencies_has_recursos = {
        incidencies_id: null,
        recursos_id: null,
        hora_activacio: null,
        hora_mobilitzacio: null,
        hora_assistencia: null,
        hora_transport: null,
        hora_arribada_hospital: null,
        hora_transferencia: null,
        hora_finalitzacio: null,
        prioritat: 1,
        desti: this.adreca,
      };
    },
    eliminarAfectada(index){
        this.afectats.splice(index,1);
    },
    mostrarAfectades(){
        $('#afectadaModal').modal('show');
    },
    eliminarRecurs(index){
        let me = this;
        let afectatsArray = this.recursos[index].afectats;
        afectatsArray.forEach(function (afectat){
            me.recursAfectats.push(afectat);
        });
        let recursSelectIndex = this.recursos_select.findIndex(obj => obj.id == this.recursos[index].recurs.id);
        this.recursos_select[recursSelectIndex].actiu = true;
        this.recursos.splice(index,1);
    },
    mostrarRecursos(){
        $('#recursModal').modal('show');
    },
    async evaluaInsertAlertantes(){
        /* Insert en alertants? o es conocido */
        if(this.alertanteConocido == false){
            this.alertant.adreca = this.incidencia.adreca;
            this.alertant.nom = this.incidencia.nom_metge;
            this.alertant.municipis_id = this.municipi.id;
            this.alertant.telefon = this.alertantNumber;
            this.alertant.tipus_alertants_id = Number(this.alertant.tipus_alertants_id);
            await this.insertarAlertant();
            await this.selectAlertants();
            await this.getAlertantData();
        }
        console.log(1)
        return null;
    },
    evaluaErrores(){
      let hasErrors = false;
        if(this.municipi.id == null){
            hasErrors = true;
            this.errors.push("Hay que introducir el municipio del incidente");
        }

      if(this.activaRecurs == true && !this.afectatSelected.length > 0){
        hasErrors = true;
        this.errors.push("Hay que activar algún recurso o desactivar la opción de asignar recurso");
      }
      if(this.activaRecurs == false && !this.afectats.length > 0){
          this.errors.push("Hay que añadir una afectada a la incidencia");
      }
      if(this.incidencia.adreca == null){
        hasErrors = true;
        this.errors.push("Hay que introducir la dirección del incidente");
      }
      if(this.incidencia.descripcio == null){
        hasErrors = true;
        this.errors.push("Hay que introducir la descripción del incidente");
      }
      if(this.alertanteConocido == true && this.incidencia.nom_metge == null){
          hasErrors = true;
          this.errors.push("Hay que introducir el nombre de la médica alertante");
      }
      return hasErrors;
    },
    evaluaInsertIncidencia(){
      this.insertIncidencia = {
          "data": this.incidencia.data,
          "hora": this.incidencia.hora,
          "telefon_alertant": this.alertantNumber,
          "adreca": this.incidencia.adreca,
          "adreca_complement": this.incidencia.adreca_complement,
          "descripcio": this.incidencia.descripcio,
          "nom_metge": this.incidencia.nom_metge,
          "tipus_incidencies_id": Number(this.incidencia.tipus_incidencies_id),
          "alertants_id": this.alertantDB.id,
          "municipis_id": this.municipi.id,
          "usuaris_id": this.userid,
          "recursos": []
      };
    },
    async insertarAfectados(index){
        let me = this;
        // this.afectatSelected.forEach(function(afectat){
        //             me.insertarAfectat(afectat);
        // });
       return me.insertarAfectat(this.afectatSelected[index]);
    },
    // Control de Insert de la Incidencia
    async evaluarIncidencia(){
        this.evaluando = true;
        this.errors = [];
        if(!this.evaluaErrores()){
          /* Control insert afectats */
          if(this.activaRecurs == true){ // Si se ha activado asignacion de recursos
              if(this.afectatSelected.length > 0){ // Si realmente hay recursos asignados (NO CAL!)
                  let me = this;
                  for(let index = 0; index < this.afectatSelected.length; ++index){
                      await me.insertarAfectados(index);
                  }

                //   await this.insertarAfectados();
                  console.log("Se han insertado los afectados");

                /* Insert de la incidencia con recursos */
                  await this.evaluaInsertAlertantes();
                  console.log(2);
                  this.evaluaInsertIncidencia();
                  await this.insertAfectatsSinRecurso();
                    let afectatsInsert = [];
                    this.recursos.forEach(function (recurso, indexRecurso){ // Recopilando objetos de recursos con afectados en un array
                        recurso.afectats.forEach(function (afectat){
                            let afectatInsert = {
                              "recursos_id": null,
                              "afectats_id": null,
                              "prioritat": null,
                              "hora_activacio": null
                            };
                            afectatInsert.recursos_id = afectat.recurs_id;
                            // afectatInsert.afectats_id = afectat.id;
                            afectatInsert.afectats_id = me.recursosInsert[indexRecurso].id;
                            let indexRecurs = me.incidencies_has_recursos_array.findIndex(obj => obj.recursos_id == afectat.recurs_id);
                            afectatInsert.prioritat = me.incidencies_has_recursos_array[indexRecurs].prioritat;
                            afectatInsert.hora_activacio = me.incidencies_has_recursos_array[indexRecurs].hora_activacio;
                            afectatsInsert.push(afectatInsert);
                        });
                    });
                    this.insertIncidencia.recursos = afectatsInsert;
                    this.insertarIncidencia();
                    this.updateRecursos();
              }
          }
          else{ // Insert de la incidencia sin recursos
              await this.evaluaInsertAlertantes();
              this.evaluaInsertIncidencia();
              await this.insertAfectatsSinRecurso();
              console.log('afectados done');
              console.log(this.insertIncidencia);
              this.insertarIncidencia();
              this.updateRecursos();
          }
          location.reload();
        }
        else{
            this.evaluando = false;
        }
    },
    async insertAfectatsSinRecurso(){
        let me = this;
        this.insertIncidencia.afectats = [];
        return this.afectats.forEach(function (afectat) {
            if(afectat.recurs_id == null){
                me.insertIncidencia.afectats.push(afectat);
            }
            console.log("afectado x");
        });
    },
    insertarIncidencia(){
      let me = this;
      axios.post('/SGTA-Broggi/public/api/incidencia', me.insertIncidencia).then((response) => {
          console.log(response);
      }).catch( (error) => {
          console.log(error.response.status);
          console.log(error.response.data.error);
      })
    },
    insertarIncidenciesHasAfectats(afectat){
      let me = this;
      axios.post('/SGTA-Broggi/public/api/incidencia_has_recursos', afectat).then((response) => {
          console.log(response);
      }).catch( (error) => {
          console.log(error.response.status);
          console.log(error.response.data.error);
      })
    },
    async insertarAfectat(afectat){
      let me = this;
      return axios.post('/SGTA-Broggi/public/api/afectat', afectat).then((response) => {
          console.log(response);
          me.recursosInsert.push(response.data);
      }).catch( (error) => {
          console.log(error.response.status);
          console.log(error.response.data.error);
      })
    },
    async insertarAlertant(){
      let me = this;
      return axios.post('/SGTA-Broggi/public/api/alertant', me.alertant).then((response) => {
          console.log(response);
      }).catch( (error) => {
          console.log(error.response.status);
          console.log(error.response.data.error);
      });
    },
    async getAlertantData(){
        let me = this;
        return this.alertants.forEach(function(alertant){
            if(alertant.telefon == me.alertantNumber){ // Se supone que el telefono es unico pero se puede confundir con un alertante registrado
                me.alertantDB = alertant;
                me.alertanteConocido = true;
                me.incidencia.adreca = alertant.adreca;
                me.alertant.tipus_alertants_id = alertant.tipus_alertants_id;
                let municipi = me.municipis.find(obj => obj.id == alertant.municipis_id);
                me.municipi = municipi;
                if(alertant.tipus_alertants_id == 1){
                    me.incidencia.adreca_complement = alertant.nom;
                }
            }
        });
    },
    updateRecursos(){
        let me = this;
        this.recursos.forEach(function (recurs){
            let recursToUpdate = recurs.recurs;
            axios.put('/SGTA-Broggi/public/api/recurs/'+recursToUpdate.id, recursToUpdate).then((response) => {
                console.log(response);
            }).catch( (error) => {
                console.log(error.response.status);
                console.log(error.response.data.error);
            });
        });
    }
  },
  computed: {
    comarquesFiltered: function () {
      //   this.municipi = {
      //   id: null,
      //   nom: "Selecciona...",
      //   comarques_id: null
      // };
      if (this.provincia.id > 0 && this.municipi.id == null) {
        let comarquesFiltered = [];
        let comarques = this.comarques;
        for (let i = 0; i < comarques.length; ++i) {
          if (comarques[i].provincies_id == this.provincia.id) {
            comarquesFiltered.push(comarques[i]);
          }
        }
        return comarquesFiltered;
      } else if (this.municipi.id > 0) {
        let comarquesFiltered = [];
        let comarques = this.comarques;
        let counter = 0;
        let found = false;
        while (counter < comarques.length && !found) {
          if (comarques[counter].id == this.municipi.comarques_id) {
            this.comarca = comarques[counter];
            comarquesFiltered.push(comarques[counter]);
            found = true;
          } else {
            ++counter;
          }
        }
        return comarquesFiltered;
      } else {
        return this.comarques;
      }
    },
    municipisFiltered: function () {
      if (this.comarca.id > 0) {
        let municipisFiltered = [];
        let municipis = this.municipis;
        for (let i = 0; i < municipis.length; ++i) {
          if (municipis[i].comarques_id == this.comarca.id) {
            municipisFiltered.push(municipis[i]);
          }
        }
        return municipisFiltered;
      } else {
        return this.municipis;
      }
    },
    provinciesFiltered: function () {
      if (this.comarca.id > 0) {
        let provincia = this.provincies.find(
          (o) => o.id == this.comarca.provincies_id
        );
        this.provincia = provincia;
        let provinciesFiltered = [];
        provinciesFiltered.push(provincia);
        return provinciesFiltered;
      } else {
        return this.provincies;
      }
    },
    afectadasCount: function () {
      return this.afectats.length;
    },
    recursosCount: function () {
      return this.recursos.length;
    },
    adreca: function (){
        if(this.incidencia.adreca != null){
            return this.incidencia.adreca;
        }
        else{
            return null;
        }
    }
  },
  created() {
    this.selectAlertants(),this.selectProvincies(), this.selectComarques(), this.selectMunicipis(), this.selectRecursos(), this.selectPreguntes(), this.selectRespostes();
  },
};
</script>


<style>
.btn {
    font-size: 15px;
}

.contenido{
    font-size: 15px;
}

.btn-secondary:not(:disabled):not(.disabled).active,
.btn-secondary:not(:disabled):not(.disabled):active,
.show > .btn-secondary.dropdown-toggle {
  background-color: #e3177d;
  border-color: black;

}

.btn-secondary {
  border-color: black;
  display: flex;
  align-items: center;
  justify-content: center;
}

.parentGrid {
  display: grid;
  grid-template-columns: 1fr 1fr;
}

#tabButtons {
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  justify-content: space-between;
}

.card-header {
  background-color: #15acc4;
  border: 1px solid black;
  border-left: 0;
  border-right: 0;
  margin-top: -1px;
}

.modal-header{
    background-color: #15acc4 !important;
}

.card {
  border: 1px solid black !important;
}

button {
  background-color: #e3177d !important;
  border: 1px solid black !important;
}

#afectadasList, #recursosList {
  color: black;
  font-weight: bold;
  background-color: #15acc4 !important;
}

.tabButton{
    background-color: white !important;
    border: 0 !important;
}

.selectedTab{
    background-color: #e3177d !important;
    border: 1px solid black !important;
}

.green{
    background-color: green;
    color: white;
}

.red{
    background-color: red;
    color: white;
}

#entregar{
  border: 1px solid black;
}

#titulitosTabs {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
}

.iconNavPrincipal{
    color: black;
}

#titulito {
    font-family: 'Signika', sans-serif;
    font-size: 1.3em;
}

.hidden{
    visibility: hidden;
}

#buscadorTelefono > input{
    border: 1px solid black;
}

.arrowNav{
    height: 8vh;
}

#preguntesModal{
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: space-around;
}

#preguntaModal{
    width: 50vw;
    margin-bottom: 2vw;
    margin-top: 2vw;
}

#preguntaModal > .card-header{
    font-weight: bold;
}

.modal-title{
    font-weight: bold !important;
}

.cerrarBtn {
  background-color: #6c757d !important;
  color: white;
}
</style>
