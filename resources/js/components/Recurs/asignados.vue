<template>
  <main class="col-md-10 col-sm-12">
    <div class="card" id="infoCard">
      <div class="card-header" id="infoHeader">
        <div>#{{ incidenciaID }}</div>
        <div>{{ tipusIncidencia }}</div>
        <div>Prioritat: {{ prioritat }}</div>
      </div>
      <div class="card-body p-3">
        <div id="map">

        </div>
        <div id="info" class="col-12 p-0">
          <div class="col-11" id="infoFields">
            <div class="infobox" id="descripcionBox">
              <div class="col-2 text-center boldInfo">Descripción:</div>
              <div id="descripcion" class="col-9">
                {{ descripcio }}
              </div>
            </div>
            <div class="infobox" id="direccionBox">
              <div class="col-2 text-center boldInfo">Dirección:</div>
              <div id="direccion" class="col-9">
                {{ address }}
              </div>
            </div>
          </div>

          <div class="col-1" id="masInfo">
            <button @click="showInfo()" class="btn">
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
          <input type="time" v-model="incidenciaRecursInsert.hora_mobilitzacio" />
        </div>

        <div id="assistencia" class="button" @click="activarAssistencia()" :class="{ visible: movilitzacio }">
          <button :disabled="!movilitzacio">
            <i class="fas fa-briefcase-medical"></i> Iniciar Assistència
          </button>
          <input type="time" v-model="incidenciaRecursInsert.hora_assistencia" />
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
          <!-- <input
            :disabled="!mostrarTransport"
            type="text"
            placeholder="Introdueix direcció"
            id="direccioHospital"
            :v-model="hospitalAddress"
          /> -->
          <select
            :disabled="!mostrarTransport"
            class="custom-select"
            id="direccioHospital"

            v-model="incidenciaRecursInsert.desti"
            >
            <option selected value="Selecciona...">
                Selecciona...
            </option>
            <option
                v-for="(address, index) in addresses"
                :key="index"
                :value="address.adreca"
            >
                {{ address.nom }}
            </option>
            </select>
          <div id="botonsTransport">
            <div class="botoTransport button">
              <button :disabled="!mostrarTransport" id="iniciarTransport" @click="activarTransport()">
                <label for="iniciarTransport"><i class="fas fa-ambulance"></i> Iniciar Transport</label>
              </button>
              <input type="time" v-model="incidenciaRecursInsert.hora_transport" />
            </div>
            <div class="botoTransport button">
              <button :disabled="!transport" id="arribadaHospital" @click="activarHospital()">
                  <label for="arribadaHospital"><i class="fas fa-hospital"></i> Arribada Hospital</label>
              </button>
              <input type="time" v-model="incidenciaRecursInsert.hora_arribada_hospital" />
            </div>
            <div class="botoTransport button">
              <button :disabled="!hospital" @click="activarTransferencia()">
                <label for="ininciarTransferencia"><i class="fas fa-user-friends"></i> Iniciar Transferència</label>
              </button>
              <input type="time" v-model="incidenciaRecursInsert.hora_transferencia" />
            </div>
            <div class="botoTransport button">
              <button :disabled="!transferencia" id="hospitalitzacio" @click="hospitalitzacio()">
                  <label for="hospitalitzacio"><i class="fas fa-procedures"></i> Hospitalització</label>
              </button>

              <button id="alta" @click="altaVoluntaria()">
                <label for="alta"><i class="fas fa-notes-medical"></i> Alta Voluntària</label>
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
            <div class="modal-title">Más Información</div>
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
            <p>Complemento Dirección: {{ adreca_complement }}</p>
            <p>Nombre del Alertante: {{ nom_alertant }}</p>
            <p>Teléfono del Alertante: {{ telefon_alertant }}</p>
            <p>Afectados:</p>
            <ul>
                <li v-for="afectat in afectats" :key="afectat.id">
                    <p>Nom: {{ afectat.nom }}</p>
                    <p>Cognoms: {{ afectat.cognoms }}</p>
                    <p>Sexe: <span v-if="afectat.sexes_id == 1">Home</span> <span v-else>Dona</span></p>
                    <p>Edat: {{ afectat.edat }}</p>
                    <p v-if="afectat.te_cip == 1">CIP: {{ afectat.cip }}</p>
                </li>
            </ul>
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
import mapboxgl from 'mapbox-gl'
import 'mapbox-gl/dist/mapbox-gl.css'


