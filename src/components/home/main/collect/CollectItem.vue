<template>
  <div v-show="isShow" class="collect-item">
    <div class="img" @click="goProductDetail(collectItem.g_id)">
         <el-image @mouseenter="isDeleteShow=true" @mouseleave="isDeleteShow=false" :fit="'cover'" style="width:100%;height:15rem" :src="imgAddress+getGoodsimg" class="imglist" fit="cover"></el-image>
    </div>
    <div class="name">{{collectItem.g_name}}</div>
    <div class="price">￥{{collectItem.nowprice}}</div>
    <div class="addshoppingcart" @click="addShoppingCart(collectItem.g_id)"> <span>加入购物车</span></div>
    <div @mouseenter="isDeleteShow=true" @mouseleave="isDeleteShow=false" v-show="isDeleteShow" @click="removeCollect" class="delete-collect">移除关注</div>
  </div>
</template>

<script>
export default {
    props:{
        collectItem:{
            type:Object,
            default:function(){
                return{
                g_id:'111',
                g_name:'闪亮小白鞋',
                nowprice:'200',
                g_img:require("../../../../assets/img/test/test1.jpg")
                }
               
            }
        }
    },
    data(){
        return{
            isDeleteShow:false,
            imgAddress:this.$globalVariable.GOODSIMG,
            isShow:true,
        }
    },
    methods:{
        //移除收藏列表
        removeCollect(){
            this.$axios({
                url:'/goods/removeCollect',
                method:'post',
                data:{
                    u_id:this.$store.state.userInfo.u_id,
                    g_id:this.collectItem.g_id,
                }
            }).then(data=>{
                console.log(data);
                if(data.data.code==200){
                    this.$message({
                        type:'success',
                        message:data.data.msg
                    })
                    this.isShow=false;
                }else{
                     this.$message({
                        type:'error',
                        message:data.data.msg
                    })
                }
            })
        },
        //跳转商品详情页面、
        goProductDetail(id){
         this.$router.push(`/home/productdetails:${id}`)
        },
        //加入购物车
        addShoppingCart(id){
           this.$axios({
               url:'/goods/addShoppingAndRemoveCollect',
               method:'post',
               data:{
                   g_id:id,
                   u_id:this.$store.state.userInfo.u_id,
               }
           }).then(data=>{
             if(data.data.code==200){
                 this.$message({
                     message:data.data.msg,
                     type:'success'
                 })
                 this.isShow=false
             }else{
                  this.$message({
                     message:data.data.msg,
                     type:'error'
                 })
             }
           })
        }
    },
    created(){
      
    },
    computed:{
        getGoodsimg:function(){   
            return this.collectItem.g_img.split(',')[0];
        }
    }
}
</script>

<style lang="less" scoped>
.collect-item{
    position: relative;
    overflow: hidden;
     width:15rem;
     padding: 0.5rem;
     background: whitesmoke;
     box-sizing: content-box;
     margin-top: 1rem;
     .img{
         flex: 1 1 10rem;  
     }
     .name{
         text-align: center;
         font-size:0.7rem;
         color: @fontcolor;
     }
     .price{
         text-align: center;
         font-weight: 700;
         font-size:1rem;
     }
     .addshoppingcart{
        text-align: center; 
        background: rgb(217, 218, 217);
        cursor: pointer;
     }
}
.addshoppingcart:hover{
    color: red;
}
.delete-collect{
    position: absolute;
    top:0;
    background: rgba(92, 94, 92, 0.952);
    width: 100%;
    left: 0;
    text-align: center;
    color: whitesmoke;
    font-size:1.1rem ;
    cursor: pointer;
    
}

</style>