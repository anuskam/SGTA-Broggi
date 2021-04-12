/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue').default;

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

// const files = require.context('./', true, /\.vue$/i)
// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))

Vue.component('administrador-component', require('./components/Administrador/administradora.vue').default);
Vue.component('cecosnav-component', require('./components/CECOS/cecosNav.vue').default);
Vue.component('recursos-component', require('./components/Recurs/recursosTabs.vue').default);
Vue.component('asignados-component', require('./components/Recurs/asignados.vue').default);
Vue.component('todos-component', require('./components/Recurs/todos.vue').default);
Vue.component('nuevoincidente-component', require('./components/CECOS/nuevoIncidente.vue').default);
Vue.component('gestionarincidente-component', require('./components/CECOS/gestionarIncidente.vue').default);
Vue.component('formacion-component', require('./components/CECOS/formacion.vue').default);
Vue.component('gestionarusuarias-component', require('./components/Administrador/gestionarUsuarias.vue').default);
Vue.component('gestionaralertantes-component', require('./components/Administrador/gestionarAlertantes.vue').default);
Vue.component('gestionarrecursos-component', require('./components/Administrador/gestionarRecursos.vue').default);
Vue.component('adminnav-component', require('./components/Administrador/adminNav.vue').default);



/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

const app = new Vue({
    el: '#app',
});
