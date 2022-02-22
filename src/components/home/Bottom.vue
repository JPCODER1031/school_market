<template>
    <div class="bottom">
        <div>个人项目测试网站</div>
        <span> Copyright © www.jpyyds.fun All Rights Reserved.</span>
     <span> 备案号:蜀ICP备2021018308号-1</span> 
    </div>
</template>
<script>
export default {
    
}
</script>
<style lang="less" scoped>
.bottom{
    width: 100%;
    height: 8rem; 
    background: linear-gradient(to right top,#FFFFCC,@titlecolor ,@maincolor,#99CCFF);
    background-size:300%  300%;
    animation: happy 7s linear  infinite alternate;
    display: flex;
    flex-flow: column nowrap;
    justify-content: center;
    align-items: center;
 
}
@keyframes happy{
   from { background-position: 0 0; }
  to { background-position: 100% 0; }
}
</style>