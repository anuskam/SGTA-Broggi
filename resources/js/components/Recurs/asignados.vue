<template>
  <main class="col-md-10 col-sm-12">
    <div class="card" id="infoCard">
      <div class="card-header" id="infoHeader">
        <div>#12</div>
        <div>Traumatisme</div>
        <div>G-003</div>
      </div>
      <div class="card-body p-3">
        <div id="map">

        </div>
        <div id="info" class="col-12 p-0">
          <div class="col-11" id="infoFields">
            <div class="infobox" id="descripcionBox">
              <div class="col-2 text-center">Descripción:</div>
              <div id="descripcion" class="col-9">
                Juan se ha caido de una escalera mientras rescataba al mishu de
                la vecina de al lado...
              </div>
            </div>
            <div class="infobox" id="direccionBox">
              <div class="col-2 text-center">Dirección:</div>
              <div id="direccion" class="col-9">
                C/ Inventada, 4 2º A, 08019 Barcelona
              </div>
            </div>
          </div>

          <div class="col-1" id="masInfo">
            <button @click="showInfo()">
              <i class="fas fa-2x fa-plus-circle"></i><br />Más Info
            </button>
          </div>
        </div>
      </div>
    </div>
    <div id="botones" class="card mt-4 p-2">
      <div id="leftButtons" class="col-2">
        <div id="movilitzacio" class="button" @click="activarMovilitzacio()">
          <button><i class="fas fa-running"></i> Iniciar Movilització</button>
          <input type="time" v-model="horaMovilitzacio" />
        </div>

        <div id="assistencia" class="button" @click="activarAssistencia()" :class="{ visible: movilitzacio }">
          <button :disabled="!movilitzacio">
            <i class="fas fa-briefcase-medical"></i> Iniciar Assistència
          </button>
          <input type="time" v-model="horaAssistencia" />
        </div>
      </div>
      <div id="checkTransport" class="col-1" @click="activarMostrarTransport()"  :class="{ visible: assistencia }">
        <button :disabled="!assistencia">
          <i class="fas fa-hospital-user"><p></p>
            <!-- <input type="checkbox" name="" id="transportButton"/> -->
            </i>
        </button>
      </div>
      <div id="transportButtons" class="card col-9 p-0"  :class="{ visible: mostrarTransport }">
        <div class="card-header" id="transportHeader">Destí Hospitalari</div>
        <div class="card-body p-2 pl-4 pr-4" id="transportForm">
          <input
            :disabled="!mostrarTransport"
            type="text"
            placeholder="Introdueix direcció"
            id="direccioHospital"
          />
          <div id="botonsTransport">
            <div class="botoTransport button">
              <button :disabled="!mostrarTransport" @click="activarTransport()">
                <i class="fas fa-ambulance"></i> Iniciar Transport
              </button>
              <input type="time" v-model="horaTransport" />
            </div>
            <div class="botoTransport button">
              <button :disabled="!transport" @click="activarHospital()"><i class="fas fa-hospital"></i> Arribada Hospital</button>
              <input type="time" v-model="horaHospital" />
            </div>
            <div class="botoTransport button">
              <button :disabled="!hospital" @click="activarTransferencia()">
                <i class="fas fa-user-friends"></i> Iniciar Transferència
              </button>
              <input type="time" v-model="horaTransferencia" />
            </div>
            <div class="botoTransport button">
              <button :disabled="!transferencia"><i class="fas fa-procedures"></i> Hospitalització</button>
              <button id="alta">
                <i class="fas fa-notes-medical"></i> Alta Voluntària
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="modal" tabindex="-1" role="dialog" id="infoModal">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Más Información</h5>
            <!-- <button
              type="button"
              class="close"
              data-dismiss="modal"
              aria-label="Close"
            >
              <span aria-hidden="true">&times;</span>
            </button> -->
          </div>
          <div class="modal-body">
            <p>Complemento Dirección: Esquina con una oficina de correos y tres casas feas</p>
            <p>Nombre del Alertante: Juan Palomo</p>
            <p>Teléfono del Alertante: 686593421</p>
            <p>CIP: CAME2934958293</p>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-dismiss="modal"
            >
              Cerrar
            </button>
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
            movilitzacio: false,
            assistencia: false,
            mostrarTransport: false,
            transport: false,
            hospital: false,
            transferencia: false,
            horaMovilitzacio: null,
            horaAssistencia: null,
            horaTransport: null,
            horaHospital: null,
            horaTransferencia: null,
        }
    },
    methods: {
        showInfo(){
            $('#infoModal').modal('show')
        },
        activarMovilitzacio(){
            this.movilitzacio = true;
            this.horaMovilitzacio = new Date().toLocaleTimeString("en-GB", {
            hour: "numeric",
            minute: "numeric",
            second: "numeric",
            });
        },
        activarAssistencia(){
            this.assistencia = true;
            this.horaAssistencia = new Date().toLocaleTimeString("en-GB", {
            hour: "numeric",
            minute: "numeric",
            second: "numeric",
            });
        },
        activarMostrarTransport(){
            this.mostrarTransport = true;
        },
        activarTransport(){
            this.transport = true;
            this.horaTransport = new Date().toLocaleTimeString("en-GB", {
            hour: "numeric",
            minute: "numeric",
            second: "numeric",
            });
        },
        activarHospital(){
            this.hospital = true;
            this.horaHospital = new Date().toLocaleTimeString("en-GB", {
            hour: "numeric",
            minute: "numeric",
            second: "numeric",
            });
        },
        activarTransferencia(){
            this.transferencia = true;
            this.horaTransferencia = new Date().toLocaleTimeString("en-GB", {
            hour: "numeric",
            minute: "numeric",
            second: "numeric",
            });
        },
    },
  mounted() {
    console.log("Component mounted.");
  },
};
</script>

