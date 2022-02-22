<template>
 <el-row v-if="is_show" justify="center" type="flex"  class="item">
                   <el-col  :span="4" ><div class="grid-content"> <el-checkbox :label="productItem.sc_id" ></el-checkbox></div> </el-col>
                   <el-col  :span="10" ><div class="grid-content">       
                     <div class="imgandprice" @click="goProductDetaile(productItem.g_id)"> <el-image
                    style="width: 50px; height: 50px"
                    :src="doProductImg"
                    fit="fill"></el-image><span>{{ productItem.g_name }}</span></div></div> </el-col>
                   <el-col  :span="4" ><div class="grid-content">￥{{productItem.nowprice}} </div> </el-col>
                    <el-col  :span="6" ><div class="grid-content">
  <el-link type="info" @click="addCollect(productItem.sc_id)" >收藏</el-link> <el-link type="danger" style="margin-left:1rem" @click="deleteItem(productItem.sc_id)">删除</el-link></div> </el-col>
           
              </el-row>
</template>

<script>
export default {
  props: {
    productItem: {
      type: Object,
    },
  },
  data(){
     return{
       is_show:true
     }
  },
  methods:{
    deleteItem(id){
       this.$confirm('是否删除此项','提示',{
         confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
      }).then(()=>{
        this.$axios({
          url:'/goods/deleteShoppingCartItem',
          method:'post',
          data:{
            sc_id:id,
            u_id:this.$store.state.userInfo.u_id,
          },
        }).then((data)=>{
           console.log(data)
           if(data.data.code==200){

             this.$message({
            type: 'success',
            message: data.data.msg
             });
             this.is_show=false;
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
   async addCollect(id){
    let data=this.$axios.post('/goods/addCollect',{
        sc_id:id,
        u_id:this.$store.state.userInfo.u_id
      });
    data.then(info=>{
      if(info.data.code==200){
         this.$message({
          showClose: true,
          message: info.data.msg,
          type: 'success'
        });
      }else{
          this.$message({
          showClose: true,
          message: info.data.msg,
          type: 'warning'
        });
      }
    })
    
    
    },
   goProductDetaile(id){
     this.$router.push(`/home/productdetails:${id}`)
   }
  },
  created(){
  
  },
  computed:{
    doProductImg:function(){
     let imgs=this.productItem.g_img;

     let img=imgs.split(",")[0];

     return this.$globalVariable.GOODSIMG+img;
    }
  }
};
</script>

<style lang="less" scoped>
.grid-content{
   display: flex;
   flex-flow: row nowrap;
   align-items: center;
   line-height: 50px;
   
 }
 .imgandprice{
   display: flex;
   flex-flow: row nowrap;
   align-items: center;
   justify-content: center;
 }
 .item{
   padding: 1rem;
 }
</style>