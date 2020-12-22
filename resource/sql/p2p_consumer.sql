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
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='用户绑定银行卡信息';

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
  `STATUS` tinyint(1) DEFAULT NULL COMMENT '可用状态',
  `REQUEST_NO` varchar(50) DEFAULT NULL COMMENT '请求流水号',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='c端用户信息表';

-- ----------------------------
-- Table structure for consumer_details
-- ----------------------------
DROP TABLE IF EXISTS `consumer_details`;
CREATE TABLE `consumer_details` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CONSUMER_ID` bigint(20) NOT NULL COMMENT '用户标识',
  `ID_CARD_PHOTO` varchar(50) DEFAULT NULL COMMENT '身份证照片面标识',
  `ID_CARD_EMBLEM` varchar(50) DEFAULT NULL COMMENT '身份证国徽面标识',
  `ADDRESS` varchar(50) DEFAULT NULL COMMENT '住址',
  `ENTERPRISE_MAIL` varchar(20) DEFAULT NULL COMMENT '企业邮箱',
  `CONTACT_RELATION` varchar(10) DEFAULT NULL COMMENT '联系人关系',
  `CONTACT_NAME` varchar(10) DEFAULT NULL COMMENT '联系人姓名',
  `CONTACT_MOBILE` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='用户详细信息表';

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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='充值记录表';

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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='提现记录表';

-- ----------------------------
-- View structure for balance_record_view
-- ----------------------------
DROP VIEW IF EXISTS `balance_record_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `balance_record_view` AS select `recharge_record`.`CONSUMER_ID` AS `CONSUMER_ID`,`recharge_record`.`USER_NO` AS `USER_NO`,`recharge_record`.`AMOUNT` AS `AMOUNT`,`recharge_record`.`CREATE_DATE` AS `CREATE_DATE`,`recharge_record`.`CALLBACK_STATUS` AS `CALLBACK_STATUS` from `recharge_record` where (`recharge_record`.`CALLBACK_STATUS` = 1);

SET FOREIGN_KEY_CHECKS = 1;
