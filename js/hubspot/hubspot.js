import Vue from '../../node_modules/vue/dist/vue.js';

import modal from './components/modal.vue'
import modalButton from './components/modal--button.vue'

Vue.component('modal', modal);
Vue.component('modalButton', modalButton);


import { store } from './store';

const vues = document.querySelectorAll(".vue");
const each = Array.prototype.forEach;

each.call(vues, (el, index) => new Vue({
  store,
  el
}))

