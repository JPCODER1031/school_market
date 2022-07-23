/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : school_market

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 08/06/2022 23:12:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'http://127.0.0.1:3030/uploadImg/admin/admindefault.png',
  `status` int NULL DEFAULT 1 COMMENT '管理员状态:\r\n0:被冻结，\r\n1:正常，\r\n2:警告，\r\n3:危险',
  `identity` int NULL DEFAULT 1 COMMENT '管理员身份:\r\n0:测试用户，\r\n1:普通管理员，\r\n2:超级管理员',
  `sex` int NULL DEFAULT 1 COMMENT '0:女1:男',
  `tel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `qq` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账号创建的时间',
  `is_deleted` int NULL DEFAULT 1 COMMENT '假删除1表示未删除，0表示删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (2, 'commadmin', 'commadmin', 'commadmin', 'http://127.0.0.1:3030/uploadImg/admin/admindefault.png', 1, 1, 1, '2244242', '352', '2222@qq.com', '2022-03-07 16:03:28', 1);
INSERT INTO `admin` VALUES (3, 'test', 'test', 'test', 'http://127.0.0.1:3030/uploadImg/admin/admindefault.png', 1, 0, 0, '34343', '33433', 'emai.@sinla', '2022-03-07 16:03:26', 1);
INSERT INTO `admin` VALUES (4, 'username', '123', 'jack', 'http://127.0.0.1:3030/uploadImg/admin/admindefault.png', 1, 0, 0, '12433534', NULL, NULL, '2022-03-08 17:22:04', 0);
INSERT INTO `admin` VALUES (6, 'admin', 'admin', 'admin', 'http://127.0.0.1:3030/uploadImg/admin/54a3a52f6bfab6b857316cc00.jpg', 1, 2, 1, '123123', '123213', '409653822@qq.com', '2022-03-09 13:13:01', 1);

-- ----------------------------
-- Table structure for ask_buy
-- ----------------------------
DROP TABLE IF EXISTS `ask_buy`;
CREATE TABLE `ask_buy`  (
  `ab_id` int NOT NULL AUTO_INCREMENT COMMENT '求购ID',
  `ab_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ab_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ab_price` decimal(10, 2) NULL DEFAULT NULL,
  `ab_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ab_date` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `u_id` int NOT NULL,
  `is_deleted` int NULL DEFAULT 1 COMMENT '0为删除1存在',
  PRIMARY KEY (`ab_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ask_buy
-- ----------------------------
INSERT INTO `ask_buy` VALUES (2, '兵屯屯', '买个可爱的兵屯屯', 34.00, '杨管辖', '2022-05-16 12:58:51', 1000, 0);
INSERT INTO `ask_buy` VALUES (3, '火绒冗', '便宜带你', 22.00, '操场上', '2022-02-13 09:59:41', 1000, 1);
INSERT INTO `ask_buy` VALUES (4, '火绒冗', '便宜带你', 22.00, '操场上', '2022-02-13 10:00:57', 1000, 1);
INSERT INTO `ask_buy` VALUES (18, '我伟大时代阿三', '我伟大时代阿三打撒啊撒dasda😝', 999.00, '大肥羊学校未来科技', '2022-02-13 12:18:46', 1000, 1);
INSERT INTO `ask_buy` VALUES (19, '阿萨十大大苏打', '阿萨十大大苏打啊实打实的啊是大啊是大啊是大asd', 999.00, '大肥羊学校未来科技', '2022-02-13 12:21:04', 1000, 1);
INSERT INTO `ask_buy` VALUES (20, '你天天什么什么', '你天天什么什么什么模式的是多么的什么的😄', 999.00, '大肥羊学校未来科技', '2022-05-16 09:17:32', 1000, 0);
INSERT INTO `ask_buy` VALUES (24, '实时😃', '实时😃', 999.00, '大肥羊学校未来科技', '2022-05-08 11:53:26', 1000, 1);
INSERT INTO `ask_buy` VALUES (25, '王顺溜溜', '饿呃饿呃', 3333.00, '学校测试', '2022-05-15 21:15:40', 1002, 1);
INSERT INTO `ask_buy` VALUES (26, '士大夫', '士大夫', 33.00, '天天', '2022-05-10 09:17:58', 1002, 1);

