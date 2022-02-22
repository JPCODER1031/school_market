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
      <el-form-item label-width="0" class="item" prop="username">
        <el-input
          type="text"
          v-model="ruleForm.username"
          placeholder="请输入用户名"
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item label-width="0" class="item" prop="password">
        <el-input
          type="password"
          v-model="ruleForm.password"
          placeholder="请输入密码"
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item label-width="0" class="item" prop="checkpassword">
        <el-input
          type="password"
          v-model="ruleForm.checkpassword"
          placeholder="请输入确认密码"
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item label-width="0" class="item" prop="nickname">
        <el-input
          type="text"
          v-model="ruleForm.nickname"
          placeholder="请输入昵称"
          required
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item label-width="0" class="item" prop="branch">
        <el-input
          type="text"
          v-model="ruleForm.branch"
          placeholder="请输入分院"
          required
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')"
          >注册</el-button
        >
        <el-button @click="resetForm('ruleForm')">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  data() {
    
    var validateName = (rule, value, callback) => {
      if (!value) {
        return callback(new Error("账号不能为空"));
      } else if (value.length > 12 || value.length < 8) {
        return callback(new Error("账号不能小于8位且不能大于12位"));
      } else {
        callback();
      }
    };
    var validateNickName = (rule, value, callback) => {
      let reg = /\<|\>/g;
      if (!value) {
        return callback(new Error("昵称不能为空"));
      } else if (reg.test(value)) {
        return callback(new Error("不能出现<或者>括号"));
      } else {
        callback();
      }
    };
    var validateBranch = (rule, value, callback) => {
      if (!value) {
        return callback(new Error("分院不能为空"));
      } else {
        callback();
      }
    };
    var validatePass = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        if (this.ruleForm.checkpassword !== "") {
          this.$refs.ruleForm.validateField("checkpassword");
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.ruleForm.password) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
      ruleForm: {
        username: "",
        password: "",
        checkpassword: "",
        nickname: "",
        branch: "",
      },
      rules: {
        username: [
          { required: true, validator: validateName, trigger: "blur" },
        ],
        password: [
          { required: true, validator: validatePass, trigger: "blur" },
        ],
        checkpassword: [
          { required: true, validator: validatePass2, trigger: "blur" },
        ],
        nickname: [
          { required: true, validator: validateNickName, trigger: "blur" },
        ],
        branch: [
          { required: true, validator: validateBranch, trigger: "blur" },
        ],
      },
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          console.log(this.ruleForm)
           this.$axios({
             url:'/user/registerUser',
             method:'post',
             data:{
               resetForm:this.ruleForm
             }
           }).then(res=>{
             if(res.data.code==200){
      this.$confirm(res.data.msg, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning',
          center: true
        }).then(() => {
            this.$router.push('/loginc')
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消'
          });
        });
      
             }else{
                 this.$message({
                   type:'error',
                   message:res.data.msg
               })
             }
           })
        } else {
           this.$message({
             type:'error',
             message:'请检查填入信息是否符合规范!'
           })
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
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
</style>
