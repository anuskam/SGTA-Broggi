<template>
  <div>
      <nav class="navbar navbar-expand-lg navbar-light" id="cecosNav">
        <a class="navbar-brand" href="#"><img src="/SGTA-Broggi/public/media/img/prototipoLogo.png" id="cecosLogo" alt="Broggi"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" @click="selectTab(1)">Nuevo Incidente <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" @click="selectTab(2)">Editar Incidentes</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" @click="selectTab(3)">Formación</a>
                </li>
            </ul>
        </div>
      </nav>


    <div v-show="currentTab == 1">
        <button class="btn btn-danger col-12" id="generarLlamada" v-show="!incidencia" @click="startIncidencia()"><i class="fas fa-phone-alt"></i>  Generar Llamada</button>
      <nuevoincidente-component v-show="incidencia" :alertantNumber = pickedNumber></nuevoincidente-component>
    </div>

    <div v-show="currentTab == 3">
      <formacion-component></formacion-component>
    </div>


  </div>

</template>

<script>
export default {
  data: function () {
    return {
      currentTab: 1,
      incidencia: false,
      alertants: [],
      telefons: [],
    };
  },
  methods: {
    selectTab(selectedTab) {
      this.currentTab = selectedTab;
    },
    startIncidencia(){
        this.incidencia = true;
    },
    getAlertants(){
        let me = this;
        axios
        .get("/alertant")
        .then((response) => {
          me.alertants = response.data;
        })
        .catch((error) => {
          console.log(error);
        })
        .finally(() => {
            this.loading = false;
            this.getTelefons();
        });

    },
    getTelefons(){
        let me = this;
        this.alertants.forEach(function(alertant){
            me.telefons.push(alertant.telefon);
        });
    }
  },
  computed: {
      pickedNumber: function () {
          let randomArray = [];
          let random;
          do{
              random = Math.floor(Math.random() * 399999999 + 600000000);
          }while(random/100000000 >= 8 && random/100000000 < 9);
          randomArray.push(random);

          let random2 = Math.floor(Math.random() * 69);
          let randomDB = this.telefons[random2];
          randomArray.push(randomDB);

          let randomChoiceNumber = Math.floor(Math.random() * 2);
          let randomChoice = randomArray[randomChoiceNumber];

          return randomChoice;
      }
  },
  created() {
     this.getAlertants();
  }
};
</script>

<style scoped>
    #generarLlamada{
        font-size: 2em;
        margin-top: 33vh;
        background-color: red !important;
    }

    #navbarNav a{
        color: #0A0A0A;
    }

    #cecosNav {
        cursor: default;
    }
</style>
