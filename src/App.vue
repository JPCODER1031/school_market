<template>
  <div id="app">
    <!-- <div  v-if="navIsShow" id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/login">Login</router-link>
    </div> -->
    <router-view />
     <Bottom/>
  </div>
</template>
<script>
import Bottom from './components/home/Bottom.vue';
export default {
  components:{
    Bottom,
  },
  data() {
    return {
      message: "nihao",
      navIsShow: true,
    };
  },
  created() {},
  mounted() {
  
  },
  watch: {
    //控制登录界面时隐藏导航栏
    $route(to, from) {
      if (to.path == "/loginc") {
        this.$data.navIsShow = false;
      } else if (to.path == "/") {
        this.$data.navIsShow = true;
      }
    },
  },
};
</script>
<style lang="less">
* {
  margin: 0;
  padding: 0;
}

</style>
