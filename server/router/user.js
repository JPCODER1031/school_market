const express=require('express');
const router=express.Router();//为后端加入后端路由
const conn=require('../mysqlconfig.js');//数据库连接
const rsa=require('../utils/rsa.js');
const jwt=require('../utils/jwt.js');//签发token命令js
const formidable=require('formidable');
const path=require('path');
const fs=require('fs');
const { consumers } = require('stream');
// const cookieParser = require('cookie-parser');
let sql='';//数据库查询语句；
//将查询到得结果转换为json字符串形式
const responseJSON=function(res,ret){
  if(typeof ret=="undefined"){
      res.json({
          code:"-200",
          msg:'操作失败',
      })
  }else{
      res.json(ret)
  }
};
//获取当前时间
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
  //时间转换
  function rTime(date) {
    var json_date = new Date(date).toJSON();
    return new Date(new Date(json_date) + 8 * 3600 * 1000).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '') 
  }
  //数据库出现err
  function senderror(err,res){
    console.log(err);
           res.json({
             code:-200,
            msg:'操作失败!'
           })
  }
// router.use(cookieParser());
//验证cookie中得token
// router.use(jwt.verifyToken())
//功能测试
router.get('/',function(req,res){
    sql='select *from user';
    conn.query(sql,function(err,result){
    responseJSON(res,result);
   });
})
//注册用户
router.post('/registerUser',function(req,res){
  let data=req.body;
  console.log(data);
  sql=`select u_name from user where u_name='${data.resetForm.username}'`
  conn.query(sql,function(err,result){
    if(err){
      console.log(err)
      senderror(err,res)
    }else{
      if(result.length==0){
        adduser()
      }else{
        res.json({
          code:-200,
          msg:'用户名已存在请换个！'
        })
      }
    }
  })
  function adduser(){
    sql=`insert into user(u_name,u_password,u_nickname,u_branch_courts) values('${data.resetForm.username}','${data.resetForm.password}','${data.resetForm.nickname}','${data.resetForm.branch}')`;
     conn.query(sql,function(err,result){
       if(err){
         console.log(err);
         senderror(err,res)
       }else{
         res.json({
           code:200,
           msg:'注册成功!去登陆吧'
         })
       }
     })
  }
})
//发送公钥
router.get('/getPublicKey',function(req,res){
     rsa.public_key(res);
})
//接受发过来得加密数据并验证登录
router.post('/validateLogin',function(req,res){
   let user= rsa.validateLogin(req,res);
   sql=`select *from user where u_name="${user.username}" and u_password="${user.password}"`;
   conn.query(sql,function(err,result){
     if(err){
        console.log(err);
     }else{
         if(result.length==0){
             console.log(1)
        res.send({
            code:"-200",
            msg:"用户名或密码错误!"
        })
         } else{
           
            res.send(result)
        }
     }
   })
   

})  
//修改用户密码
router.post('/updatePassword',function(req,res){
    let data=req.body;
    console.log(data);
    sql=`update user set u_password='${data.pass}' where  u_name='${data.u_name}'  and u_id='${data.u_id}'`
    conn.query(sql,function(err,result){
     if(err){
         console.log(err);
         res.json({
            code:'-200',
            msg:'密码修改失败!'
        })
     }else{
       res.json({
           code:'200',
           msg:'密码修改成功!'
       })
     }
    })
})
//修改用户基本信息
router.post('/updateBasicInfo',function(req,res){
    let data=req.body;
    sql=`update user set u_nickname='${data.u_nickname}',u_tel='${data.u_tel}',u_qq='${data.u_qq}',u_school='${data.u_school}',u_class='${data.u_class}',u_branch_courts='${data.u_branch_courts}' where u_name='${data.u_name}' and u_id=${data.u_id}`
    conn.query(sql,function(err,result){
        if(err){
            console.log(err);
            res.json({
               code:'-200',
               msg:'基本信息修改失败!'
           })
        }else{
          res.json({
              code:'200',
              msg:'基本信息修改成功!'
          })
        }
       })
})
//修改用户头像
router.post('/updateAvatar',function(req,res,next){
    let form = new formidable.IncomingForm();
    form.encoding = 'utf-8' // 编码
    form.keepExtensions = true // 保留扩展名
    form.uploadDir = path.join(__dirname, '../public/uploadImg/user/')
    form.multiples = true;
    form.parse(req,(err, fields, files)=>{
        if (err) {
            res.json({
                code:'-200',
                msg:'头像上传失败'
            })
            next(err)    
        }
        let imgObj=JSON.parse(JSON.stringify(files));
        console.log(imgObj);
        let suffix=imgObj.file.originalFilename.split('.').splice(-1);
        fs.renameSync( "./public/uploadImg/user/"+imgObj.file.newFilename, "./public/uploadImg/user/"+files.file.newFilename+'.'+suffix[0]);
        let imgName=files.file.newFilename+'.'+suffix[0];
        sql=`update user set u_avatar='${imgName}'`
        conn.query(sql,(err,result)=>{
          if(err){
              console.log(err)
          }else{
            res.json({
                code:'200',
                msg:'头像修改成功',
                imgName:files.file.newFilename+'.'+suffix[0]
            })
          }
        })
      
     
    })
})
//添加用户聊天列表
router.post('/addFriendList',function(req,res){
  let data=req.body
  console.log(data)
  if(data.u_id==data.chatListID){
    res.json({
      code:-200,
      msg:'不能添加自己进聊天列表!'
    })
  }else{
    addFriendList();
  }

  function addFriendList(){
    sql=`INSERT INTO friend_lists(u_id, fl_u_id) SELECT ${data.u_id},${data.chatListID} from friend_lists WHERE not EXISTS(SELECT u_id,fl_u_id FROM friend_lists WHERE u_id=${data.u_id} and fl_u_id=${data.chatListID}) LIMIT 1;
    INSERT INTO friend_lists(u_id, fl_u_id) SELECT ${data.chatListID},${data.u_id} from friend_lists WHERE not EXISTS(SELECT u_id,fl_u_id FROM friend_lists WHERE u_id=${data.chatListID} and fl_u_id=${data.u_id}) LIMIT 1;`
    conn.query(sql,function(err,result){
      if(err){
        console.log(err)
        res.json({
          code:-200,
          msg:'操作失败!'
        })
      }else{
       res.json({
         code:200,
         msg:'添加成功!'
       })
      }
    })
  }
  
})
module.exports=router;