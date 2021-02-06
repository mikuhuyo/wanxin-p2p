DROP DATABASE IF EXISTS `p2p_file`;
CREATE DATABASE  `p2p_file` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `p2p_file`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fileobject
-- ----------------------------
DROP TABLE IF EXISTS `fileobject`;
CREATE TABLE `fileobject` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fileName` varchar(50) DEFAULT NULL COMMENT '原文件名',
  `origin` varchar(20) NOT NULL COMMENT '存储源',
  `resourceKey` varchar(100) NOT NULL COMMENT '文件key',
  `flag` varchar(10) NOT NULL COMMENT '正反面',
  `downloadUrl` varchar(200) DEFAULT NULL COMMENT '文件下载地址',
  `isProtect` tinyint(1) NOT NULL COMMENT '公有还是私有',
  `uploaddate` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
