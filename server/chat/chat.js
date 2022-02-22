const conn=require('../mysqlconfig.js');//数据库连接
const main=require('../index.js');//zhu
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
let sql='';
module.exports=function(socket){
   
   socket.on('setSocket',function(data){
        socket.id=data.u_id;
        console.log(socket.id)
   })
    //测试
    socket.on('disconnect',function(){
            console.log('用户下线',socket.id)
    });
   socket.on('login',function(data){
       socket.emit('sendmsg',data);  
   })
   //获取用户列表
   socket.on('getChatList',function(data){
     
       sql=`select U.u_id,U.u_avatar,U.u_nickname,U.u_class,FL.fl_id from user as U left join friend_lists as FL on FL.fl_u_id=U.u_id where U.u_id in (select fl_u_id from friend_lists where u_id=${data.u_id}) GROUP BY U.u_id HAVING  count(*)>1 or count(*)=1`;
       conn.query(sql,function(err,result){
           if(err){
               console.log(err);
               socket.emit('getChatList',{
                   code:-200,
                   msg:'数据库内部错误!'
                }); 
           }else{
            socket.emit('getChatList',{
                code:200,
                msg:'好友列表获取成功!',
                result:result
             }); 
           }
       })
   })
   //获取用户一对一聊天信息
   socket.on('getChatLog',function(data){
    
       sql=`select cl_id,send_u_id,recv_u_id,send_time,send_content from chat_log WHERE (send_u_id=${data.send_u_id} and recv_u_id=${data.recv_u_id}) or (send_u_id=${data.recv_u_id} and recv_u_id=${data.send_u_id}) order by send_time asc;`
       conn.query(sql,function(err,result){
           if(err){
               console.log(err);
               socket.emit('getChatLog',{
                   code:-200,
                   msg:'获取一对一聊天失败!'
               })
           }else{
               socket.emit('getChatLog',{
                   code:200,
                   msg:'一对一聊天信息查询成功!',
                   result:result
               })
              
           }
       })
   })
   //删除聊天列表
   socket.on('deleteChatList',function(data){
       sql=`delete from friend_lists where u_id=${data.u_id} and fl_u_id=${data.chat_item_u_id}`;
       conn.query(sql,function(err,result){
           if(err){
               console.log(err);
               socket.emit('deleteChatList',{
                   code:-200,
                   msg:'删除聊天列表失败!'
               })
           }else{
               socket.emit("deleteChatList",{
                   code:200,
                   msg:'删除成功!'
               })
           }
       })
   })
   //消息发布
   socket.on('pubMessages',function(data){
       console.log(data)
       //添加消息进数据库
       sql=`insert into chat_log(send_u_id,recv_u_id,send_time,send_content) values(${data.send_u_id},${data.recv_u_id},'${getNowTime()}','${data.message}')`;
       conn.query(sql,function(err,result){
           if(err){
               console.log(err);
               socket.broadcast.to(data.recv_u_id).emit('pubMessage',{
                     code:-200,
                     msg:'消息发送失败!',
                     ID:data.recv_u_id
               })
           }else{
            socket.broadcast.to(data.recv_u_id).emit('pubMessage',{
                code:200,
                msg:'消息发送成功!',
                ID:data.recv_u_id
          })
           }
       })
       //查询最后一条数据库聊天信息
       sql=`select * from chat_log where (send_u_id=${data.send_u_id} and recv_u_id=${data.recv_u_id}) or(send_u_id=${data.recv_u_id} and recv_u_id= ${data.send_u_id} )  order by send_time desc limit 1`;
       conn.query(sql,function(err,result){
           if(err){
               console.log(err),
               socket.broadcast.to(data.recv_u_id).emit('getNowNews',{
                   code:-200,
                   msg:'获取新消息失败!',
                   ID:data.recv_u_id
               });    
           }else{
            socket.broadcast.emit('getNowNews',{
                code:200,
                msg:'获取新消息成功!',
                result:result,
                ID:data.recv_u_id
            })
            
           }
       })
   })
}