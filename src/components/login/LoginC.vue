<template>
  <div class="main">
    <el-form
      :model="ruleForm"
      status-icon
      size="medium"
      :rules="rules"
      ref="ruleForm"
      label-width="150px"
      class="demo-ruleForm"
    >
      <el-form-item label-width="0px" class="item" prop="username">
        <el-input
          type="text"
          v-model="ruleForm.username"
          placeholder="请输入用户名"
          required
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item label-width="0px" class="item" prop="password">
        <el-input
          type="text"
          v-model="ruleForm.password"
          placeholder="请输入密码"
          required
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item label-width="0px" class="item" prop="verifyCode">
        <div class="verify">
          <el-input
            type="text"
            style="width: 8rem"
            v-model="ruleForm.verifyCode"
            placeholder="请输入验证码"
            required
            autocomplete="off"
          ></el-input>
          <Sidentify v-if="isverify" ref="verify"></Sidentify>
        </div>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')"
          >登录</el-button
        >
        <el-button @click="resetForm('ruleForm')">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import Sidentify from "../publicComponent/Sidentify";
import "../../assets/js/rsa.js"
export default {
  components: {
    Sidentify,
  },
  provide() { //组件刷新
    return {
      reloadAll: this.reloadAll,
    };
  },
  data() {
    var validateName = (rule, value, callback) => {
      let reg = /\<|\>/g;
      if (!value) {
        return callback(new Error("昵称为空"));
      } else if (reg.test(value)) {
        return callback(new Error("不能出现<或者>括号"));
      } else {
        callback();
      }
    };
    var validatePassword = (rule, value, callback) => {
      let reg = /\<|\>/g;
      if (!value) {
        return callback(new Error("密码为空"));
      } else if (reg.test(value)) {
        return callback(new Error("不能出现<或者>括号"));
      } else {
        callback();
      }
    };
    var VCode = (rule, value, callback) => {
      let reg = /\<|\>/g;
      if (!value) {
        return callback(new Error("验证码为空"));
      } else if (reg.test(value)) {
        return callback(new Error("不能出现<或者>括号"));
      } else {
        callback();
      }
    };
    return {
      isverify: true, //控制验证码刷新
      ruleForm: {
        username: "",
        password: "",
        verifyCode: "",
      },
      rules: {
        username: [{ validator: validateName, trigger: "blur" }],
        password: [{ validator: validatePassword, trigger: "blur" }],
        verifyCode: [{ validator: VCode, trigger: "blur" }],
      },
    };
  },
  methods: {
    //登录表单提交
    submitForm(formName) {
      let _this=this;
      this.$refs[formName].validate(async (valid) => {
        //检查前端规则是否输入正确valid返回true\\false
        // console.log(this.$refs.verify.newstr)拿到子组件验证码的值
        if (valid) {
          //拿到密钥并封装密码
         let data= await this.$axios.get('/user/getPublicKey')
         let encrypt = new JSEncrypt();
              encrypt.setPublicKey(data.data.public_key) 
              const encryptKey =  encrypt.encrypt(this.ruleForm.password); //使用公钥加密，得到密文
          //将封装得密码发送给后端验证登录
          let loginResult=await this.$axios({
                url:'/user/validateLogin',
                method:'post',
                data:{
                  username: this.ruleForm.username,
                  password: encryptKey   //encryptKey 格式为base64
                }
                  
          });
          let text={   username: this.ruleForm.username,
                      password: encryptKey   //encryptKey 格式为base64
                  }
          if((loginResult.data.code!=-200)&&(_this.$refs.verify.newstr.join('')!=_this.ruleForm.verifyCode)){
            if(loginResult.data.msg==undefined){
              this.$message.error("验证码错误");
            }else{
      
               this.$message.error(loginResult.data.msg);
            }
          }else{
                   //将用户基本信息保存至vuex userINfo中
              this.$store.commit('setUserInfo', loginResult.data[0]);
              this.$router.push("/home/productlist")
          }
        } else {
         this.$message.error('请填写完整账号信息');
          return false;
        }
      });
    },
    resetForm(formName) {
      //重置表单方法
      this.$refs[formName].resetFields();
    },
    reloadAll() {
      this.isverify = false;
      this.$nextTick(() => {
        this.isverify = true;
      });
    },
  },
};
</script>

<style lang="less" scoped>
.main {
  display: flex;
  align-items: center;
  margin-top: 1rem;
}
.item {
  width: 100% !important;
}
.verify {
  display: flex;
  flex-flow: row nowrap;
  justify-content: space-between;
}
</style>
