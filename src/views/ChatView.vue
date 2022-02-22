<template>
  <div class="jwchat">
    <JwChat-index
     :taleList="tableList"
      @enter="bindEnter"
      v-model="inputMsg"
     :showRightBox="false"
     :winBarConfig="winBarConfig"
     scrollType="scroll"
     :config="config"
    >
    </JwChat-index>
    <!-- 
      v-model	输入框中的文字	String	-	""
      taleList	会话内容	Array	-	[]
      toolConfig	工具栏配置	Object	-	{}
      width	JwChat界面框宽度	string	-	750px
      height	JwChat界面框高度	string	-	570px
      config	组件配置	Object	-	{}
      scrollType	消息自动到低	String	scroll	noroll
      showRightBox	显示右边内容	Boolean	false	true
      winBarConfig	多窗口配置
      quickList   自动匹配快捷回复
      @enter	输入框点击就发送或者回车触发的事件	输入的原始数据
      @clickTalk	点击聊天框列中的用户和昵称触发事件	当前对话数据
     -->
  </div>
</template>

<script>
import {mapState} from 'vuex';
export default { 
  data() {
    return {
      USERIMG:this.$globalVariable.USERIMG,
      config: {
        id:0,
        img: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
        name: '购物聊天',
        dept: '请选择一个用户',
        callback: this.bindCover,
        historyConfig:{
          show: true,
          tip: '加载更多',
          callback: this.bindLoadHistory,
        }
        },

      // 输入框中的文字
      inputMsg: "",
       // 会话内容
      tableList:[],
      //多窗口配置
      winBarConfig:{
        active: "win00", // 当前选中
        width: "160px", // 宽度大小
        listHeight: "60px", // 单个高度
        //聊天列表用户设置
        list:[
          //  {
          //   id: "win00",
          //   img: "https://img1.baidu.com/it/u=2109725846,3376113789&fm=26&fmt=auto&gp=0.jpg",
          //   name: "JwChat",
          //   dept: "最简单、最便捷",
          //   readNum: 1,
          // },
          //   {
          //   id: "win11",
          //   img: "https://img1.baidu.com/it/u=2109725846,3376113789&fm=26&fmt=auto&gp=0.jpg",
          //   name: "顺溜",
          //   dept: "我就是帅",
          //   readNum: 0,
          // },
        ]
        ,
        callback: this.bindWinBar,
      },
   
     
      
    }
  },
  methods: {
    // 切换用户窗口，加载对应的历史记录
    bindWinBar(play = {}) {
      const { type, data = {} } = play;
      console.log('我看',play);
      //切换当前聊天用户
      if (type === "winBar") {
        const { id, dept, name, img } = data;
        this.config = { ...this.config, id, dept, name, img };
        //当前选中得id
        this.winBarConfig.active = id;
        this.getChatLog();
        console.log(id)
      }
      //删除列表
      if (type === "winBtn") {
        const { target: { id } = {} } = data;
        const { list } = this.winBarConfig;
       
        this.winBarConfig.list = list.reduce((pre, item) => {
          if (id != item.id) pre.push(item);
          return pre;
        }, []);
          this.deleteChatList(data)
      }
      
    },
     // 输入框点击就发送或者回车触发的事件
    bindEnter(e) {
      console.log(e);
      const msg = this.inputMsg;
      if (!msg) return;
      this.pubMessage(msg);
    
    },
    bindLoadHistory () {
      const history = new Array(3).fill().map((i, j) => {
        return {
          "date": "2020/05/20 23:19:07",
          "text": { "text": j + new Date() },
          "mine": false,
          "name": "JwChat",
          "img": "image/three.jpeg"
        }
      })
      let list = history.concat(this.list)
      this.list = list
      console.log('加载历史', list, history)
    },
    bindCover (type) {
      console.log('header', type)
    },
    //时间格式转化
    rTime(date) {
      var json_date = new Date(date).toJSON();
      return new Date(new Date(json_date) + 8 * 3600 * 1000).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '') 
    },
    //对象转换 
		rObject(obj){
			  let newobj={};
			  newobj.id=obj.u_id;
			  newobj.img=this.USERIMG+obj.u_avatar;
			  newobj.dept=obj.u_class;
			  newobj.name=obj.u_nickname;
        newobj.readNum=0;
			  return newobj;
		  },
    //获取用户聊天列表
    getChatList(){
      this.$socket.emit('getChatList',{
        u_id:this.userInfo.u_id
      });
      this.sockets.subscribe('getChatList', res => {
   
            let result=res.result.map(item=>{
              return  this.rObject(item)
           });
          this.$set(this.winBarConfig,'list',result) 
      })
    },
    //获取一对一用户聊天信息
     getChatLog(){
         this.$socket.emit('getChatLog',{
          send_u_id:this.userInfo.u_id,
          recv_u_id:this.winBarConfig.active
       });
       this.sockets.subscribe('getChatLog',res=>{
         if(res.result.length!=0){
           this.tableList=res.result.map(item=>{
             return{
          "date": this.rTime(item.send_time),
          "text": { "text": item.send_content},
          "mine": item.send_u_id==this.userInfo.u_id?true:false,
          "name": item.send_u_id==this.userInfo.u_id?this.userInfo.u_nickname:this.config.name,
          "img": item.send_u_id==this.userInfo.u_id?this.USERIMG+this.userInfo.u_avatar:this.config.img,
             }
           })
         }else{
           this.tableList=[];
         }
    
       })
      },
    //删除用户聊天列表
    deleteChatList(data){
      this.$socket.emit('deleteChatList',{
        u_id:this.userInfo.u_id,
        chat_item_u_id:data.target.id
      })
      this.sockets.subscribe('deleteChatList',res=>{
            console.log(res)
      })
    },
    //消息发送
    pubMessage(message){
    let getNowTime= function () {
    let dateTime
    let yy = new Date().getFullYear()
    let mm = new Date().getMonth() + 1
    let dd = new Date().getDate()
    let hh = new Date().getHours()
    let mf = new Date().getMinutes() < 10 ? '0' + new Date().getMinutes()
      :
      new Date().getMinutes()
    let ss = new Date().getSeconds() < 10 ? '0' + new Date().getSeconds()
      :
      new Date().getSeconds()
    dateTime = yy + '-' + mm + '-' + dd + ' ' + hh + ':' + mf + ':' + ss
   
    return dateTime
     };
    const msgObj = {
        date:getNowTime(),
        text: { text: message},
        mine: true,
        name: this.userInfo.u_nickname,
        img: this.USERIMG+this.userInfo.u_avatar,
         };
    this.tableList.push(msgObj);
    this.$socket.emit('pubMessages',{
         message:message,
         send_u_id:this.userInfo.u_id,
         recv_u_id:this.config.id
       })
       
    }
    //选择用户
  },
  computed:{
     ...mapState({
       userInfo:'userInfo'
     })
  },
  created(){
    
   
    this.sockets.subscribe('getNowNews',res=>{
         console.log(res)
        if(res.ID==this.userInfo.u_id){
         const msgObj = {
        date: this.rTime(res.result[0].send_time),
        text: { text: res.result[0].send_content},
        mine: res.result[0].send_u_id==this.userInfo.u_id?true:false,
        name: res.result[0].send_u_id==this.userInfo.u_id?this.userInfo.u_nickname:this.config.name,
        img: res.result[0].send_u_id==this.userInfo.u_id?this.USERIMG+this.userInfo.u_avatar:this.config.img,
         };
        this.tableList.push(msgObj);
         }
       });
    this.$socket.emit('setSocket',{
        u_id:this.userInfo.u_id,
    });
    this.getChatList();
  },
  mounted(){
    this.config.id=this.$route.query.active_id;
  },
  beforeDestroy(){
  this.sockets.unsubscribe('getNowNews')
    }
};
</script>

<style lang="less" scoped>
.jwchat{
    height: 100vh;
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  background: linear-gradient(to left top,#798dfa,#7ae8bd);
  display: flex;
  justify-content: center;
  align-items: center;

}
</style>