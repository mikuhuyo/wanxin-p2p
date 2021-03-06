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
