<template>
  <div class="main">
     <Left></Left>
     <router-view/>
     <Right></Right>
  </div>
</template>

<script>
import Left from "./main/Left";
import Center from "./main/Center";
import Right from "./main/Right";
export default {
  components:{
      Left,
      Right,
      Center
  }

}
</script>

<style lang="less" scoped>
.main{
  width: 100%;
  display: flex;
  flex-flow:row nowrap;
   background: rgb(226, 238, 236);
   padding-bottom: 0.7rem;
}
</style>