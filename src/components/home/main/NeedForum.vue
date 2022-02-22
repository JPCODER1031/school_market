<template>
  <div class="needforum">
    <PageTitle>求购专区</PageTitle>
    <div class="commentlistshow">
            <span> <i class="el-icon-chat-dot-square"></i>  评论</span> 
            <div><el-switch
                style="display: block"
                v-model="commentIsShow"
                active-color="#13ce66"
                inactive-color="#ff4949"
                active-text="Valine"
                inactive-text="Disqus"
                >
            </el-switch>
            </div>
        </div>
         <div class="divider">
            <el-divider></el-divider>
      </div>
    <div class="test1">
      <CommentInputAddEmoj @publishNeedorum="publishNeedorum" v-show="commentIsShow"></CommentInputAddEmoj>
    </div>
    <div class="needforumlist">  
      <NeedForumItem v-for="item in needForumList" :need="item" :key="item.ab_id"></NeedForumItem>
    </div>
  </div>
</template>

<script>
import CommentInputAddEmoj from "../../publicComponent/CommentInputAddEmoj";
import NeedForumItem from "./needforum/NeedForumItem";
import PageTitle from '../../publicComponent/PageTitle';
import {mapState} from 'vuex'
export default {
  components: {
    CommentInputAddEmoj,
    NeedForumItem,
    PageTitle
  },
  data() {
    return {
      commentIsShow:false,
      needForumList:[],
    };
  },
  methods:{
    getNeedForum(){
      this.$axios({
        url:'/goods/getNeedForum',
        method:'get'
      }).then(res=>{
        this.needForumList=res.data.result;
        // console.log(this.needForumList)
        // console.log(res)
      })
    },
    publishNeedorum(commentContent){
      this.$axios({
        url:"/goods/quickPublishAskToBuy",
        method:'post',
        data:{
          commentContent:commentContent,
           u_id:this.userInfo.u_id,
        }
      }).then(res=>{
        console.log(res)
          if(res.data.code==200){
            this.$message({
              type:'success',
              message:res.data.msg
            })
          }else{
             this.$message({
              type:'error',
              message:res.data.msg
            })
          }
      })
    this.getNeedForum();
    }
  },
  created(){
     this.getNeedForum()
  },
  computed:{
       ...mapState({
         userInfo:'userInfo'
       })
  }
};
</script>

<style lang="less" scoped>
.needforum {
  display: flex;
  flex: 7;
  flex-flow: column nowrap;
  align-items: center;
  padding: 1rem;
}
.header {
  display: flex;
  flex-flow: row nowrap;
  align-items: center;
  ul {
    list-style-type: none;
    display: flex;
    flex-flow: row nowrap;
    justify-content: center;
    li {
      margin: 1rem 1rem;
    }
  }
  h2{
    font-size:2rem ;
    color: @titlecolorpluss;
    font-weight: 600;
  }
}
.commentlistshow{
width: 80%;
display: flex;
flex-flow: row nowrap;
justify-content: space-between;
:first-child{
    font-size: 1.2rem;
    font-weight: 600;
}
}
.test1 {
  width: 80%;
}
.needforumlist{
  width: 80%;
}
</style>