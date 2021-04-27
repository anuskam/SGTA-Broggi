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
        <td>{{ incidencia.data }}</td>
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
      </tr>
    </tbody>
</table>

<div v-else class="alert mt-3 alertaSinRecursos" role="alert">
  No hay ninguna incidencia asignada
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
            municipis_id: null,
            tipus_incidencies_id: null,
            alertants_id: null,
            telefon_alertant: ''
          },
          municipis: [],
          alertants: [],
          tipusIncidencies: [],
          tipusAlertants: [],
        }
      },
      methods:{
        selectIncidencies() {
          let me = this;
         return axios
              .get('/SGTA-Broggi/public/api/incidencia')
              .then(response => {
                me.incidencies = response.data;
              })
              .catch(error => {
                console.log(error);
              })
        },
        filterIncidencies(){
            this.incidencies = this.incidencies.filter(obj => obj.incidencies_has_recursos.length > 0);
            this.$forceUpdate();
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

        }
      },
      async created(){
        await this.selectIncidencies(), this.filterIncidencies(), this.selectMunicipis(), this.selectAlertant(), this.selectTipusAlertant(), this.selectTipusIncidencia();
      },
      mounted() {
          console.log('Component mounted.')
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
</style>
