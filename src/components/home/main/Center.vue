<template>
  <div class="center">
      <div class="shop-rule">
        <div class="shop-title"><svg t="1638674681936" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="3733" width="32" height="32"><path d="M992.290287 320.016035H769.120259l-174.644911-174.644911a96.026257 96.026257 0 1 0-164.063818 1.137752L255.994169 319.959148H31.743277A32.027715 32.027715 0 0 0 0 351.986863v639.985422c0 17.293828 14.221898 32.027715 31.743277 32.027715h960.490122a32.027715 32.027715 0 0 0 31.743277-31.970827V352.04375a32.027715 32.027715 0 0 0-31.686389-32.027715zM480.131286 186.557742a95.798707 95.798707 0 0 0 65.420732-0.568876l133.116968 134.027169H346.50233L480.131286 186.557742zM127.997085 512.011662h320.049598v64.05543H127.997085V512.011662z m511.988338 320.049599h-511.988338V768.005831h511.988338v63.998542z m192.052514-127.997085H127.997085V640.008746h704.040852v63.998543z" fill="#6baf9d" p-id="3734"></path></svg><span>推荐阅读</span></div>
        <ul class="rule-list">
          <li>校园二手市场发布商品规则</li>
          <li>校园二手市场账号注册规则</li>
          <li>关于校园二手市场平台</li>
        </ul>
      </div>
      <div class="cut-off"><div>最新发布</div>  <el-divider class="delived" content-position="left"></el-divider></div>
      <div class="shoplist">
       
             <ShopItem v-for="good in goods" :ProductDetails="good" :key="good.g_id"></ShopItem> 
      </div>

  </div>
</template>

<script>
import ShopItem from './ShopItem';
import {mapActions,mapState} from 'vuex';
export default {
 components:{
   ShopItem
 },
 data(){
 return{
      goods:[],
      classifyid:0,
 }
 },
 created(){
   this.getGoodsInfo();
   this.getGoodInfo2();//解决初始化不了商品
  
 },
 methods:{
   //将vuex中action解析到方法中
  ...mapActions({
    getGoodsInfo:'getGoodInfo',
  }),
   getGoodInfo2(){
      this.$axios({
        url:'http://127.0.0.1:3030/goods/getGoods',
        method:'get',
      }).then(data=>{
      this.goods=data.data;
       
      })
    }
 },
 mounted(){
   //从侧边导航传分类过来的id进行分类操作
   this.$EventBus.$on('publishClassify',(id)=>{
     this.classifyid=id;
     })
    this.$nextTick(()=>{
    this.goods=this.goodsInfo;
    })
    this.$EventBus.$on('searchProductList',res=>{ 
     this.$router.push('/home/productlist')
     this.$nextTick(()=>{
       this.goods=res;
    })
   })
 },
 computed:{
   ...mapState({
   goodsInfo:'goodsInfo',
   }),
 },
 watch:{
  classifyid(val){
 
    this.goods=this.goodsInfo;
    if(val!=0){
        this.goods=this.goods.filter(function(item){
    if(val!=item.classify){
      return false;
    }else{
      return true;
    }
  })
    }else{
      this.goods=this.goodsInfo;
    }

  console.log(this.goods)

  }
 
 }

}
</script>

<style lang="less" scoped>
.center{
  display: flex;
  flex:7;
  flex-flow: column nowrap;
  align-items: center;

}
.shop-rule{
  margin-top:2rem;
  background: @maincolor;
  padding:0.5rem 1rem;
  .shop-title{
     display:flex; 
     color: @titlecolor;
     font-size: 1.5rem;
     span{
         margin-left: 0.5rem;
     }
  }
  width: 80%;
  ul{
    margin-top: 0.5rem;
      list-style-type: none;
      display: flex;
      flex-flow: row nowrap;
      justify-content: space-between;
      color: @fontcolor;
      font-size: 0.8rem;
      li{
        cursor: pointer;
      }
      
  }
}
.cut-off{
  width: 80%;
  display: flex;
  flex-flow: row nowrap;
  justify-content:flex-start;
  align-items: center;
  color: @maincolor;
  font-size:1.2rem ;
  line-height: 1.2rem;
  margin-top:0.6rem;
  :first-child{
  
    height: 1.5rem;
    background: @titlecolor;
    padding: 0.5rem 1rem;
    box-sizing: content-box;
   white-space: nowrap;
  }
}
.delived{
  padding: 0.5px;
  background: rgb(128, 125, 125);
}
.shoplist{
  width:80%;
  display: flex;
  flex-flow: row wrap;
  justify-content: flex-start;
  

}
</style>