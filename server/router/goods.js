const express=require('express');
const router=express.Router();//为后端加入后端路由
const conn=require('../mysqlconfig.js');//数据库连接
const upload=express('../utils/upload.js');//mutler文件解析
const formidable=require('formidable');
const path=require('path');
const fs=require('fs');
const { json } = require('body-parser');
const { query } = require('../mysqlconfig.js');
let sql='';//数据库语句初始化
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
router.get('/test',function(req,res){
    res.send("测试数据");
})
//搜索
router.get('/searchProducts',function (req,res) {
  let data=req.query;
  console.log(data)
  sql=`select * from goods where g_name like '%${data.searchContent}%' or g_desc like '%${data.searchContent}%' and is_delete=1`;
  conn.query(sql,function(err,result){
    if(err){
      console.log(err)
      res.json({
        code:-200,
        msg:'查询失败!'
      })
    }else{
      res.json({
        code:200,
        msg:'查询成功!',
        result:result
      })
    }
  })
  })
//请求求购列表
router.get('/getNeedForum',function(req,res){
  sql=`select AB.ab_id,AB.ab_title,AB.ab_content,AB.ab_price,AB.ab_address,AB.ab_date,U.u_avatar,U.u_tel,U.u_nickname,U.u_qq from ask_buy as AB left join user as U on U.u_id=AB.u_id`
  conn.query(sql,function(err,result){
        if(err){
            senderror(err,res);
        }else{
            res.json({
                code:200,
                result:result,
                msg:'求购列表请求成功!'
            })
        }
  }) 
})
//商品求购发布
router.post('/publishAskToBuy',function(req,res){
     let data=req.body;
     console.log(data);
     sql=`insert into ask_buy(ab_title,ab_content,ab_address,ab_price,ab_date,u_id) values('${data.askToBuyForm.name}','${data.askToBuyForm.desc}','${data.askToBuyForm.address}',${data.askToBuyForm.price},'${getNowTime()}',${data.u_id}) `;
     conn.query(sql,function(err,result){
       if(err){
        senderror(err,res);
       }else{
        res.json({
          code:200,
          msg:'商品求购发布成功'
        }) 
       }
     })
})
//商品求购快捷发布
router.post('/quickPublishAskToBuy',function(req,res){
      let data=req.body;
      let commentContent=data.commentContent;
      console.log(commentContent)
      let commentContentTitle=commentContent.slice(0,7);

      sql=`select *from user where u_id=${data.u_id}`
      conn.query(sql,function(err,result){
        if(err){
         senderror(err,res);
        }else{
            addAskToNuy(result[0])
        }
      })
      function addAskToNuy(ret){
        sql=`insert into ask_buy(ab_title,ab_content,ab_address,ab_price,ab_date,u_id) values ('${commentContentTitle}','${commentContent}','${ret.u_school+ret.u_branch_courts}',${999},'${getNowTime()}',${data.u_id})`;
        conn.query(sql,function(err,result){
             if(err){
               senderror(err,res);
             }else{
               res.json({
                 code:200,
                 msg:"快捷求购信息发布成功!"
               })
             }
        })
      }
     
      console.log(data);
})
//商品图片上传
router.post('/uploadImg',function(req,res,next){
    let form = new formidable.IncomingForm();
    form.encoding = 'utf-8' // 编码
    form.keepExtensions = true // 保留扩展名
    form.uploadDir = path.join(__dirname, '../public/uploadImg/goods/')
    form.multiples = true;
    form.parse(req, (err, fields, files) => {
      if (err) return next(err);
      let imgObj=JSON.parse(JSON.stringify(files));
      console.log(imgObj.file.originalFilename);
      let suffix=imgObj.file.originalFilename.split('.').splice(-1);
      // console.log(imgObj)
      // console.log(suffix);
      // console.log(imgObj.file.filepath)
      fs.renameSync( "./public/uploadImg/goods/"+imgObj.file.newFilename, "./public/uploadImg/goods/"+files.file.newFilename+'.'+suffix[0]);
      res.json(files.file.newFilename+'.'+suffix[0])
    })
  }
)
//商品发布
router.post('/publishGood',function(req, res, next) {
  let data=req.body;
  
  
  sql=`insert into goods(g_name,g_desc,classify,g_img,oldprice,nowprice,u_id,g_daysremaining,g_pubdate) values ('${data.name}','${data.desc}',${data.classifyvalue},'${data.imgArr}',${data.oldprice},${data.nowprice},${data.u_id},'${data.daysremaining}','${getNowTime()}')`
  conn.query(sql,function(err,result){
    if(err){
      console.log(err)
   
        res.json({
            code:"-200",
            msg:'商品添加失败',
        })
    }else{
        res.json({
          code:"200",
          msg:'商品添加成功',
      })
    }
    
  })
    
 
})
//获取全部商品信息
router.get('/getGoods',function(req,res,next){
  sql='select *from goods where is_delete=1 and g_state=1'
  conn.query(sql,function(err,result){
   if(err){
     console.log(err);

   }else{
     res.send(result)
   }
  })
})
//获取商品详细信息
router.get('/getProductDetails',function(req,res,next){
 
  sql=`select G.u_id,G.g_name,G.oldprice,G.nowprice,G.g_img,G.g_pubdate,U.u_school,U.u_branch_courts,U.u_name,U.u_nickname from goods as G LEFT JOIN user as U on G.u_id=U.u_id where G.g_id=${req.query.productID}`
  conn.query(sql,function(err,result){
    if(err){
      console.log(err);
    }else{
      responseJSON(res,result);
    }
  })
  
})
//发表商品评论
router.post('/pubComment',function(req,res){
   let data=req.body;
  sql=`insert into comments(c_content,c_pubdate,u_id,g_id) values ('${data.c_content}','${getNowTime()}',${data.u_id},${data.g_id})`;
  conn.query(sql,(err,result)=>{
    if(err){
      console.log(err)
      res.json({
        code:'-200',
        msg:'评论发表失败'
      })
    }else{
      res.json({
        code:'200',
        msg:'评论发表成功'
      })
    }
  })
 
})
//请求商品评论
router.get('/productDetaileComments',function(req,res){
  let productID=req.query.productID;

sql=`select U.u_avatar,U.u_nickname,C.c_pubdate,C.c_content from comments as C left join user as U on C.u_id=U.u_id where C.g_id=${productID}`;
 conn.query(sql,function(err,result){
   if(err){
     console.log(err)
   }else{
   res.json(result);
   }
 })
})
//获取用户是否收藏这件商品
router.get('/isCollect',function(req,res){
  
     let data=req.query;
     sql=`select * from collect where u_id=${data.u_id} and g_id=${data.g_id}`
     conn.query(sql,function(err,result){
       if(err){
         console.log(err);
         res.json({
           code:'-200',
           msg:'是否收藏获取失败'
         })
       }else{
         if(result.length!=0){
             res.json({
               code:'200',
               isCollect:true,
             })
         }else{
          res.json({
            code:'200',
            isCollect:false,
          })
         }
        
       }
     })
})
//用户添加收藏
router.get('/addCollect',function(req,res){
   let data=req.query;
   sql=`insert into collect(u_id,g_id) values(${data.u_id},${data.g_id})`
   conn.query(sql,function(err,result){
     if(err){
       console.log(err)
       res.json({
        code:'-200',
        msg:'收藏失败'
      })
     }else{
      res.json({
        code:'200',
        msg:'收藏成功'
      })
     }

   })
})
//取消收藏
router.get('/cancelCollect',function(req,res){
  let data=req.query;
  sql=`delete from collect where u_id=${data.u_id} and g_id=${data.g_id}`
  conn.query(sql,function(err,result){
    if(err){
      console.log(err)
      res.json({
       code:'-200',
       msg:'取消收藏失败!'
     })
    }else{
     res.json({
       code:'200',
       msg:'取消收藏成功!'
     })
    }

  })
})
//获取收藏列表
router.get('/getCollects',function(req,res){
  
  let data=req.query;
  sql=`select G.g_img,G.g_name,G.nowprice,G.g_id from collect as C left join goods as G on C.g_id=G.g_id where C.u_id=${data.u_id}`;
  conn.query(sql,function (err,result) {
     if(err){
       console.log(err);
       res.json({
         code:'-200',
         msg:'收藏列表获取失败!'
       })
     }else{
       if(result.length==0){
         res.json({
           code:'200',
           msg:'没有数据',
           collect:undefined,
         })
       }else{
         res.json({
           code:'200',
           msg:'查询成功',
           collect:result,
         })
       }
     }
    })
})
//删除收藏
router.post('/removeCollect',function(req,res){
  console.log(req.body);
  let data=req.body;
  sql=`delete from collect where u_id=${data.u_id} and g_id=${data.g_id}`
  conn.query(sql,function(err,result){
    if(err){
      console.log(err)
      res.json({
       code:'-200',
       msg:'取消收藏失败!'
     })
    }else{
     res.json({
       code:'200',
       msg:'取消收藏成功!'
     })
    }

  })
})
//获取购物车列表
router.get('/getShoppingCart',function(req,res){
  let u_id=req.query.u_id;
  sql=`select SC.sc_id,SC.g_id,G.g_img,G.g_name,G.nowprice from shopping_cart as SC left join goods AS G on SC.g_id=G.g_id where SC.u_id=${u_id} `;
  conn.query(sql,function(err,result){
   if(err){
     console.log(err);
     res.json({
      code:'-200',
      msg:'购物车列表查询失败!'
    })
   }else{
    if(result.length==0){
      res.json({
        code:'200',
        msg:'没有数据',
        shoppingCart:undefined,
      })
    }else{
      res.json({
        code:'200',
        msg:'查询成功',
        shoppingCart:result,
      })
    }
   }
  })
})
//商品添加购物车
router.post('/addShoppingCart',function(req,res){
  let data=req.body;
  sql=`insert into shopping_cart(u_id,g_id) values(${data.u_id},${data.g_id})`
  conn.query(sql,function(err,result){
    if(err){
      console.log(err)
      res.json({
        code:'-200',
        msg:'加入购物车失败!'
      })
    }else{
      res.json({
        code:'200',
        msg:'加入购物车成功',
      })
    }
  })
  console.log(data);
})
//单个删除购物车
router.post('/deleteShoppingCartItem',function(req,res){
  let data=req.body;

  sql=`delete from shopping_cart where sc_id=${data.sc_id} and u_id=${data.u_id}`;
  conn.query(sql,function(err,result){
    if(err){
      console.log(err);
      res.json({
        code:'-200',
        msg:'删除失败',
      })
    }else{
      res.json({
        code:'200',
        msg:'删除成功',
      })
    }
  })

})
//购物车加入收藏单项
router.post('/addCollect',function(req,res){
  let data=req.body;
  console.log(req.body)
  sql=`select * from collect where g_id=(select g_id from shopping_cart where sc_id=${data.sc_id}) and u_id=${data.u_id}`;
  //检查是否已加入收藏列表
  conn.query(sql,function(err,result){
       if(err){
         console.log(err);
         res.json({
           code:'-200',
           msg:'预期外的的错误'
         })
       }else{
     
        if(result.length==0){
          addCollect();
        }else{
          res.json({
            code:'-200',
            msg:'收藏列表已存在',
          })
        }
       }
  
    })
    //添加收藏
   function addCollect(){
    sql=`insert into collect(g_id,u_id) values ((select g_id from shopping_cart where sc_id=${data.sc_id}),${data.u_id})`;
    conn.query(sql,function(err,result){
      if(err){
        console.log(err);
        res.json({
          code:'-200',
          msg:'加入收藏列表失败!'
        })
      }else{
        res.json({
          code:'200',
          msg:'加入收藏列表成功!'
        })
      }
    })
   }
  
})
//批量删除购物车
router.post('/deleteShoppingCarts',function(req,res){
  let data=req.body;
   sql=`delete from shopping_cart where u_id=${data.u_id} and sc_id in (${data.sc_ids.toString()})`;
   conn.query(sql,function(err,result){
     if(err){
       console.log(err);
       res.json({
         code:'-200',
         msg:'删除失败!'
       })
     }else{
       res.json({
        code:'200',
        msg:'删除成功!'
       })
     }
   })
 
})
//批量加入收藏
router.post('/addCollects',function(req,res){
  let data=req.body;
  console.log(data)
  sql=`select * from collect WHERE g_id in(select g_id from shopping_cart where sc_id in (${data.sc_ids.toString()}) and u_id=${data.u_id}) and u_id=${data.u_id}`;
  conn.query(sql,function(err,result){
    if(err){
      console.log(err);
      res.json({
        code:'-200',
        msg:'数据库内部错误!请让后端检查！'
      })
    }else{
       if(result.length!=0){
        res.json({
          code:'-200',
          msg:'你选择的商品有的或许已加入收藏,请仔细检查!'
        })
       }else{
        addCollects(data);
       }

    }
  })
  //全部加入收藏
  function addCollects(info){
    sql=`insert into collect(g_id,u_id) select g_id,u_id from shopping_cart where sc_id in (${info.sc_ids.toString()}) and  u_id=${info.u_id}`;
    conn.query(sql,function(err){
      if(err){
        console.log(err);
         res.json({
         code:'-200',
         msg:'添加收藏失败!'
      })
      }else{
        res.json({
          code:'200',
          msg:'商品添加成功!'
        })
      }
    })
  }
})
//商品移除收藏并加入购物车
router.post('/addShoppingAndRemoveCollect',function(req,res){
  let data=req.body;
  sql=`delete from collect where g_id=${data.g_id} and u_id=${data.u_id}`
  conn.query(sql,function(err,result){
    if(err){
      console.log(err);
      res.json({
        code:'-200',
        msg:'操作失败!'
      })
    }else{
      addShoppingCart(data)
    }
  })
  //添加购物车
  function addShoppingCart(info){
    sql=`insert into shopping_cart(u_id,g_id) values(${info.u_id},${info.g_id})`
    conn.query(sql,function(err,result){
      if(err){
        console.log(err)
        res.json({
          code:'-200',
          msg:'操作失败!'
        })
      }else{
        res.json({
          code:'200',
          msg:'操作成功!',
        })
      }
    })
  }
  console.log(data)
})
//获取购买订单
router.post('/getBuyOrder',function(req,res){
  let data=req.body;
  console.log(data)
  sql=`select O.o_date,O.o_id,U.u_nickname,G.g_img,G.g_name,O.address,O.o_status from orders as O inner join user as U on U.u_id=O.seller_id inner join goods as G on G.g_id=O.g_id where O.buyer_id=${data.u_id}`
  conn.query(sql,function(err,result){
    if(err){
      console.log(err);
      res.json({
        code:-200,
        msg:'数据库异常!'
      })
    }else{
      if(result.length==0){
        res.json({
          code:200,
          result:result,
          msg:'查询成功,但是没有数据!'
        })
      }else{
        res.json({
          code:200,
          result:result,
          msg:'查询成功!'
        })
      }
     
    }
  })
})
//获取出售订单
router.post('/getSellOrder',function(req,res){
  let data=req.body;
  sql=`select O.o_date,O.o_id,U.u_nickname,U.u_tel,G.g_img,G.g_name,O.address,O.o_status from orders as O inner join user as U on U.u_id=O.seller_id inner join goods as G on G.g_id=O.g_id where O.seller_id=${data.u_id}`
  conn.query(sql,function(err,result){
    if(err){
      console.log(err);
      res.json({
        code:-200,
        msg:'数据库异常!'
      })
    }else{
      if(result.length==0){
        res.json({
          code:200,
          result:result,
          msg:'查询成功,但是没有数据!'
        })
      }else{
        res.json({
          code:200,
          result:result,
          msg:'查询成功!'
        })
      }
    
    }
  })
})
//改变订单状态
router.post('/updateOrderStatus',function(req,res){
   let data=req.body;
   console.log(data)
   sql=`update orders set o_status=${data.orderStatus} where o_id=${data.o_id}`;
   conn.query(sql,function(err,result){
     if(err){
       console.log(err);
       res.json({
         code:-200,
         msg:'数据库错误,操作失败!'
       })
     }else{
       res.json({
         code:200,
         msg:'状态修改成功!'
       })
     }
   })
})
//立即购买
router.post('/buyNow',function(req,res){
  let data=req.body;
  console.log(data);
  sql=`insert into orders(g_id,buyer_id,seller_id,address,o_date)  values (${data.g_id},${data.userInfo.u_id},(select u_id from goods where g_id=${data.g_id}),'${data.userInfo.u_school+data.userInfo.u_branch_courts+data.userInfo.u_class}','${getNowTime()}');
      update goods set g_state=0 and is_delete=0 where g_id=${data.g_id}`;
  conn.query(sql,function(err,result){
    if(err){
     senderror(err,res);
    }else{
      res.json({
        code:200,
        msg:'购买成功!'
      })
    }
  })

})
//获取出售数量
router.get('/getSelledCount',function(req,res){
    sql=`select count(*) as nums from goods where g_state=0;`
    conn.query(sql,function(err,result){
      if(err){
        console.log(err)
        res.json({
          code:-200,
          msg:'出售数量查询失败!'
        })
      }else{
        console.log(result)
        res.json({
          code:200,
          msg:'出售数量查询成功!',
          nums:result[0].nums
        })
      }
    })
})
module.exports=router;