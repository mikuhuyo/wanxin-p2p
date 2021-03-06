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
  `RESPONSE_DATA` text NULL COMMENT '处理结果',
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
