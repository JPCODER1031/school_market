<template>
  <div class="right">
    <div class="buy" @click="changeWantBuyDialogState">我要买</div>
    <div class="sell" @click="changeSellDialogState">我要卖</div>
    <div class="need" @click="jumpNeedForum">求购专区</div>
    <div class="info">
      <span>我们帮助</span><span>{{selled}}</span><span>闲置物品找到了新主人</span>
    </div>
    <div class="connection" @click="addWei">
   <svg t="1645415677640" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2297" width="128" height="128"><path d="M337.387283 341.82659c-17.757225 0-35.514451 11.83815-35.514451 29.595375s17.757225 29.595376 35.514451 29.595376 29.595376-11.83815 29.595376-29.595376c0-18.49711-11.83815-29.595376-29.595376-29.595375zM577.849711 513.479769c-11.83815 0-22.936416 12.578035-22.936416 23.6763 0 12.578035 11.83815 23.676301 22.936416 23.676301 17.757225 0 29.595376-11.83815 29.595376-23.676301s-11.83815-23.676301-29.595376-23.6763zM501.641618 401.017341c17.757225 0 29.595376-12.578035 29.595376-29.595376 0-17.757225-11.83815-29.595376-29.595376-29.595375s-35.514451 11.83815-35.51445 29.595375 17.757225 29.595376 35.51445 29.595376zM706.589595 513.479769c-11.83815 0-22.936416 12.578035-22.936416 23.6763 0 12.578035 11.83815 23.676301 22.936416 23.676301 17.757225 0 29.595376-11.83815 29.595376-23.676301s-11.83815-23.676301-29.595376-23.6763z" fill="#28C445" p-id="2298"></path><path d="M510.520231 2.959538C228.624277 2.959538 0 231.583815 0 513.479769s228.624277 510.520231 510.520231 510.520231 510.520231-228.624277 510.520231-510.520231-228.624277-510.520231-510.520231-510.520231zM413.595376 644.439306c-29.595376 0-53.271676-5.919075-81.387284-12.578034l-81.387283 41.433526 22.936416-71.768786c-58.450867-41.433526-93.965318-95.445087-93.965317-159.815029 0-113.202312 105.803468-201.988439 233.803468-201.98844 114.682081 0 216.046243 71.028902 236.023121 166.473989-7.398844-0.739884-14.797688-1.479769-22.196532-1.479769-110.982659 1.479769-198.289017 85.086705-198.289017 188.67052 0 17.017341 2.959538 33.294798 7.398844 49.572255-7.398844 0.739884-15.537572 1.479769-22.936416 1.479768z m346.265896 82.867052l17.757225 59.190752-63.630058-35.514451c-22.936416 5.919075-46.612717 11.83815-70.289017 11.83815-111.722543 0-199.768786-76.947977-199.768786-172.393063-0.739884-94.705202 87.306358-171.653179 198.289017-171.65318 105.803468 0 199.028902 77.687861 199.028902 172.393064 0 53.271676-34.774566 100.624277-81.387283 136.138728z" fill="#28C445" p-id="2299"></path></svg>
    </div>
    <WantBuyDialog
      :visible.sync="wantBuyDialogIsShow"
      :wantBuyDialogIsShow="wantBuyDialogIsShow"
      @getbuydialogshowstate="getBuyDialogShowState"
      @handlecancel="wantBuyHandleCancel"
      @handlepublish="wantBuyHandlePublish"
      @handleclose="wantBuyHandleClose"
    >
      <div slot="main" class="buydialog">
        <div class="wrap">
          <el-form ref="wantBuyForm" :model="wantBuyForm" :rules="wantBuyRules" label-width="80px">
            <el-form-item label="商品名称" prop='name'>
              <el-input v-model="wantBuyForm.name"></el-input>
            </el-form-item>
            <el-form-item label="商品描述" prop='desc'>
              <el-input
                rows="4"
                type="textarea"
                v-model="wantBuyForm.desc"
              ></el-input>
            </el-form-item>
            <el-form-item label="交易地点" prop='address'>
              <el-input v-model="wantBuyForm.address"></el-input>
            </el-form-item>
            <el-form-item label="期望价格" prop='price'>
              <el-input v-model="wantBuyForm.price"
                ><template slot="prepend">￥</template></el-input
              >
            </el-form-item>
          </el-form>
        </div>
      </div>
    </WantBuyDialog>
    <SellDialog
      :title="`发布商品`"
      :visible.sync="sellDialogIsShow"
      :dialogIsShow="sellDialogIsShow"
      @getdialogshowstate="getsellDialogShowState"
      @handlecancel="sellHandleCancel"
      @handlepublish="sellHandlePublish"
      @handleclose="sellHandleClose"
    >
      <div slot="main" class="buydialog">
        <div class="wrap">
          <el-form
            ref="sellform"
            :model="sellForm"
            :rules="rules"
            label-width="6rem"
          >
            <el-form-item label="先择商品图片" prop="imgfile">
              <!-- 图片上传 -->
              <el-upload
                action="http://127.0.0.1:3030/goods/uploadImg"
                list-type="picture-card"
                :limit="5"
                :file-list="sellForm.imgfile"
                :on-exceed="exceedLimit"
                :on-success="onSuccess"
                :auto-upload="true"
                :on-change="onHandleChange" 
              >
                <i slot="default" class="el-icon-plus"></i>
                <div slot="file" slot-scope="{ file }">
                  <img
                    class="el-upload-list__item-thumbnail"
                    :src="file.url"
                    alt=""
                  />
                  <span class="el-upload-list__item-actions">
                    <!-- 预览大图图标 -->
                    <span
                      class="el-upload-list__item-preview"
                      @click="handlePictureCardPreview(file)"
                    >
                      <i class="el-icon-zoom-in"></i>
                    </span>
                    <span
                      v-if="disabled"
                      class="el-upload-list__item-delete"
                      @click="handleDownload(file)"
                    >
                      <i class="el-icon-download"></i>
                    </span>
                    <!-- 删除图标 -->
                    <span
                      v-if="!disabled"
                      class="el-upload-list__item-delete"
                      @click="handleRemove(sellForm.imgfile)"
                    >
                      <i class="el-icon-delete"></i>
                    </span>
                  </span>
                </div>
              </el-upload>
              <el-dialog :visible.sync="dialogVisible">
                <img width="100%" :src="dialogImageUrl" alt="" />
              </el-dialog>
            </el-form-item>
            <el-form-item label="商品名称" prop="name">
              <el-input type="text" v-model="sellForm.name"></el-input>
            </el-form-item>
            <el-form-item label="商品类别" prop="classifyvalue">
              <el-select
                v-model="sellForm.classifyvalue"
                placeholder="请选择类别"
              >
                <el-option
                  v-for="(item, index) in sellForm.classify"
                  :label="item.goodstype"
                  :value="item.id"
                  :key="index"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="商品描述" prop="desc">
              <el-input
                rows="4"
                type="textarea"
                v-model="sellForm.desc"
              ></el-input>
            </el-form-item>
            <el-form-item label="原价" prop="oldprice">
              <el-input v-model="sellForm.oldprice"
                ><template slot="prepend">￥</template></el-input
              >
            </el-form-item>
            <el-form-item label="现价格" prop="nowprice">
              <el-input v-model="sellForm.nowprice"
                ><template slot="prepend">￥</template></el-input
              >
            </el-form-item>
            <el-form-item label="寄售天数" prop="daysremaining">
              <el-input v-model="sellForm.daysremaining"></el-input>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </SellDialog>
  </div>
