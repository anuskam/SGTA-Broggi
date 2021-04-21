<template>
<main class="col-10">
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
  Este recurso no tiene ninguna incidencia en su historial
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
          municipis: [],
          alertants: [],
          tipusIncidencies: [],
          tipusAlertants: [],
          incidenciesHasRecursos: [],
          incidenciaHasRecursos: [],
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
            this.incidenciaHasRecursos = this.incidenciesHasRecursos.filter(obj => obj.recursos_id == me.recursos_id);
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
}
</style>
