const state = {
    showmodal: false,
    hslink : '',
    modaltitle: '',
    dlurl: ''
  };
  
  const actions = {
    toggleModal({commit}){
      commit('setToggleModal')
    },
    openModal({commit}){
      commit('setOpenedModal')
    },
    closeModal({commit}){
      commit('setClosedModal')
    },
    injectContent({ commit }, { hslink, modaltitle, dlurl }){
      commit('setModalContent', { hslink, modaltitle, dlurl })
      commit('setOpenedModal')
    }
  };
  
  const mutations = {
    setToggleModal(state){
      state.showmodal = !state.showmodal;
    },
    setClosedModal(state){
      state.showmodal = false;
    },
    setOpenedModal(state){
      state.showmodal = true;
    },
    setModalContent(state, { hslink, modaltitle, dlurl }){
      state.hslink = hslink
      state.modaltitle = modaltitle
      state.dlurl = dlurl
    }
  };
  
  export const modal = {
    namespaced: true,
    state,
    actions,
    mutations
  };
  