</template>

<script>
import WantBuyDialog from "../main//right/WantBuyDialog";
import SellDialog from "../../publicComponent/Dialog";
import { mapState } from 'vuex';
export default {
  components: {
    WantBuyDialog,
    SellDialog,
  },
  data() {
    var validateName = (rule, value, callback) => {
      if (!value) {
        return callback(new Error("名称不能为空"));
      }
      if (value.length > 18) {
        callback(new Error("商品名称不能大于18"));
      } else if (value.length < 2) {
        callback(new Error("商品名称不能小于2"));
      } else {
        callback();
      }
    };
    var validateDaysRemaining = (rule, value, callback) => {
      if (parseInt(value) > 365) {
        callback(new Error("寄售天数不能大于365天"));
      } else {
        callback();
      }
    };
    var validatePrice = (rule, value, callback) => {
      if (!value) {
        callback(new Error("价格不能为空"));
      } else {
        callback();
      }
    };
    var validateOldPrice = (rule, value, callback) => {
      if (!value) {
        callback(new Error("价格不能为空"));
      } else {
        callback();
      }
    };
    var validateDesc = (rule, value, callback) => {
      if (!value) {
        callback(new Error("商品描述不能为空"));
      } else if (value.length < 5) {
        callback(new Error("描述不能低于5个字"));
      }
    };
    return {
      wantBuyDialogIsShow: false, //求购弹框
      sellDialogIsShow: false, //发布商品弹框
      selled:0,//卖掉件数
      //求购表单
      wantBuyForm: {
        name: "",
        desc: "",
        address: "",
        price: "",
      },
      //发布商品表单
      sellForm: {
        imgfile: [],
        imgArr:[],
        name: "",
        classify: [
          { id: 1, goodstype: "手机" },
          { id: 2, goodstype: "电脑" },
          { id: 3, goodstype: "影音娱乐" },
          { id: 4, goodstype: "数码配件" },
          { id: 5, goodstype: "运动健身" },
          { id: 6, goodstype: "衣物鞋帽" },
          { id: 7, goodstype: "图书教材" },
          { id: 8, goodstype: "交通出行" },
          { id: 9, goodstype: "其他商品" },
        ],
        desc: "",
        oldprice: "",
        nowprice: "",
        daysremaining: "",
        classifyvalue: "",
      },
      sellParam:new FormData(),//提交的表单数据
      rules: {
        name: [{ validator: validateName, trigger: "blur" }],
        desc: [{ validator: validateDesc, trigger: "blur" }],
        nowprice: [{ validator: validatePrice, trigger: "blur" }],
        oldprice: [{ validator: validateOldPrice, trigger: "blur" }],
        daysremaining: [{ validator: validateDaysRemaining, trigger: "blur" }],
        imgfile:[],
        classifyvalue:[]
      },
      wantBuyRules:{
        name: [],
        desc: [],
        address: [],
        price: [],
      },
      dialogImageUrl: "",
      dialogVisible: false,
      disabled: false,
    };
  },
  methods: {
    //微信弹窗
    addWei(){
       this.$message({
          dangerouslyUseHTMLString: true,
          message: '<strong>+V:PP138844345</strong>',
          showClose:true,
          duration:0,
          type:'info'
        });
    },
    jumpNeedForum() {
      this.$router.push("/home/needforum");
    },
    wantBuyHandleCancel() {
      //关闭弹框按钮
      this.wantBuyDialogIsShow = false;
    },
    async wantBuyHandlePublish() {
      //确定按钮
   
      let res=await this.$axios({
            url:'/goods/publishAskToBuy',
            method:'post',
            data:{
                askToBuyForm:this.wantBuyForm,
                u_id:this.userInfo.u_id,
            }
            
      })
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
      console.log(this.$refs.wantBuyForm)
      this.$refs.wantBuyForm.resetFields();
      this.wantBuyDialogIsShow = false;
    },
    wantBuyHandleClose() {
      //取消按钮（X)
      this.wantBuyDialogIsShow = false;
    },
    changeWantBuyDialogState() {
      this.wantBuyDialogIsShow = !this.wantBuyDialogIsShow;
    },
    getBuyDialogShowState(val) {
      this.wantBuyDialogIsShow = val;
    },
    //以上是求购传入的方法
    sellHandleCancel() {
      //关闭弹框按钮
      this.sellDialogIsShow = false;
    },
    async sellHandlePublish() {
      // this.sellParam.append('message',this.sellForm);
      let  u_id=this.$store.state.userInfo.u_id;
      // console.log(this.sellParam);
      //确定按钮
      this.$axios({
        url:'/goods/publishGood',
        method:'post',
        data:{...this.sellForm,u_id:u_id},
        headers: {
            
          // 'Content-Type': 'application/x-www-form-urlencoded',
          // 'Content-Type':'multipart/form-data',
        
        }
      })
      .then(res => {
        if(res.data.code==200){
       this.$message({ 
          message: res.data.msg,
          type: 'success'
        });
        }else{
        this.$message.error(res.data.msg);
        }
        
      })
      .catch(err => {
        console.error(err); 
      })
      this.sellDialogIsShow = false;
      // console.log(this.$refs.sellform);
      this.$refs.sellform.resetFields();//亲空表单
     
    },
    sellHandleClose() {
      //取消按钮（X)
      this.sellDialogIsShow = false;
    },
    changeSellDialogState() {
      this.sellDialogIsShow = !this.sellDialogIsShow;
    },
    getsellDialogShowState(val) {
      this.sellDialogIsShow = val;
    },
    //图片上传的回调函数
    exceedLimit() {
      //图片最大上传数回调
      this.$message.error({
        type: "error",
        showClose: true,
        message: "图片最大上传数为5",
      });
    },
    handleRemove(file) {
      //删除图片回调
      console.log(file);
    },
    handlePictureCardPreview(file) {
      //图片预览
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },
    handleDownload(file) {
      console.log(file);
    },
    //图片上传前的钩子函数
    beforeUpload(file) {
      console.log(file.raw.type);
    },
    //图片上传成功的钩子函数
    onSuccess(response, file, fileList) {
    this.sellForm.imgArr.push(response);
    },
    //图片修改时回调
    onHandleChange(file,filesList) {
                console.log(file);
                //创建临时的路径来展示图片
                var windowURL = window.URL || window.webkitURL;
                this.src=windowURL.createObjectURL(file.raw);
                //重新写一个表单上传的方法
                this.sellParam.append('sellImg', file.raw, file.name);
      },
    //获取出售数量
     getSelledCount(){
       this.$axios({
        url:'/goods/getSelledCount',
        method:'get',
      }).then(res=>{
        this.selled=res.data.nums
      })
    
    }
  },
  created(){
    this.getSelledCount();
  },
  computed: {
      ...mapState({
        userInfo:'userInfo'
      })

  }
   
};
</script>

