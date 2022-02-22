<template>
  <div class="buyitem">
   <div class="header"><span class="time">{{buyItemTime(buyItem.o_date)}}</span><div class="orderNumbers"><span>订单编号:</span><span>{{buyItem.o_id}}</span></div> <span class="seller">卖家:{{buyItem.u_nickname}}</span> <span @click="deleteBuyItem" class="delete"><i class="el-icon-delete-solid"></i></span></div>
   <div class="info">  
            <el-image
            style="width: 3rem; height: 3rem"
            :src="GOODSIMGADDRESS+splitImg(buyItem.g_img)"
            fit="fill"></el-image> 
            <div class="name">{{buyItem.g_name}}</div> <div class="count">x1</div>
            <div class="address">
        <el-popover
            placement="top-start"
            title="地址详情"
            width="200"
            trigger="hover"
            class="addre"
        >
        <div class="addressinfo">
            <el-row>
                <el-col :span="24"> {{userInfo.u_nickname}}</el-col>
                <el-col :span="24"> {{buyItem.address}}</el-col>
                <el-col :span="24"> {{userInfo.u_tel}}</el-col>
            </el-row>
        </div>
            <el-button slot="reference">地址详情</el-button>
        </el-popover>
        </div>
        <div class="orderstate">
            <el-popover
            placement="top-start"
            title="订单状态"
            width="300"
            trigger="hover"
            class="addre"
        >
      <el-steps :space="200" :active="buyItem.o_status" finish-status="success">
           <el-step title="等待发货" @click.native="changeStatus(1)"></el-step>
  <el-step title="已发货" @click.native="changeStatus(2)"></el-step>
  <el-step title="运送中" @click.native="changeStatus(3)"></el-step>
  <el-step title="已完成" @click.native="changeStatus(4)"></el-step>
</el-steps>
            <el-button slot="reference">订单状态</el-button>
        </el-popover>
        </div>
        </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
   props:{
       buyItem:{
           type:Object,
           default:function(){
               return{
                   id:"35828",
                   name:"闪亮小白鞋",
                   time:"2021-12-04 12:14:55",
                   seller:"王顺刘子",
                   img:require('../../../../assets/img/test/test1.jpg'),
                   price:"120",
                   state:1,
                   address:"四川省凉山州西昌学院",
                   buyer:"刘润土",
                   buyerTel:'13990857042'
               }
           }
       }
   },
   data(){
      return{
          GOODSIMGADDRESS:this.$globalVariable.GOODSIMG,
      }
   },
    methods:{
       changeStatus(id){
         if(this.buyItem.o_status==3&&id==4){
               this.$axios({
                 url:'/goods/updateOrderStatus',
                 method:'post',
                 data:{
                     orderStatus:id,
                     o_id:this.buyItem.o_id,
                 }
             }).then(data=>{
                
                 this.$emit('updateData')
             })
         }else{
               this.$message({
                 type:'info',
                 message:'这个状态暂时不能修改!'
             })
           
         }
         
       },
       deleteBuyItem(){
             this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$message({
            type: 'success',
            message: '删除成功!'
          });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });          
        });
      
       },
        buyItemTime:function(date){
            
                  let json_date = new Date(date).toJSON();
                 return new Date(new Date(json_date) + 8 * 3600 * 1000).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '') 
            
       },
       splitImg(imgaddress){
            let img=imgaddress.split(',')[0];
            return img
       }

   },
   computed:{
      ...mapState({
          userInfo:'userInfo'
      })
   }
}
</script>

<style lang="less" scoped>
.buyitem{
    #boxshadow();
    
    .header{
        display: flex;
        flex-flow: row nowrap;
        background: rgb(233, 231, 231);
        align-items: center;
        line-height: 1.2rem;
       .time{
           color: rgb(117, 117, 117);
           font-size: 0.8rem;
           margin-left: 1rem;
       }
       .orderNumbers{
           margin-left: 1rem;
           :first-child{
                  color: rgb(117, 117, 117);
               font-size: 0.8rem;
           }
           :last-child{
               font-size:1rem ;
               font-weight:600 ;
                  color: rgb(87, 87, 87);
           }
       }
       .seller{
              color: rgb(117, 117, 117);
           margin-left: 4rem;
           font-size:0.8rem ;
           cursor: pointer;
       }
       .delete{
           display: flex;
           flex: 1;
           flex-flow: row-reverse nowrap;
           margin-right:1rem;
           cursor: pointer;
           
       }
    }
    .info{
        margin-top:1rem ;
        display: flex;
        flex-flow: row nowrap;
        align-items: center;
        justify-content: space-between;
        .addressinfo{
            display: flex;
            flex-flow:column nowrap;
            
        }
        .address{
            :first-child{
                background: @maincolor;
                border: none;
            }
        }
        .orderstate{
              :first-child{
                background: @maincolor;
                border: none;
            }
            margin-right: 2rem;
        }
       
    }
}

</style>