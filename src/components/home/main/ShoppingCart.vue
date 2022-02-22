<template>
  <div class="shopping-cart">
    <PageTitle>购物车</PageTitle>
    <div class="warp">
      <div class="total">
        <span>全部商品：{{ getCountShopping }}</span>
      </div>
      <!-- 头部标题 -->
      <el-row justify="center" type="flex" style="background:rgb(196, 194, 194);padding:0.5rem;font-weight:600">
        <el-col :span="4"><div class="grid-content" > <el-checkbox :indeterminate="isIndeterminate" v-model="checkAll"  @change="handleCheckAllChange">全选</el-checkbox></div></el-col>
        <el-col :span="10"><div class="grid-content"><span>商品</span></div> </el-col>
          <el-col :span="4"><div class="grid-content">价格</div> </el-col>
            <el-col  :span="6"><div class="grid-content">操作</div> </el-col>
      </el-row>
      <!-- 商品列表 -->
      <div class="shoppingList">
        <el-checkbox-group v-model="shoppingLists" class="shoppingList">
             <CartItem v-for="(shoppingItem,index) in shoppingList" :productItem="shoppingItem" :key="shoppingItem.sc_id"></CartItem>
        </el-checkbox-group>
      </div>
      <!-- 总计 -->
      <div class="countstick">
         <el-row justify="center" align="middle" type="flex" style="background:rgb(196, 194, 194);padding:0.5rem;font-weight:600">
        <el-col :span="4"><div class="grid-content" > <el-checkbox :indeterminate="isIndeterminate" v-model="checkAll" @change="handleCheckAllChange">全选</el-checkbox></div></el-col>
        <el-col :span="4"><div class="grid-content"><span @click="deleteSelect">批量删除</span></div> </el-col>
          <el-col :span="4"><div class="grid-content"><span @click="addCollect">加入收藏</span></div> </el-col>
            <el-col  :span="12"><div class="close-account"><span> 总计{{this.getAllShoppingItemPrice}}￥</span> <el-button type="danger">结算</el-button></div> </el-col>
      </el-row> 
      </div>
    
    </div>
  </div>
</template>

<script>
import PageTitle from "../../publicComponent/PageTitle.vue";
import CartItem from './shoppingcart/CartItem.vue';
import {mapState} from 'vuex'
export default {
  components: {
    PageTitle,
    CartItem,
  },
  data() {
    return {
      total: 22,
      shoppingList: [],
      shoppingLists:[],
      isIndeterminate: true,
      checkAll: false,
    };

  },
  methods:{
    //改变全选
    handleCheckAllChange(val){
       this.shoppingLists = val ? this.selectAllId : [];
        this.isIndeterminate = false;
    },
    //删除选中的所有项
    deleteSelect(){
      
          this.$confirm('是否删除已选的项','提示',{
         confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
      }).then(()=>{
        this.$axios.post('/goods/deleteShoppingCarts',{
           u_id:this.userInfo.u_id,
           sc_ids:this.shoppingLists
        }).then(data=>{
          if(data.data.code==200){
          this.$message({
            type: 'success',
            message: data.data.msg
          });
         
          this.shoppingList=this.shoppingList.filter(item=>{
            if(this.shoppingLists.indexOf(item.sc_id)!=-1){
              return false
            }else{
              return true
            }
          })
        
          }else{
              this.$message({
            type: 'info',
            message: data.data.msg
          });   
          }
          
        })
      }).catch(()=>{
           this.$message({
            type: 'info',
            message: '已取消删除'
          });   
        })
    },
    //收藏选中的项
    addCollect(){
        this.$confirm('是否收藏已选的项','提示',{
         confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
      }).then(()=>{
        this.$axios({
          url:'/goods/addCollects',
          method:'post',
          data:{
            u_id:this.userInfo.u_id, 
            sc_ids:this.shoppingLists,
          }
        }).then(data=>{ 
          if(data.data.code!=-200){
              this.$message({
            type: 'success',
            message: data.data.msg
          });
          }else{
              this.$message({
            type: 'error',
            message: data.data.msg
          });
          }
        })
       
      }).catch(()=>{
            this.$message({
            type: 'info',
            message: '已取消收藏'
          });          

      })
    },
    //获取用户购物车列表
    getShoppingCart(){
      this.$axios.get('/goods/getShoppingCart',{
        params:{
          u_id:this.userInfo.u_id,
        }
      }).then(data=>{
       
       this.shoppingList=data.data.shoppingCart;
      })
    }

  },
  computed:{
    ...mapState({
     userInfo:'userInfo',
    }),
    //获取所有购物车列表的id
    selectAllId:function(){
      return this.shoppingList.map(item=>{
        return item.sc_id
      })
    },
    //获取总共多少钱
    getAllShoppingItemPrice:function(){
       let Allprices=this.shoppingList.filter(item=>{
         if(this.shoppingLists.indexOf(item.sc_id)!=-1){
           return true
         }else{
           return false
         }
       })
       return Allprices.reduce((countPrice,item)=>{
         return countPrice+=parseInt(item.nowprice)
       },0)
    },
    //获取总共多少件商品
    getCountShopping:function(){
      return this.shoppingList.length
    },
  },
  created(){
    this.getShoppingCart()
  }
};
</script>

<style lang="less" scoped>
.shopping-cart {
  #warp();
}
.warp {
  #boxshadow();
  background: @maincolor;
  display: flex;
  flex-flow: column nowrap;

  overflow: hidden;
  position: relative;
}
.total {
  width: 100%;
  :first-child {
    color: red;
    font-weight: 700;
    font-size: 1.2rem;
  }
}
.shoppingList{
  font-size: 1rem;
  
}
.countstick{
  position: sticky;
  top:60vh;
  span:hover{
    color: red;
     cursor: pointer;
  }
}
.close-account{
  display: flex;
  flex-flow: row nowrap;
  justify-content: flex-end;
  cursor: pointer;
  align-items: center;
  span{
    color: red;
    margin-right:2rem ;
  }
}
</style>