<style scoped>
main {
  margin-top: 1.4vh;
}
#infoCard {
  height: 65vh;
}
#botones {
  height: 28vh;
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  justify-content: space-around;
  align-items: center;
}
#infoHeader {
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  justify-content: space-between;
  font-size: 1.2em;
  font-weight: bold;
  margin-right: -0.5px;
  border-bottom: 1px solid black;
  background-color: #15acc4;
}
button {
  background-color: #e3177d;
  font-weight: bold;
  font-size: 0.9em;
}
.card {
  border: 1px solid black;
}
#transportHeader {
  background-color: #15acc4;
  font-weight: bold;
  padding: 6px 20px;
  text-align: center;
}
#leftButtons {
  height: 100%;
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  justify-content: space-around;
}
#assistencia{
    opacity: .4;
}
#checkTransport {
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  justify-content: center;
  align-items: center;
  opacity: .4;
  /* margin-left: -80px; */
}
#checkTransport button {
  padding: 10px 4px;
  height: 100%;
}
#transportButton {
  background-color: #e3177d;
}
#transportButtons {
  height: 100%;
  opacity: .4;
}
.visible{
    opacity: 1 !important;
}
#transportForm {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-around;
  align-items: center;
}
#botonsTransport {
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  width: 100%;
  justify-content: space-between;
}
.button {
  display: flex;
  flex-direction: column;
  /* align-items: center; */
}
#direccioHospital {
  width: 100%;
}
#map {
  height: 65%;
  background-color: black;
}
#info {
  height: 20%;
  margin-top: 4%;
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  flex-wrap: nowrap;
  font-weight: bold;
}

#infoFields {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  padding-right: 0;
}
.infobox {
  display: flex;
  flex-direction: row;
  align-items: center;
  text-align: justify;
}
.infobox > div {
  background-color: #15acc4;
  border: 1px solid black;
}

#descripcion,
#direccion {
  background-color: white;
}
#masInfo {
  display: flex;
  flex-direction: column;
  justify-content: center;
  vertical-align: center;
}
#masInfo > button {
  padding: 10px 20px;
  margin-left: -50px;
}
.modal-header{
    font-weight: bold;
    background-color: #15acc4;
}
#alta{
    opacity: 1 !important;
}
</style>
