<template>
  <div class="home">
    <Header></Header>
    <Main/>
  </div>
</template>

<script>
// @ is an alias to /src
import Header from "../components/home/Header";
import Main from "../components/home/Main"
export default {
  name: "Home",
  components: {Header,Main},
};
</script>
<style lang="less" scoped>
.home {
  width: 100%;
  display: flex;
  flex-flow: column nowrap;
  background: rgb(226, 238, 236);
}


</style>
