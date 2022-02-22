import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import ProductList from "../components/home/main/Center.vue";
import store from "../store/index.js";
//以下代码解决路由地址重复点击的报错问题
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}
Vue.use(VueRouter);
//路由懒加载
const ProductDetails= () => import("../components/home/main/ProductDetails.vue");//商品详情
const NeedForum= () => import("../components/home/main/NeedForum.vue");//求购论坛
const Personal= () => import("../components/home/main/Personal.vue");//个人中心
const ShoppingCart=() => import("../components/home/main/ShoppingCart.vue");//购物车
const Collect=() => import("../components/home/main/Collect.vue");//收藏夹
const Order=() => import("../components/home/main/Order.vue");//订单
const Login=() => import( "../views/Login.vue")//登录主界面
const RegisterC=() => import("../components/login/RegisterC.vue")//注册组件
const LoginC= ()=>import("../components/login/LoginC");//登录逐渐
const ChatView=() => import("../views/ChatView.vue")//聊天界面
const routes = [{
    path: "/",
    name: "Home",
    component: Home,
    children: [{
        path: "/home/productdetails:productID",
        name: "productdetails", //替换为商品详细信息
        component: ProductDetails,
        meta:{
          requiresAuth:false
        }
      },
      {
        path: "/home/productlist",
        name: "productlist",
        component: ProductList, //主页中间center商品列表
        meta:{
          requiresAuth:false
        },
      },
      {
        path: "/home/needforum",
        name: "needforum", //求购论坛
        component:NeedForum ,
        meta:{
          requiresAuth:false
        },
      },
      {
        path: "/home/personal",
        name: "personal", //个人中心
        component:Personal,
        meta:{
          requiresAuth:true
        }
      },
      {
        path: "/home/shoppingcart",
        name: "shoppingcart", //购物车
        component:ShoppingCart,
        meta:{
          requiresAuth:true
        }
      },
      {
        path: "/home/collect",
        name: "collect", //收藏夹
        component:Collect ,
        meta:{
          requiresAuth:true
        }

      }, {
        path: "/home/order",
        name: "order", //订单
        component:Order ,
        meta:{
          requiresAuth:true
        }
      }
    ],
    redirect: "/home/productlist",
    meta:{
      requiresAuth:false
    }
  },
  {
    path: "/login",
    name: "Login",
    component:Login,
    children: [{
        path: "/loginc",
        name: "loginc",
        component: LoginC,
      },
      {
        path: "/registerc",
        name: "registerc",
        component:RegisterC,
      },
    ],
    redirect: "/loginc",
  },
  {
    path: "/chatview",
    name: "chatview",
    component: ChatView, //聊天界面跳转
    meta:{
      requiresAuth:true
    }
  },
];

const router = new VueRouter({
  routes,
});
router.beforeEach((to,from,next)=>{

     if(to.matched.some(r=>r.meta.requiresAuth)){
        if(store.getters.isLogin){
          next()
        }else{
          confirm('你还没有登录!')
        }
     }else{
       next();
     }
  
})
export default router;