import Vue from "vue";
import Vuex from "vuex";
import axios from "../utils/axios";//后端数据交互
import createVuexAlong from "vuex-along";
Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    userInfo:{},//用户登录后的信息
    goodsInfo:[],//所有商品信息
  },
  mutations: {
    setUserInfo(state,user){
      state.userInfo=user;
    },
    setGoodsInfo(state,goods){
      state.goodsInfo=goods;
    }

  },
  getters:{
    getUserInfo:(state)=>{
      return state.userInfo;
    },
    isLogin:(state)=>{
      return   Object.keys(state.userInfo).length==0?false:true;
    }
  },
  actions: {
    getGoodInfo(context){
      axios({
        url:'/goods/getGoods',
        method:'get',
      }).then(data=>{
        context.commit('setGoodsInfo',data.data);
      
       
      })
    }
  },
  modules: {},
//插件vuex-along
plugins: [
  createVuexAlong({
    // 设置保存的集合名字，避免同站点下的多项目数据冲突
    name: "hello-vuex-along",
    local: {
      list: ["ma"],
      // 过滤模块 ma 数据， 将其他的存入 localStorage
      isFilter: true,
    },
    session: {
      // 保存模块 ma 中的 a1 到 sessionStorage
      list: ["ma.a1"],
    },
  }),
],

});
