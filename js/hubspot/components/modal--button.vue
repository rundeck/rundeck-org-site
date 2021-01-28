<template>
  <div @click="toggleModal()">
    <slot></slot>
  </div>
</template>
<script>
import { mapState, mapActions } from '../../../node_modules/vuex'
import axios from '../../../node_modules/axios'

export default {
  props: {
    'hslink': {
      type: String
    },
    'modaltitle': {
      type: String
    },
    'dlurl': {
      type: String
    }
  },
  methods: {
    ...mapActions('modal', ['toggleModal', 'injectContent']),
    toggleModal: function(){
      // gtag('event', 'click', {
      //   'event_category': 'oss',
      //   'event_label': this.modaltitle,
      // });
      window.location.assign(this.dlurl);
      const { hslink, modaltitle, dlurl } = this;
      this.injectContent({ hslink, modaltitle, dlurl })
    }
  },
}
</script>
