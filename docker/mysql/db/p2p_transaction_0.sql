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
