<template>
  <div class="personal">
    <div class="personal-header">
      <div class="headportrait">
        <div class="block">
          <el-upload
            class="avatar-uploader"
            action="http://127.0.0.1:3030/user/updateAvatar"
            :auto-upload="true"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload">
            
            <img v-if="imageUrl" :src="imageUrl" width="120rem"  class="avatar">
            <img v-else :src="imgAdress+userInfo.u_avatar" width="120rem" class="avatar">

</el-upload>
          <!-- <el-avatar
            shape="square"
            :size="100"
            src="http://127.0.0.1:3030/uploadImg/user/userdefault.jpg"
          ></el-avatar> -->
        </div>
      </div>
      <div class="divider"></div>
      <div class="summary">
        <span>已发布商品:{{ productPublished }}</span>
        <span>已出售商品:{{ productPublished }}</span>
        <span>正在出售商品:{{ productPublished }}</span>
        <span>已下架商品:{{ productPublished }}</span>
        <span>待求购商品:{{ productPublished }}</span>
        <span>已举报商品:{{ productPublished }}</span>
      </div>
    </div>
    <div class="personal-info">
      <div class="title">
        <span>个人资料</span>
      </div>
    </div>
    <div class="personal-content">
      <!-- 账户信息 -->
      <div class="divide">
        <el-divider content-position="left">账户信息</el-divider>
      </div>
      <div class="account-info">
        <ul>
          <li>
            <div>账户ID:</div>
            <span>{{ userInfo.u_id }}</span>
          </li>
          <li>
            <div>账号状态:</div>
            <span>{{ userInfo.u_state==0? '正常' : (userInfo.u_state==1? '警告' :(userInfo.u_state==2? '危险':'异常' ))}}</span>
          </li>
          <li>
            <div>学号:</div>
            <span>{{ userInfo.u_name}}</span>
          </li>
        </ul>
      </div>
      <!-- 密码管理 -->
      <div class="divide">
        <el-divider content-position="left">密码管理</el-divider>
        <div @click="changePass" class="password-update">编辑</div>
      </div>
      <div class="password-info">
        <el-form
          :model="passwordForm"
          status-icon
          :rules="rules"
          size="mini"
          :disabled="passwordForm.disabled"
          ref="passwordForm"
          label-width="0"
          class="demo-ruleForm"
        >
          <ul>
            <li>
              <div class="tags">原始密码:</div>
              <div class="passwordinput">
                <el-form-item prop="originalPassword"
                  ><el-input
                    v-model.number="passwordForm.originalPassword"
                  ></el-input
                ></el-form-item>
              </div>
            </li>
            <li>
              <div class="tags">新密码:</div>
              <div class="passwordinput">
                <el-form-item prop="pass"
                  ><el-input
                    type="password"
                    v-model="passwordForm.pass"
                    autocomplete="off"
                    show-password
                  ></el-input
                ></el-form-item>
              </div>
            </li>
            <li>
              <div class="tags">确认密码:</div>
              <div class="passwordinput">
                <el-form-item prop="checkPass"
                  ><el-input
                    type="password"
                    v-model="passwordForm.checkPass"
                    autocomplete="off"
                    @keyup.enter.native="submitPassword"
                    show-password
                  ></el-input
                ></el-form-item>
              </div>
            </li>
          </ul>
        </el-form>
      </div>
      <!-- 基本信息 -->
      <div class="divide">
        <el-divider content-position="left">基本信息</el-divider>
        <div @click="changeBasicInfo" class="password-update">编辑</div>
      </div>
      <div class="password-info">
        <el-form
          :model="basicForm"
          status-icon
          :rules="rules"
          size="mini"
          :disabled="basicForm.disabled"
          ref="basicForm"
          label-width="0"
          class="demo-ruleForm"
        >
          <ul>
            <li>
              <div class="tags">昵称:</div>
              <div class="passwordinput">
                <el-form-item
                  ><el-input
                    v-model="basicForm.u_nickname"
                  ></el-input
                ></el-form-item>
              </div>
            </li>
            <li>
              <div class="tags">手机:</div>
              <div class="passwordinput">
                <el-form-item 
                  ><el-input
                  
                    v-model="basicForm.u_tel"
                    autocomplete="off"
                   
                  ></el-input
                ></el-form-item>
              </div>
            </li>
            <li>
              <div class="tags">QQ:</div>
              <div class="passwordinput">
                <el-form-item 
                  ><el-input
                   
                    v-model="basicForm.u_qq"
                    autocomplete="off"
                 
                   
                  ></el-input
                ></el-form-item>
              </div>
            </li>
            <li>
              <div class="tags">学校:</div>
              <div class="passwordinput">
                <el-form-item 
                  ><el-input
                  
                    v-model="basicForm.u_school"
                    autocomplete="off"
                   
                  ></el-input
                ></el-form-item>
              </div>
            </li>
            <li>
              <div class="tags">班级:</div>
              <div class="passwordinput">
                <el-form-item 
                  ><el-input
                  
                    v-model="basicForm.u_class"
                    autocomplete="off"
                  
                  ></el-input
                ></el-form-item>
              </div>
            </li>
            <li>
              <div class="tags">学院:</div>
              <div class="passwordinput">
                <el-form-item 
                  ><el-input
                 
                    v-model="basicForm.u_branch_courts"
                    autocomplete="off"
                   @keyup.enter.native="submitBasicInfo"
                  ></el-input
                ></el-form-item>
              </div>
            </li>
          </ul>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
