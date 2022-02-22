<template>
  <div class="headers">
      <ul>
        <li v-for="(item, index) in left">
          <el-image
            style="width: 3rem; height: 3rem"
            :src="item"
            fit="fit"
            :key="index"
          ></el-image>
        </li>
      </ul>
      <h2><slot></slot></h2>
      <ul>
        <li v-for="(item, index) in right">
          <el-image
            style="width: 3rem; height: 3rem"
            :src="item"
            fit="fit"
            :key="index"
          ></el-image>
        </li>
      </ul>
    </div>
</template>

<script>
export default {
    data(){
        return{
             left: [
        require("../../assets/img/needforum/erji.png"),
        require("../../assets/img/needforum/hudiejie.png"),
        require("../../assets/img/needforum/jisuanji.png"),
        require("../../assets/img/needforum/kuzi.png"),
      ],
      right: [
        require("../../assets/img/needforum/lanqiu.png"),
        require("../../assets/img/needforum/shangdian.png"),
        require("../../assets/img/needforum/taideng.png"),
        require("../../assets/img/needforum/xiangji.png"),
      ],
        }
    }
}
</script>

<style lang="less" scoped>

.headers{
  display: flex;
  flex-flow: row nowrap;
  align-items: center;
 ul {
    list-style-type: none;
    display: flex;
    flex-flow: row nowrap;
    justify-content: center;
    li {
      margin: 1rem 1rem;
    }
  }
  h2{
    font-size:2rem ;
    color: @titlecolorpluss;
    font-weight: 600;
    white-space: nowrap;
  }
}
</style>