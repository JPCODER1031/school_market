var express = require('express');
const router=express.Router();//为后端加入后端路由
//将静态文件目录设置为：项目根目录+/public
router.use(express.static(__dirname + '/public'));
//或者
// app.use(express.static(path.join(__dirname, 'public')));
module.exports=router;