export default {
    props: {
        recursos_id: Number,
    },
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
            mapboxKey: "pk.eyJ1IjoiYWx4bXJjZCIsImEiOiJja25ieXJqOGExMmdvMndtdWU1bXVsb3kwIn0.zN5ubwh81_aR_xFX1w0Aqg",
            map: null,
            address: "",
            hospitalAddress: null,
            hospitals: [],
            addresses: [],
            alertants: [],
            municipis:[],
            incidenciesHasRecursos: [],
            incidenciaHasRecursos: [],
            afectatsDB: [],
            afectats: [],
            incidenciaID: null,
            incidencia: null,
            prioritat: null,
            tipus_incidencies: [],
            tipusIncidencia: null,
            descripcio: null,
            alertant: null,
            adreca_complement: null,
            nom_alertant: null,
            telefon_alertant: null,
            incidenciaRecursInsert: {
                "afectats_id": null,
                "desti": null,
                "hora_activacio": null,
                "hora_arribada_hospital": null,
                "hora_assistencia": null,
                "hora_finalitzacio": null,
                "hora_mobilitzacio": null,
                "hora_transferencia": null,
                "hora_transport": null,
                "incidencies_id": null,
                "recursos_id": null,
                "prioritat": null,
            },
            incidenciaRecursosInsert: [],
            recurs: null,
        }
    },
    methods: {
        altaVoluntaria(){
            if(this.assistencia && !this.mostrarTransport){
                this.updateFunction();
            }
        },
        hospitalitzacio(){
            if(this.transferencia){
                this.updateFunction();
            }
        },
        async updateFunction(){
            let me = this;
            this.incidenciaRecursInsert.incidencies_id = this.incidencia.id;
            this.incidenciaRecursInsert.recursos_id = this.recursos_id;
            this.incidenciaRecursInsert.hora_finalitzacio = new Date().toLocaleTimeString("en-GB", {
                hour: "numeric",
                minute: "numeric",
                second: "numeric",
            });
            this.incidenciaHasRecursos.forEach((recurs) => {
                me.incidenciaRecursInsert.hora_activacio = recurs.hora_activacio;
                me.incidenciaRecursInsert.afectats_id = recurs.afectats_id;
                me.incidenciaRecursInsert.prioritat = recurs.prioritat;
                me.incidenciaRecursosInsert.push(me.incidenciaRecursInsert);
            });
            this.incidencia.incidencies_has_recursos = this.incidenciaRecursosInsert;
            await this.updateIncidencia();
            await this.selectRecurso();
            this.recurs.actiu = true;
            await this.updateRecurso();
            location.reload();
        },
        selectRecurso(){
            let me = this;
            return axios.get('/SGTA-Broggi/public/api/recurs/'+me.recursos_id).then((response) => {
                me.recurs = response.data;
            }).catch( (error) => {
                console.log(error.response.status);
                console.log(error.response.data.error);
            });
        },
        updateIncidencia(){
            let me = this;
            return axios.put('/SGTA-Broggi/public/api/incidencia/'+me.incidenciaID, me.incidencia).then((response) => {
                console.log(response);
            }).catch( (error) => {
                console.log(error.response.status);
                console.log(error.response.data.error);
            });
        },
        updateRecurso(){
            let me = this;
            return axios.put('/SGTA-Broggi/public/api/recurs/'+me.recursos_id, me.recurs).then((response) => {
                console.log(response);
            }).catch( (error) => {
                console.log(error.response.status);
                console.log(error.response.data.error);
            });
        },
        async getIncidenciaData(){
            await this.selectIncidenciesHasRecursos();
            await this.selectIncidenciaHasRecursos();
            await this.selectAfectats();
            await this.getAfectats();
            await this.selectIncidencia();
            await this.selectTipusIncidencia();
            await this.getAlertant();
            this.descripcio = this.incidencia.descripcio;
            this.adreca_complement = this.incidencia.adreca_complement;
            this.nom_alertant = this.alertant.nom;
            this.telefon_alertant = this.alertant.telefon;
            let me = this;
            let municipi = this.municipis.find(obj => obj.id == me.incidencia.municipis_id);
            this.address = this.incidencia.adreca + ", " + municipi.nom;
            this.addAddress(this.address);
            this.tipusIncidencia = this.getTipusIncidencia(this.incidencia.tipus_incidencies_id);
            this.prioritat = this.incidencia.incidencies_has_recursos[0].prioritat;
        },
        getAlertant(){
            let me = this;
            return this.alertant = this.alertants.find(obj => obj.id == me.incidencia.alertants_id);
        },
        selectTipusIncidencia() {
          let me = this;
          return axios
              .get("/SGTA-Broggi/public/api/tipusIncidencia")
              .then((response) => {
                me.tipus_incidencies = response.data;
              }).catch((error) => {
                console.log(error);
              })
        },
        getTipusIncidencia(incidenciesID) {
          let tipusIncidencia = this.tipus_incidencies.find(obj => obj.id == incidenciesID);
          let tipusIncidencia_nom;
          if (tipusIncidencia != null) {
            tipusIncidencia_nom = tipusIncidencia.tipus;
          }
          else {
            tipusIncidencia_nom = this.tipus_incidencies.find(obj => obj.id == 1).id;
          }

          return tipusIncidencia_nom;
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
            this.incidenciaID = this.incidenciaHasRecursos[this.incidenciaHasRecursos.length-1].incidencies_id;
            return true;
        },
        selectAfectats(){
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
        getAfectats(){
            let me = this;
            return this.incidenciaHasRecursos.forEach((afectat) =>{
                me.afectats.push(me.afectatsDB.find(obj => (obj.id == afectat.afectats_id && obj.hora_finalitzacio == null)));
            });
        },
        selectIncidencia(){
            let me = this;
            return axios
            .get("/SGTA-Broggi/public/api/incidencia/"+me.incidenciaID)
            .then((response) => {
            me.incidencia = response.data;
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
        selectAlertants(){
            let me = this;
            axios
            .get("/SGTA-Broggi/public/api/alertant")
            .then((response) => {
            me.alertants = response.data;
            })
            .catch((error) => {
            console.log(error);
            });
        },
        getHospitalsAddresses(){
            let me = this;
            this.alertants.forEach(function (alertant, index){
                if(alertant.tipus_alertants_id == 1){
                    let municipi = me.municipis.find(obj => obj.id == alertant.municipis_id);
                    let nomMunicipi = municipi.nom;
                    let adreca = {
                        "adreca": alertant.adreca + ", "+nomMunicipi,
                        "nom": alertant.nom
                    }
                    me.addresses.push(adreca);
                }
            });
        },
        initMap(idDiv) {
            let map = new mapboxgl.Map({ //Create new mapbox object
            container: idDiv,
            style: "mapbox://styles/mapbox/streets-v11",
            center: [-3, 40], // starting position [lng, lat]
            zoom: 7, // starting zoom
            });
            map.markers = [];
            console.log("Map initialized");
            return map;
        },
        addAddress(address){
            this.drawMarkFromAddress(address);
        },
        drawMarkFromAddress(address){
            let url = this.createURLApiCall(address);
            let me = this;
            console.log(url);
            axios
            .get(url)
            .then(response => {
                let coordinates = response.data.features[0].center;
                me.addMark(coordinates[0], coordinates[1]);
                console.log(coordinates);
                me.map.flyTo({
                    center: [
                        coordinates[0],
                        coordinates[1]
                    ],
                    essential: true // this animation is considered essential with respect to prefers-reduced-motion
                    });

            })
            .catch(error => {
                console.log(error);
            });
        },
        addMark(lat, lng){
            let mark = new mapboxgl.Marker().setLngLat([lat, lng]).addTo(this.map);

            this.map.markers.push(mark);

            return mark;
        },
        createURLApiCall(address) {
            var route = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
            var addressUrl = address.replaceAll(" ", "%20").toLowerCase() + ".json";

            let autocomplete = "true";
            //let country = "es";
            let language = "es";

            let params =
            "?access_token=" + mapboxgl.accessToken +
            "&autocomplete=" + autocomplete +
            //"&country=" + country +
            "&language=" + language;

            return route + addressUrl + params;
        },
        showInfo(){
            $('#infoModal').modal('show')
        },
        activarMovilitzacio(){
            this.movilitzacio = true;
            this.incidenciaRecursInsert.hora_mobilitzacio = new Date().toLocaleTimeString("en-GB", {
            hour: "numeric",
            minute: "numeric",
            second: "numeric",
            });
        },
        activarAssistencia(){
            this.assistencia = true;
            this.incidenciaRecursInsert.hora_assistencia = new Date().toLocaleTimeString("en-GB", {
            hour: "numeric",
            minute: "numeric",
            second: "numeric",
            });
        },
        activarMostrarTransport(){
            this.mostrarTransport = true;
            this.getHospitalsAddresses();
        },
        activarTransport(){
            this.transport = true;
            this.incidenciaRecursInsert.hora_transport = new Date().toLocaleTimeString("en-GB", {
            hour: "numeric",
            minute: "numeric",
            second: "numeric",
            });
        },
        activarHospital(){
            this.hospital = true;
            this.incidenciaRecursInsert.hora_arribada_hospital = new Date().toLocaleTimeString("en-GB", {
            hour: "numeric",
            minute: "numeric",
            second: "numeric",
            });
        },
        activarTransferencia(){
            this.transferencia = true;
            this.incidenciaRecursInsert.hora_transferencia = new Date().toLocaleTimeString("en-GB", {
            hour: "numeric",
            minute: "numeric",
            second: "numeric",
            });
        },
    },
  mounted() {
    mapboxgl.accessToken = this.mapboxKey;
    this.map = this.initMap("map");
    this.addAddress(this.address);
    this.getIncidenciaData();
  },
  created(){
      this.selectMunicipis(), this.selectAlertants();
  },
  updated(){
      if(this.hospitalAddress != null){
          if(this.map.markers.length > 1){
              this.map.markers[this.map.markers.length-1].remove();
          }
          this.addAddress(this.hospitalAddress);
      }
  }
};
</script>

<style scoped>
main {
  margin-top: 1.4vh;
  color: black;
  font-family: 'Rubik', sans-serif;
  font-size: 15px;
}
#infoCard {
  height: 65vh;
  color: black;
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
  font-size: 0.9em;
  color: white;
  border-radius: 4px;

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
  /* font-weight: bold; */
}

.boldInfo{
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
  color: black;
}
.modal-header{
    font-weight: bold;
    background-color: #15acc4;
}
#alta{
    opacity: 1 !important;
    visibility: visible !important;
}
#alta:hover{
    cursor: pointer;
}
</style>
