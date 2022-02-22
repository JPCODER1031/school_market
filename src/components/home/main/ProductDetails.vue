<template>
  <div class="productdetails">
      <!-- 测试数据{{$route.params.productID}} -->
      
      <div class="warp">
          <div class="productimg">    
                <el-carousel :interval="5000" height="30rem" arrow="always">
                    <el-carousel-item v-for="(imgItme,index) in productDetails.g_img"  :key="index">
                        <el-image style="width: 100%; ":src="imgurl+imgItme" class="imglist" fit="cover"></el-image>
                    </el-carousel-item>
                </el-carousel>
              <div :class="isCollect==true?'collect':'discollect'" @click="collect($event)"><i class="el-icon-star-on"></i></div>  <!-- 收藏图标 -->
            </div>
          <div class="productinfo">
              <span> {{productDetails.g_name}}</span>
              <div class="productprice">
                  <span>原价:￥{{productDetails.oldprice}}</span><span>二手价:￥{{productDetails.nowprice}}</span>   
              </div>
              <div class="browsecount">  <span>被浏览次数:2</span></div>
          
              <ul class="tags">
                  <li><el-tag type="success" effect="dark"> 交易地点</el-tag><span>{{productDetails.u_school}}</span></li>
                  <li><el-tag type="success" effect="dark">发布时间</el-tag><span>{{productDetails.g_pubdate}}</span></li>
                  <li><el-tag type="success" effect="dark"> 学院</el-tag><span>{{productDetails.u_branch_courts}}</span></li>
                  <li><el-tag type="success" effect="dark"> 卖家</el-tag><span>{{productDetails.u_nickname}}</span></li>
              </ul>
              <div class="connect" @click="connectBuyer"> <span>联系卖家</span></div>
              <div class="buy"><span @click="addShoppingCart">加入购物车</span> <span @click="buyNow">立即购买</span></div>
              <div class="inform">举报</div>               
          </div>
      </div>
      <div class="divider">
            <el-divider></el-divider>
      </div>
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
      <div v-show="commentIsShow" class="commentlist">
          <div class="commentwrap">
              <div class="headportrait ">
                   <div class="block"><el-avatar :size="50" :src="userImgurl+userInfo.u_avatar"></el-avatar></div>
              </div>
              <div class="commentinput">
                  <div class="commentinputchild">
                    <el-input
                        type="textarea"
                        placeholder="请输入内容"
                        v-model="commentContent"
                        maxlength="2000"
                        show-word-limit  
                        rows="8"
                        > 
                    </el-input>
                  </div>
               
                <div class="commentpublic">
                    <span @click="toogleDialogEmoji">😃</span> <el-button @click="pubComment" size="mini" type="primary">~咻~</el-button>
                </div>
                 <VEmojiPicker
                        v-show="emojIsshow"
                        :style="{ width: '100%', height: '30rem'}"
                        labelSearch="Search"
                        lang="pt-BR"
                        @select="onSelectEmoji"
                        class="emojclass"
                        
                    />
              </div>
              
          </div>
        <CommentItem v-for="(comment,index) in commentsObj" :commentsobj="{...comment,index:index+1}"  :key="index"></CommentItem>
      </div>
  </div>
</template>