export default {
  
  data() {
    var oldPassword = (rule, value, callback) => {
      if (!value) {
        return callback(new Error("原始密码不能为空"));
      }
      setTimeout(() => {
        if (value != this.userInfo.u_password) {
          callback(new Error("密码错误"));
        } else {
          callback();
        }
      }, 1000);
    };
    var validatePass = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        if (this.passwordForm.checkPass !== "") {
          this.$refs.passwordForm.validateField("checkPass");
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.passwordForm.pass) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
      imgAdress:'http://127.0.0.1:3030/uploadImg/user/',
      imageUrl:'',
      productPublished: 0,
      //密码修改框
      passwordForm: {
        pass: "",
        checkPass: "",
        originalPassword: "",
        disabled: true,
      },
      basicForm: {
          nickName:"王孙盒子",
          tel:'13990857042',
          qq:'409653822',
          school:'西昌学院',
          class:'18计科班',
          branchCourts:"信息技术",
          disabled:true
      },
      rules: {
        pass: [{ validator: validatePass, trigger: "blur" }],
        checkPass: [{ validator: validatePass2, trigger: "blur" }],
        originalPassword: [{ validator: oldPassword, trigger: "blur" }],
      },
    };
  },
  methods: {
    changePass() {
      this.passwordForm.disabled = !this.passwordForm.disabled;
    },
    submitPassword() {
      // console.log(this.passwordForm);
      this.$refs.passwordForm.validate((valid) => {
          if (valid) {
              this.$axios({
        url:'/user/updatePassword',
        method:'post',
        data:{...this.passwordForm,u_name:this.userInfo.u_name,u_id:this.userInfo.u_id},
      }).then(data=>{
        if(data.data.code==200){
           this.$message({
          message: data.data.msg,
          type: 'success'
        });
        }else{
              this.$message({
          message: data.data.msg,
          type: 'error'
        });
        }
         
        console.log(data)
        this.$refs.passwordForm.resetFields();
      })
          } else {
            this.$message({
          message: '警告!请正确输入',
          type: 'warning'
        });
            return false;
          }
        });
    
    
    },
     submitBasicInfo() {
       this.$axios({
        url:'/user/updateBasicInfo',
        method:'post',
        data:this.basicForm,
       }).then(data=>{
        if(data.data.code==200){
           this.$message({
          message: data.data.msg,
          type: 'success'
        });
        }else{
              this.$message({
          message: data.data.msg,
          type: 'error'
        });
        }
       })
      console.log(this.basicForm);
     
    },
    changeBasicInfo(){
        this.basicForm.disabled=!this.basicForm.disabled;
    },
    initUserInfoFrom(){
      this.basicForm={...this.basicForm,...this.userInfo}
      console.log(this.userInfo);
    },
    //头像上传
    handleAvatarSuccess(res,flie){
      this.imageUrl = this.imgAdress+res.imgName;
      if(res.code==200){
      this.$message({
        type:'success',
        message:res.msg
      })
      }else{
          this.$message({
        type:'error',
        message:res.msg
      })
      }
     
    },
  //头像上传前的检测
    beforeAvatarUpload(file) {
    const isJPG = file.type === 'image/png' || file.type === 'image/jpg' || file.type === 'image/jpeg' || file.type === 'image/gif';;
    const isLt2M = file.size / 1024 / 1024 < 2;

    if (!isJPG) {
      this.$message.error('上传头像图片只能 jpg、png、gif 格式!');
    }
    if (!isLt2M) {
      this.$message.error('上传头像图片大小不能超过 2MB!');
    }
    return isJPG && isLt2M;
  }
    
    
  },

  computed:{
    ...mapState({
      userInfo:'userInfo',
    }),
   
  },
  created(){
   
  this.initUserInfoFrom();
   
   
  }
};
</script>

