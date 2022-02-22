<template>
  <div class="wantbuydialog">
    <el-dialog
      title="求购商品"
      :visible.sync="dialogVisble"
      :before-close="handleclose"
      width="60%"
      center
    >
      <slot name="main"></slot>
      <span slot="footer" class="dialog-footer">
        <el-button @click="handlecancel">取 消</el-button>
        <el-button type="primary" @click="handlepublish">马上发布</el-button
        >
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
    props:{
        wantBuyDialogIsShow:{
            type:Boolean,
            default:false,
        }
    },
     data() {
      return {
     
      };
    },
    methods:{
        handlecancel(){
            this.$emit("handlecancel")//取消按钮
        },
        handlepublish(){
            this.$emit("handlepublish")//确认发布按钮
        },
        handleclose(){
            this.$emit("handleclose")//关闭前的回调，会暂停 Dialog 的关闭
        }
    },
    computed:{
        dialogVisble:{
            get(){
        
                return this.wantBuyDialogIsShow;

            },
            set(val){
               
               this.$emit("getbuydialogshowstate",val)
            }
        }
    }
};
</script>

<style lang="less" scoped>
.wantbuydialog{
    box-sizing: content-box;
}
</style>