<template>
  <div class="needforumitem">
    <div class="headportrait"> 
      <el-avatar :src="USERIMGADDRESS+need.u_avatar"></el-avatar>
   </div>
    <div class="warp">
        <div class="title"><span>【求购】{{need.ab_title}}</span></div>
        <span class="content"> {{need.ab_content}}</span>
        <div class="pat-info"><span>期望价格<span class="price">￥{{need.ab_price}}</span></span> <span class="address">期望交易地点{{need.ab_address}}</span><span class="time">{{rTime(need.ab_date)}}</span></div>
        <div class="user-info"><span><i class="el-icon-s-custom"></i>{{need.u_nickname}}</span><span>TEL:{{need.u_tel}}</span><span>QQ:{{need.u_qq}}</span></div>
    </div>
  </div>
</template>

<script>
export default {
    props:{
        need:{
            type:Object,
            default:function(){
                return{
                title:'有没有人卖手机的',
                content:'我想收购一个二手手机，最好是小米的，小米yyds',
                price:2000.00,
                address:'西昌学院北校区足球场中间',
                time:'2021-12-21',
                author:'少年阿王',
                tel:'17765580879',
                qq:'956165898'
                }
            
            }
        }
    },
    data(){
        return{
            USERIMGADDRESS:this.$globalVariable.USERIMG
        }
    },
    methods:{
         //时间转换
   rTime:function(date) {
    var json_date = new Date(date).toJSON();
    return new Date(new Date(json_date) + 8 * 3600 * 1000).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '') 
  }
    }

}
</script>

<style lang="less" scoped>
.needforumitem{
display: flex;
background: white;
padding: 1rem;
margin-top: 2rem;
box-shadow: 0.5rem 0.5rem 0.5rem @hoverbackground inset;
}
.headportrait{
    flex: 1;
    display: flex;
    flex-flow: column nowrap;
    align-items: center;
    margin-top:1rem;
    

}
.warp{
    flex: 5;
    >*{
    padding: 0.5rem;
}
    .title{
        color: @titlecolorpluss;
        font-size: 1.2rem;
        font-weight: 600;
    }
    .content{
        font-weight: 500;
        font-size: 0.9rem;
    }

}
.pat-info{
    color: @fontcolor;
    font-size: 0.7rem;
    >*{
        margin-left: 2rem;
    }
    :first-child{
          margin-left: 0;
    }
    .price{
        color: red;
        font-size:1rem;
    }
}
.user-info{
    font-weight: 600;
    >*{
        margin-left: 1rem;
    }
    :nth-child(1){
        color: @fontcolor;
        margin-left: 0;
    }

}
</style>