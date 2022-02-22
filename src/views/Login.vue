<template>
  <div class="login">
    <h1>校园闲置物品交易平台</h1>
    <div class="main">
      <div class="nav">
        <router-link to="/loginc">登录</router-link>
        <router-link to="/registerc">注册</router-link>
      </div>
      <div class="content">
        <router-view />
      </div>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style lang="less" scoped>
.login {
  display: flex;
  flex-flow: column nowrap;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100vh !important;
  background: linear-gradient(to bottom,skyblue,rgb(255, 255, 255));
  background-size: cover;
}
.main {
  width: 25rem;

  background: rgba(255, 255, 255);
  display: flex;
  flex-flow: column nowrap;
  border-radius: 20px;
}
.nav {
  display: flex;
  :first-child {
    border-top-left-radius: 20px;
  }
  :last-child {
    border-top-right-radius: 20px;
  }
}
a {
  flex: 1;
  display: flex;
  justify-content: center;
  background: rgba(85, 197, 248, 0.815);
  text-decoration: none;
  font-size: 1rem;
  padding: 0.8rem;
  color: @maincolor;
}
h1 {
  color: rgb(136, 224, 4);
  font-size: 2rem;
  margin-bottom: 2rem;
  letter-spacing: 10px;
  display: flex;
  flex-flow: row nowrap;
  white-space: nowrap;
}
a:hover {
  color: rgb(54, 53, 53);
  background: @maincolor;
}
.content {
  flex: 1;
}
</style>
