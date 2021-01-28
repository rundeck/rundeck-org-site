<template>
  <div>

    <transition
      enter-class="opacity-0"
      enter-active-class="ease-out transition duration-150"
      enter-to-class="opacity-100"
      leave-class="opacity-100"
      leave-active-class="ease-out transition duration-150"
      leave-to-class="opacity-0 ease-out transition duration-150"
      appear
    >
      <div v-show="showmodal" class=" fixed inset-0 transition-opacity" style="z-index: 99999;
    " >
        <div
          @click="closeModal()"
          class="absolute inset-0 bg-black opacity-50"
          tabindex="-1"
        ></div>
      </div>
    </transition>
    <transition
      enter-class="transform translate-x-full duration-150"
      enter-active-class="transform ease-out transition duration-150"
      enter-to-class="transform translate-x-0 transition duration-200"
      leave-class="transform translate-x-0 transition duration-200"
      leave-active-class="transform ease-in transition duration-100"
      leave-to-class="translate-x-full"
      appear
    >
      <div
        v-show="showmodal"
        class="w-11/12 lg:w-5/12 bg-white transform transition-transform duration-150 pt-4 pb-6 rounded fixed shadow-lg overflow-auto" style="z-index: 99999; left: 50%; top: 10px; transform: translate(-50%, 0%);max-height: calc(100vh - 40px);"
      >
        <div class="flex justify-between px-4">
          <div class="text-lg font-bold">{{ modaltitle }}</div>
          <button
            @click="closeModal()"
            type="button"
            class="text-gray-600 focus:outline-none focus:text-gray-900"
            aria-label="Close"
          >
            <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
              <path
                d="M18.2929 19.7071C18.6834 20.0976 19.3166 20.0976 19.7071 19.7071C20.0976 19.3166 20.0976 18.6834 19.7071 18.2929L13.4142 12L19.7071 5.70711C20.0976 5.31658 20.0976 4.68342 19.7071 4.29289C19.3166 3.90237 18.6834 3.90237 18.2929 4.29289L12 10.5858L5.70711 4.29289C5.31658 3.90237 4.68342 3.90237 4.29289 4.29289C3.90237 4.68342 3.90237 5.31658 4.29289 5.70711L10.5858 12L4.29289 18.2929C3.90237 18.6834 3.90237 19.3166 4.29289 19.7071C4.68342 20.0976 5.31658 20.0976 5.70711 19.7071L12 13.4142L18.2929 19.7071Z"
              />
            </svg>
          </button>
        </div>
        <div class="text-center bg-blue-200 py-6 mt-2">
          <div class="text-2xl font-bold">Your Downlod will Begin Shortly...</div>
          <a :href="dlurl">If download doesn't start <u>click here</u></a>
        </div>
        <div class="px-4 pt-6">
          <div class="text-xl font-bold">Join the community for updates and free stuff!</div>
        </div>
        <div class="mt-4 overflow-auto  px-4">
          <div class="hubspot-form">
                <div id="embedcontainer" ref="bedcontainer" class="iframe-holder">
                </div>
                <div id="embeditem" ref="bedcontainer">
                </div>
              </div>
        </div>
      </div>
    </transition>
  </div>
</template>
<script>
import { mapState, mapActions } from '../../../node_modules/vuex'
export default {
  methods: {
    ...mapActions('modal', ['closeModal']),
    createhslink: function(){
      let script = document.createElement('script')
      script.text = this.hslink
      let el = document.getElementById('embeditem')
      while (el.firstChild) {
        el.removeChild(el.firstChild)
      }
      el.appendChild(script)
    }
  },
  computed: {
    ...mapState('modal',['showmodal', 'hslink', 'modaltitle', 'dlurl'])
  },
  created() {
    let wistiajson = document.createElement('script');
    let wistiajs = document.createElement('script');
    wistiajson.setAttribute('src',"https://fast.wistia.com/embed/medias/142f4r65hu.jsonp");
    wistiajs.setAttribute('src',"https://fast.wistia.com/assets/external/E-v1.js");
    document.head.appendChild(wistiajson);
    document.head.appendChild(wistiajs);
  },
  mounted() {
    if(this.hslink != ''){
      this.createhslink()
    }
  },
  watch: {
    hslink: function() {
      this.createhslink()
    }
  }
}
</script>
<style scoped>
</style>