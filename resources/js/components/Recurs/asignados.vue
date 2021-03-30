<template>
    <main class="col-9">
        <div class="card" id="infoCard">
            <div class="card-header" id="infoHeader">
                    <div>#12</div>
                    <div>Traumatisme</div>
                    <div>G-003</div>
            </div>
            <div class="card-body p-4">
                <div>
                    <img src="" alt="">
                </div>
                <div id="info">

                </div>
            </div>
        </div>
        <div id="botones" class="card mt-4 p-4">
            <div id="assistencia">
                <button>Activar Assistencia</button>
            </div>
            <div id="transport">
                <button>Activar Transport</button>
            </div>
        </div>
    </main>
</template>

<script>
    export default {
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>

<style scoped>
    main{
        margin-top: 1.4vh;
    }
    #infoCard{
        height: 65vh;
    }
    #botones{
        height: 25vh;
    }
    #infoHeader{
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap;
        justify-content: space-between;
        font-size: 1.2em;
        font-weight: bold;
        background-color: #15acc4;
        margin-right: -0.5px;
        border-bottom: 1px solid black;
    }
    button{
        background-color: #e3177d;
    }
    .card{
        border: 1px solid black
    }
</style>
