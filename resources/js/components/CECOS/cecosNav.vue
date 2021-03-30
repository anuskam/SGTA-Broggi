<template>
  <div>
    <div id="tabButtons">
      <button @click="selectTab(1)" class="btn btn-sm mr-3">
        NUEVO INCIDENTE
      </button>
      |
      <button @click="selectTab(2)" class="btn btn-sm mr-3 ml-3">
        GESTIONAR INCIDENTE
      </button>
      |
      <button @click="selectTab(3)" class="btn btn-sm ml-3">FORMACIÓN</button>
    </div>

    <div v-if="currentTab == 1">
      <nuevoincidente-component></nuevoincidente-component>
    </div>
    <!-- <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">Pagina cecos</div>

                    <div class="card-body">
                        <nuevoIncidente></nuevoIncidente>
                    </div>
                </div>
            </div>
        </div> -->
  </div>

  <!-- CREAR NAVBAR CON TABS Y LLAMAR A LOS COMPONENTES -->
</template>

<script>
export default {
  data: function () {
    return {
      currentTab: 1,
    };
  },
  methods: {
    selectTab(selectedTab) {
      this.currentTab = selectedTab;
    },
  },
};
</script>