<script>
import CommentItem  from './productdetails/CommentItem';
import { VEmojiPicker, emojisDefault, categoriesDefault } from "v-emoji-picker";
import {mapState} from 'vuex';
export default {
    components:{
   CommentItem,
   VEmojiPicker,
    },
 data(){
     return{
         userImgurl:this.$globalVariable.USERIMG,
         imgurl:this.$globalVariable.GOODSIMG,
         productID:this.$route.params.productID.split('')[1],//获取路由传过来的id
         productDetails:{},
         commentIsShow:true,//评论
         emojIsshow:false,//表情选择
         commentContent:'',//评论类容
         commentsObj:[],
         isCollect:false,
     } 
 },
 methods:{
     //立即购买
     buyNow(){
       this.$axios({
           url:'/goods/buyNow',
           method:'post',
           data:{
               g_id:this.productID,
               userInfo:this.userInfo,
               
           }
       }).then(res=>{
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
     },
     //添加购物车按钮
     addShoppingCart(){
        this.$axios({
            method:'post',
            url:'goods/addShoppingCart',
            data:{
                u_id:this.userInfo.u_id,
                g_id:this.productID,
            }
        }).then(data=>{
            if(data.data.code==200){
                this.$message({
                    message:data.data.msg,
                    type:'success'
                })
            }else{
                  this.$message({
                    message:data.data.msg,
                    type:'error'
                })
            }
        
        })
     },
     //初始化是否收藏
     getIsCollect(){
       this.$axios.get('/goods/isCollect',{
           params:{
               u_id:this.userInfo.u_id,
               g_id:this.productID,
           }
               
       }).then(data=>{
           this.isCollect=data.data.isCollect;
       })
     },
     collect(e){
     if(this.isCollect){
         this.cancelCollect();
     }else{
         this.addCollect();
     } 
     this.getIsCollect();
        // console.log(e.currentTarget);
     },
     //添加收藏
     addCollect(){
      this.$axios({
           url:'/goods/addCollect',
           method:'get',
           params:{
               u_id:this.userInfo.u_id,
               g_id:this.productID,
           }
       }).then(data=>{
           if(data.data.code==200){
               this.$message({
                   type:'success',
                   message:data.data.msg
               })
           }else{
                this.$message({
                   type:'error',
                   message:data.data.msg
               })
           }
       })
     },
     //取消收藏
     cancelCollect(){
      this.$axios({
           url:'/goods/cancelCollect',
           method:'get',
           params:{
               u_id:this.userInfo.u_id,
               g_id:this.productID,
           }
       }).then(data=>{
           if(data.data.code==200){
               this.$message({
                   type:'success',
                   message:data.data.msg
               })
           }else{
                this.$message({
                   type:'error',
                   message:data.data.msg
               })
           }
       })
     },
     //打开表情选择框
     toogleDialogEmoji() {
      
      this.emojIsshow = !this.emojIsshow;
    },
    //选择表情
     onSelectEmoji(emoji){
       this.commentContent+=emoji.data;
        this.emojIsshow = !this.emojIsshow;
     },
     //发表评论
     pubComment(){
         let userID=this.$store.state.userInfo.u_id;
        
         this.$axios.post('/goods/pubComment',{
                c_content:this.commentContent,
                u_id:userID,
                g_id:this.productID,
         }).then(data=>{
             if(data.data.code==200){
                 this.$message({
                     type:'success',
                     message:data.data.msg
                 })
                 this.getComments();
                 this.commentContent='';
             }else{
                 this.$message({
                     type:'error',
                     message:data.data.msg
                 })
             }
         })
     },
     //请求评论
     getComments(){
         
      this.$axios.get('/goods/productDetaileComments',{
         params:{
            productID:this.productID,
         }
     })
     .then(res => {
         this.commentsObj=[...res.data];
     })
     .catch(err => {
         console.error(err); 
     })
     },
     getProductDetails(){
      this.$axios({
         method:'get',
         url: '/goods/getProductDetails',  
         params:{
            productID:this.productID,
             }
     }).then(data=>{
         this.productDetails={...data.data[0]};
         this.productDetails.g_img=this.productDetails.g_img.split(',')      
     })
     },
     //联系买家
     connectBuyer(){    
         this.$axios({
             method:'post',
             url:'/user/addFriendList',
             data:{
                 u_id:this.userInfo.u_id,
                 chatListID:this.productDetails.u_id
             }
         }).then(res=>{
             if(res.data.code==200){
               this.$router.push({
                   path:'/chatview',
                   query:{
                       active_id:this.productDetails.u_id
                   }
                   });
             }else{
                 this.$message({
                 type:"error",
                 message:res.data.msg
             })
             }
             
         })
     }

 },
 created(){
     //请求商品详细信息
    this.getProductDetails();
     //请求评论信息
    this.getComments();
    this.getIsCollect();
 },
 computed:{
    ...mapState({
        userInfo:'userInfo'
    })
 },
 mounted() {
  
 },
}
</script>

<style lang="less" scoped>
.commentwrap{
      width: 80%;
      display: flex;
      flex-flow: row nowrap;
      background: white;
      box-shadow: 0.5rem 0.5rem 0.5rem @hoverbackground;
      border-radius: 0.5rem;
      padding: 1rem 1rem;
      margin-top:2rem ;
  .headportrait{
        flex:1;
        display: flex;
        justify-content: center;
        :first-child{
            margin-top:0.5rem; 
        }
    };
  .commentinput{
      flex:4;
      .commentinputchild{
      :nth-child(1){
      background-image: url('../../../assets/img/commentBack.webp');
      background-repeat:no-repeat ;
      background-position:right  center  ;
      border:none ;
      }
      }
     
  
  } 
 
}
.emojclass{
    background: whitesmoke;
}
.commentpublic{
     display: flex;
     flex-flow: row nowrap;
     justify-content: space-between;   
     align-items: center;
     :first-child{
         font-size:1.5rem ;
         padding: 0.7rem;
         cursor: pointer;
     }
     :last-child{
        font-size:1rem ;
        margin-right: 1rem;
        text-align: center;
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
.divider{
    display: flex;
    width: 80%;

}
.productdetails{
    display: flex;
    flex-flow: column nowrap;
    justify-content: center;
    align-items: center;
    flex:7;
    padding-top:2rem;
    box-sizing: border-box; 
    
}
.warp{
    width: 80%;
    display: flex;
    flex-flow: row nowrap;
    background: @maincolor;
    padding: 1rem;
    border-radius: 0.5rem;
}
.productimg{
    flex:3;
   position: relative;
.discollect{
     width: 3rem;
     height: 3rem;
     position: absolute;
     top:1rem;
     right: 1rem;
     z-index: 99;
     font-size:2rem ;
     background: rgba(255, 217, 0, 0.753);
     border-radius:50% ;
     text-align: center;
     line-height: 3rem;
    color: @maincolor;
 }
 .collect{
     width: 3rem;
     height: 3rem;
     position: absolute;
     top:1rem;
     right: 1rem;
     z-index: 99;
     font-size:2rem ;
     background: rgba(255, 217, 0, 0.753);
     border-radius:50% ;
     text-align: center;
     line-height: 3rem;
      color: red;
     
 }:hover{
     background:@hoverbackground;
      color: red;
 }
  
}

.productinfo{
    position: relative;
    flex: 2;
    
    >:first-child{
        font-size: 1.5rem;
        font-weight: 600;
        color: @titlecolorpluss;
    }
    >:nth-child(3){
        font-size:0.6rem ;
         color: @fontcolor;
         align-content: center;
         align-self: centers;
    }
    >*{
        margin-left: 2rem;
        margin-top: 1rem;
    }
    
}
.browsecount{
    display: flex;
    justify-content: center;
}
.tags{
    list-style: none;
    li{
        margin-top: 1rem;
        :first-child{
            width: 4rem;
            text-align: center;
        }
        :last-child{
            margin-left:2rem ;
        }
    }
}
.connect{
    display: flex;
    justify-content: flex-start;
    :first-child{
        padding: 0.5rem 6rem;
        background: rgb(24, 144, 241);
        border-radius: 0.3rem;
        cursor: pointer;
        color: @maincolor;  
    }:hover{
        background: @hoverbackground;
    }
}
.buy{
    display: flex;
    justify-content: flex-end;
    margin-top:4.5rem ;
    :first-child{
         padding: 0.5rem 1rem;
        background: rgba(255, 192, 203, 0.849);
        border-radius: 0.3rem;
        cursor: pointer;
        color: red;  
        margin-right: 1rem;
        border:solid 1px red;
        font-weight: 600;
        white-space: nowrap;
    }
    :last-child{
        padding: 0.5rem 1rem;
        background: red;
        border-radius: 0.3rem;
        cursor: pointer;
        color: @maincolor;  
        font-weight: 600;
        margin-right: 5rem;
         white-space: nowrap;
    }
    :hover{
        background: @hoverbackground;
    }
}
.inform{
   position: absolute;
   right: 0;
   top:-1rem;
   color: @currPricefont;
   cursor: pointer;
 
}
.productprice{
    :first-child{
      color: @fontcolor;
      font-size: 0.6rem;
      text-decoration: line-through;
    }
    :last-child{
      color: @currPricefont;
      font-size: 1.6rem;
      margin-left:2rem ;
    }
}
.commentlist{
    width: 100%;
    display: flex;
    flex-flow: column nowrap;
    align-items: center;
   
}
.imglist{
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>