<style lang="less" scoped>
#public() {
  width: 70%;
  padding: 0.5rem 1.2rem;
  text-align: center;
  margin-right: 1.5rem;
  box-sizing: content-box;
  margin-top: 2rem;
  cursor: pointer;
}

.right {
  display: flex;
  flex: 1;
  flex-flow: column nowrap;
  align-items: flex-end;
  color: @maincolor;
}

.buy {
  background: rgb(236, 28, 28);
  #public();
}
.buy:hover {
  background: @hoverbackground;
}
.sell {
  background: rgb(253, 171, 1);
  #public();
}
.sell:hover {
  background: @hoverbackground;
}
.need {
  #public();
  background: rgb(73, 169, 7);
}
.need:hover {
  background: @hoverbackground;
}
.info {
  color: @titlecolor;
  width: 70%;
  height: 10rem;
  text-align: center;
  margin-right: 1.5rem;
  box-sizing: content-box;
  margin-top: 2rem;
  box-sizing: content-box;
  padding: 0.5rem 1.2rem;
  border: dashed 0.2rem @titlecolor;
  display: flex;
  flex-flow: column nowrap;
  justify-content: space-around;
  font-weight: 600;
  :nth-child(2) {
    font-size: 4rem;
  }
}
.connection {
  #public();
  cursor: pointer;
  font-size: 3rem;
}
.buydialog {
  display: flex;
  justify-content: center;
  .wrap {
    width: 80%;
  }
}
</style>