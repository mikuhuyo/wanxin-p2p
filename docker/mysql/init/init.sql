DROP DATABASE IF EXISTS `minio`;
CREATE DATABASE  `minio` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `minio`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sign
-- ----------------------------
DROP TABLE IF EXISTS `sign`;
CREATE TABLE `sign` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `username` varchar(56) NOT NULL COMMENT '用户名',
  `password` varchar(256) NOT NULL COMMENT '用户密码',
  `appId` varchar(256) NOT NULL COMMENT '应用ID',
  `salt` varchar(256) NOT NULL COMMENT '加密盐',
  `status` char(1) DEFAULT '0' COMMENT '用户状态-0 未开启, 1 开启',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;


DROP DATABASE IF EXISTS `hmily`;
CREATE DATABASE  `hmily` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hmily`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hmily_lock
-- ----------------------------
DROP TABLE IF EXISTS `hmily_lock`;
CREATE TABLE `hmily_lock` (
  `lock_id` bigint(20) NOT NULL COMMENT '主键id',
  `trans_id` bigint(20) NOT NULL COMMENT '全局事务id',
  `participant_id` bigint(20) NOT NULL COMMENT 'hmily参与者id',
  `resource_id` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '资源id',
  `target_table_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '锁定目标表名',
  `target_table_pk` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '锁定表主键',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`lock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='hmily全局lock表';

-- ----------------------------
-- Table structure for hmily_participant_undo
-- ----------------------------
DROP TABLE IF EXISTS `hmily_participant_undo`;
CREATE TABLE `hmily_participant_undo` (
  `undo_id` bigint(20) NOT NULL COMMENT '主键id',
  `participant_id` bigint(20) NOT NULL COMMENT '参与者id',
  `trans_id` bigint(20) NOT NULL COMMENT '全局事务id',
  `resource_id` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '资源id, tac模式下为jdbc url',
  `undo_invocation` longblob NOT NULL COMMENT '回滚调用点',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`undo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='hmily事务参与者undo记录, 用在AC模式';

