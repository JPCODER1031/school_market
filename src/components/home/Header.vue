<template>
  <div class="header">
    <div class="personal">
      <el-dropdown>
        <span class="el-dropdown-link">
          <div class="block">
            <el-avatar :size="40" style="cursor: pointer;" :src="USERIMGADDRESS+userInfo.u_avatar"></el-avatar>
          </div>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item @click.native="gonShoppingCart">购物车</el-dropdown-item>
            <el-dropdown-item @click.native="gonCollect">收藏夹</el-dropdown-item>
          <el-dropdown-item @click.native="gonOrder">订单中心</el-dropdown-item>
           <el-dropdown-item @click.native="goChat">消息通知</el-dropdown-item>
         
        </el-dropdown-menu>
      </el-dropdown>
      <el-dropdown v-if="$store.state.userInfo.u_name!=undefined">
  <span class="el-dropdown-link username">
    {{ username }}<i class="el-icon-arrow-down el-icon--right"></i>
  </span>

  <el-dropdown-menu  slot="dropdown">
    <el-dropdown-item  @click.native="goPersonal" >个人中心</el-dropdown-item>
     <el-dropdown-item @click.native="loginOut">注销</el-dropdown-item>
  </el-dropdown-menu>
</el-dropdown>
     <span class="notice_login" @click="goLogin" v-else>亲!请登录</span>
    </div>
    <div class="search">
      <div class="warp">
      <a-input-search
      placeholder="请输入你想要的商品名字!"
      enter-button
      size="large"
      @search="onSearch"
      style="width:20rem"
    />
        <div class="hot">
          <span>热门:</span>
           <span v-for="(item,index) in hotword" :key="index"> {{item}}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
export default {
  data() {
    return {
      circleUrl:"https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png",
      USERIMGADDRESS:this.$globalVariable.USERIMG,
      username: "张三",
      hotword:["衣服","篮球","吹风机"],
      searchContent:'',
      timer:''
    };
  },
  methods: {
    //搜索 框
    onSearch(val) {
     
     
        if(this.timer!==null){
          clearTimeout(this.timer);
        }
        this.timer=setTimeout(()=>{
          this.getsearchList(val)
        },600)
      
    },
    getsearchList(val){
       this.$axios({
        method:'get',
        url: '/goods/searchProducts',
        params:{
          searchContent:val
        }
      }).then(res=>{
        console.log(res)
        if(res.data.code==200){
          this.$notify({
              type:'success',
              message:res.data.msg
          })
           this.$EventBus.$emit('searchProductList',res.data.result)
        }else{
          this.$message({
              type:'error',
              message:res.data.msg
          })
        }
       
      })
    },
    //跳转去个人中心
    goPersonal(){
      this.$router.push("/home/personal")
    },
    //购物车
    gonShoppingCart(){
      this.$router.push("/home/shoppingcart")
    },
    //收藏夹
    gonCollect(){
      this.$router.push("/home/collect")
    },
    //订单中心
    gonOrder(){
 this.$router.push("/home/order")
    },
    goChat(){
    this.$router.push("/chatview")
    },
    //退出登录
    loginOut(){
     this.$store.commit("setUserInfo",{});
     this.$router.push("/loginC")
    },
    goLogin(){
     this.$router.push("/loginC")
    }
  },
  mounted(){
     let {u_nickname}= this.$store.getters.getUserInfo;
     if(u_nickname==undefined){
       this.username="请登录";
     }
     this.username=u_nickname;
  },
  computed:{
    ...mapState({
      userInfo:'userInfo'
    })
  }
};
</script>
<style lang="less" scoped>
.personal {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  flex: 1;

  > * {
    padding-left: 1rem;
  }
}

.header {
  width: 100%;
  height: 7rem;
  background: @maincolor;
  display: flex;
  flex-flow: row-reverse;
  line-height: 1rem;
  border-bottom:solid 0.5px @fontcolor; 
}
.search {
  display: flex;
  flex-direction: row-reverse;
  align-items: center;
  flex: 2;
}
.warp {
  display: flex;
  flex-flow: column wrap;
  margin-top: 1rem;
}
.hot {
  margin-top: 1rem;
  color: @fontcolor;
  :first-child {
    color: hotpink;
  }
  span {
    margin-left: 0.3rem;
    font-size: 0.5rem;
    padding: 0.5rem;
  }
}
.notice_login{
  letter-spacing: 0.2rem;
  cursor: pointer;
  color: red;
}
</style>