-- ----------------------------
-- Table structure for chat_log
-- ----------------------------
DROP TABLE IF EXISTS `chat_log`;
CREATE TABLE `chat_log`  (
  `cl_id` int NOT NULL AUTO_INCREMENT COMMENT '聊天记录id',
  `send_u_id` int NULL DEFAULT NULL,
  `recv_u_id` int NULL DEFAULT NULL,
  `send_time` datetime NULL DEFAULT NULL,
  `send_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '保留字段',
  PRIMARY KEY (`cl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 307 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_log
-- ----------------------------
INSERT INTO `chat_log` VALUES (1, 1002, 1000, '2022-02-02 15:05:27', '在么？弟弟', NULL);
INSERT INTO `chat_log` VALUES (2, 1000, 1002, '2022-02-03 09:13:31', '干啥', NULL);
INSERT INTO `chat_log` VALUES (3, 1002, 1000, '2022-02-17 11:10:09', '洒洒水', NULL);
INSERT INTO `chat_log` VALUES (285, 1000, 1003, '2022-03-16 17:34:00', 'www', NULL);
INSERT INTO `chat_log` VALUES (286, 1000, 1002, '2022-03-16 17:34:10', 'www', NULL);
INSERT INTO `chat_log` VALUES (287, 1000, 1002, '2022-03-16 17:35:33', '22', NULL);
INSERT INTO `chat_log` VALUES (288, 1002, 1000, '2022-03-16 17:40:27', 'wwww', NULL);
INSERT INTO `chat_log` VALUES (289, 1000, 1002, '2022-03-16 17:42:24', 'www', NULL);
INSERT INTO `chat_log` VALUES (290, 1002, 1000, '2022-03-16 17:44:04', '333', NULL);
INSERT INTO `chat_log` VALUES (291, 1000, 1002, '2022-03-16 17:44:47', '55', NULL);
INSERT INTO `chat_log` VALUES (292, 1002, 1000, '2022-03-16 17:47:58', 'www', NULL);
INSERT INTO `chat_log` VALUES (293, 1002, 1000, '2022-03-16 17:48:21', 'wwww', NULL);
INSERT INTO `chat_log` VALUES (294, 1000, 1002, '2022-04-13 20:54:45', '3333', NULL);
INSERT INTO `chat_log` VALUES (295, 1000, 1002, '2022-04-16 17:53:12', '威威巍', NULL);
INSERT INTO `chat_log` VALUES (296, 1002, 1000, '2022-04-16 17:53:38', '/::8', NULL);
INSERT INTO `chat_log` VALUES (297, 1002, 1000, '2022-04-16 17:54:11', '2222', NULL);
INSERT INTO `chat_log` VALUES (298, 1000, 1002, '2022-04-17 16:10:57', '/:,@@你干啥啊', NULL);
INSERT INTO `chat_log` VALUES (299, 1000, 1002, '2022-05-08 11:55:23', 'www', NULL);
INSERT INTO `chat_log` VALUES (300, 1002, 1000, '2022-05-08 11:55:32', 'ghh /::L', NULL);
INSERT INTO `chat_log` VALUES (301, 1002, 1000, '2022-05-15 21:20:06', '/:<W>', NULL);
INSERT INTO `chat_log` VALUES (302, 1000, 1002, '2022-05-16 14:07:22', 'sssdsdsds/:>-|', NULL);
INSERT INTO `chat_log` VALUES (303, 1002, 1000, '2022-05-16 14:07:28', 'eee', NULL);
INSERT INTO `chat_log` VALUES (304, 1000, 1002, '2022-05-18 19:05:15', '111', NULL);
INSERT INTO `chat_log` VALUES (305, 1002, 1000, '2022-05-18 19:06:53', '宿舍', NULL);
INSERT INTO `chat_log` VALUES (306, 1002, 1000, '2022-05-19 09:52:35', '操场交易', NULL);
INSERT INTO `chat_log` VALUES (307, 1002, 1000, '2022-05-19 10:25:55', 'erereeerre', NULL);

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `cl_id` int NOT NULL AUTO_INCREMENT,
  `g_id` int NOT NULL COMMENT '商品id',
  `u_id` int NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`cl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (45, 9, 1002);
INSERT INTO `collect` VALUES (46, 8, 1002);
INSERT INTO `collect` VALUES (61, 7, 1002);
INSERT INTO `collect` VALUES (65, 17, 1000);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `c_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `c_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类容',
  `c_pubdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论发布时间',
  `u_id` int NOT NULL COMMENT '用户id',
  `g_id` int NULL DEFAULT NULL COMMENT '商品id',
  `parentid` int UNSIGNED NULL DEFAULT 0 COMMENT '为0是一级评论，\r\n其他则是父辈的ID',
  `replyid` int NULL DEFAULT 0 COMMENT '回复那个贴子的id\r\n0为没有回复一级帖子\r\n',
  `is_deleted` int NULL DEFAULT 1 COMMENT '0标识删除 1标识未删除',
  PRIMARY KEY (`c_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (5, '这个商品真是太好了', '2022-01-23 10:22:07', 1000, 7, 0, 0, 0);
INSERT INTO `comments` VALUES (6, '😄😆你妹的真的好！！！！', '2022-01-23 10:22:45', 1000, 7, 0, 0, 1);
INSERT INTO `comments` VALUES (7, 'wew😃', '2022-01-24 10:32:21', 1000, 7, 0, 0, 0);
INSERT INTO `comments` VALUES (8, '🎱', '2022-01-24 15:33:19', 1000, 7, 0, 0, 0);
INSERT INTO `comments` VALUES (9, '🕎🍠你干啥', '2022-01-24 15:33:47', 1000, 7, 0, 0, 0);
INSERT INTO `comments` VALUES (10, '再来一个😄', '2022-01-24 15:57:41', 1000, 7, 0, 0, 0);
INSERT INTO `comments` VALUES (11, '😃🏈', '2022-02-12 16:08:57', 1002, 7, 5, 5, 1);
INSERT INTO `comments` VALUES (12, '我的凶低叫顺溜😎', '2022-02-13 18:42:08', 1002, 4, 0, 0, 1);
INSERT INTO `comments` VALUES (13, '照样杀不\n', '2022-02-19 12:49:34', 1002, 9, 0, 0, 1);
INSERT INTO `comments` VALUES (14, '你好卡斯卡迪🖲', '2022-02-19 13:56:54', 1002, 8, 0, 0, 1);
INSERT INTO `comments` VALUES (15, '😂', '2022-03-04 20:39:59', 1000, 5, 0, 0, 1);
INSERT INTO `comments` VALUES (16, 'jjhsjdfsjfjsdhjfhjsdfj ', '2022-03-04 20:40:10', 1000, 7, 5, 12, 0);
INSERT INTO `comments` VALUES (17, '你好', '2022-03-14 10:26:56', 1000, 7, 5, 5, 1);
INSERT INTO `comments` VALUES (18, 'www威威巍', '2022-03-14 11:31:52', 1000, 7, 5, 11, 0);
INSERT INTO `comments` VALUES (19, '算速度', '2022-03-14 11:34:34', 1000, 7, 6, 6, 1);
INSERT INTO `comments` VALUES (20, '威威', '2022-03-14 11:34:40', 1000, 7, 6, 19, 0);
INSERT INTO `comments` VALUES (21, '二为惹人', '2022-03-14 15:21:12', 1000, 7, 5, 16, 0);
INSERT INTO `comments` VALUES (22, '😘', '2022-03-15 18:30:38', 1000, 9, 13, 13, 1);
INSERT INTO `comments` VALUES (23, 'ajsdasdasasd', '2022-04-13 20:53:38', 1000, 5, 0, 0, 1);
INSERT INTO `comments` VALUES (24, '333😃', '2022-04-13 20:53:58', 1000, 5, 15, 15, 1);
INSERT INTO `comments` VALUES (25, '🤣sdsd sads ', '2022-05-08 11:51:44', 1000, 7, 0, 0, 1);
INSERT INTO `comments` VALUES (26, 'sdsdsdsd 🏈', '2022-05-08 11:51:53', 1000, 7, 25, 25, 1);
INSERT INTO `comments` VALUES (27, '傻逼 我小学生', '2022-05-15 21:10:18', 1002, 9, 0, 0, 1);
INSERT INTO `comments` VALUES (28, '的顶顶顶', '2022-05-16 14:04:45', 1000, 9, 0, 0, 1);
INSERT INTO `comments` VALUES (29, '实打实打算😎', '2022-05-16 14:04:54', 1000, 9, 28, 28, 1);
INSERT INTO `comments` VALUES (30, '来购物罗😘💻', '2022-05-18 18:33:42', 1002, 17, 0, 0, 1);
INSERT INTO `comments` VALUES (31, '哈哈☪️💙', '2022-05-18 18:34:16', 1000, 17, 0, 0, 1);
INSERT INTO `comments` VALUES (32, '😃f地方的地方', '2022-05-18 18:34:28', 1000, 1, 30, 30, 1);
INSERT INTO `comments` VALUES (33, 'rrrrrr😄', '2022-05-19 10:24:52', 1000, 17, 0, 0, 1);
INSERT INTO `comments` VALUES (34, 'rrrr🎱', '2022-05-19 10:24:59', 1000, 1, 33, 33, 1);

-- ----------------------------
-- Table structure for donations
-- ----------------------------
DROP TABLE IF EXISTS `donations`;
CREATE TABLE `donations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `u_id` int NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int NOT NULL DEFAULT 0 COMMENT '0表示未取货，1表示已取货',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `is_deleted` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of donations
-- ----------------------------
INSERT INTO `donations` VALUES (1, 1000, 'tghthfgf', 'reerrr', '2022-05-18 22:30:08', 1, 'ssdds', 1);
INSERT INTO `donations` VALUES (2, 1000, '我这里有一堆不太适合我的衣服，请帮我送给山区的小朋友', '书社楼8栋401房', '2022-05-16 16:37:50', 0, '22', 1);
INSERT INTO `donations` VALUES (3, 1000, 'ff', '四川省南充市顺庆区', '2022-05-16 16:59:06', 1, 'dsdsdsssdsdsd', 0);
INSERT INTO `donations` VALUES (4, 1000, '请下午三点过来这时我才下课', '西苑宿舍楼8东8-1', '2022-05-18 18:37:15', 0, '', 1);

-- ----------------------------
-- Table structure for donations_orders
-- ----------------------------
DROP TABLE IF EXISTS `donations_orders`;
CREATE TABLE `donations_orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `donations_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of donations_orders
-- ----------------------------
INSERT INTO `donations_orders` VALUES (4, '贵州青青草原', '3', '2022-05-16 17:01:28', 1);

-- ----------------------------
-- Table structure for friend_lists
-- ----------------------------
DROP TABLE IF EXISTS `friend_lists`;
CREATE TABLE `friend_lists`  (
  `fl_id` int NOT NULL AUTO_INCREMENT COMMENT '好友列表id',
  `u_id` int NULL DEFAULT NULL COMMENT '当前用户id',
  `fl_u_id` int NULL DEFAULT NULL COMMENT '好友id\r\n',
  PRIMARY KEY (`fl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friend_lists
-- ----------------------------
INSERT INTO `friend_lists` VALUES (3, 1003, 1002);
INSERT INTO `friend_lists` VALUES (7, 1002, 1003);
INSERT INTO `friend_lists` VALUES (36, 1002, 1000);
INSERT INTO `friend_lists` VALUES (37, 1006, 1000);
INSERT INTO `friend_lists` VALUES (38, 1000, 1006);
INSERT INTO `friend_lists` VALUES (44, 1000, 1002);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `g_id` int NOT NULL AUTO_INCREMENT,
  `g_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `g_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `classify` int NULL DEFAULT NULL COMMENT '0：全部商品\r\n1：手机；\r\n2：电脑；\r\n3：影音娱乐；\r\n4：数码配件；\r\n5：运动健身；\r\n6：衣物鞋帽；\r\n7：图书教材；\r\n8：交通出行；\r\n9：其他商品',
  `g_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `oldprice` decimal(10, 2) NULL DEFAULT NULL,
  `nowprice` decimal(10, 2) NULL DEFAULT NULL,
  `u_id` int NOT NULL COMMENT '与用户关联的id',
  `g_daysremaining` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '寄售天数',
  `g_state` int NULL DEFAULT 1 COMMENT '为0时以卖出，\r\n为1时正在出售，\r\n2:管理员下架\r\n为3时背举报下架',
  `g_pubdate` datetime NULL DEFAULT NULL,
  `is_delete` int UNSIGNED NULL DEFAULT 1 COMMENT '伪删除为0时以删除,为1时存在',
  `is_top` int NULL DEFAULT 66 COMMENT '置顶',
  PRIMARY KEY (`g_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (3, 'love3', '22222', 9, '1fc5de6299e5a1512d6a2e200.jpg,1fc5de6299e5a1512d6a2e201.png', 22.00, 22.00, 1000, '22', 1, '2022-01-12 10:58:38', 0, 0);
INSERT INTO `goods` VALUES (4, '王顺溜溜', '买回家当住伪球球了', 9, 'bd181ec98080d90278a082400.jpg,bd181ec98080d90278a082401.jpg', 33.00, 22.00, 1000, '23', 0, '2022-01-19 10:58:45', 0, 0);
INSERT INTO `goods` VALUES (5, '宝批龙', '田里抓的宝批龙', 5, 'bd181ec98080d90278a082400.jpg,bd181ec98080d90278a082401.jpg', 332.00, 22.00, 1000, '22', 1, '2022-01-12 10:58:50', 0, 66);
INSERT INTO `goods` VALUES (7, '头像', '啊数据库的萨基肯德基奥斯卡', 6, '6efbcceb046d437201e6de800.jpg,6efbcceb046d437201e6de801.jpg,6efbcceb046d437201e6de802.jpg,6efbcceb046d437201e6de803.jpg', 23.00, 32.00, 1000, '44', 1, '2022-01-20 11:02:18', 1, 66);
INSERT INTO `goods` VALUES (8, '奥特曼', '南安市电脑阿三打撒看', 9, 'f737c0ec5ca0cc44aafe54f00.jpg,f737c0ec5ca0cc44aafe54f01.jpg', 222.00, 222.00, 1000, '333', 2, '2022-02-12 16:12:10', 0, 66);
INSERT INTO `goods` VALUES (9, '44444', '22222', 9, 'b71a213c17fcab809dd8d1000.jpeg,b71a213c17fcab809dd8d1001.jpeg', 22.00, 22.00, 1002, '22', 0, '2022-02-13 18:59:03', 0, 66);
INSERT INTO `goods` VALUES (10, '44444', '22222', 9, '61447b58287c1b09554fe9600.jpg,61447b58287c1b09554fe9601.jpg', 22.00, 22.00, 1002, '22', 2, '2022-02-20 10:43:50', 0, 66);
INSERT INTO `goods` VALUES (14, '欸非', '士大夫但是的', 4, '35482ca239e0243ca246ccf05.jpg,35482ca239e0243ca246ccf06.jpg,35482ca239e0243ca246ccf07.jpg', 33.00, 434.00, 1000, '34', 1, '2022-03-14 21:07:07', 1, 66);
INSERT INTO `goods` VALUES (15, '呃呃呃', '呃呃呃谔谔谔谔', 6, '', 3.00, 55.00, 1000, '55', 1, '2022-04-16 18:04:54', 0, 66);
INSERT INTO `goods` VALUES (16, '奥特曼', '阿三大苏打', 9, 'e63318f271547d415f5a22f00.jpg,e63318f271547d415f5a22f01.jpg', 22.00, 22.00, 1000, '33', 1, '2022-05-08 11:52:59', 0, 66);
INSERT INTO `goods` VALUES (17, '土土', '撒旦发射点发生', 1, 'a55027e8961ea3929fd0cec00.jpg,a55027e8961ea3929fd0cec01.jpg,a55027e8961ea3929fd0cec02.jpg', 23.00, 45.00, 1002, '34', 1, '2022-05-15 20:15:46', 1, 66);
INSERT INTO `goods` VALUES (18, '天天', '似懂非懂夫士大夫', 3, 'a55027e8961ea3929fd0cec03.jpg,a55027e8961ea3929fd0cec04.jpg', 33.00, 43.00, 1002, '4444', 1, '2022-05-15 20:16:53', 1, 66);
INSERT INTO `goods` VALUES (19, '看看', '夫士大夫士大夫撒旦', 8, 'a55027e8961ea3929fd0cec03.jpg,a55027e8961ea3929fd0cec04.jpg,a55027e8961ea3929fd0cec05.jpg,a55027e8961ea3929fd0cec06.jpg', 34.00, 34.00, 1002, '34', 1, '2022-05-15 20:17:40', 1, 66);
INSERT INTO `goods` VALUES (20, 'ggg', 'dsssdsd', 9, '84740a8057b7452971bfb9300.jpg', 222.00, 33.00, 1000, '3', 1, '2022-05-16 14:03:29', 0, 66);

-- ----------------------------
-- Table structure for hot_word
-- ----------------------------
DROP TABLE IF EXISTS `hot_word`;
CREATE TABLE `hot_word`  (
  `hw_id` int NOT NULL AUTO_INCREMENT,
  `word` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `counts` int NULL DEFAULT 0,
  PRIMARY KEY (`hw_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hot_word
-- ----------------------------
INSERT INTO `hot_word` VALUES (1, '头像', 0);

-- ----------------------------
-- Table structure for leave_word
-- ----------------------------
DROP TABLE IF EXISTS `leave_word`;
CREATE TABLE `leave_word`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `u_id` int NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ab_id` int NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of leave_word
-- ----------------------------
INSERT INTO `leave_word` VALUES (1, 1002, '你这个撒谎给你商品联系我QQ:282883321', 2, '2022-03-14 16:22:22', 1);
INSERT INTO `leave_word` VALUES (2, 1000, '你好加+++W:1991221929😃', 3, '2022-03-14 17:03:16', 1);
INSERT INTO `leave_word` VALUES (3, 1000, 'www', 4, '2022-03-14 17:03:47', 1);
INSERT INTO `leave_word` VALUES (4, 1000, 'wwww😃', 2, '2022-03-14 17:40:10', 1);
INSERT INTO `leave_word` VALUES (5, 1000, '吧举报hi v规划obhj/\n\n吧g/就；和吧话就哦了看', 19, '2022-03-17 16:48:07', 1);
INSERT INTO `leave_word` VALUES (6, 1000, '33', 19, '2022-03-17 16:48:46', 1);
INSERT INTO `leave_word` VALUES (7, 1000, '33 ', 19, '2022-03-17 16:48:52', 1);
INSERT INTO `leave_word` VALUES (8, 1000, '444444', 19, '2022-03-17 16:48:58', 1);
INSERT INTO `leave_word` VALUES (9, 1000, '22', 21, '2022-03-17 18:27:17', 1);

-- ----------------------------
-- Table structure for notices
-- ----------------------------
DROP TABLE IF EXISTS `notices`;
CREATE TABLE `notices`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` varchar(9999) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `autor` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notices
-- ----------------------------
INSERT INTO `notices` VALUES (1, '校园二手市场发布商品规则', '顾客篇：购物指南\n\n　　进入xx购物中心的顾客随意在门口领到的一本《xx购物中心购物指南》，前面五页是购物中心五层楼的平面图，后两页字体颜色加深，写着：\n\n　　xx购物中心是为本市民提供生活便利而建造的购物中心，包含着吃喝玩乐各式各样的店铺营业，只为给来此的每一位顾客带来美好的体验，但同时也希望顾客您能遵守一些购物中心的规则：\n\n　　1.看到此内容的顾客，请安静认真的看完，请勿宣扬。\n\n　　2.您手持的《购物指南》请保存好，不要在购物中心内丢弃，不要随意送给购物中心内的任何人，最好随身带走。\n\n　　3.购物中心内的任何一位店铺员工都会认真服务您，但请不要打扰保洁员清扫、维修人员维修和巡查员巡逻。\n\n　　4.遇到保洁员清扫购物中心时，请不要打扰，必要时请配合保洁员的清扫工作，但不要过多语言交流影响到清扫工作。\n\n　　5.如果您是开车来购物中心的，请记好车停在哪个停车场，找不到时请看地图或询问附近的店铺内员工。但请记住，购物中心负二楼（B2）不对外开放，如果有员工回答“停车场在负二楼（B2）”，请不要相信。\n\n　　6.坐电梯误入负二楼（B2）时，请不要走出电梯，及时离开，不要好奇观望。\n\n　　7.不要接受任何一位没有穿工作服的员工服务，这是不安全的，请拒绝该员工的服务，让店铺内其他员工服务或者离开该店铺。\n\n　　8.购物中心只营业至晚上22：00，请早于这个时间点离开购物中心。因不可抗力因素导致停留过久，请想尽办法至负一楼（B1），此楼层有一处连接地铁口，连接地铁口处门未关请借此机会离开，若门已关也请在负一楼（B1）等候，请尽量不要发出声音。\n\n　　9.在购物中心闲逛时感到害怕或不对劲，请就近找一个人少的店铺坐下休息，直到平复情绪后立刻离开购物中心。携带的儿童有异常情绪，也请离开购物中心。\n\n　　10.独自一人遇到过于安静的情况时，请不要和店铺员工外的人说话，尽快离开购物中心。\n\n　　11.非紧急情况，请不要擅自进入购物中心的消防通道，不要在开着门的消防通道口停留，遇到员工外的人员进入请向附近店铺员工反应。\n\n　　12.结伴而行的顾客，在购物中心内分开后找不到同伴，请向穿黑色西装制度的巡查员工反应，不要独自寻找，特别是不同楼层的寻找。\n\n　　13.看到购物中心某个楼层结构布置与《购物指南》地图不相符时，请不要惊讶或质疑，找最近的电扶梯安静离开该楼层即可。注意，购物中心只', 'admin', '2022-05-18 22:33:29');
INSERT INTO `notices` VALUES (2, '校园二手市场账号注册规则', '顾客篇：购物指南\n\n　　进入xx购物中心的顾客随意在门口领到的一本《xx购物中心购物指南》，前面五页是购物中心五层楼的平面图，后两页字体颜色加深，写着：\n\n　　xx购物中心是为本市民提供生活便利而建造的购物中心，包含着吃喝玩乐各式各样的店铺营业，只为给来此的每一位顾客带来美好的体验，但同时也希望顾客您能遵守一些购物中心的规则：\n\n　　1.看到此内容的顾客，请安静认真的看完，请勿宣扬。\n\n　　2.您手持的《购物指南》请保存好，不要在购物中心内丢弃，不要随意送给购物中心内的任何人，最好随身带走。\n\n　　3.购物中心内的任何一位店铺员工都会认真服务您，但请不要打扰保洁员清扫、维修人员维修和巡查员巡逻。\n\n　　4.遇到保洁员清扫购物中心时，请不要打扰，必要时请配合保洁员的清扫工作，但不要过多语言交流影响到清扫工作。\n\n　　5.如果您是开车来购物中心的，请记好车停在哪个停车场，找不到时请看地图或询问附近的店铺内员工。但请记住，购物中心负二楼（B2）不对外开放，如果有员工回答“停车场在负二楼（B2）”，请不要相信。\n\n　　6.坐电梯误入负二楼（B2）时，请不要走出电梯，及时离开，不要好奇观望。\n\n　　7.不要接受任何一位没有穿工作服的员工服务，这是不安全的，请拒绝该员工的服务，让店铺内其他员工服务或者离开该店铺。\n\n　　8.购物中心只营业至晚上22：00，请早于这个时间点离开购物中心。因不可抗力因素导致停留过久，请想尽办法至负一楼（B1），此楼层有一处连接地铁口，连接地铁口处门未关请借此机会离开，若门已关也请在负一楼（B1）等候，请尽量不要发出声音。\n\n　　9.在购物中心闲逛时感到害怕或不对劲，请就近找一个人少的店铺坐下休息，直到平复情绪后立刻离开购物中心。携带的儿童有异常情绪，也请离开购物中心。\n\n　　10.独自一人遇到过于安静的情况时，请不要和店铺员工外的人说话，尽快离开购物中心。\n\n　　11.非紧急情况，请不要擅自进入购物中心的消防通道，不要在开着门的消防通道口停留，遇到员工外的人员进入请向附近店铺员工反应。\n\n　　12.结伴而行的顾客，在购物中心内分开后找不到同伴，请向穿黑色西装制度的巡查员工反应，不要独自寻找，特别是不同楼层的寻找。\n\n　　13.看到购物中心某个楼层结构布置与《购物指南》地图不相符时，请不要惊讶或质疑，找最近的电扶梯安静离开该楼层即可。注意，购物中心只', 'admin', '2022-05-18 22:33:40');
INSERT INTO `notices` VALUES (3, '关于校园二手市场平台', '顾客篇：购物指南\n\n　　进入xx购物中心的顾客随意在门口领到的一本《xx购物中心购物指南》，前面五页是购物中心五层楼的平面图，后两页字体颜色加深，写着：\n\n　　xx购物中心是为本市民提供生活便利而建造的购物中心，包含着吃喝玩乐各式各样的店铺营业，只为给来此的每一位顾客带来美好的体验，但同时也希望顾客您能遵守一些购物中心的规则：\n\n　　1.看到此内容的顾客，请安静认真的看完，请勿宣扬。\n\n　　2.您手持的《购物指南》请保存好，不要在购物中心内丢弃，不要随意送给购物中心内的任何人，最好随身带走。\n\n　　3.购物中心内的任何一位店铺员工都会认真服务您，但请不要打扰保洁员清扫、维修人员维修和巡查员巡逻。\n\n　　4.遇到保洁员清扫购物中心时，请不要打扰，必要时请配合保洁员的清扫工作，但不要过多语言交流影响到清扫工作。\n\n　　5.如果您是开车来购物中心的，请记好车停在哪个停车场，找不到时请看地图或询问附近的店铺内员工。但请记住，购物中心负二楼（B2）不对外开放，如果有员工回答“停车场在负二楼（B2）”，请不要相信。\n\n　　6.坐电梯误入负二楼（B2）时，请不要走出电梯，及时离开，不要好奇观望。\n\n　　7.不要接受任何一位没有穿工作服的员工服务，这是不安全的，请拒绝该员工的服务，让店铺内其他员工服务或者离开该店铺。\n\n　　8.购物中心只营业至晚上22：00，请早于这个时间点离开购物中心。因不可抗力因素导致停留过久，请想尽办法至负一楼（B1），此楼层有一处连接地铁口，连接地铁口处门未关请借此机会离开，若门已关也请在负一楼（B1）等候，请尽量不要发出声音。\n\n　　9.在购物中心闲逛时感到害怕或不对劲，请就近找一个人少的店铺坐下休息，直到平复情绪后立刻离开购物中心。携带的儿童有异常情绪，也请离开购物中心。\n\n　　10.独自一人遇到过于安静的情况时，请不要和店铺员工外的人说话，尽快离开购物中心。\n\n　　11.非紧急情况，请不要擅自进入购物中心的消防通道，不要在开着门的消防通道口停留，遇到员工外的人员进入请向附近店铺员工反应。\n\n　　12.结伴而行的顾客，在购物中心内分开后找不到同伴，请向穿黑色西装制度的巡查员工反应，不要独自寻找，特别是不同楼层的寻找。\n\n　　13.看到购物中心某个楼层结构布置与《购物指南》地图不相符时，请不要惊讶或质疑，找最近的电扶梯安静离开该楼层即可。注意，购物中心只', 'admin', '2022-05-18 22:33:51');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `o_id` int NOT NULL AUTO_INCREMENT COMMENT '购买订单ID',
  `g_id` int NOT NULL,
  `buyer_id` int NOT NULL COMMENT '买家id',
  `seller_id` int NOT NULL COMMENT '卖家id',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `o_date` datetime NULL DEFAULT NULL COMMENT '订单创建时间',
  `o_status` int NOT NULL DEFAULT 1 COMMENT '1等待发货，2已发货，3运送中，4已完成',
  PRIMARY KEY (`o_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11051 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (11051, 9, 1000, 1002, '大肥羊学校未来科技量子力学2班', '2022-05-16 14:06:12', 1);

-- ----------------------------
-- Table structure for reports
-- ----------------------------
DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `g_id` int NOT NULL,
  `u_id` int NOT NULL COMMENT '举报者id',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '举报内容',
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` int NULL DEFAULT 1 COMMENT '0为删除，1为存在',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reports
-- ----------------------------
INSERT INTO `reports` VALUES (1, 5, 1000, '这个商品传播不法信息', '2022-03-08 10:11:29', 1);
INSERT INTO `reports` VALUES (2, 7, 1000, '这个头像很不和谐', '2022-03-11 10:23:42', 1);
INSERT INTO `reports` VALUES (3, 7, 1000, '哈哈哈哈', '2022-03-11 10:24:32', 1);
INSERT INTO `reports` VALUES (4, 15, 1000, '身上到底是谁', '2022-04-16 18:05:41', 1);
INSERT INTO `reports` VALUES (5, 5, 1000, '222', '2022-04-16 21:11:46', 1);
INSERT INTO `reports` VALUES (6, 9, 1000, '通用语言', '2022-05-16 14:05:17', 1);
INSERT INTO `reports` VALUES (7, 17, 1000, 'ett ', '2022-05-19 10:25:11', 1);

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `sc_id` int NOT NULL AUTO_INCREMENT,
  `u_id` int NULL DEFAULT NULL,
  `g_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`sc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1048 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
INSERT INTO `shopping_cart` VALUES (1047, 1000, 19);
INSERT INTO `shopping_cart` VALUES (1048, 1000, 17);

-- ----------------------------
-- Table structure for system_log
-- ----------------------------
DROP TABLE IF EXISTS `system_log`;
CREATE TABLE `system_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` int NOT NULL DEFAULT 1 COMMENT '0删除，1存在',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 130 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_log
-- ----------------------------
INSERT INTO `system_log` VALUES (1, '冻结学生账号', '2022-03-08 19:28:46', 0);
INSERT INTO `system_log` VALUES (2, '激活学生账号', '2022-03-08 19:28:47', 0);
INSERT INTO `system_log` VALUES (3, '下架商品', '2022-03-08 20:32:34', 0);
INSERT INTO `system_log` VALUES (4, '上架商品', '2022-03-08 20:32:36', 0);
INSERT INTO `system_log` VALUES (5, '查找举报', '2022-03-08 20:34:30', 0);
INSERT INTO `system_log` VALUES (6, '用户登录', '2022-03-09 11:44:08', 0);
INSERT INTO `system_log` VALUES (7, '用户登录', '2022-03-09 11:45:31', 0);
INSERT INTO `system_log` VALUES (8, '用户登录', '2022-03-09 14:19:11', 0);
INSERT INTO `system_log` VALUES (9, '用户登录', '2022-03-09 14:27:30', 0);
INSERT INTO `system_log` VALUES (10, '用户登录', '2022-03-09 14:27:32', 0);
INSERT INTO `system_log` VALUES (11, '用户登录', '2022-03-09 14:29:59', 0);
INSERT INTO `system_log` VALUES (12, '用户登录', '2022-03-09 14:30:14', 0);
INSERT INTO `system_log` VALUES (13, '用户登录', '2022-03-09 14:30:15', 0);
INSERT INTO `system_log` VALUES (14, '用户登录', '2022-03-09 14:30:15', 0);
INSERT INTO `system_log` VALUES (15, '用户登录', '2022-03-09 14:31:37', 0);
INSERT INTO `system_log` VALUES (16, '用户登录', '2022-03-09 14:32:00', 0);
INSERT INTO `system_log` VALUES (17, '用户登录', '2022-03-09 14:32:38', 0);
INSERT INTO `system_log` VALUES (18, '用户登录', '2022-03-09 14:38:02', 0);
INSERT INTO `system_log` VALUES (19, '用户登录', '2022-03-09 14:38:04', 0);
INSERT INTO `system_log` VALUES (20, '用户登录', '2022-03-09 14:38:06', 0);
INSERT INTO `system_log` VALUES (21, '用户登录', '2022-03-09 14:38:07', 0);
INSERT INTO `system_log` VALUES (22, '用户登录', '2022-03-09 14:38:09', 0);
INSERT INTO `system_log` VALUES (23, '用户登录', '2022-03-09 14:38:11', 0);
INSERT INTO `system_log` VALUES (24, '用户登录', '2022-03-09 14:38:13', 0);
INSERT INTO `system_log` VALUES (25, '用户登录', '2022-03-09 14:38:20', 0);
INSERT INTO `system_log` VALUES (26, '用户登录', '2022-03-09 14:39:03', 0);
INSERT INTO `system_log` VALUES (27, '用户登录', '2022-03-09 14:40:36', 0);
INSERT INTO `system_log` VALUES (28, '用户登录', '2022-03-09 14:44:52', 0);
INSERT INTO `system_log` VALUES (29, '用户登录', '2022-03-09 14:46:08', 0);
INSERT INTO `system_log` VALUES (30, '用户登录', '2022-03-09 14:47:16', 0);
INSERT INTO `system_log` VALUES (31, '用户登录', '2022-03-16 16:49:23', 0);
INSERT INTO `system_log` VALUES (32, '用户登录', '2022-03-16 16:49:25', 0);
INSERT INTO `system_log` VALUES (33, '用户登录', '2022-03-16 16:49:28', 0);
INSERT INTO `system_log` VALUES (34, '查找举报', '2022-03-16 16:52:42', 1);
INSERT INTO `system_log` VALUES (35, '查找举报', '2022-03-16 16:52:46', 1);
INSERT INTO `system_log` VALUES (36, '删除商品评论', '2022-03-16 16:53:20', 1);
INSERT INTO `system_log` VALUES (37, '删除商品评论', '2022-03-16 16:53:28', 1);
INSERT INTO `system_log` VALUES (38, '删除商品评论', '2022-03-16 16:53:38', 1);
INSERT INTO `system_log` VALUES (39, '用户登录', '2022-03-16 17:08:01', 0);
INSERT INTO `system_log` VALUES (40, '用户登录', '2022-03-16 17:12:01', 0);
INSERT INTO `system_log` VALUES (41, '用户登录', '2022-04-13 19:43:02', 1);
INSERT INTO `system_log` VALUES (42, '用户登录', '2022-04-13 19:43:04', 1);
INSERT INTO `system_log` VALUES (43, '用户登录', '2022-04-13 19:43:06', 1);
INSERT INTO `system_log` VALUES (44, '用户登录', '2022-04-13 19:43:12', 1);
INSERT INTO `system_log` VALUES (45, '用户登录', '2022-04-13 19:43:19', 1);
INSERT INTO `system_log` VALUES (46, '用户登录', '2022-04-13 19:44:29', 1);
INSERT INTO `system_log` VALUES (47, '用户登录', '2022-04-13 19:44:39', 1);
INSERT INTO `system_log` VALUES (48, '用户登录', '2022-04-13 19:45:18', 1);
INSERT INTO `system_log` VALUES (49, '用户登录', '2022-04-13 19:46:23', 1);
INSERT INTO `system_log` VALUES (50, '用户登录', '2022-04-13 19:46:36', 1);
INSERT INTO `system_log` VALUES (51, '用户登录', '2022-04-13 19:47:19', 1);
INSERT INTO `system_log` VALUES (52, '用户登录', '2022-04-13 19:48:09', 1);
INSERT INTO `system_log` VALUES (53, '用户登录', '2022-04-13 19:48:24', 1);
INSERT INTO `system_log` VALUES (54, '用户登录', '2022-04-13 19:49:23', 1);
INSERT INTO `system_log` VALUES (55, '用户登录', '2022-04-13 19:49:47', 1);
INSERT INTO `system_log` VALUES (56, '用户登录', '2022-04-13 20:26:33', 1);
INSERT INTO `system_log` VALUES (57, '用户登录', '2022-04-13 20:27:57', 1);
INSERT INTO `system_log` VALUES (58, '查找举报', '2022-04-13 20:32:42', 1);
INSERT INTO `system_log` VALUES (59, '查找举报', '2022-04-13 20:34:47', 1);
INSERT INTO `system_log` VALUES (60, '用户登录', '2022-04-13 20:55:10', 1);
INSERT INTO `system_log` VALUES (61, '冻结学生账号', '2022-04-13 20:59:20', 1);
INSERT INTO `system_log` VALUES (62, '激活学生账号', '2022-04-13 20:59:23', 1);
INSERT INTO `system_log` VALUES (63, '冻结学生账号', '2022-04-13 20:59:28', 1);
INSERT INTO `system_log` VALUES (64, '冻结学生账号', '2022-04-13 20:59:29', 1);
INSERT INTO `system_log` VALUES (65, '激活学生账号', '2022-04-13 20:59:30', 1);
INSERT INTO `system_log` VALUES (66, '用户登录', '2022-04-16 15:50:28', 1);
INSERT INTO `system_log` VALUES (67, '查找举报', '2022-04-16 16:03:10', 1);
INSERT INTO `system_log` VALUES (68, '用户登录', '2022-04-16 17:49:51', 1);
INSERT INTO `system_log` VALUES (69, '查找举报', '2022-04-16 17:51:29', 1);
INSERT INTO `system_log` VALUES (70, '修改公告', '2022-04-16 17:52:15', 1);
INSERT INTO `system_log` VALUES (71, '用户登录', '2022-04-16 17:55:22', 1);
INSERT INTO `system_log` VALUES (72, '查找举报', '2022-04-16 17:55:28', 1);
INSERT INTO `system_log` VALUES (73, '查找举报', '2022-04-16 17:55:29', 1);
INSERT INTO `system_log` VALUES (74, '查找举报', '2022-04-16 17:57:37', 1);
INSERT INTO `system_log` VALUES (75, '查找举报', '2022-04-16 17:57:44', 1);
INSERT INTO `system_log` VALUES (76, '查找举报', '2022-04-16 17:59:24', 1);
INSERT INTO `system_log` VALUES (77, '修改公告', '2022-04-16 18:01:19', 1);
INSERT INTO `system_log` VALUES (78, '用户登录', '2022-04-16 22:34:53', 1);
INSERT INTO `system_log` VALUES (79, '用户登录', '2022-04-17 16:38:32', 1);
INSERT INTO `system_log` VALUES (80, '查找举报', '2022-04-17 16:39:21', 1);
INSERT INTO `system_log` VALUES (81, '用户登录', '2022-05-08 11:55:46', 1);
INSERT INTO `system_log` VALUES (82, '下架商品', '2022-05-08 11:56:36', 1);
INSERT INTO `system_log` VALUES (83, '删除商品', '2022-05-08 11:56:40', 1);
INSERT INTO `system_log` VALUES (84, '冻结学生账号', '2022-05-08 11:57:08', 1);
INSERT INTO `system_log` VALUES (85, '激活学生账号', '2022-05-08 11:57:11', 1);
INSERT INTO `system_log` VALUES (86, '查找举报', '2022-05-08 11:57:30', 1);
INSERT INTO `system_log` VALUES (87, '修改公告', '2022-05-08 11:57:44', 1);
INSERT INTO `system_log` VALUES (88, '用户登录', '2022-05-15 21:23:14', 1);
INSERT INTO `system_log` VALUES (89, '用户登录', '2022-05-15 21:23:59', 1);
INSERT INTO `system_log` VALUES (90, '用户登录', '2022-05-15 21:25:52', 1);
INSERT INTO `system_log` VALUES (91, '用户登录', '2022-05-15 21:29:03', 1);
INSERT INTO `system_log` VALUES (92, '用户登录', '2022-05-15 21:38:45', 1);
INSERT INTO `system_log` VALUES (93, '用户登录', '2022-05-15 21:39:17', 1);
INSERT INTO `system_log` VALUES (94, '查找举报', '2022-05-15 21:41:19', 1);
INSERT INTO `system_log` VALUES (95, '下架商品', '2022-05-15 21:48:31', 1);
INSERT INTO `system_log` VALUES (96, '下架商品', '2022-05-15 21:48:45', 1);
INSERT INTO `system_log` VALUES (97, '用户登录', '2022-05-16 11:32:14', 1);
INSERT INTO `system_log` VALUES (98, '用户登录', '2022-05-16 11:44:43', 1);
INSERT INTO `system_log` VALUES (99, '用户登录', '2022-05-16 11:49:11', 1);
INSERT INTO `system_log` VALUES (100, '用户登录', '2022-05-16 11:50:27', 1);
INSERT INTO `system_log` VALUES (101, '查找举报', '2022-05-16 12:37:20', 1);
INSERT INTO `system_log` VALUES (102, '用户登录', '2022-05-16 12:55:44', 1);
INSERT INTO `system_log` VALUES (103, '求购帖子删除', '2022-05-16 12:58:51', 1);
INSERT INTO `system_log` VALUES (104, '用户登录', '2022-05-16 13:18:00', 1);
INSERT INTO `system_log` VALUES (105, '用户登录', '2022-05-16 14:08:25', 1);
INSERT INTO `system_log` VALUES (106, '下架商品', '2022-05-16 14:09:34', 1);
INSERT INTO `system_log` VALUES (107, '上架商品', '2022-05-16 14:09:35', 1);
INSERT INTO `system_log` VALUES (108, '查找举报', '2022-05-16 14:09:56', 1);
INSERT INTO `system_log` VALUES (109, '用户登录', '2022-05-16 15:09:19', 1);
INSERT INTO `system_log` VALUES (110, '用户登录', '2022-05-16 15:10:31', 1);
INSERT INTO `system_log` VALUES (111, '用户登录', '2022-05-16 15:35:04', 1);
INSERT INTO `system_log` VALUES (112, '用户登录', '2022-05-16 15:43:21', 1);
INSERT INTO `system_log` VALUES (113, '用户登录', '2022-05-16 15:59:09', 1);
INSERT INTO `system_log` VALUES (114, '用户登录', '2022-05-16 16:01:18', 1);
INSERT INTO `system_log` VALUES (115, '用户登录', '2022-05-16 16:50:31', 1);
INSERT INTO `system_log` VALUES (116, '用户登录', '2022-05-18 20:41:35', 1);
INSERT INTO `system_log` VALUES (117, '用户登录', '2022-05-18 22:28:54', 1);
INSERT INTO `system_log` VALUES (118, '管理员停用', '2022-05-18 22:29:19', 1);
INSERT INTO `system_log` VALUES (119, '管理员停用', '2022-05-18 22:29:20', 1);
INSERT INTO `system_log` VALUES (120, '管理员停用', '2022-05-18 22:29:21', 1);
INSERT INTO `system_log` VALUES (121, '管理员停用', '2022-05-18 22:29:22', 1);
INSERT INTO `system_log` VALUES (122, '管理员停用', '2022-05-18 22:29:23', 1);
INSERT INTO `system_log` VALUES (123, '管理员停用', '2022-05-18 22:29:23', 1);
INSERT INTO `system_log` VALUES (124, '查找举报', '2022-05-18 22:31:24', 1);
INSERT INTO `system_log` VALUES (125, '查找举报', '2022-05-18 22:32:05', 1);
INSERT INTO `system_log` VALUES (126, '修改公告', '2022-05-18 22:33:29', 1);
INSERT INTO `system_log` VALUES (127, '修改公告', '2022-05-18 22:33:40', 1);
INSERT INTO `system_log` VALUES (128, '修改公告', '2022-05-18 22:33:51', 1);
INSERT INTO `system_log` VALUES (129, '用户登录', '2022-05-19 10:27:18', 1);
INSERT INTO `system_log` VALUES (130, '查找举报', '2022-05-19 10:28:00', 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `u_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户唯一标识id',
  `u_name` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `u_password` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `u_nickname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `u_avatar` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'userdefault.jpg' COMMENT '用户头像',
  `u_tel` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `u_qq` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ',
  `u_school` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学校',
  `u_class` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班级',
  `u_branch_courts` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分院',
  `u_state` int NULL DEFAULT 0 COMMENT '用户状态0正常；1警告；2冻结',
  `balance` decimal(10, 0) UNSIGNED NULL DEFAULT NULL,
  `is_deleted` int NULL DEFAULT 0 COMMENT '假删除0表示未删除，1表示删除',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`u_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1000, 'admin', 'admin', '王顺溜溜', 'a645d125c37e6090b85e54002.jpg', '13990857042', '409653822', '大肥羊学校', '量子力学2班', '未来科技', 0, 0, 0, '2022-05-18 18:38:50');
INSERT INTO `user` VALUES (1002, 'admin2', 'admin2', '刘润土土', 'a645d125c37e6090b85e54000.jpg', '17765563456', '956165894', '西瓜田', '刺猹红海军2班', '东边村', 0, 0, 0, '2022-05-18 18:33:08');
INSERT INTO `user` VALUES (1003, '1811030174', 'aaaa22dddd', '赵鬼子', 'eb08fe1237f32780c5637eb00.jpg', '19977463987', '2240784621', '大肥羊学校', '量子传送2班', '未来科技', 0, 0, 0, '2022-05-08 11:57:11');

SET FOREIGN_KEY_CHECKS = 1;