-- ----------------------------
-- Table structure for hmily_transaction_global
-- ----------------------------
DROP TABLE IF EXISTS `hmily_transaction_global`;
CREATE TABLE `hmily_transaction_global` (
  `trans_id` bigint(20) NOT NULL COMMENT '全局事务id',
  `app_name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名称',
  `status` tinyint(4) NOT NULL COMMENT '事务状态',
  `trans_type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '事务模式',
  `retry` int(11) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `version` int(11) NOT NULL COMMENT '版本号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`trans_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='hmily事务表(发起者)';

-- ----------------------------
-- Table structure for hmily_transaction_participant
-- ----------------------------
DROP TABLE IF EXISTS `hmily_transaction_participant`;
CREATE TABLE `hmily_transaction_participant` (
  `participant_id` bigint(20) NOT NULL COMMENT '参与者事务id',
  `participant_ref_id` bigint(20) DEFAULT NULL COMMENT '参与者关联id且套调用时候会存在',
  `trans_id` bigint(20) NOT NULL COMMENT '全局事务id',
  `trans_type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '事务类型',
  `status` tinyint(4) NOT NULL COMMENT '分支事务状态',
  `app_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用名称',
  `role` tinyint(4) NOT NULL COMMENT '事务角色',
  `retry` int(11) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `target_class` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接口名称',
  `target_method` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接口方法名称',
  `confirm_method` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'confirm方法名称',
  `cancel_method` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'cancel方法名称',
  `confirm_invocation` longblob COMMENT 'confirm调用点',
  `cancel_invocation` longblob COMMENT 'cancel调用点',
  `version` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`participant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='hmily事务参与者';

SET FOREIGN_KEY_CHECKS = 1;


DROP DATABASE IF EXISTS `p2p_account`;
CREATE DATABASE  `p2p_account` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `p2p_account`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '用户名',
  `MOBILE` varchar(50) DEFAULT NULL COMMENT '手机号',
  `PASSWORD` varchar(50) DEFAULT NULL COMMENT '密码',
  `SALT` varchar(50) DEFAULT NULL COMMENT '加密盐',
  `STATUS` tinyint(1) DEFAULT NULL COMMENT '账号状态',
  `DOMAIN` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账号信息';

-- ----------------------------
-- Records of account
-- ----------------------------
BEGIN;
INSERT INTO `account` VALUES (1129286208275427330, 'admin', '', 'c9ed3d27e29562391682311cb17f6283ad8f04a86fc0a474', NULL, 1, 'b');
COMMIT;

-- ----------------------------
-- Table structure for account_role
-- ----------------------------
DROP TABLE IF EXISTS `account_role`;
CREATE TABLE `account_role` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ACCOUNT_ID` bigint(20) DEFAULT NULL COMMENT '账号标识',
  `ROLE_ID` bigint(20) DEFAULT NULL COMMENT '角色标识',
  PRIMARY KEY (`ID`),
  KEY `Fk_Reference_15` (`ACCOUNT_ID`),
  KEY `FK-Reference_16` (`ROLE_ID`),
  CONSTRAINT `FK-Reference_16` FOREIGN KEY (`ROLE_ID`) REFERENCES `role` (`ID`),
  CONSTRAINT `Fk_Reference_15` FOREIGN KEY (`ACCOUNT_ID`) REFERENCES `account` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='账号-角色关系';

-- ----------------------------
-- Records of account_role
-- ----------------------------
BEGIN;
INSERT INTO `account_role` VALUES (1, 1129286208275427330, 1);
COMMIT;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PARENT_ID` bigint(20) DEFAULT NULL COMMENT '父id',
  `TITLE` varchar(50) NOT NULL COMMENT '菜单标题',
  `URL` varchar(200) DEFAULT NULL COMMENT '链接url',
  `ICON` varchar(50) DEFAULT NULL COMMENT '图标',
  `SORT` int(11) NOT NULL COMMENT '排序',
  `COMMENT` varchar(200) DEFAULT NULL COMMENT '说明',
  `STATUS` int(11) NOT NULL COMMENT '状态',
  `PRIVILEGE_CODE` varchar(50) DEFAULT NULL COMMENT '绑定权限',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Table structure for privilege
-- ----------------------------
DROP TABLE IF EXISTS `privilege`;
CREATE TABLE `privilege` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '权限名称',
  `CODE` varchar(50) DEFAULT NULL COMMENT '权限编码',
  `PRIVILEGE_GROUP_ID` bigint(20) DEFAULT NULL COMMENT '所属权限组id',
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_6` (`PRIVILEGE_GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限';

-- ----------------------------
-- Table structure for privilege_group
-- ----------------------------
DROP TABLE IF EXISTS `privilege_group`;
CREATE TABLE `privilege_group` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PARENT_ID` bigint(20) DEFAULT NULL COMMENT '父id',
  `NAME` varchar(50) DEFAULT NULL COMMENT '权限组名称',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限组';

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `CODE` varchar(50) DEFAULT NULL COMMENT '角色编码',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色信息';

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, 'b端用户', 'admin');
INSERT INTO `role` VALUES (2, 'c端用户', 'user');
COMMIT;

-- ----------------------------
-- Table structure for role_privilege
-- ----------------------------
DROP TABLE IF EXISTS `role_privilege`;
CREATE TABLE `role_privilege` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ROLE_ID` bigint(20) DEFAULT NULL COMMENT '角色id',
  `PRIVILEGE_ID` bigint(20) DEFAULT NULL COMMENT '权限id',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-权限关系';

SET FOREIGN_KEY_CHECKS = 1;


DROP DATABASE IF EXISTS `p2p_consumer`;
CREATE DATABASE  `p2p_consumer` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `p2p_consumer`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bank_card
-- ----------------------------
DROP TABLE IF EXISTS `bank_card`;
CREATE TABLE `bank_card` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '用户标识',
  `BANK_CODE` varchar(50) DEFAULT NULL COMMENT '银行编码',
  `BANK_NAME` varchar(50) DEFAULT NULL COMMENT '银行名称',
  `CARD_NUMBER` varchar(50) NOT NULL COMMENT '银行卡号',
  `MOBILE` varchar(50) DEFAULT NULL COMMENT '银行预留手机号',
  `STATUS` bit(1) DEFAULT NULL COMMENT '可用状态',
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_1` (`CONSUMER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户绑定银行卡信息';

-- ----------------------------
-- Table structure for consumer
-- ----------------------------
DROP TABLE IF EXISTS `consumer`;
CREATE TABLE `consumer` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USERNAME` varchar(50) NOT NULL COMMENT '用户名',
  `FULLNAME` varchar(50) DEFAULT '' COMMENT '真实姓名',
  `ID_NUMBER` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '用户编码,生成唯一,用户在存管系统标识',
  `MOBILE` varchar(50) DEFAULT NULL COMMENT '平台预留手机号',
  `USER_TYPE` varchar(50) DEFAULT NULL COMMENT '用户类型,个人or企业，预留',
  `ROLE` varchar(50) DEFAULT NULL COMMENT '用户角色.B借款人or I投资人',
  `AUTH_LIST` varchar(50) DEFAULT NULL COMMENT '存管授权列表',
  `IS_BIND_CARD` tinyint(1) DEFAULT NULL COMMENT '是否已绑定银行卡',
  `LOAN_AMOUNT` decimal(10,0) DEFAULT NULL,
  `STATUS` tinyint(1) DEFAULT NULL COMMENT '可用状态-0 不可用, 1 可用',
  `IS_CARD_AUTH` tinyint(1) DEFAULT NULL COMMENT '是否进行身份验证-0 未验证, 1 已验证',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '请求流水号',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='c端用户信息表';

-- ----------------------------
-- Table structure for consumer_details
-- ----------------------------
DROP TABLE IF EXISTS `consumer_details`;
CREATE TABLE `consumer_details` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '用户标识',
  `ID_CARD_PHOTO` varchar(256) DEFAULT NULL COMMENT '身份证照片面标识',
  `ID_CARD_EMBLEM` varchar(256) DEFAULT NULL COMMENT '身份证国徽面标识',
  `ADDRESS` varchar(50) DEFAULT NULL COMMENT '住址',
  `ENTERPRISE_MAIL` varchar(20) DEFAULT NULL COMMENT '企业邮箱',
  `CONTACT_RELATION` varchar(10) DEFAULT NULL COMMENT '联系人关系',
  `CONTACT_NAME` varchar(10) DEFAULT NULL COMMENT '联系人姓名',
  `CONTACT_MOBILE` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户详细信息表';

-- ----------------------------
-- Table structure for recharge_record
-- ----------------------------
DROP TABLE IF EXISTS `recharge_record`;
CREATE TABLE `recharge_record` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '用户标识',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '用户编码,生成唯一,用户在存管系统标识',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '触发时间',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '请求流水号',
  `CALLBACK_STATUS` tinyint(1) DEFAULT NULL COMMENT '回调状态',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值记录表';

-- ----------------------------
-- Table structure for withdraw_record
-- ----------------------------
DROP TABLE IF EXISTS `withdraw_record`;
CREATE TABLE `withdraw_record` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '用户标识',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '用户编码,生成唯一,用户在存管系统标识',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `COMMISSION` decimal(10,2) DEFAULT NULL COMMENT '平台佣金',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '触发时间',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '请求流水号',
  `CALLBACK_STATUS` tinyint(1) DEFAULT NULL COMMENT '回调状态',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='提现记录表';

-- ----------------------------
-- View structure for balance_record_view
-- ----------------------------
DROP VIEW IF EXISTS `balance_record_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `balance_record_view` AS select `recharge_record`.`CONSUMER_ID` AS `CONSUMER_ID`,`recharge_record`.`USER_NO` AS `USER_NO`,`recharge_record`.`AMOUNT` AS `AMOUNT`,`recharge_record`.`CREATE_DATE` AS `CREATE_DATE`,`recharge_record`.`CALLBACK_STATUS` AS `CALLBACK_STATUS` from `recharge_record` where (`recharge_record`.`CALLBACK_STATUS` = 1);

SET FOREIGN_KEY_CHECKS = 1;


DROP DATABASE IF EXISTS `p2p_bank_depository`;
CREATE DATABASE  `p2p_bank_depository` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `p2p_bank_depository`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for balance_details
-- ----------------------------
DROP TABLE IF EXISTS `balance_details`;
CREATE TABLE `balance_details` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '用户编码,生成唯一,用户在存管系统标识',
  `CHANGE_TYPE` tinyint(4) DEFAULT NULL COMMENT '账户变动类型.1.增加.2.减少.3.冻结.4解冻',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '变动金额',
  `FREEZE_AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '冻结金额',
  `BALANCE` decimal(10,2) DEFAULT NULL COMMENT '可用余额',
  `APP_CODE` varchar(50) DEFAULT NULL COMMENT '应用编码',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '账户变动时间',
  `REQUEST_CONTENT` text COMMENT '引起余额变动的冗余业务信息',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户余额明细表';

-- ----------------------------
-- Table structure for bank_card
-- ----------------------------
DROP TABLE IF EXISTS `bank_card`;
CREATE TABLE `bank_card` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_ID` bigint(20) DEFAULT NULL COMMENT '用户标识',
  `BANK_CODE` varchar(50) NOT NULL COMMENT '银行编码',
  `BANK_NAME` varchar(50) DEFAULT NULL COMMENT '银行名称',
  `CARD_NUMBER` varchar(50) DEFAULT NULL COMMENT '银行卡号',
  `PASSWORD` varchar(50) DEFAULT NULL COMMENT '银行卡密码',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行用户银行卡信息';

-- ----------------------------
-- Table structure for bank_card_details
-- ----------------------------
DROP TABLE IF EXISTS `bank_card_details`;
CREATE TABLE `bank_card_details` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `BANK_CARD_ID` bigint(20) NOT NULL COMMENT '银行卡ID',
  `CHANGE_TYPE` tinyint(4) DEFAULT NULL COMMENT '账户变动类型',
  `MONEY` decimal(10,2) DEFAULT NULL COMMENT '变动金额',
  `BALANCE` decimal(10,2) DEFAULT NULL COMMENT '当前余额',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '账户变动时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行卡明细';

-- ----------------------------
-- Table structure for bank_user
-- ----------------------------
DROP TABLE IF EXISTS `bank_user`;
CREATE TABLE `bank_user` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `FULLNAME` varchar(50) NOT NULL COMMENT '真实姓名',
  `ID_NUMBER` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `MOBILE` varchar(50) DEFAULT NULL COMMENT '银行预留手机号',
  `USER_TYPE` tinyint(4) DEFAULT NULL COMMENT '用户类型,个人1or企业0, 预留',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行用户信息表';

-- ----------------------------
-- Table structure for claim
-- ----------------------------
DROP TABLE IF EXISTS `claim`;
CREATE TABLE `claim` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `PROJECT_ID` bigint(20) DEFAULT NULL COMMENT '标的标识',
  `PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '标的编码',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '发标人用户标识(冗余)',
  `SOURCE_TENDER_ID` bigint(20) NOT NULL COMMENT '投标信息标识(转让来源)',
  `ROOT_PROJECT_ID` bigint(20) DEFAULT NULL COMMENT '原始标的标识(冗余)',
  `ROOT_PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '原始标的编码(冗余)',
  `ASSIGNMENT_REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '债权转让 请求流水号',
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_17` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='债权转让标的附加信息';

-- ----------------------------
-- Table structure for depository_bank_card
-- ----------------------------
DROP TABLE IF EXISTS `depository_bank_card`;
CREATE TABLE `depository_bank_card` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_ID` bigint(20) DEFAULT NULL COMMENT '用户标识',
  `BANK_CODE` varchar(50) NOT NULL COMMENT '银行编码',
  `BANK_NAME` varchar(50) DEFAULT NULL COMMENT '银行名称',
  `CARD_NUMBER` varchar(50) DEFAULT NULL COMMENT '银行卡号',
  `MOBILE` varchar(50) DEFAULT NULL COMMENT '银行预留手机号',
  `APP_CODE` varchar(50) DEFAULT NULL COMMENT '应用编码',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '请求流水号',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存管用户绑定银行卡信息';

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '发标人用户编码',
  `PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '标的编码',
  `NAME` varchar(50) DEFAULT NULL COMMENT '标的名称',
  `DESCRIPTION` longtext COMMENT '标的描述',
  `TYPE` varchar(50) DEFAULT NULL COMMENT '标的类型',
  `PERIOD` int(11) DEFAULT NULL COMMENT '标的期限(单位:天)',
  `BORROWER_ANNUAL_RATE` decimal(10,2) DEFAULT NULL COMMENT '年化利率(借款人视图)',
  `REPAYMENT_WAY` varchar(50) DEFAULT NULL COMMENT '还款方式',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '募集金额',
  `PROJECT_STATUS` varchar(50) DEFAULT NULL COMMENT '标的状态',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `MODIFY_DATE` datetime DEFAULT NULL COMMENT '修改时间',
  `IS_ASSIGNMENT` tinyint(4) DEFAULT NULL COMMENT '是否是债权出让标',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '请求流水号',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的信息表';

-- ----------------------------
-- Table structure for recharge_details
-- ----------------------------
DROP TABLE IF EXISTS `recharge_details`;
CREATE TABLE `recharge_details` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '请求流水号',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '用户编码,生成唯一,用户在存管系统标识',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '触发时间',
  `STATUS` tinyint(4) DEFAULT NULL COMMENT '执行结果',
  `FINISH_DATE` datetime DEFAULT NULL COMMENT '执行返回时间',
  `APP_CODE` varchar(50) DEFAULT NULL COMMENT '应用编码',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值记录表';

-- ----------------------------
-- Table structure for request_details
-- ----------------------------
DROP TABLE IF EXISTS `request_details`;
CREATE TABLE `request_details` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `APP_CODE` varchar(50) DEFAULT NULL COMMENT '应用编码',
  `REQUEST_NO` varchar(50) DEFAULT NULL,
  `SERVICE_NAME` varchar(50) DEFAULT NULL COMMENT '请求类型:1.用户信息, 2.绑卡信息',
  `REQUEST_DATA` text,
  `RESPONSE_DATA` text,
  `STATUS` tinyint(4) DEFAULT NULL COMMENT '执行结果',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '请求时间',
  `FINISH_DATE` datetime DEFAULT NULL COMMENT '执行返回时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存管系统请求信息表';

-- ----------------------------
-- Table structure for tender
-- ----------------------------
DROP TABLE IF EXISTS `tender`;
CREATE TABLE `tender` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '投标人用户编码',
  `PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '标的编码',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '投标冻结金额',
  `TENDER_STATUS` varchar(50) DEFAULT NULL COMMENT '投标状态',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `MODIFY_DATE` datetime DEFAULT NULL COMMENT '修改时间',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '投标/债权转让 请求流水号',
  `REMARK` varchar(50) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投标信息表';

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '用户编码,生成唯一,用户在存管系统标识',
  `FULLNAME` varchar(50) NOT NULL COMMENT '真实姓名',
  `ID_NUMBER` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `PASSWORD` varchar(50) DEFAULT NULL COMMENT '存管支付密码',
  `MOBILE` varchar(50) DEFAULT NULL COMMENT '存管预留手机号',
  `USER_TYPE` tinyint(4) DEFAULT NULL COMMENT '用户类型,个人or企业, 预留',
  `ROLE` varchar(50) DEFAULT NULL COMMENT '用户角色',
  `AUTH_LIST` varchar(50) DEFAULT NULL COMMENT '授权列表',
  `IS_BIND_CARD` tinyint(4) DEFAULT NULL COMMENT '是否已绑定银行卡',
  `APP_CODE` varchar(50) DEFAULT NULL COMMENT '应用编码',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '请求流水号',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '产生时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存管用户信息表';

-- ----------------------------
-- Table structure for withdraw_details
-- ----------------------------
DROP TABLE IF EXISTS `withdraw_details`;
CREATE TABLE `withdraw_details` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '请求流水号',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '用户编码,生成唯一,用户在存管系统标识',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `COMMISSION` decimal(10,2) DEFAULT NULL COMMENT '平台佣金',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '触发时间',
  `STATUS` tinyint(4) DEFAULT NULL COMMENT '执行结果',
  `FINISH_DATE` datetime DEFAULT NULL COMMENT '执行返回时间',
  `APP_CODE` varchar(50) DEFAULT NULL COMMENT '应用编码',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户余额明细表';

SET FOREIGN_KEY_CHECKS = 1;



DROP DATABASE IF EXISTS `p2p_depository_agent`;
CREATE DATABASE  `p2p_depository_agent` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `p2p_depository_agent`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for depository_record
-- ----------------------------
DROP TABLE IF EXISTS `depository_record`;
CREATE TABLE `depository_record` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '请求流水号',
  `REQUEST_TYPE` varchar(50) DEFAULT NULL COMMENT '请求类型:1.用户信息(新增、编辑)、2.绑卡信息',
  `OBJECT_TYPE` varchar(50) DEFAULT NULL COMMENT '业务实体类型',
  `OBJECT_ID` bigint(20) DEFAULT NULL COMMENT '关联业务实体标识',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '请求时间',
  `IS_SYN` tinyint(1) DEFAULT NULL COMMENT '是否是同步调用',
  `REQUEST_STATUS` tinyint(1) DEFAULT NULL COMMENT '数据同步状态',
  `CONFIRM_DATE` datetime DEFAULT NULL COMMENT '消息确认时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存管交易记录表';

SET FOREIGN_KEY_CHECKS = 1;


DROP DATABASE IF EXISTS `p2p_repayment`;
CREATE DATABASE  `p2p_repayment` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `p2p_repayment`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for receivable_detail
-- ----------------------------
DROP TABLE IF EXISTS `receivable_detail`;
CREATE TABLE `receivable_detail` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `RECEIVABLE_ID` bigint(20) DEFAULT NULL COMMENT '应收项标识',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '实收本息',
  `RECEIVABLE_DATE` datetime DEFAULT NULL COMMENT '实收时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资人实收明细';

-- ----------------------------
-- Table structure for receivable_plan
-- ----------------------------
DROP TABLE IF EXISTS `receivable_plan`;
CREATE TABLE `receivable_plan` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `CONSUMER_ID` bigint(20) DEFAULT NULL COMMENT '投标人用户标识',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '投标人用户编码',
  `TENDER_ID` bigint(20) NOT NULL COMMENT '投标信息标识',
  `REPAYMENT_ID` bigint(20) DEFAULT NULL COMMENT '还款计划项标识',
  `NUMBER_OF_PERIODS` int(11) DEFAULT NULL COMMENT '期数',
  `INTEREST` decimal(10,2) DEFAULT NULL COMMENT '应收利息',
  `PRINCIPAL` decimal(10,2) DEFAULT NULL COMMENT '应收本金',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '应收本息',
  `SHOULD_RECEIVABLE_DATE` datetime DEFAULT NULL COMMENT '应收时间',
  `RECEIVABLE_STATUS` tinyint(4) DEFAULT NULL COMMENT '状态：0,.未收 1.已收  2.部分收到',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `COMMISSION` decimal(10,2) DEFAULT NULL COMMENT '年化利率(平台佣金，利差)',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资人应收明细';

-- ----------------------------
-- Table structure for repayment_detail
-- ----------------------------
DROP TABLE IF EXISTS `repayment_detail`;
CREATE TABLE `repayment_detail` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `REPAYMENT_PLAN_ID` bigint(20) DEFAULT NULL COMMENT '还款计划项标识',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '实还本息',
  `REPAYMENT_DATE` datetime DEFAULT NULL COMMENT '实际还款时间',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '冻结用户资金请求流水号(用于解冻合并整体还款)，\r\n            有漏洞，存管不支持单次“确定还款”，合并多个还款预处理的操作，折中做法。',
  `STATUS` tinyint(4) DEFAULT NULL COMMENT '可用状态',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款人还款明细，针对一个还款计划可多次进行还款';

-- ----------------------------
-- Table structure for repayment_plan
-- ----------------------------
DROP TABLE IF EXISTS `repayment_plan`;
CREATE TABLE `repayment_plan` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `CONSUMER_ID` bigint(20) DEFAULT NULL COMMENT '发标人用户标识',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '发标人用户编码',
  `PROJECT_ID` bigint(20) DEFAULT NULL COMMENT '标的标识',
  `PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '标的编码',
  `NUMBER_OF_PERIODS` int(11) DEFAULT NULL COMMENT '期数',
  `INTEREST` decimal(10,2) DEFAULT NULL COMMENT '还款利息',
  `PRINCIPAL` decimal(10,2) DEFAULT NULL COMMENT '还款本金',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '本息',
  `SHOULD_REPAYMENT_DATE` datetime DEFAULT NULL COMMENT '应还时间',
  `REPAYMENT_STATUS` varchar(50) DEFAULT NULL COMMENT '应还状态0.待还,1.已还， 2.部分还款',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '计划创建时间',
  `COMMISSION` decimal(10,2) DEFAULT NULL COMMENT '年化利率(平台佣金，利差)',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款人还款计划';

SET FOREIGN_KEY_CHECKS = 1;


DROP DATABASE IF EXISTS `p2p_transaction_0`;
CREATE DATABASE  `p2p_transaction_0` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `p2p_transaction_0`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for claim
-- ----------------------------
DROP TABLE IF EXISTS `claim`;
CREATE TABLE `claim` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `PROJECT_ID` bigint(20) DEFAULT NULL COMMENT '标的标识',
  `PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '标的编码',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '发标人用户标识(冗余)',
  `SOURCE_TENDER_ID` bigint(20) NOT NULL COMMENT '投标信息标识(转让来源)',
  `ROOT_PROJECT_ID` bigint(20) DEFAULT NULL COMMENT '原始标的标识(冗余)',
  `ROOT_PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '原始标的编码(冗余)',
  `ASSIGNMENT_REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '债权转让 请求流水号',
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_17` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='债权转让标的附加信息';

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '发标人用户标识',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '发标人用户编码',
  `PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '标的编码',
  `NAME` varchar(50) DEFAULT NULL COMMENT '标的名称',
  `DESCRIPTION` longtext COMMENT '标的描述',
  `TYPE` varchar(50) DEFAULT NULL COMMENT '标的类型',
  `PERIOD` int(11) DEFAULT NULL COMMENT '标的期限(单位:天)',
  `ANNUAL_RATE` decimal(10,2) DEFAULT NULL COMMENT '年化利率(投资人视图)',
  `BORROWER_ANNUAL_RATE` decimal(10,2) DEFAULT NULL COMMENT '年化利率(借款人视图)',
  `COMMISSION_ANNUAL_RATE` decimal(10,2) DEFAULT NULL COMMENT '年化利率(平台佣金，利差)',
  `REPAYMENT_WAY` varchar(50) DEFAULT NULL COMMENT '还款方式',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '募集金额',
  `PROJECT_STATUS` varchar(50) DEFAULT NULL COMMENT '标的状态',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `STATUS` tinyint(1) DEFAULT NULL COMMENT '可用状态',
  `IS_ASSIGNMENT` tinyint(4) DEFAULT NULL COMMENT '是否是债权出让标',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的信息表';

-- ----------------------------
-- Table structure for tender
-- ----------------------------
DROP TABLE IF EXISTS `tender`;
CREATE TABLE `tender` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '投标人用户标识',
  `CONSUMER_USERNAME` varchar(50) DEFAULT NULL COMMENT '投标人用户名',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '投标人用户编码',
  `PROJECT_ID` bigint(20) DEFAULT NULL COMMENT '标的标识',
  `PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '标的编码',
  `AMOUNT` decimal(10,0) DEFAULT NULL COMMENT '投标冻结金额',
  `TENDER_STATUS` varchar(50) DEFAULT NULL COMMENT '投标状态',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '投标/债权转让 请求流水号',
  `STATUS` tinyint(4) DEFAULT NULL COMMENT '可用状态',
  `PROJECT_NAME` varchar(50) DEFAULT NULL COMMENT '标的名称',
  `PROJECT_PERIOD` int(11) DEFAULT NULL COMMENT '标的期限(单位:天) -- 冗余字段',
  `PROJECT_ANNUAL_RATE` decimal(10,2) DEFAULT NULL COMMENT '年化利率(投资人视图) -- 冗余字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投标信息表';

SET FOREIGN_KEY_CHECKS = 1;


DROP DATABASE IF EXISTS `p2p_transaction_1`;
CREATE DATABASE  `p2p_transaction_1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `p2p_transaction_1`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for claim
-- ----------------------------
DROP TABLE IF EXISTS `claim`;
CREATE TABLE `claim` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `PROJECT_ID` bigint(20) DEFAULT NULL COMMENT '标的标识',
  `PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '标的编码',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '发标人用户标识(冗余)',
  `SOURCE_TENDER_ID` bigint(20) NOT NULL COMMENT '投标信息标识(转让来源)',
  `ROOT_PROJECT_ID` bigint(20) DEFAULT NULL COMMENT '原始标的标识(冗余)',
  `ROOT_PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '原始标的编码(冗余)',
  `ASSIGNMENT_REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '债权转让 请求流水号',
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_17` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='债权转让标的附加信息';

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '发标人用户标识',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '发标人用户编码',
  `PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '标的编码',
  `NAME` varchar(50) DEFAULT NULL COMMENT '标的名称',
  `DESCRIPTION` longtext COMMENT '标的描述',
  `TYPE` varchar(50) DEFAULT NULL COMMENT '标的类型',
  `PERIOD` int(11) DEFAULT NULL COMMENT '标的期限(单位:天)',
  `ANNUAL_RATE` decimal(10,2) DEFAULT NULL COMMENT '年化利率(投资人视图)',
  `BORROWER_ANNUAL_RATE` decimal(10,2) DEFAULT NULL COMMENT '年化利率(借款人视图)',
  `COMMISSION_ANNUAL_RATE` decimal(10,2) DEFAULT NULL COMMENT '年化利率(平台佣金，利差)',
  `REPAYMENT_WAY` varchar(50) DEFAULT NULL COMMENT '还款方式',
  `AMOUNT` decimal(10,2) DEFAULT NULL COMMENT '募集金额',
  `PROJECT_STATUS` varchar(50) DEFAULT NULL COMMENT '标的状态',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `STATUS` tinyint(1) DEFAULT NULL COMMENT '可用状态',
  `IS_ASSIGNMENT` tinyint(4) DEFAULT NULL COMMENT '是否是债权出让标',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的信息表';

-- ----------------------------
-- Table structure for tender
-- ----------------------------
DROP TABLE IF EXISTS `tender`;
CREATE TABLE `tender` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '投标人用户标识',
  `CONSUMER_USERNAME` varchar(50) DEFAULT NULL COMMENT '投标人用户名',
  `USER_NO` varchar(50) DEFAULT NULL COMMENT '投标人用户编码',
  `PROJECT_ID` bigint(20) DEFAULT NULL COMMENT '标的标识',
  `PROJECT_NO` varchar(50) DEFAULT NULL COMMENT '标的编码',
  `AMOUNT` decimal(10,0) DEFAULT NULL COMMENT '投标冻结金额',
  `TENDER_STATUS` varchar(50) DEFAULT NULL COMMENT '投标状态',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '投标/债权转让 请求流水号',
  `STATUS` tinyint(4) DEFAULT NULL COMMENT '可用状态',
  `PROJECT_NAME` varchar(50) DEFAULT NULL COMMENT '标的名称',
  `PROJECT_PERIOD` int(11) DEFAULT NULL COMMENT '标的期限(单位:天) -- 冗余字段',
  `PROJECT_ANNUAL_RATE` decimal(10,2) DEFAULT NULL COMMENT '年化利率(投资人视图) -- 冗余字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投标信息表';

SET FOREIGN_KEY_CHECKS = 1;


DROP DATABASE IF EXISTS `p2p_uaa`;
CREATE DATABASE  `p2p_uaa` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `p2p_uaa`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_details`;
CREATE TABLE `oauth_client_details` (
  `client_id` varchar(255) NOT NULL,
  `resource_ids` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `authorized_grant_types` varchar(255) DEFAULT NULL,
  `web_server_redirect_uri` varchar(255) DEFAULT NULL,
  `authorities` varchar(255) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` text,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `archived` tinyint(1) DEFAULT '0',
  `trusted` tinyint(1) DEFAULT '0',
  `autoapprove` varchar(255) DEFAULT 'false',
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
BEGIN;
INSERT INTO `oauth_client_details` VALUES ('wanxin-p2p-web-admin', 'wanxin-resource', 'itcastb', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', '', 'ROLE_ADMIN,ROLE_CONSUMER,ROLE_API', 7200, 259200, NULL, '2019-05-07 18:17:18', 0, 0, 'false');
INSERT INTO `oauth_client_details` VALUES ('wanxin-p2p-web-app', 'wanxin-resource', '123456', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', '', 'ROLE_CONSUMER,ROLE_API', 31536000, 2592000, NULL, '2019-05-07 18:17:37', 0, 0, 'false');
INSERT INTO `oauth_client_details` VALUES ('wanxin-p2p-web-h5', 'wanxin-resource', 'itcasth5', 'read', 'client_credentials,password,authorization_code,implicit,refresh_token', '', 'ROLE_CONSUMER,ROLE_API', 31536000, 2592000, NULL, '2019-05-07 19:21:23', 0, 0, 'false');
COMMIT;

-- ----------------------------
-- Table structure for oauth_code
-- ----------------------------
DROP TABLE IF EXISTS `oauth_code`;
CREATE TABLE `oauth_code` (
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `code` varchar(255) DEFAULT NULL,
  `authentication` blob,
  KEY `code_index` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of oauth_code
-- ----------------------------
BEGIN;
INSERT INTO `oauth_code` VALUES ('2019-05-07 16:36:01', 'ZSsBXJ', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000001F40200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000B524F4C455F504147455F417371007E000D740006504147455F427871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E0016787074001477616E78696E2D7032702D7765622D61646D696E737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000374000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740006666461666461740009636C69656E745F696471007E001978737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F400000000000017400047265616478017371007E0026770C000000103F400000000000017371007E000D74000D524F4C455F434F4E53554D4552787371007E001C3F40000000000000770800000010000000007871007E0021707371007E0026770C000000103F4000000000000174000F77616E78696E2D7265736F75726365787371007E0026770C000000103F4000000000000171007E001F787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000001F40200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E003373720042636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E496E746567726174696F6E57656241757468656E7469636174696F6E44657461696C731C938A97B19CA1700200024C001261757468656E7469636174696F6E5479706571007E000E4C0006646F6D61696E71007E000E787200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000001F40200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000F303A303A303A303A303A303A303A31740020343230323236303537364230423838363542373932303733353130463333324174000870617373776F7264740001627073720031636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E556E69666965645573657244657461696C7336EC2B84B1CCA9020200084C000C6465706172746D656E74496471007E000E4C00126772616E746564417574686F72697469657371007E00084C00066D6F62696C6571007E000E4C000870617373776F726471007E000E4C00077061796C6F616471007E00144C000874656E616E74496471007E000E4C000F75736572417574686F72697469657371007E00144C0008757365726E616D6571007E000E7870740001317371007E000B0000000277040000000271007E000F71007E00117874000B31383631313130363938337400063131313131317371007E001C3F4000000000000C7708000000100000000174000372657374000A726573313131313131317871007E003D7371007E001C3F4000000000000C77080000001000000001740005524F4C45317371007E000B0000000277040000000274000270317400027032787874000561646D696E);
INSERT INTO `oauth_code` VALUES ('2019-05-07 16:36:28', 'QwGbDX', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000001F40200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000B524F4C455F504147455F417371007E000D740006504147455F427871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E0016787074001477616E78696E2D7032702D7765622D61646D696E737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000374000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740006666461666461740009636C69656E745F696471007E001978737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F400000000000017400047265616478017371007E0026770C000000103F400000000000017371007E000D74000D524F4C455F434F4E53554D4552787371007E001C3F40000000000000770800000010000000007871007E0021707371007E0026770C000000103F4000000000000174000F77616E78696E2D7265736F75726365787371007E0026770C000000103F4000000000000171007E001F787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000001F40200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E003373720042636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E496E746567726174696F6E57656241757468656E7469636174696F6E44657461696C731C938A97B19CA1700200024C001261757468656E7469636174696F6E5479706571007E000E4C0006646F6D61696E71007E000E787200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000001F40200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000F303A303A303A303A303A303A303A31740020343230323236303537364230423838363542373932303733353130463333324174000870617373776F7264740001627073720031636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E556E69666965645573657244657461696C7336EC2B84B1CCA9020200084C000C6465706172746D656E74496471007E000E4C00126772616E746564417574686F72697469657371007E00084C00066D6F62696C6571007E000E4C000870617373776F726471007E000E4C00077061796C6F616471007E00144C000874656E616E74496471007E000E4C000F75736572417574686F72697469657371007E00144C0008757365726E616D6571007E000E7870740001317371007E000B0000000277040000000271007E000F71007E00117874000B31383631313130363938337400063131313131317371007E001C3F4000000000000C7708000000100000000174000372657374000A726573313131313131317871007E003D7371007E001C3F4000000000000C77080000001000000001740005524F4C45317371007E000B0000000277040000000274000270317400027032787874000561646D696E);
INSERT INTO `oauth_code` VALUES ('2019-05-07 16:38:46', 'EoQHi0', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000001F40200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000B524F4C455F504147455F417371007E000D740006504147455F427871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E0016787074001477616E78696E2D7032702D7765622D61646D696E737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000374000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740006666461666461740009636C69656E745F696471007E001978737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F400000000000017400047265616478017371007E0026770C000000103F400000000000017371007E000D74000D524F4C455F434F4E53554D4552787371007E001C3F40000000000000770800000010000000007871007E0021707371007E0026770C000000103F4000000000000174000F77616E78696E2D7265736F75726365787371007E0026770C000000103F4000000000000171007E001F787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000001F40200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E003373720042636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E496E746567726174696F6E57656241757468656E7469636174696F6E44657461696C731C938A97B19CA1700200024C001261757468656E7469636174696F6E5479706571007E000E4C0006646F6D61696E71007E000E787200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000001F40200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000F303A303A303A303A303A303A303A31740020304641373846394345334634323035313934314346354345464245443246314274000870617373776F7264740001627073720031636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E556E69666965645573657244657461696C7336EC2B84B1CCA9020200084C000C6465706172746D656E74496471007E000E4C00126772616E746564417574686F72697469657371007E00084C00066D6F62696C6571007E000E4C000870617373776F726471007E000E4C00077061796C6F616471007E00144C000874656E616E74496471007E000E4C000F75736572417574686F72697469657371007E00144C0008757365726E616D6571007E000E7870740001317371007E000B0000000277040000000271007E000F71007E00117874000B31383631313130363938337400063131313131317371007E001C3F4000000000000C7708000000100000000174000372657374000A726573313131313131317871007E003D7371007E001C3F4000000000000C77080000001000000001740005524F4C45317371007E000B0000000277040000000274000270317400027032787874000561646D696E);
INSERT INTO `oauth_code` VALUES ('2019-05-07 16:39:08', '2Hjx6y', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000001F40200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000B524F4C455F504147455F417371007E000D740006504147455F427871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E0016787074001477616E78696E2D7032702D7765622D61646D696E737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000374000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740006666461666461740009636C69656E745F696471007E001978737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F400000000000017400047265616478017371007E0026770C000000103F400000000000017371007E000D74000D524F4C455F434F4E53554D4552787371007E001C3F40000000000000770800000010000000007871007E0021707371007E0026770C000000103F4000000000000174000F77616E78696E2D7265736F75726365787371007E0026770C000000103F4000000000000171007E001F787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000001F40200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E003373720042636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E496E746567726174696F6E57656241757468656E7469636174696F6E44657461696C731C938A97B19CA1700200024C001261757468656E7469636174696F6E5479706571007E000E4C0006646F6D61696E71007E000E787200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000001F40200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000F303A303A303A303A303A303A303A31740020304641373846394345334634323035313934314346354345464245443246314274000870617373776F7264740001627073720031636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E556E69666965645573657244657461696C7336EC2B84B1CCA9020200084C000C6465706172746D656E74496471007E000E4C00126772616E746564417574686F72697469657371007E00084C00066D6F62696C6571007E000E4C000870617373776F726471007E000E4C00077061796C6F616471007E00144C000874656E616E74496471007E000E4C000F75736572417574686F72697469657371007E00144C0008757365726E616D6571007E000E7870740001317371007E000B0000000277040000000271007E000F71007E00117874000B31383631313130363938337400063131313131317371007E001C3F4000000000000C7708000000100000000174000372657374000A726573313131313131317871007E003D7371007E001C3F4000000000000C77080000001000000001740005524F4C45317371007E000B0000000277040000000274000270317400027032787874000561646D696E);
INSERT INTO `oauth_code` VALUES ('2019-05-07 16:39:53', 'Ety7jZ', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000001F40200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000B524F4C455F504147455F417371007E000D740006504147455F427871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E0016787074001477616E78696E2D7032702D7765622D61646D696E737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000374000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740006666461666461740009636C69656E745F696471007E001978737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F400000000000017400047265616478017371007E0026770C000000103F400000000000017371007E000D74000D524F4C455F434F4E53554D4552787371007E001C3F40000000000000770800000010000000007871007E0021707371007E0026770C000000103F4000000000000174000F77616E78696E2D7265736F75726365787371007E0026770C000000103F4000000000000171007E001F787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000001F40200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E003373720042636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E496E746567726174696F6E57656241757468656E7469636174696F6E44657461696C731C938A97B19CA1700200024C001261757468656E7469636174696F6E5479706571007E000E4C0006646F6D61696E71007E000E787200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000001F40200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000C3137322E31362E302E313538740020353843343139323538383845353145443843303044374543313841343844384474000870617373776F7264740001627073720031636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E556E69666965645573657244657461696C7336EC2B84B1CCA9020200084C000C6465706172746D656E74496471007E000E4C00126772616E746564417574686F72697469657371007E00084C00066D6F62696C6571007E000E4C000870617373776F726471007E000E4C00077061796C6F616471007E00144C000874656E616E74496471007E000E4C000F75736572417574686F72697469657371007E00144C0008757365726E616D6571007E000E7870740001317371007E000B0000000277040000000271007E000F71007E00117874000B31383631313130363938337400063131313131317371007E001C3F4000000000000C7708000000100000000174000372657374000A726573313131313131317871007E003D7371007E001C3F4000000000000C77080000001000000001740005524F4C45317371007E000B0000000277040000000274000270317400027032787874000561646D696E);
INSERT INTO `oauth_code` VALUES ('2019-05-07 16:40:25', 'Wft44a', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000001F40200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000B524F4C455F504147455F417371007E000D740006504147455F427871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E0016787074001477616E78696E2D7032702D7765622D61646D696E737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000374000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740006666461666461740009636C69656E745F696471007E001978737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F400000000000017400047265616478017371007E0026770C000000103F400000000000017371007E000D74000D524F4C455F434F4E53554D4552787371007E001C3F40000000000000770800000010000000007871007E0021707371007E0026770C000000103F4000000000000174000F77616E78696E2D7265736F75726365787371007E0026770C000000103F4000000000000171007E001F787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000001F40200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E003373720042636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E496E746567726174696F6E57656241757468656E7469636174696F6E44657461696C731C938A97B19CA1700200024C001261757468656E7469636174696F6E5479706571007E000E4C0006646F6D61696E71007E000E787200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000001F40200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000C3137322E31362E302E313538740020353843343139323538383845353145443843303044374543313841343844384474000870617373776F7264740001627073720031636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E556E69666965645573657244657461696C7336EC2B84B1CCA9020200084C000C6465706172746D656E74496471007E000E4C00126772616E746564417574686F72697469657371007E00084C00066D6F62696C6571007E000E4C000870617373776F726471007E000E4C00077061796C6F616471007E00144C000874656E616E74496471007E000E4C000F75736572417574686F72697469657371007E00144C0008757365726E616D6571007E000E7870740001317371007E000B0000000277040000000271007E000F71007E00117874000B31383631313130363938337400063131313131317371007E001C3F4000000000000C7708000000100000000174000372657374000A726573313131313131317871007E003D7371007E001C3F4000000000000C77080000001000000001740005524F4C45317371007E000B0000000277040000000274000270317400027032787874000561646D696E);
INSERT INTO `oauth_code` VALUES ('2019-05-07 16:44:27', 'ZHygQU', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000001F40200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000B524F4C455F504147455F417371007E000D740006504147455F427871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E0016787074001477616E78696E2D7032702D7765622D61646D696E737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000374000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740006666461666461740009636C69656E745F696471007E001978737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F400000000000017400047265616478017371007E0026770C000000103F400000000000017371007E000D74000D524F4C455F434F4E53554D4552787371007E001C3F40000000000000770800000010000000007871007E0021707371007E0026770C000000103F4000000000000174000F77616E78696E2D7265736F75726365787371007E0026770C000000103F4000000000000171007E001F787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000001F40200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E003373720042636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E496E746567726174696F6E57656241757468656E7469636174696F6E44657461696C731C938A97B19CA1700200024C001261757468656E7469636174696F6E5479706571007E000E4C0006646F6D61696E71007E000E787200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000001F40200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000C3137322E31362E302E313538740020383939424535433943454332343343353031353839363134313442303242463574000870617373776F7264740001627073720031636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E556E69666965645573657244657461696C7336EC2B84B1CCA9020200084C000C6465706172746D656E74496471007E000E4C00126772616E746564417574686F72697469657371007E00084C00066D6F62696C6571007E000E4C000870617373776F726471007E000E4C00077061796C6F616471007E00144C000874656E616E74496471007E000E4C000F75736572417574686F72697469657371007E00144C0008757365726E616D6571007E000E7870740001317371007E000B0000000277040000000271007E000F71007E00117874000B31383631313130363938337400063131313131317371007E001C3F4000000000000C7708000000100000000174000372657374000A726573313131313131317871007E003D7371007E001C3F4000000000000C77080000001000000001740005524F4C45317371007E000B0000000277040000000274000270317400027032787874000561646D696E);
INSERT INTO `oauth_code` VALUES ('2019-05-07 17:06:26', 'nUaf5O', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000001F40200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000B524F4C455F504147455F417371007E000D740006504147455F427871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E0016787074001477616E78696E2D7032702D7765622D61646D696E737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000374000D726573706F6E73655F74797065740004636F646574000C72656469726563745F75726974000461616161740009636C69656E745F696471007E001978737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F400000000000017400047265616478017371007E0026770C000000103F400000000000017371007E000D74000D524F4C455F434F4E53554D4552787371007E001C3F40000000000000770800000010000000007871007E0021707371007E0026770C000000103F4000000000000174000F77616E78696E2D7265736F75726365787371007E0026770C000000103F4000000000000171007E001F787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000001F40200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E003373720042636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E496E746567726174696F6E57656241757468656E7469636174696F6E44657461696C731C938A97B19CA1700200024C001261757468656E7469636174696F6E5479706571007E000E4C0006646F6D61696E71007E000E787200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000001F40200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000C3137322E31362E302E313538740020453038463141303036323138314432314534433832433630343845454430463574000870617373776F7264740001627073720031636E2E6974636173742E77616E78696E7032702E7561612E646F6D61696E2E556E69666965645573657244657461696C7336EC2B84B1CCA9020200084C000C6465706172746D656E74496471007E000E4C00126772616E746564417574686F72697469657371007E00084C00066D6F62696C6571007E000E4C000870617373776F726471007E000E4C00077061796C6F616471007E00144C000874656E616E74496471007E000E4C000F75736572417574686F72697469657371007E00144C0008757365726E616D6571007E000E7870740001317371007E000B0000000277040000000271007E000F71007E00117874000B31383631313130363938337400063131313131317371007E001C3F4000000000000C7708000000100000000174000372657374000A726573313131313131317871007E003D7371007E001C3F4000000000000C77080000001000000001740005524F4C45317371007E000B0000000277040000000274000270317400027032787874000561646D696E);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
