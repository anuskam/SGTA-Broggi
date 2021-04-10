<template>
  <main>
    <div id="navbar">
      <div id="asignats" @click="selectedTab = 'assignats'" :class="{ selected: !colorSelection }">
        <p>Assignats</p>
      </div>
      <div id="tots" @click="selectedTab = 'tots'" :class="{ selected: colorSelection }">
        <p>Tots</p>
      </div>
    </div>
    <div v-show="selectedTab == 'assignats'" id="assignatsTab" class="recursTab">
        <asignados-component></asignados-component>
    </div>
    <div v-show="selectedTab == 'tots'" id="totsTab" class="recursTab">
        <todos-component></todos-component>
    </div>
  </main>
</template>

<script>
export default {
    data(){
        return{
            tabs: ['assignats', 'tots'],
            selectedTab: 'assignats',
            colorSelection: false
        }
    },
    updated() {
        if(this.selectedTab == 'assignats' && this.colorSelection == true){
            this.colorSelection = false;
        }
        else if(this.selectedTab == 'tots' && this.colorSelection == false){
            this.colorSelection = true;
        }
    },
}
</script>

<style scoped>
    #navbar {
    /* position: absolute; */
    float: left;
    display: flex;
    flex-direction: column;
    flex-wrap: wrap;
    left: 0;
    top: 0;
    height: 100vh;
    width: 11%;
    background-color: rgba(128, 128, 128, 0.503);
    }

    #asignats, #tots{
        height: 50vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        font-size: 1.2em;
        font-weight: bolder;
        /* background-color: rgba(128, 128, 128, 0.503); */
        color: black;
    }

    #asignats:hover, #tots:hover{
        background-color: #fcc41c;
    }

    #asignats{
        border: 1px solid black;
        border-bottom: 0.1px solid black;
    }

    #tots{
        border: 1px solid black;
        border-top: 0px solid black;
    }

    .selected{
        background-color: #fcc41c;
    }

    .recursTab{
        float: right;
        height: 100vh;
        width: 89%;
        display: flex;
        flex-direction: row;
        justify-content: center;
    }

</style>
