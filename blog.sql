/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80000
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80000
 File Encoding         : 65001

 Date: 14/05/2021 04:08:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hibernate_sequence
-- ----------------------------
DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE `hibernate_sequence`  (
  `next_val` bigint(20) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hibernate_sequence
-- ----------------------------
INSERT INTO `hibernate_sequence` VALUES (17);

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appreciation` bit(1) NOT NULL,
  `commentabled` bit(1) NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `first_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `published` bit(1) NOT NULL,
  `recommend` bit(1) NOT NULL,
  `share_statement` bit(1) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `views` int(11) NULL DEFAULT NULL,
  `type_id` bigint(20) NULL DEFAULT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK292449gwg5yf7ocdlmswv9w4j`(`type_id`) USING BTREE,
  INDEX `FK8ky5rrsxh01nkhctmo7d48p82`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES (5, b'1', b'1', '*吟游诗人天下第一*', '2020-12-18 15:36:02', '555555', NULL, '原创', b'1', b'1', b'0', 'FF14', '2021-05-14 03:20:15', 17, 2, 3);
INSERT INTO `t_blog` VALUES (6, b'0', b'0', '65165165', '2020-12-19 10:12:00', '564165165', NULL, '原创', b'1', b'1', b'0', '楚辞', '2021-04-18 08:41:40', 0, 2, 1);
INSERT INTO `t_blog` VALUES (7, b'1', b'1', '6454546', '2020-12-19 10:12:22', '5461651656', 'http://localhost:8080/admin/login/moroccan-flower.png', '原创', b'1', b'1', b'1', '人鬼情未了', '2020-12-19 10:12:22', 0, 1, 1);
INSERT INTO `t_blog` VALUES (8, b'1', b'1', '54165656', '2020-12-19 10:12:42', '312656', NULL, '原创', b'1', b'1', b'0', '测试测试', '2021-05-14 03:23:00', 6, 1, 4);
INSERT INTO `t_blog` VALUES (9, b'1', b'1', '  在SpringMVC 中，控制器Controller 负责处理由DispatcherServlet 分发的请求，它把用户请求的数据经过业务处理层处理之后封装成一个Model ，然后再把该Model 返回给对应的View 进行展示。在SpringMVC 中提供了一个非常简便的定义Controller 的方法，你无需继承特定的类或实现特定的接口，只需使用@Controller 标记一个类是Controller ，然后使用@RequestMapping 和@RequestParam 等一些注解用以定义URL 请求和Controller 方法之间的映射，这样的Controller 就能被外界访问到。此外Controller 不会直接依赖于HttpServletRequest 和HttpServletResponse 等HttpServlet 对象，它们可以通过Controller 的方法参数灵活的获取到。为了先对Controller 有一个初步的印象，以下先定义一个简单的Controller ：', '2020-12-22 06:32:28', 'ler 不会直接依赖于HttpServletRequest 和HttpServletResponse 等HttpServlet 对象，它们可以通过Controller 的方法参数灵活的获取到。为了先对Controller 有一个初步的印象，以下先定义一个简单的Controller ：', 'http://p1.music.126.net/nn2xRZ9PWq-nh9Y7dNmzQg==/528865144722558.jpg', '转载', b'1', b'1', b'1', 'java字符串ids转换为List，list转Stirn', '2020-12-22 06:32:28', 0, 1, 1);
INSERT INTO `t_blog` VALUES (10, b'1', b'1', '12月22日，王书金案重审二审宣判，河北省高院裁定驳回王书金的上诉，全案维持原判，对王书金执行死刑，剥夺政治权利终身。王书金称自己是聂树斌案真凶的主张未被认定。2005年王书金被警方抓获后供述多起强奸杀人案，11月24日重审一审宣判，王书金被认定强奸4人杀害3人被判处死刑。后王书金提起上诉，上诉理由是法院未认定其为聂树斌案真凶。\r\n\r\n', '2020-12-22 07:03:53', '崔是同党', NULL, '翻译', b'1', b'1', b'0', 'arya', '2021-05-14 03:10:09', 1, 2, 3);
INSERT INTO `t_blog` VALUES (11, b'1', b'0', '长征八号运载火箭为两级半构型，火箭捆绑2个助推器。长征八号按照模块化、系列化、组合化的思路开展研制，充分吸收了在役和新一代运载火箭研制成果，具有良好的继承性、经济性、先进性和适应性，可以进一步完善新一代运载火箭型谱，满足未来中低轨高密度发射任务需求。\r\n\r\n长征八号运载火箭是基于新一代低温绿色环保液体推进剂发动机和模块化箭体结构研制而成的新中型运载火箭。它的存在将升级换代常规有毒推进剂构型的SSO及LEO轨道发射业务，同时进一步提升运载能力、拓展服务范畴。\r\n\r\n与以往研制的“长征系列”火箭相比，长征八号运载火箭以液氢、液氧为推进剂，燃烧后生成的是水，真正实现了无毒无污染零排放。作为一支环保“绿箭”，以液氧煤油模块和液氢液氧模块的组合，替代了常规的有毒推进剂，燃料燃烧产生的推力十分巨大，切实保证了发射过程的环保、高效。', '2020-12-22 07:05:10', '长征八号运载火箭采用可回收式设计，以实现芯一级和固体助推器的回收为例，可以极大地减少火箭发射的成本，同时还大大缩短了发射周期。', NULL, '转载', b'1', b'0', b'0', '长征八号运载火箭首飞成功', '2021-05-14 03:09:55', 1, 2, 4);
INSERT INTO `t_blog` VALUES (12, b'1', b'1', '当地时间12月21日，世卫组织举行新冠肺炎例行发布会，世卫组织卫生紧急项目技术主管玛丽亚·范·科霍夫在回答总台记者提问时表示，英国上报的新冠病毒变体9月已在当地传播，目前英国报告的数据显示此种新冠病毒变体传播力增强，传播指数从1.1上升至1.5。20日起，伦敦及周边地区，已从三级防控级别提升至最高级别四级。目前已有多国宣布禁止英国航班入境。\r\n\r\n面对英国新冠病毒变体的消息，中国的疫情防控形势面临哪些新变化？元旦临近，春节也要来了，新的人员大规模流动，又会对疫情防控带来什么影响？12月21日晚的央视《新闻1+1》节目中，总台记者白桦、中国疾控中心副主任冯子健对大众关注的问题进行了解答。\r\n\r\n\r\n央视报道截图\r\n\r\n关于在英国出现的新冠病毒变异情况，哪些信息可以确认？', '2020-12-22 07:05:58', '央视报道截图', 'http://p1.music.126.net/nn2xRZ9PWq-nh9Y7dNmzQg==/528865144722558.jpg', '转载', b'1', b'1', b'1', '英国变异新冠病毒传播率提高70%，数据准确吗？', '2020-12-22 07:05:58', 0, 2, 1);
INSERT INTO `t_blog` VALUES (13, b'1', b'1', '在何老师的全文里，最重要的一句是“我录节目没有与各家粉丝接触过”……\r\n\r\n他否认直接收下粉丝所送的“应援礼”，然后解释，礼物都是从艺人以及艺人团队的手中获得，以前是不好意思拒绝，以后会重视起来，不但不收粉丝的礼物，艺人的礼物也不再收。\r\n\r\n', '2020-12-22 07:07:06', '何炅老师是圈内出名的老好人，他几乎将人性的光辉发挥到了极致，堪称零瑕疵艺人。', 'http://p1.music.126.net/nn2xRZ9PWq-nh9Y7dNmzQg==/528865144722558.jpg', '转载', b'0', b'1', b'1', '何炅回应“收粉丝应援金条”，只承认收过艺人礼物为不良引导道歉', '2020-12-22 07:07:06', 0, 1, 1);
INSERT INTO `t_blog` VALUES (14, b'1', b'1', '证券时报e公司讯，12月22日早盘，贵州茅台涨约1.8%，盘中股价最高超1875元，再度突破历史新高。五粮液今日盘中同创历史新高，盘中最高价报288元。此外，泸州老窖、洋河股份、ST舍得等白酒股今日也创历史新高。', '2020-12-22 07:08:23', '财富密码 买白酒股票', 'http://p1.music.126.net/nn2xRZ9PWq-nh9Y7dNmzQg==/528865144722558.jpg', '翻译', b'1', b'1', b'1', '贵州茅台、五粮液今日同创历史新高', '2020-12-22 07:08:23', 0, 1, 1);
INSERT INTO `t_blog` VALUES (15, b'1', b'1', '中新社北京12月22日电 (记者 马海燕)记者22日从中国教育部获悉，目前，全球有70个国家将中文纳入国民教育体系，中国以外正在学习中文的人数约2500万。\r\n\r\n　　教育部22日举行发布会，介绍“十三五”期间教育对外开放工作情况。据教育部国际合作与交流司司长、港澳台办公室主任刘锦介绍，“十三五”期间全球参加HSK(中文水平考试)、YCT(中小学中文考试)等中文水平考试的人数达4000万人次。\r\n\r\n　　“十三五”期间，中国新签11份高等教育学历学位互认协议，累计覆盖54个国家和地区。与此同时，中国各级各类教育赴境外办学稳步推进，中国特色海外国际学校建设试点启动。今年9月1日，迪拜中国国际学校作为首批试点正式开学。', '2020-12-22 07:09:18', '来源：中国新闻网', 'http://p1.music.126.net/nn2xRZ9PWq-nh9Y7dNmzQg==/528865144722558.jpg', '转载', b'1', b'1', b'1', '70个国家将中文纳入国民教育体系', '2020-12-22 07:09:18', 0, 1, 1);

-- ----------------------------
-- Table structure for t_blog_tags
-- ----------------------------
DROP TABLE IF EXISTS `t_blog_tags`;
CREATE TABLE `t_blog_tags`  (
  `blogs_id` bigint(20) NOT NULL,
  `tags_id` bigint(20) NOT NULL,
  INDEX `FK5feau0gb4lq47fdb03uboswm8`(`tags_id`) USING BTREE,
  INDEX `FKh4pacwjwofrugxa9hpwaxg6mr`(`blogs_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_blog_tags
-- ----------------------------

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_comment` bit(1) NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `blog_id` bigint(20) NULL DEFAULT NULL,
  `parent_comment_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKke3uogd04j4jx316m1p51e05u`(`blog_id`) USING BTREE,
  INDEX `FK4jj284r3pb7japogvo6h72q95`(`parent_comment_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (1, b'1', NULL, '6666', '2021-04-14 21:28:58', '111', 'dsfsd', 8, NULL);
INSERT INTO `t_comment` VALUES (2, b'1', 'https://unsplash.it/100/100?image=1005', '11111', NULL, '1123535521', 'ditto', 5, 0);
INSERT INTO `t_comment` VALUES (3, b'1', 'https://unsplash.it/100/100?image=1005', '11111111111', NULL, '1123535521', 'ditto', 5, 0);
INSERT INTO `t_comment` VALUES (4, b'1', 'https://unsplash.it/100/100?image=1005', '杨哥哥', NULL, '1123535521', 'ditto', 5, 0);
INSERT INTO `t_comment` VALUES (5, b'1', 'https://unsplash.it/100/100?image=1005', '你妈死了', NULL, '1123535521', 'ditto', 5, 0);
INSERT INTO `t_comment` VALUES (6, b'1', 'https://unsplash.it/100/100?image=1005', '11111', NULL, '1123535521', 'ditto', 5, 0);
INSERT INTO `t_comment` VALUES (7, b'1', 'https://unsplash.it/100/100?image=1005', '11111111', NULL, '1123535521', 'ditto', 5, 0);
INSERT INTO `t_comment` VALUES (8, b'1', 'https://unsplash.it/100/100?image=1005', '11111111', NULL, '1123535521', 'ditto', 5, 0);
INSERT INTO `t_comment` VALUES (9, b'1', 'https://unsplash.it/100/100?image=1005', '11111111', NULL, '1123535521', 'ditto', 5, 0);
INSERT INTO `t_comment` VALUES (10, b'0', NULL, '其1', NULL, NULL, '游客', 5, 2);
INSERT INTO `t_comment` VALUES (11, b'1', 'https://unsplash.it/100/100?image=1005', '11111111', NULL, '1123535521', 'ditto', 5, 2);
INSERT INTO `t_comment` VALUES (12, b'1', 'https://unsplash.it/100/100?image=1005', '111111111', NULL, '1123535521', 'ditto', 5, 2);
INSERT INTO `t_comment` VALUES (13, b'1', 'https://unsplash.it/100/100?image=1005', '21世纪了爹', NULL, '1123535521', 'ditto', 5, 2);
INSERT INTO `t_comment` VALUES (14, b'1', 'https://unsplash.it/100/100?image=1005', '杨宇十个寄吧', NULL, '1123535521', 'ditto', 5, 2);
INSERT INTO `t_comment` VALUES (15, b'0', '', '555', NULL, NULL, '游客', 5, 5);
INSERT INTO `t_comment` VALUES (16, b'1', 'https://unsplash.it/100/100?image=1005', 'hjhj', NULL, '1123535521', 'ditto', 5, 5);
INSERT INTO `t_comment` VALUES (17, b'1', 'https://unsplash.it/100/100?image=1005', 'ghhghg', NULL, '1123535521', 'ditto', 5, 5);
INSERT INTO `t_comment` VALUES (18, b'1', 'https://unsplash.it/100/100?image=1005', 'iop', NULL, '1123535521', 'ditto', 5, 0);
INSERT INTO `t_comment` VALUES (19, b'1', 'https://unsplash.it/100/100?image=1005', 'huig', NULL, '1123535521', 'ditto', 5, 6);
INSERT INTO `t_comment` VALUES (20, b'1', 'https://unsplash.it/100/100?image=1005', 'poi', NULL, '1123535521', 'ditto', 5, 0);
INSERT INTO `t_comment` VALUES (21, b'1', 'https://unsplash.it/100/100?image=1005', '8455', NULL, '1123535521', 'ditto', 5, 2);

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (3, 'tag1', 1);
INSERT INTO `t_tag` VALUES (4, 'tag2', 1);
INSERT INTO `t_tag` VALUES (5, 'new165', 1);
INSERT INTO `t_tag` VALUES (6, 'tag6', 1);
INSERT INTO `t_tag` VALUES (7, 'tag7', 1);
INSERT INTO `t_tag` VALUES (8, 'tag8', 1);
INSERT INTO `t_tag` VALUES (9, 'tag9', 1);
INSERT INTO `t_tag` VALUES (10, 'tag10', 1);
INSERT INTO `t_tag` VALUES (16, 'aaa', 1);

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO `t_type` VALUES (1, 'type3', 1);
INSERT INTO `t_type` VALUES (2, 'type1', 1);
INSERT INTO `t_type` VALUES (3, 'type2', 1);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'https://unsplash.it/100/100?image=1005', '2020-12-18 23:33:18', '1123535521', 'ditto', '123', '1', '2020-12-18 23:33:45', 'otto');
INSERT INTO `t_user` VALUES (3, NULL, '2021-05-14 02:20:54', '147', 'arya', '123', NULL, NULL, 'arya');
INSERT INTO `t_user` VALUES (4, '', '2021-05-14 02:25:52', '147', 'aryastark', '123456', NULL, '2021-05-14 02:37:35', 'aryaaaa');

SET FOREIGN_KEY_CHECKS = 1;
