<template>
  <div class="order">
<PageTitle> 订单中心</PageTitle>
<div class="warp">
  <el-divider content-position="left" class="divide"><div>购买订单</div></el-divider>
  <BuyItem @updateData="updateData" v-for="item in buyList" :buyItem="item" :key="item.o_id"></BuyItem>
  <el-empty v-show="buyList.length==0?true:false" :image-size="200"></el-empty>
  <!-- 出售的商品 -->
   <el-divider content-position="left" class="divide">出售订单</el-divider>
   <SellItem @updateData="updateData" v-for="(item,index) in sellList" :sellItem="item" :key="index"></SellItem>
   <el-empty v-show="sellList.length==0?true:false"  :image-size="200"></el-empty>
</div>
  </div>
</template>

<script>
import PageTitle from "../../publicComponent/PageTitle.vue";
import BuyItem from "./order/BuyItem.vue";
import SellItem from "./order/SellItem.vue";
import {mapState} from "vuex";
export default {
   components:{
       PageTitle,
       BuyItem,
       SellItem
   },
   data(){
       return{
           buyList:[],
           sellList:[]
       }
   },
   methods:{
       //更新父组件状态
       updateData(){
          this.getBuyOrder();
          this.getSellOrder();
       },
       getBuyOrder(){
           this.$axios({
               url:'/goods/getBuyOrder',
               method:'post',
               data:{
                   u_id:this.userInfo.u_id
               }
           }).then(data=>{ 
               this.buyList=data.data.result;
           })
       },
        getSellOrder(){
           this.$axios({
               url:'/goods/getSellOrder',
               method:'post',
               data:{
                   u_id:this.userInfo.u_id
               }
           }).then(data=>{ 
                
               this.sellList=data.data.result;
           
           })
       }
   },
   created(){
    this.getBuyOrder();
    this.getSellOrder();
   },
   computed:{
       ...mapState({
           userInfo:'userInfo'
       })
   }

}
</script>

<style lang="less" scoped>
.order{
    #warp()
}
.warp{
    display: flex;
    flex-flow: column nowrap;
    align-items: center;
    #boxshadow();
    background: @maincolor;
    .divide{
        background: @titlecolorpluss;
        div{
            background: @titlecolorpluss;
            color: @maincolor;
        }
    }
}
</style>