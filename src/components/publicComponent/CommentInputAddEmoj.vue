<template>
  <div class="commentinputaddemoj">
    <div class="headportrait">
      <div class="block">
        <el-avatar
          :size="50"
          :src="USERIMGADDRESS+userInfo.u_avatar"
        ></el-avatar>
      </div>
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
        <span @click="toogleDialogEmoji">😃</span>
        <el-button size="mini" type="primary" @click="publishNeedorum">~咻~</el-button>
      </div>
      <VEmojiPicker
        v-show="emojIsshow"
        :style="{ width: '100%', height: '30rem' }"
        labelSearch="Search"
        lang="pt-BR"
        @select="onSelectEmoji"
        class="emojclass"
      />
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex'
export default {
  data() {
    return {
      commentContent: "",
      emojIsshow: false,
      USERIMGADDRESS:this.$globalVariable.USERIMG
    };
  },
  methods: {
    toogleDialogEmoji() {
      this.emojIsshow = !this.emojIsshow;
    },
    onSelectEmoji(emoji) {
      this.commentContent += emoji.data;
      this.emojIsshow = !this.emojIsshow;
    },
    publishNeedorum(){
      
      this.$emit('publishNeedorum',this.commentContent)
      this.commentContent=''
    }
  },
  computed:{
     ...mapState({
       userInfo:'userInfo'
     })
  }
};
</script>

<style lang="less" scoped>
.commentinputaddemoj {
  width: 100%;
  display: flex;
  flex-flow: row nowrap;
  box-shadow: 0.5rem 0.5rem 0.5rem @hoverbackground;
      border-radius: 0.5rem;
      padding: 1rem 1rem;
      background: white;
      overflow: hidden;
  .headportrait {
     flex:1;
        display: flex;
        justify-content: center;
        :first-child{
            margin-top:0.5rem; 
        }
  }
  
}
.commentinput {
    flex: 5;
    display: flex;
    flex-flow: column nowrap;
    justify-content: center;
    .commentinputchild{
     :nth-child(1) {
      background: url("../../assets/img/commentBack.webp");
      background-position: right center;
      background-repeat: no-repeat;
      border: none;
    }
    }
    
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
</style>