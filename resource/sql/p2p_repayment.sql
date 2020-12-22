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
