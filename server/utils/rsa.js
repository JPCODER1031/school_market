const NodeRSA=require('node-rsa');
const key=new NodeRSA({b:1024});//密钥长度为1024位
key.setOptions({encryptionScheme:"pkcs1"});//指定的加密格式
const public_key=function(res){
    res.send({ public_key: key.exportKey("pkcs8-public-pem")})
}
const validateLogin=function(req, res) {
        let data=req.body;
        let buff = data.password.replace(/\s+/g, '');
        key.importKey(key.exportKey('pkcs8-private-pem')); //导入私钥
        return {
            username:data.username,
            password:key.decrypt(buff, 'utf8')
        }
     
   
  }
module.exports={
    public_key,
    validateLogin

}