<style lang="less" scoped>
.personal {
  #warp();
}
.personal-header {
  width: 80%;
  display: flex;
  flex-flow: row nowrap;
  background: @maincolor;
  align-items: center;
  #boxshadow();
  .divider {
    display: flex;
    flex-flow: column nowrap;
    height: 100px;
    border: solid 2px @titlecolorpluss;
    margin-left: 1rem;
  }
  .summary {
    display: flex;
    flex-flow: column nowrap;
    font-size: 0.5rem;
    color: @titlecolorpluss;
    margin-left: 1rem;
  }
}
.personal-info {
  width: 80%;
  padding: 1rem;
  margin-top: 2rem;
  background: @maincolor;
  box-sizing: border-box;
  color: @maincolor;
  border-top: solid 2px @titlecolorpluss;
  border-radius: 0.5rem;
}
.title {
  :first-child {
    background: @titlecolorpluss;
    padding: 1rem;
  }
}
.personal-content {
  #boxshadow();
  margin-top: 1rem;
  background: @maincolor;

  .divide {
    display: flex;
    flex-flow: row nowrap;
    align-items: center;
    :first-child {
      background: @titlecolorpluss;
      color: @maincolor;
    }
    .password-update {
      display: flex;
      align-items: center;
      white-space: nowrap;
      line-height: -2rem;
      border: solid 1px @titlecolorpluss;
      height: 2rem;
      width: 3rem;
      text-align: center;
      justify-content: center;
      border-radius: 0.5rem;
      color: @titlecolorpluss;
      font-weight: 600;
      cursor: pointer;
    }
    :hover {
      background: @hoverbackground;
      color: @maincolor;
    }
  }
  .account-info {
    color: @homeleftfontcolor;
    ul {
      list-style-type: none;
      margin-left: 1.5rem;
      font-weight: 600;

      li {
        margin-top: 1rem;
        :first-child {
          width: 4rem;
          text-align: left;
          display: inline-block;
        }
        :last-child {
          margin-left: 2rem;
        }
      }
    }
  }
}

.password-info {
  color: @homeleftfontcolor;
  ul {
    list-style-type: none;
    margin-left: 1.5rem;
    font-weight: 600;

    li {
      display: flex;
      flex-flow: row nowrap;
      margin-top: 1rem;
      align-items: center;
      .tags {
        width: 4rem;
      }
      .passwordinput {
        width: 15rem;

        display: inline-block;
        margin-left: 2rem;
      }
    }
  }
}
</style>