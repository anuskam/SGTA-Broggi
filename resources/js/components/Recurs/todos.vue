<template>
<main class="col-10">
    <table class="table">
    <thead>
      <tr>
        <th scope="col">ID</th>
        <th scope="col">Sigles</th>
        <th scope="col">Nom</th>
        <th scope="col">Descripcio</th>
        <th scope="col">Actiu</th>
        <th scope="col"></th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="cicle in cicles" :key="cicle.id">
        <td>{{ cicle.id }}</td>
        <td>{{ cicle.sigles }}</td>
        <td>{{ cicle.nom }}</td>
        <td>{{ cicle.descripcio }}</td>
        <td>
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" name="actiu[]" value="actiu" :checked="cicle.actiu" disabled>
                <label for="actiu" class="custom-control-label"></label>
            </div>
        </td>
      </tr>
    </tbody>
</table>

</main>
</template>

<script>
    export default {
        data(){
            return{
                cicles: [],
                cicle:{
                    id: '',
                    sigles: '',
                    nom: '',
                    descripcio: '',
                    actiu: false
                },
                insert : true
            }
        },
        methods:{
            selectCicles(){
                let me = this;
            axios.get('/cicle').then(response => {
                me.cicles = response.data;
            }).catch(error => {
                console.log(error);
            }).finally(() => this.loading = false)
            }
        },
        created(){
            this.selectCicles();
        },
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
