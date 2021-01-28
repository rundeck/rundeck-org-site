import Vue from '../../../node_modules/vue/dist/vue.js'
import Vuex from '../../../node_modules/vuex';

import { modal } from './modal';

Vue.use(Vuex);

export const store = new Vuex.Store({
    modules: {
        modal
    }
});
