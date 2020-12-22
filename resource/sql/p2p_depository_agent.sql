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
