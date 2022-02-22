const multer=require("multer");
const path=require("path");
const {v4:uuidv4} =require('uuid');
const storage=multer.diskStorage({
//destination：字段设置上传路径，可以为函数
destination: path.resolve(__dirname, '../upload'),

//filename：设置文件保存的文件名
filename: function(req, file, cb) {
    let extName = file.originalname.slice(file.originalname.lastIndexOf('.'))
    let fileName =uuidv4();
    cb(null, fileName + extName)
}
})
//设置过滤规则（可选）
var imageFilter = function(req, file, cb){
    var acceptableMime = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif']
    //微信公众号只接收上述四种类型的图片
    if(acceptableMime.indexOf(file.mimetype) !== -1){
        cb(null, true)
    }else{
        cb(null, false)
    }
}
const upload=multer({
    storage,
    fileFilter:imageFilter,
}).array('photos',5);//定义表单字段，数量闲置未5