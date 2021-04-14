<template>

  <div id="contenedor">
    <div id="contenedorVideo">
      <video id="videoDesa" width="500" height="300" src="/SGTA-Broggi/public/media/video/desa.mp4" type="video/mp4" controls>
      </video>
    </div>

    <button type="button" class="btn mt-2" id="backward" @click="retroceder()"><i class="fas fa-backward" aria-hidden="true"></i> Retroceder 5 segundos</button>
    <button class="btn mt-2" id="reproducir" @click="play()" :disabled="disablePlay"><i class="fas fa-play" aria-hidden="true"></i> Reproducir</button>
    <button type="button" class="btn mt-2" id="forward" @click="avanzar()">Avanzar 5 segundos  <i class="fas fa-forward" aria-hidden="true"></i></button>


    <div class="test col-5 ml-5">
        <div id="questions" v-for="(question, index) in questions" :key="question.id" v-show="activa">
          <div v-show="index === currentQuestion">
            <p>{{ question.question }}</p>
            <ul>
              <li v-for="(option, index) in question.options" :key="index">
                <button class="btn btn-secondary col-7 mb-2" @click="evaluarRespuesta(index)"
                :class="{correcta : correcta[index], incorrecta: incorrecta[index]}" :id="index" :disabled="!enableButtons">{{ option }}</button>
                <br>
              </li>
            </ul>
            <br>
          </div>
        </div>
    </div>

    <button id="contador" class="btn btn-success" disabled>
        <i class="fas fa-check"></i> {{ aciertos }} de 5
    </button>
  </div>


</template>

<script>
export default {
  props: ['question', 'index'],
  data() {
    return {
      currentQuestion: -1,
      questions: [
        {
          id: 1,
          question: "Para abrir la vía aérea es necesario: ",
          options: [' Colocar la víctima en PLS', ' Realizar una hipertensión del cuello', ' Levantar la cabeza a la víctima', ' Ninguna es correcta'],
          correctAnswer: 1,
          aparecePregunta: [7, 7.3],
        },
        {
          id: 2,
          question: "En el masaje carídaco, la presión se aplica: ",
          options: [' En el centro del esternón', ' En el extremo inferior del apéndice xifoides', ' En el centro del pecho o línea que une los pezones', ' Todas son correctas'],
          correctAnswer: 2,
          aparecePregunta: [17, 17.3],
        },
        {
          id: 3,
          question: "No es una zona de aplicación de electrodos DESA... ",
          options: [' Debajo de la clavícula izquierda', ' A unos 10cm debajo de la axila izquierda', ' En el costado izquierdo', ' Ninguna es correcta'],
          correctAnswer: 0,
          aparecePregunta: [27, 27.3],
        },
        {
          id: 4,
          question: "Los ciclos RCP para personas adultas son de:  ",
          options: [' 30 compresiones torácicas + 5 ventilaciones de rescate', ' 15 compresiones torácicas + 2 ventilaciones de rescate', ' 2 ventilaciones de rescate + 15 compresiones torácicas + 5 ventilaciones', ' 30 compresiones torácicas + 2 ventilaciones de rescate'],
          correctAnswer: 3,
          aparecePregunta: [46, 46.3],
        },
        {
          id: 5,
          question: "En los niños, la RCP empieza siempre... ",
          options: ['Aplicando masaje cardíaco', ' Con 5 insuflaciones de aire', ' Efectuando 2 o 3 percusiones con el puño', ' Ninguna es correcta'],
          correctAnswer: 1,
          aparecePregunta: [72, 72.3],
        },
      ],
      //mas cosas
      activa: false,
      correcta: [false, false, false, false],
      incorrecta: [false, false, false, false],
      enableButtons: true,
      aciertos: 0,
      disablePlay: false,
    };
  },
  methods: {
    evaluarRespuesta(index){
        this.enableButtons = false;
        let correcta = this.questions[this.currentQuestion].correctAnswer;
      if(correcta == index){
        console.log("acierto");
        ++this.aciertos;
      }
      else{
        console.log("fallo");
      }
        this.correcta[correcta] = true;
        this.incorrecta = [true, true, true, true];
        this.incorrecta[correcta] = false;
        this.$forceUpdate();
        this.play();
    },
    play(){
      let video = document.querySelector("#videoDesa");
      let reproducir = document.querySelector("#reproducir");
      if (!video.paused && !video.ended) {
        video.pause();
        reproducir.innerHTML = `<i class="fas fa-play" aria-hidden="true"></i> Reproducir`;

      }
      else {
        video.play();
        this.disablePlay = false;
        reproducir.innerHTML = `<i class="fas fa-pause" aria-hidden="true"></i> Pausa`;
      }
    },
    retroceder() {
      let video = document.querySelector("#videoDesa");
      video.currentTime -= 5;
    },
    avanzar() {
      let video = document.querySelector("#videoDesa");
      video.currentTime += 5;
    },
    controlTiempo() {
      let video = document.querySelector("#videoDesa");
      if (
        ((video.currentTime >= this.questions[this.currentQuestion+1].aparecePregunta[0])
        && (video.currentTime <= this.questions[this.currentQuestion+1].aparecePregunta[1]))
      ) {
        video.pause();
        this.disablePlay = true;
        this.enableButtons = true;
        this.correcta = [false, false, false, false];
        this.incorrecta = [false, false, false, false];
        ++this.currentQuestion;
        this.activa = true;
      }
    }
  },

  created() {

  },
  mounted() {
    console.log("Component mounted.");
    let video = document.querySelector("#videoDesa");
    video.addEventListener("timeupdate", this.controlTiempo);

  },
};
</script>

<style>
  ul li{
    list-style: none;
  }

  #contenedor{
    display: flex;
    flex-direction: row;
    flex-wrap: nowrap;
    justify-content: center;
  }

  #questions{
    color: black;
  }

  #backward {
    background-color: #fcc41c;
  }

  #reproducir {
    background-color: #e3177d;
  }

  #forward {
    background-color: #15acc4;
  }

  .correcta{
    background-color: green !important;
  }

  .incorrecta{
    background-color: red !important;
  }

  #contador{
    float: right;
    position: absolute;
    background-color: green !important;
    bottom: 10px;
    right: 10px;
  }
</style>
