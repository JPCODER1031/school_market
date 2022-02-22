const jwt=require("jsonwebtoken");

let generateToken=function(userObj){
    let secret="LVOEYOU";
  let token= 'Bearer'+jwt.sign(userObj,secret,{expiresIn:"1day"})//第一个参数是个用户对象不要存放隐私数据，第二个是加密的字符串;
  return token;
};
let  verifyToken=function(token){
   let secret="LVOEYOU";
  jwt.verify(token,secret,(erro,data)=>{
       console.log(data);
   })
}
module.exports={
//创建TOKEN持续对话
generateToken,
verifyToken,
}