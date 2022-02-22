const express=require('express');
const app=express();
const server=require('http').Server(app);//挂在服务
const port=process.env.PORT||3030;//获取端口
const io=require('socket.io')(server);//将服务挂载到soket上
const sockets=require('./chat/chat.js');//将自己写的聊天事件处理函数导入
const user=require('./router/user.js');//用户路由导入
const goods=require('./router/goods.js');//商品路由导入
const bodyParser = require('body-parser');//解析,用req.body获取post参数
const utils=require('./router/utils.js');//前端访问静态文件工具类
//请求头设置
app.all('*',function(req,res,next){
    res.header("Access-Control-Allow-Origin", req.headers.origin);
    res.header("Access-Control-Allow-Credentials",true);
    res.header('Access-Control-Allow-Headers', 'Content-Type, Content-Length, Authorization, Accept, X-Requested-With ');
    res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
    res.header("X-Powered-By",' 3.2.1')
    res.header("Content-Type", "application/json;charset=utf-8");
   if (req.method=="OPTIONS"){ //post请求返回
    res.sendStatus(200);
    }else{
        next();
    }
    
});
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use('/goods',goods);//将商品路由实例挂
app.use('/user',user);//将用户路由实例挂
app.use(express.static(__dirname + '/public'))//静态文件托管http://127.0.0.1:3030/uploadImg/61b5f5f310065a7e33eacde00.jpg
//聊天事件处理
io.on('connection',sockets)
server.listen(port,function(){
    console.log(`服务启动成功请访问:http://127.0.0.1:${port}`);
});
module.exports={
    io,
}


 
