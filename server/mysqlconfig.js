const mysql=require('mysql');
const mysqlConfig={
    host:'localhost',
    user:'root',
    password:'root',
    database:'school_market',
    charset:'utf8mb4',
    multipleStatements: true // 支持执行多条 sql 语句
}
const conn=mysql.createConnection(mysqlConfig);
conn.connect((err)=>{
    if(err){
        console.log("数据库连接失败！")
    }else{
        console.log("数据库连接成功！")
    }
})
module.exports=conn;
