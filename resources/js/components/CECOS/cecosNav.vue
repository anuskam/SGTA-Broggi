<template>
  <div class="contenido" :class="{ dislexiaFont: activaDislexia }">
      <nav class="navbar navbar-expand-lg navbar-light" id="cecosNav">
        <a class="navbar-brand"><img src="/SGTA-Broggi/public/media/img/prototipoLogo.png" id="cecosLogo" alt="logoBroggi"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item active borderLeftRight ml-2" id="nuevoIncidenteItem">
                    <a class="nav-link" @click="selectTab(1)">Nuevo Incidente <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item borderLeftRight ml-4" id="editarIncidenteItem">
                    <a class="nav-link" @click="selectTab(2)">Editar Incidentes</a>
                </li>
                <li class="nav-item borderLeftRight ml-4" id="formacionItem">
                    <a class="nav-link" @click="selectTab(3)">Formación</a>
                </li>
            </ul>
        </div>
        <div class="custom-control custom-switch dislexia">
            <input type="checkbox" class="custom-control-input" id="dislexiaSwitch" v-model="activaDislexia">
            <label class="custom-control-label" for="dislexiaSwitch">Dislexia</label>
        </div>
      </nav>


    <div v-show="currentTab == 1">
        <button class="btn btn-danger col-12" id="generarLlamada" v-show="!incidencia" @click="startIncidencia()"><i class="fas fa-phone-alt"></i>  Generar Llamada</button>
      <nuevoincidente-component v-show="incidencia" :alertantNumber = pickedNumber :userid = userid></nuevoincidente-component>
    </div>

    <div v-show="currentTab == 2">
        <gestionarIncidente-component></gestionarIncidente-component>
    </div>

    <div v-if="currentTab == 3">
      <formacion-component></formacion-component>
    </div>


  </div>

</template>

<script>
export default {
    props: {
        userid: Number,
    },
  data: function () {
    return {
      currentTab: 1,
      incidencia: false,
      alertants: [],
      telefons: [],
      activaDislexia: false
    };
  },
  methods: {
    selectTab(selectedTab) {
      this.currentTab = selectedTab;
      console.log(this.userid);
    },
    startIncidencia(){
        this.incidencia = true;
    },
    getAlertants(){
        let me = this;
        axios
        .get("/SGTA-Broggi/public/api/alertant")
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
      font-family: 'Signika', sans-serif;
      font-size: 35px;
      margin-top: 33vh;
      background-color: #E2211D !important;

    }


    /* MOVIMIENTO BARRA DEBAJO DE ELEMENTOS DE NAVBAR */
    .borderLeftRight {
      display: inline-block;
      position: relative;
      color: hsl(222, 25%, 14%);
    }

    .borderLeftRight::after {
      content: '';
      position: absolute;
      width: 100%;
      transform: scaleX(0);
      height: 2px;
      bottom: 0;
      left: 0;
      background-color: black;
      transform-origin: bottom right;
      transition: transform 0.4s cubic-bezier(0.86, 0, 0.07, 1);
    }

    .borderLeftRight:hover::after {
      transform: scaleX(1);
      transform-origin: bottom left;
    }
    /* FIN DE LO QUE HE COPIADO POR SI NO CONVENCE */

    .contenido {
      /* font-size: 1em; */
      font-family: 'Rubik', sans-serif;
    }

    .dislexia {
      margin-right: 90px;
    }

    .dislexiaFont{
        font-family: Arial, Helvetica, sans-serif !important;
        letter-spacing: 2px !important;
    }

</style>
