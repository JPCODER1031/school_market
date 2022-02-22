<template>
  <div class="comment">
     <div class="wrap">
       <div class="left">  
          <el-avatar  size="small" :src="squareUrl+commentsobj.u_avatar"></el-avatar>
        </div>
       <div class="right">
         <span class="username"> {{commentsobj.u_nickname}}</span>
         <div class="right-wrap">
         <div class="right-wrap-left"> 
         <span> {{commentsobj.index}}楼</span>
         <span>{{commentsobj.c_pubdate}}</span>
         <span ><i class="el-icon-lollipop"></i> </span>
         </div>   
         <span class="right-wrap-right">回复</span>
        </div>
        <div class="comment-content">
         {{commentsobj.c_content}}
        </div>
       </div>
     </div>
  </div>
</template>

<script>
export default {
  props:{
    commentsobj:{
      type:Object,
    },
    floor:0,
  },
   data(){
     return{
       squareUrl: "http://127.0.0.1:3030/uploadImg/user/",
     }
   },
   created(){
     
   },
   computed:{
  
   }
}
</script>

<style lang="less" scoped>
.comment{
  width: 80%;

  margin-top:1rem ; 
  margin:1rem  0;
  background: white;
  box-shadow: 0.5rem 0.5rem 0.5rem @hoverbackground;
  border-radius: 0.5rem;
}
.wrap{
  display: flex;
  flex-flow: row nowrap;
  padding: 1rem;
  .left{
    flex:1;
    display: flex;
    justify-content: center;
    margin-top:0.1rem;

  }
  .right{
    flex:7;
    .username{
      font-size: 1.3rem;
      font-weight: 600;
    }
  }
  .right-wrap{
    font-size: 0.8rem;
    color: @fontcolor;
    display: flex;
    flex-flow: row nowrap;
    justify-content: space-between;
    .right-wrap-left{
      margin: 0.5rem ;
      >*{
          margin:1rem 0.5rem;
      }
      :first-child{
        margin-left:0;
      }
      
    }
    >:last-child{
      color: red;
      text-overflow: ellipsis;
      max-height: 2rem;
    }
  }
}
</style>