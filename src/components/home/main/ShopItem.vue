<template>
  <div class="shopitem" @click="goProductDetails">
         <div :style="{'background': 'url(http://127.0.0.1:3030/uploadImg/goods/'+ProductDetails.g_img.split(',')[1]+')'}" class="shopimg"></div>
         <div class="price"><span>现价:￥{{ProductDetails.nowprice}}</span><span>原价:￥{{ProductDetails.oldprice}}</span></div>
         <div class="shopinfo"><span class="name">{{ProductDetails.g_name}}</span><span>剩{{ProductDetails.g_daysremaining}}天</span></div>
  </div>
</template>

<script>

export default {
    props:{
         ProductDetails:{
             type:Object,
             default:function(){
                 return{
                 g_id:1,
                 oldPrice:88,
                 nowPrice:66,
                 g_name:"闪亮小白鞋",
                 g_daysremaining:6,
                 productImgUrl:require(`../../../assets/img/test/test1.jpg`)
                 }
               
             }

         }
    }
      
    ,
   data(){
       return{

       }
   },
   methods:{
       goProductDetails(){
       
          this.$router.push('/home/productdetails:'+this.ProductDetails.g_id)
       }
   }
}
</script>

<style lang="less" scoped>
.shopitem{
    width: 22%;
    flex:0 1 1;
    background:@maincolor;
    height: 14rem;
    margin-left:1rem ;
    margin-top:1rem ;
    box-shadow: 0.4rem 0.4rem 0.4rem  @fontcolor;
    border-radius: 0.4rem;
    cursor: pointer;
   
}

.shopimg{
    width: 100%;
    height: 11rem !important;
    background-size: cover !important;
    border-radius: 0.4rem;
}
.shopimg:hover{
   background-size: 100% 100% !important;;
}
.price{
     display: flex;
     justify-content: space-around;
     flex-flow:  row nowrap;
     align-items: center;
    :first-child{
        color: red;
     
    }
    :last-child{
        color: @fontcolor;
        font-size: 0.5rem;
        text-decoration: line-through;
       
    }
}
.shopinfo{
    display:  flex;
    flex-flow: row nowrap;
    justify-content: space-around;
    align-items: center;
  
    :last-child{
       color: @fontcolor;
        font-size: 0.5rem;
    }
}
.name{
        display: block;
        flex-basis: 5rem;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
        
}
</style>