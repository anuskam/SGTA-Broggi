<template>
<main class="col-10">
  <table class="table mt-5">
    <thead>
      <tr>
        <th scope="col">Data</th>
        <th scope="col">Municipi</th>
        <th scope="col">Tipus d'incident</th>
        <th scope="col">Tipus d'alertant</th>
        <th scope="col">Telèfon</th>
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
        <td></td>
        <td>{{ incidencia.telefon_alertant }}</td>
        <td></td>
      </tr>
    </tbody>
</table>

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
        }
      },
      methods:{
        selectIncidencies() {
          let me = this;
          axios
              .get('/SGTA-Broggi/public/api/incidencia')
              .then(response => {
                me.incidencies = resposne.data;
              })
              .catch(error => {
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
        }
      },
      created(){
        this.selectIncidencies(), this.selectMunicipis();
      },
      mounted() {
          console.log('Component mounted.')
      }
    }
</script>
