DROP DATABASE IF EXISTS `ApolloPortalDB`;
CREATE DATABASE  `ApolloPortalDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ApolloPortalDB`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for App
-- ----------------------------
DROP TABLE IF EXISTS `App`;
CREATE TABLE `App` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId` (`AppId`(191)),
  KEY `DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_Name` (`Name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='应用表';

-- ----------------------------
-- Records of App
-- ----------------------------
BEGIN;
INSERT INTO `App` VALUES (1, 'consumer-service', 'C端用户服务', 'micro_service', '万信金融项目组', 'apollo', 'apollo@acme.com', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-07-16 11:55:44');
INSERT INTO `App` VALUES (2, 'common-template', '通用配置模板', 'micro_service', '万信金融项目组', 'apollo', 'apollo@acme.com', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-07-16 11:55:46');
INSERT INTO `App` VALUES (4, 'gateway-server', 'OAuth2.0网关服务', 'micro_service', '万信金融项目组', 'apollo', 'apollo@acme.com', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-07-16 11:55:47');
INSERT INTO `App` VALUES (6, 'wanxin-depository', '万信银行存管系统', 'micro_service', '万信金融项目组', 'apollo', 'apollo@acme.com', b'0', 'apollo', '2019-05-08 21:29:38', 'apollo', '2019-07-16 11:55:49');
INSERT INTO `App` VALUES (16, 'account-service', '统一账户服务', 'micro_service', '万信金融项目组', 'apollo', 'apollo@acme.com', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `App` VALUES (17, 'uaa-service', '认证中心', 'micro_service', '万信金融项目组', 'apollo', 'apollo@acme.com', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `App` VALUES (18, 'depository-agent-service', '银行存管代理', 'micro_service', '万信金融项目组', 'apollo', 'apollo@acme.com', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
COMMIT;

-- ----------------------------
-- Table structure for AppNamespace
-- ----------------------------
DROP TABLE IF EXISTS `AppNamespace`;
CREATE TABLE `AppNamespace` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Name` varchar(32) NOT NULL DEFAULT '' COMMENT 'namespace名字，注意，需要全局唯一',
  `AppId` varchar(32) NOT NULL DEFAULT '' COMMENT 'app id',
  `Format` varchar(32) NOT NULL DEFAULT 'properties' COMMENT 'namespace的format类型',
  `IsPublic` bit(1) NOT NULL DEFAULT b'0' COMMENT 'namespace是否为公共',
  `Comment` varchar(64) NOT NULL DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_AppId` (`AppId`),
  KEY `Name_AppId` (`Name`,`AppId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COMMENT='应用namespace定义';

-- ----------------------------
-- Records of AppNamespace
-- ----------------------------
BEGIN;
INSERT INTO `AppNamespace` VALUES (1, 'application', 'consumer-service', 'properties', b'0', 'default app namespace', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `AppNamespace` VALUES (2, 'application', 'common-template', 'properties', b'0', 'default app namespace', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `AppNamespace` VALUES (3, 'micro_service.spring-boot-mysql', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `AppNamespace` VALUES (4, 'micro_service.spring-boot-http', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `AppNamespace` VALUES (5, 'micro_service.spring-eureka', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `AppNamespace` VALUES (6, 'micro_service.spring-cloud-feign', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `AppNamespace` VALUES (7, 'micro_service.spring-hystrix', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `AppNamespace` VALUES (8, 'micro_service.spring-ribbon', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `AppNamespace` VALUES (9, 'micro_service.spring-freemarker', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `AppNamespace` VALUES (10, 'micro_service.spring-boot-redis', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `AppNamespace` VALUES (11, 'micro_service.mybatis-plus', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `AppNamespace` VALUES (12, 'micro_service.spring-boot-druid', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `AppNamespace` VALUES (13, 'micro_service.spring-rocketmq', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `AppNamespace` VALUES (15, 'micro_service.spring-boot-es', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `AppNamespace` VALUES (16, 'application', 'gateway-server', 'properties', b'0', 'default app namespace', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `AppNamespace` VALUES (18, 'application', 'wanxin-depository', 'properties', b'0', 'default app namespace', b'0', 'apollo', '2019-05-08 21:29:38', 'apollo', '2019-05-08 21:29:38');
INSERT INTO `AppNamespace` VALUES (25, 'micro_service.spring-zuul', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `AppNamespace` VALUES (29, 'micro_service.fileservice', 'consumer-service', 'properties', b'1', '文件存储配置', b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `AppNamespace` VALUES (31, 'micro_service.files', 'consumer-service', 'properties', b'1', '文件存储配置', b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `AppNamespace` VALUES (32, 'micro_service.gateway-flow-rule', 'gateway-server', 'properties', b'1', '', b'0', 'apollo', '2019-07-03 14:43:16', 'apollo', '2019-07-03 14:43:16');
INSERT INTO `AppNamespace` VALUES (34, 'application', 'account-service', 'properties', b'0', 'default app namespace', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `AppNamespace` VALUES (35, 'application', 'uaa-service', 'properties', b'0', 'default app namespace', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `AppNamespace` VALUES (36, 'application', 'depository-agent-service', 'properties', b'0', 'default app namespace', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `AppNamespace` VALUES (37, 'micro_service.spring-feign', 'common-template', 'properties', b'1', '', b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
COMMIT;

-- ----------------------------
-- Table structure for Authorities
-- ----------------------------
DROP TABLE IF EXISTS `Authorities`;
CREATE TABLE `Authorities` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) NOT NULL,
  `Authority` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of Authorities
-- ----------------------------
BEGIN;
INSERT INTO `Authorities` VALUES (1, 'apollo', 'ROLE_user');
COMMIT;

-- ----------------------------
-- Table structure for Consumer
-- ----------------------------
DROP TABLE IF EXISTS `Consumer`;
CREATE TABLE `Consumer` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId` (`AppId`(191)),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='开放API消费者';

-- ----------------------------
-- Table structure for ConsumerAudit
-- ----------------------------
DROP TABLE IF EXISTS `ConsumerAudit`;
CREATE TABLE `ConsumerAudit` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'Consumer Id',
  `Uri` varchar(1024) NOT NULL DEFAULT '' COMMENT '访问的Uri',
  `Method` varchar(16) NOT NULL DEFAULT '' COMMENT '访问的Method',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_ConsumerId` (`ConsumerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='consumer审计表';

-- ----------------------------
-- Table structure for ConsumerRole
-- ----------------------------
DROP TABLE IF EXISTS `ConsumerRole`;
CREATE TABLE `ConsumerRole` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'Consumer Id',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`),
  KEY `IX_ConsumerId_RoleId` (`ConsumerId`,`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='consumer和role的绑定表';

-- ----------------------------
-- Table structure for ConsumerToken
-- ----------------------------
DROP TABLE IF EXISTS `ConsumerToken`;
CREATE TABLE `ConsumerToken` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'ConsumerId',
  `Token` varchar(128) NOT NULL DEFAULT '' COMMENT 'token',
  `Expires` datetime NOT NULL DEFAULT '2099-01-01 00:00:00' COMMENT 'token失效时间',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_Token` (`Token`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='consumer token表';

-- ----------------------------
-- Table structure for Favorite
-- ----------------------------
DROP TABLE IF EXISTS `Favorite`;
CREATE TABLE `Favorite` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UserId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '收藏的用户',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Position` int(32) NOT NULL DEFAULT '10000' COMMENT '收藏顺序',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId` (`AppId`(191)),
  KEY `IX_UserId` (`UserId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='应用收藏表';

-- ----------------------------
-- Table structure for Permission
-- ----------------------------
DROP TABLE IF EXISTS `Permission`;
CREATE TABLE `Permission` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `PermissionType` varchar(32) NOT NULL DEFAULT '' COMMENT '权限类型',
  `TargetId` varchar(256) NOT NULL DEFAULT '' COMMENT '权限对象类型',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_TargetId_PermissionType` (`TargetId`(191),`PermissionType`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=725 DEFAULT CHARSET=utf8mb4 COMMENT='permission表';

-- ----------------------------
-- Records of Permission
-- ----------------------------
BEGIN;
INSERT INTO `Permission` VALUES (1, 'CreateCluster', 'consumer-service', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Permission` VALUES (2, 'CreateNamespace', 'consumer-service', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Permission` VALUES (3, 'AssignRole', 'consumer-service', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Permission` VALUES (4, 'ModifyNamespace', 'consumer-service+application', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Permission` VALUES (5, 'ReleaseNamespace', 'consumer-service+application', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Permission` VALUES (6, 'ModifyNamespace', 'consumer-service+application+DEV', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Permission` VALUES (7, 'ReleaseNamespace', 'consumer-service+application+DEV', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Permission` VALUES (8, 'CreateNamespace', 'common-template', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Permission` VALUES (9, 'AssignRole', 'common-template', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Permission` VALUES (10, 'CreateCluster', 'common-template', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Permission` VALUES (11, 'ModifyNamespace', 'common-template+application', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Permission` VALUES (12, 'ReleaseNamespace', 'common-template+application', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Permission` VALUES (13, 'ModifyNamespace', 'common-template+application+DEV', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Permission` VALUES (14, 'ReleaseNamespace', 'common-template+application+DEV', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Permission` VALUES (15, 'ModifyNamespace', 'common-template+micro_service.spring-boot-mysql', b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `Permission` VALUES (16, 'ReleaseNamespace', 'common-template+micro_service.spring-boot-mysql', b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `Permission` VALUES (17, 'ModifyNamespace', 'common-template+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `Permission` VALUES (18, 'ReleaseNamespace', 'common-template+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `Permission` VALUES (19, 'ModifyNamespace', 'common-template+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `Permission` VALUES (20, 'ReleaseNamespace', 'common-template+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `Permission` VALUES (21, 'ModifyNamespace', 'common-template+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `Permission` VALUES (22, 'ReleaseNamespace', 'common-template+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `Permission` VALUES (23, 'ModifyNamespace', 'common-template+micro_service.spring-eureka', b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `Permission` VALUES (24, 'ReleaseNamespace', 'common-template+micro_service.spring-eureka', b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `Permission` VALUES (25, 'ModifyNamespace', 'common-template+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `Permission` VALUES (26, 'ReleaseNamespace', 'common-template+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `Permission` VALUES (27, 'ModifyNamespace', 'common-template+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `Permission` VALUES (28, 'ReleaseNamespace', 'common-template+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `Permission` VALUES (29, 'ModifyNamespace', 'common-template+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `Permission` VALUES (30, 'ReleaseNamespace', 'common-template+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `Permission` VALUES (31, 'ModifyNamespace', 'common-template+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `Permission` VALUES (32, 'ReleaseNamespace', 'common-template+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `Permission` VALUES (33, 'ModifyNamespace', 'common-template+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `Permission` VALUES (34, 'ReleaseNamespace', 'common-template+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `Permission` VALUES (35, 'ModifyNamespace', 'common-template+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `Permission` VALUES (36, 'ReleaseNamespace', 'common-template+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `Permission` VALUES (37, 'ModifyNamespace', 'common-template+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `Permission` VALUES (38, 'ReleaseNamespace', 'common-template+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `Permission` VALUES (39, 'ModifyNamespace', 'common-template+micro_service.spring-freemarker', b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `Permission` VALUES (40, 'ReleaseNamespace', 'common-template+micro_service.spring-freemarker', b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `Permission` VALUES (41, 'ModifyNamespace', 'common-template+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `Permission` VALUES (42, 'ReleaseNamespace', 'common-template+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `Permission` VALUES (43, 'ModifyNamespace', 'consumer-service+micro_service.spring-boot-mysql', b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `Permission` VALUES (44, 'ReleaseNamespace', 'consumer-service+micro_service.spring-boot-mysql', b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `Permission` VALUES (45, 'ModifyNamespace', 'consumer-service+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `Permission` VALUES (46, 'ReleaseNamespace', 'consumer-service+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `Permission` VALUES (47, 'ModifyNamespace', 'consumer-service+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `Permission` VALUES (48, 'ReleaseNamespace', 'consumer-service+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `Permission` VALUES (49, 'ModifyNamespace', 'consumer-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `Permission` VALUES (50, 'ReleaseNamespace', 'consumer-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `Permission` VALUES (51, 'ModifyNamespace', 'consumer-service+micro_service.spring-eureka', b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `Permission` VALUES (52, 'ReleaseNamespace', 'consumer-service+micro_service.spring-eureka', b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `Permission` VALUES (53, 'ModifyNamespace', 'consumer-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `Permission` VALUES (54, 'ReleaseNamespace', 'consumer-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `Permission` VALUES (55, 'ModifyNamespace', 'consumer-service+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `Permission` VALUES (56, 'ReleaseNamespace', 'consumer-service+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `Permission` VALUES (57, 'ModifyNamespace', 'consumer-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `Permission` VALUES (58, 'ReleaseNamespace', 'consumer-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `Permission` VALUES (59, 'ModifyNamespace', 'consumer-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `Permission` VALUES (60, 'ReleaseNamespace', 'consumer-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `Permission` VALUES (61, 'ModifyNamespace', 'consumer-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `Permission` VALUES (62, 'ReleaseNamespace', 'consumer-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `Permission` VALUES (63, 'ModifyNamespace', 'consumer-service+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `Permission` VALUES (64, 'ReleaseNamespace', 'consumer-service+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `Permission` VALUES (65, 'ModifyNamespace', 'consumer-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `Permission` VALUES (66, 'ReleaseNamespace', 'consumer-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `Permission` VALUES (67, 'ModifyNamespace', 'common-template+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `Permission` VALUES (68, 'ReleaseNamespace', 'common-template+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `Permission` VALUES (69, 'ModifyNamespace', 'common-template+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `Permission` VALUES (70, 'ReleaseNamespace', 'common-template+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `Permission` VALUES (71, 'ModifyNamespace', 'consumer-service+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `Permission` VALUES (72, 'ReleaseNamespace', 'consumer-service+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `Permission` VALUES (73, 'ModifyNamespace', 'consumer-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `Permission` VALUES (74, 'ReleaseNamespace', 'consumer-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `Permission` VALUES (75, 'ModifyNamespace', 'common-template+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `Permission` VALUES (76, 'ReleaseNamespace', 'common-template+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `Permission` VALUES (77, 'ModifyNamespace', 'common-template+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `Permission` VALUES (78, 'ReleaseNamespace', 'common-template+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `Permission` VALUES (79, 'ModifyNamespace', 'consumer-service+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `Permission` VALUES (80, 'ReleaseNamespace', 'consumer-service+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `Permission` VALUES (81, 'ModifyNamespace', 'consumer-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `Permission` VALUES (82, 'ReleaseNamespace', 'consumer-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `Permission` VALUES (83, 'ModifyNamespace', 'common-template+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `Permission` VALUES (84, 'ReleaseNamespace', 'common-template+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `Permission` VALUES (85, 'ModifyNamespace', 'common-template+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `Permission` VALUES (86, 'ReleaseNamespace', 'common-template+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `Permission` VALUES (87, 'ModifyNamespace', 'consumer-service+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `Permission` VALUES (88, 'ReleaseNamespace', 'consumer-service+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `Permission` VALUES (89, 'ModifyNamespace', 'consumer-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `Permission` VALUES (90, 'ReleaseNamespace', 'consumer-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `Permission` VALUES (91, 'ModifyNamespace', 'common-template+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `Permission` VALUES (92, 'ReleaseNamespace', 'common-template+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `Permission` VALUES (93, 'ModifyNamespace', 'common-template+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `Permission` VALUES (94, 'ReleaseNamespace', 'common-template+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `Permission` VALUES (95, 'ModifyNamespace', 'consumer-service+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `Permission` VALUES (96, 'ReleaseNamespace', 'consumer-service+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `Permission` VALUES (97, 'ModifyNamespace', 'consumer-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `Permission` VALUES (98, 'ReleaseNamespace', 'consumer-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `Permission` VALUES (99, 'CreateNamespace', 'transaction-service', b'1', 'apollo', '2019-05-07 00:40:14', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (100, 'AssignRole', 'transaction-service', b'1', 'apollo', '2019-05-07 00:40:14', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (101, 'CreateCluster', 'transaction-service', b'1', 'apollo', '2019-05-07 00:40:14', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (102, 'ModifyNamespace', 'transaction-service+application', b'1', 'apollo', '2019-05-07 00:40:14', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (103, 'ReleaseNamespace', 'transaction-service+application', b'1', 'apollo', '2019-05-07 00:40:14', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (104, 'ModifyNamespace', 'transaction-service+application+DEV', b'1', 'apollo', '2019-05-07 00:40:14', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (105, 'ReleaseNamespace', 'transaction-service+application+DEV', b'1', 'apollo', '2019-05-07 00:40:14', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (106, 'ModifyNamespace', 'transaction-service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-07 00:41:19', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (107, 'ReleaseNamespace', 'transaction-service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-07 00:41:19', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (108, 'ModifyNamespace', 'transaction-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-07 00:41:19', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (109, 'ReleaseNamespace', 'transaction-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-07 00:41:19', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (110, 'ModifyNamespace', 'transaction-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-07 00:41:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (111, 'ReleaseNamespace', 'transaction-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-07 00:41:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (112, 'ModifyNamespace', 'transaction-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-07 00:41:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (113, 'ReleaseNamespace', 'transaction-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-07 00:41:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (114, 'ModifyNamespace', 'transaction-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-07 00:42:18', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (115, 'ReleaseNamespace', 'transaction-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-07 00:42:18', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (116, 'ModifyNamespace', 'transaction-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-07 00:42:18', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (117, 'ReleaseNamespace', 'transaction-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-07 00:42:18', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (118, 'ModifyNamespace', 'transaction-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-07 00:42:28', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (119, 'ReleaseNamespace', 'transaction-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-07 00:42:28', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (120, 'ModifyNamespace', 'transaction-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-07 00:42:28', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (121, 'ReleaseNamespace', 'transaction-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-07 00:42:28', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (122, 'ModifyNamespace', 'transaction-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-05-07 00:42:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (123, 'ReleaseNamespace', 'transaction-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-05-07 00:42:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (124, 'ModifyNamespace', 'transaction-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-05-07 00:42:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (125, 'ReleaseNamespace', 'transaction-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-05-07 00:42:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (126, 'ModifyNamespace', 'transaction-service+micro_service.spring-freemarker', b'1', 'apollo', '2019-05-07 00:43:05', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (127, 'ReleaseNamespace', 'transaction-service+micro_service.spring-freemarker', b'1', 'apollo', '2019-05-07 00:43:05', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (128, 'ModifyNamespace', 'transaction-service+micro_service.spring-freemarker+DEV', b'1', 'apollo', '2019-05-07 00:43:05', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (129, 'ReleaseNamespace', 'transaction-service+micro_service.spring-freemarker+DEV', b'1', 'apollo', '2019-05-07 00:43:05', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (130, 'ModifyNamespace', 'transaction-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-05-07 00:43:17', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (131, 'ReleaseNamespace', 'transaction-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-05-07 00:43:17', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (132, 'ModifyNamespace', 'transaction-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-05-07 00:43:17', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (133, 'ReleaseNamespace', 'transaction-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-05-07 00:43:17', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (134, 'ModifyNamespace', 'transaction-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-07 00:43:34', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (135, 'ReleaseNamespace', 'transaction-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-07 00:43:34', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (136, 'ModifyNamespace', 'transaction-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-07 00:43:34', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (137, 'ReleaseNamespace', 'transaction-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-07 00:43:34', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `Permission` VALUES (138, 'ModifyNamespace', 'common-template+micro_service.spring-boot-es', b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `Permission` VALUES (139, 'ReleaseNamespace', 'common-template+micro_service.spring-boot-es', b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `Permission` VALUES (140, 'ModifyNamespace', 'common-template+micro_service.spring-boot-es+DEV', b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `Permission` VALUES (141, 'ReleaseNamespace', 'common-template+micro_service.spring-boot-es+DEV', b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `Permission` VALUES (142, 'CreateCluster', 'gateway-server', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Permission` VALUES (143, 'CreateNamespace', 'gateway-server', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Permission` VALUES (144, 'AssignRole', 'gateway-server', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Permission` VALUES (145, 'ModifyNamespace', 'gateway-server+application', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Permission` VALUES (146, 'ReleaseNamespace', 'gateway-server+application', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Permission` VALUES (147, 'ModifyNamespace', 'gateway-server+application+DEV', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Permission` VALUES (148, 'ReleaseNamespace', 'gateway-server+application+DEV', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Permission` VALUES (149, 'ModifyNamespace', 'gateway-server+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `Permission` VALUES (150, 'ReleaseNamespace', 'gateway-server+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `Permission` VALUES (151, 'ModifyNamespace', 'gateway-server+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `Permission` VALUES (152, 'ReleaseNamespace', 'gateway-server+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `Permission` VALUES (153, 'ModifyNamespace', 'gateway-server+micro_service.spring-eureka', b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `Permission` VALUES (154, 'ReleaseNamespace', 'gateway-server+micro_service.spring-eureka', b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `Permission` VALUES (155, 'ModifyNamespace', 'gateway-server+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `Permission` VALUES (156, 'ReleaseNamespace', 'gateway-server+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `Permission` VALUES (157, 'ModifyNamespace', 'gateway-server+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `Permission` VALUES (158, 'ReleaseNamespace', 'gateway-server+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `Permission` VALUES (159, 'ModifyNamespace', 'gateway-server+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `Permission` VALUES (160, 'ReleaseNamespace', 'gateway-server+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `Permission` VALUES (161, 'ModifyNamespace', 'gateway-server+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `Permission` VALUES (162, 'ReleaseNamespace', 'gateway-server+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `Permission` VALUES (163, 'ModifyNamespace', 'gateway-server+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `Permission` VALUES (164, 'ReleaseNamespace', 'gateway-server+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `Permission` VALUES (165, 'ModifyNamespace', 'gateway-server+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `Permission` VALUES (166, 'ReleaseNamespace', 'gateway-server+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `Permission` VALUES (167, 'ModifyNamespace', 'gateway-server+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `Permission` VALUES (168, 'ReleaseNamespace', 'gateway-server+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `Permission` VALUES (169, 'ModifyNamespace', 'gateway-server+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `Permission` VALUES (170, 'ReleaseNamespace', 'gateway-server+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `Permission` VALUES (171, 'ModifyNamespace', 'gateway-server+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `Permission` VALUES (172, 'ReleaseNamespace', 'gateway-server+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `Permission` VALUES (173, 'ModifyNamespace', 'gateway-server+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `Permission` VALUES (174, 'ReleaseNamespace', 'gateway-server+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `Permission` VALUES (175, 'ModifyNamespace', 'gateway-server+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `Permission` VALUES (176, 'ReleaseNamespace', 'gateway-server+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `Permission` VALUES (177, 'CreateCluster', 'uaa-service', b'1', 'apollo', '2019-05-07 19:03:38', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (178, 'CreateNamespace', 'uaa-service', b'1', 'apollo', '2019-05-07 19:03:38', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (179, 'AssignRole', 'uaa-service', b'1', 'apollo', '2019-05-07 19:03:38', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (180, 'ModifyNamespace', 'uaa-service+application', b'1', 'apollo', '2019-05-07 19:03:38', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (181, 'ReleaseNamespace', 'uaa-service+application', b'1', 'apollo', '2019-05-07 19:03:38', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (182, 'ModifyNamespace', 'uaa-service+application+DEV', b'1', 'apollo', '2019-05-07 19:03:38', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (183, 'ReleaseNamespace', 'uaa-service+application+DEV', b'1', 'apollo', '2019-05-07 19:03:38', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (184, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-07 19:05:50', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (185, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-07 19:05:50', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (186, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-07 19:05:50', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (187, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-07 19:05:50', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (188, 'ModifyNamespace', 'uaa-service+micro_service.spring-freemarker', b'1', 'apollo', '2019-05-07 19:06:39', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (189, 'ReleaseNamespace', 'uaa-service+micro_service.spring-freemarker', b'1', 'apollo', '2019-05-07 19:06:39', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (190, 'ModifyNamespace', 'uaa-service+micro_service.spring-freemarker+DEV', b'1', 'apollo', '2019-05-07 19:06:39', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (191, 'ReleaseNamespace', 'uaa-service+micro_service.spring-freemarker+DEV', b'1', 'apollo', '2019-05-07 19:06:40', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (192, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-07 19:07:49', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (193, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-07 19:07:49', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (194, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-07 19:07:49', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (195, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-07 19:07:49', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (196, 'ModifyNamespace', 'uaa-service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-07 19:10:30', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (197, 'ReleaseNamespace', 'uaa-service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-07 19:10:30', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (198, 'ModifyNamespace', 'uaa-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-07 19:10:30', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (199, 'ReleaseNamespace', 'uaa-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-07 19:10:30', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (200, 'ModifyNamespace', 'uaa-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-07 19:12:12', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (201, 'ReleaseNamespace', 'uaa-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-07 19:12:12', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (202, 'ModifyNamespace', 'uaa-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-07 19:12:12', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (203, 'ReleaseNamespace', 'uaa-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-07 19:12:12', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (204, 'ModifyNamespace', 'uaa-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-07 19:12:19', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (205, 'ReleaseNamespace', 'uaa-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-07 19:12:19', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (206, 'ModifyNamespace', 'uaa-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-07 19:12:19', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (207, 'ReleaseNamespace', 'uaa-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-07 19:12:19', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (208, 'ModifyNamespace', 'uaa-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-05-07 19:12:26', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (209, 'ReleaseNamespace', 'uaa-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-05-07 19:12:26', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (210, 'ModifyNamespace', 'uaa-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-05-07 19:12:26', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (211, 'ReleaseNamespace', 'uaa-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-05-07 19:12:26', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (212, 'CreateNamespace', 'wanxin-depository', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Permission` VALUES (213, 'AssignRole', 'wanxin-depository', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Permission` VALUES (214, 'CreateCluster', 'wanxin-depository', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Permission` VALUES (215, 'ModifyNamespace', 'wanxin-depository+application', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Permission` VALUES (216, 'ReleaseNamespace', 'wanxin-depository+application', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Permission` VALUES (217, 'ModifyNamespace', 'wanxin-depository+application+DEV', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Permission` VALUES (218, 'ReleaseNamespace', 'wanxin-depository+application+DEV', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Permission` VALUES (219, 'ModifyNamespace', 'wanxin-depository+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `Permission` VALUES (220, 'ReleaseNamespace', 'wanxin-depository+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `Permission` VALUES (221, 'ModifyNamespace', 'wanxin-depository+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `Permission` VALUES (222, 'ReleaseNamespace', 'wanxin-depository+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `Permission` VALUES (223, 'ModifyNamespace', 'wanxin-depository+micro_service.spring-freemarker', b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `Permission` VALUES (224, 'ReleaseNamespace', 'wanxin-depository+micro_service.spring-freemarker', b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `Permission` VALUES (225, 'ModifyNamespace', 'wanxin-depository+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `Permission` VALUES (226, 'ReleaseNamespace', 'wanxin-depository+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `Permission` VALUES (227, 'ModifyNamespace', 'wanxin-depository+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `Permission` VALUES (228, 'ReleaseNamespace', 'wanxin-depository+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `Permission` VALUES (229, 'ModifyNamespace', 'wanxin-depository+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `Permission` VALUES (230, 'ReleaseNamespace', 'wanxin-depository+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `Permission` VALUES (231, 'ModifyNamespace', 'wanxin-depository+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `Permission` VALUES (232, 'ReleaseNamespace', 'wanxin-depository+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `Permission` VALUES (233, 'ModifyNamespace', 'wanxin-depository+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `Permission` VALUES (234, 'ReleaseNamespace', 'wanxin-depository+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `Permission` VALUES (235, 'CreateNamespace', 'account_service', b'1', 'apollo', '2019-05-17 10:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (236, 'AssignRole', 'account_service', b'1', 'apollo', '2019-05-17 10:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (237, 'CreateCluster', 'account_service', b'1', 'apollo', '2019-05-17 10:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (238, 'ModifyNamespace', 'account_service+application', b'1', 'apollo', '2019-05-17 10:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (239, 'ReleaseNamespace', 'account_service+application', b'1', 'apollo', '2019-05-17 10:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (240, 'ModifyNamespace', 'account_service+application+DEV', b'1', 'apollo', '2019-05-17 10:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (241, 'ReleaseNamespace', 'account_service+application+DEV', b'1', 'apollo', '2019-05-17 10:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (242, 'CreateNamespace', 'depository-agent-service', b'1', 'apollo', '2019-05-17 10:32:21', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (243, 'CreateCluster', 'depository-agent-service', b'1', 'apollo', '2019-05-17 10:32:21', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (244, 'AssignRole', 'depository-agent-service', b'1', 'apollo', '2019-05-17 10:32:21', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (245, 'ModifyNamespace', 'depository-agent-service+application', b'1', 'apollo', '2019-05-17 10:32:21', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (246, 'ReleaseNamespace', 'depository-agent-service+application', b'1', 'apollo', '2019-05-17 10:32:21', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (247, 'ModifyNamespace', 'depository-agent-service+application+DEV', b'1', 'apollo', '2019-05-17 10:32:21', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (248, 'ReleaseNamespace', 'depository-agent-service+application+DEV', b'1', 'apollo', '2019-05-17 10:32:21', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (249, 'ModifyNamespace', 'account_service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-05-17 11:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (250, 'ReleaseNamespace', 'account_service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-05-17 11:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (251, 'ModifyNamespace', 'account_service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-05-17 11:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (252, 'ReleaseNamespace', 'account_service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-05-17 11:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (253, 'ModifyNamespace', 'account_service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-17 11:10:38', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (254, 'ReleaseNamespace', 'account_service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-17 11:10:38', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (255, 'ModifyNamespace', 'account_service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-17 11:10:38', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (256, 'ReleaseNamespace', 'account_service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-17 11:10:38', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (257, 'ModifyNamespace', 'account_service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-17 11:10:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (258, 'ReleaseNamespace', 'account_service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-17 11:10:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (259, 'ModifyNamespace', 'account_service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-17 11:10:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (260, 'ReleaseNamespace', 'account_service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-17 11:10:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (261, 'ModifyNamespace', 'account_service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-17 11:10:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (262, 'ReleaseNamespace', 'account_service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-17 11:10:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (263, 'ModifyNamespace', 'account_service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-17 11:10:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (264, 'ReleaseNamespace', 'account_service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-17 11:10:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (265, 'ModifyNamespace', 'account_service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-17 11:11:13', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (266, 'ReleaseNamespace', 'account_service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-17 11:11:13', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (267, 'ModifyNamespace', 'account_service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-17 11:11:13', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (268, 'ReleaseNamespace', 'account_service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-17 11:11:13', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (269, 'ModifyNamespace', 'account_service+micro_service.spring-freemarker', b'1', 'apollo', '2019-05-17 11:11:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (270, 'ReleaseNamespace', 'account_service+micro_service.spring-freemarker', b'1', 'apollo', '2019-05-17 11:11:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (271, 'ModifyNamespace', 'account_service+micro_service.spring-freemarker+DEV', b'1', 'apollo', '2019-05-17 11:11:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (272, 'ReleaseNamespace', 'account_service+micro_service.spring-freemarker+DEV', b'1', 'apollo', '2019-05-17 11:11:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (273, 'ModifyNamespace', 'account_service+micro_service.spring-boot-redis', b'1', 'apollo', '2019-05-17 11:11:39', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (274, 'ReleaseNamespace', 'account_service+micro_service.spring-boot-redis', b'1', 'apollo', '2019-05-17 11:11:39', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (275, 'ModifyNamespace', 'account_service+micro_service.spring-boot-redis+DEV', b'1', 'apollo', '2019-05-17 11:11:39', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (276, 'ReleaseNamespace', 'account_service+micro_service.spring-boot-redis+DEV', b'1', 'apollo', '2019-05-17 11:11:39', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (277, 'ModifyNamespace', 'account_service+micro_service.mybatis-plus', b'1', 'apollo', '2019-05-17 11:11:51', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (278, 'ReleaseNamespace', 'account_service+micro_service.mybatis-plus', b'1', 'apollo', '2019-05-17 11:11:51', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (279, 'ModifyNamespace', 'account_service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-05-17 11:11:51', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (280, 'ReleaseNamespace', 'account_service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-05-17 11:11:51', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (281, 'ModifyNamespace', 'account_service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-17 11:12:00', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (282, 'ReleaseNamespace', 'account_service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-17 11:12:00', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (283, 'ModifyNamespace', 'account_service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-17 11:12:00', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (284, 'ReleaseNamespace', 'account_service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-17 11:12:00', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (285, 'ModifyNamespace', 'account_service+micro_service.spring-rocketmq', b'1', 'apollo', '2019-05-17 11:12:13', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (286, 'ReleaseNamespace', 'account_service+micro_service.spring-rocketmq', b'1', 'apollo', '2019-05-17 11:12:13', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (287, 'ModifyNamespace', 'account_service+micro_service.spring-rocketmq+DEV', b'1', 'apollo', '2019-05-17 11:12:13', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (288, 'ReleaseNamespace', 'account_service+micro_service.spring-rocketmq+DEV', b'1', 'apollo', '2019-05-17 11:12:13', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (289, 'CreateCluster', 'account-service', b'1', 'apollo', '2019-05-17 13:06:12', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (290, 'AssignRole', 'account-service', b'1', 'apollo', '2019-05-17 13:06:12', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (291, 'CreateNamespace', 'account-service', b'1', 'apollo', '2019-05-17 13:06:12', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (292, 'ModifyNamespace', 'account-service+application', b'1', 'apollo', '2019-05-17 13:06:12', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (293, 'ReleaseNamespace', 'account-service+application', b'1', 'apollo', '2019-05-17 13:06:12', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (294, 'ModifyNamespace', 'account-service+application+DEV', b'1', 'apollo', '2019-05-17 13:06:12', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (295, 'ReleaseNamespace', 'account-service+application+DEV', b'1', 'apollo', '2019-05-17 13:06:12', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (296, 'ModifyNamespace', 'account-service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-05-17 13:09:24', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (297, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-05-17 13:09:24', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (298, 'ModifyNamespace', 'account-service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-05-17 13:09:24', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (299, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-05-17 13:09:24', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (300, 'ModifyNamespace', 'account-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-17 13:09:31', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (301, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-17 13:09:31', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (302, 'ModifyNamespace', 'account-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-17 13:09:31', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (303, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-17 13:09:31', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (304, 'ModifyNamespace', 'account-service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-17 13:09:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (305, 'ReleaseNamespace', 'account-service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-17 13:09:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (306, 'ModifyNamespace', 'account-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-17 13:09:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (307, 'ReleaseNamespace', 'account-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-17 13:09:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (308, 'ModifyNamespace', 'account-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-17 13:09:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (309, 'ReleaseNamespace', 'account-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-17 13:09:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (310, 'ModifyNamespace', 'account-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-17 13:09:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (311, 'ReleaseNamespace', 'account-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-17 13:09:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (312, 'ModifyNamespace', 'account-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-17 13:10:01', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (313, 'ReleaseNamespace', 'account-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-17 13:10:01', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (314, 'ModifyNamespace', 'account-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-17 13:10:01', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (315, 'ReleaseNamespace', 'account-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-17 13:10:01', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (316, 'ModifyNamespace', 'account-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-05-17 13:10:08', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (317, 'ReleaseNamespace', 'account-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-05-17 13:10:08', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (318, 'ModifyNamespace', 'account-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-05-17 13:10:08', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (319, 'ReleaseNamespace', 'account-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-05-17 13:10:08', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (320, 'ModifyNamespace', 'account-service+micro_service.spring-freemarker', b'1', 'apollo', '2019-05-17 13:10:19', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (321, 'ReleaseNamespace', 'account-service+micro_service.spring-freemarker', b'1', 'apollo', '2019-05-17 13:10:19', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (322, 'ModifyNamespace', 'account-service+micro_service.spring-freemarker+DEV', b'1', 'apollo', '2019-05-17 13:10:19', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (323, 'ReleaseNamespace', 'account-service+micro_service.spring-freemarker+DEV', b'1', 'apollo', '2019-05-17 13:10:19', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (324, 'ModifyNamespace', 'account-service+micro_service.spring-boot-redis', b'1', 'apollo', '2019-05-17 13:10:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (325, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-redis', b'1', 'apollo', '2019-05-17 13:10:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (326, 'ModifyNamespace', 'account-service+micro_service.spring-boot-redis+DEV', b'1', 'apollo', '2019-05-17 13:10:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (327, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-redis+DEV', b'1', 'apollo', '2019-05-17 13:10:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (328, 'ModifyNamespace', 'account-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-05-17 13:10:39', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (329, 'ReleaseNamespace', 'account-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-05-17 13:10:39', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (330, 'ModifyNamespace', 'account-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-05-17 13:10:40', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (331, 'ReleaseNamespace', 'account-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-05-17 13:10:40', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (332, 'ModifyNamespace', 'account-service+micro_service.spring-rocketmq', b'1', 'apollo', '2019-05-17 13:10:58', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (333, 'ReleaseNamespace', 'account-service+micro_service.spring-rocketmq', b'1', 'apollo', '2019-05-17 13:10:58', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (334, 'ModifyNamespace', 'account-service+micro_service.spring-rocketmq+DEV', b'1', 'apollo', '2019-05-17 13:10:58', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (335, 'ReleaseNamespace', 'account-service+micro_service.spring-rocketmq+DEV', b'1', 'apollo', '2019-05-17 13:10:58', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (336, 'ModifyNamespace', 'account-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-17 13:11:11', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (337, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-17 13:11:11', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (338, 'ModifyNamespace', 'account-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-17 13:11:11', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (339, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-17 13:11:11', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `Permission` VALUES (340, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-17 13:57:00', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (341, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-17 13:57:00', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (342, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-17 13:57:00', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (343, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-17 13:57:00', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (344, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-17 14:16:03', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (345, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-17 14:16:03', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (346, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-17 14:16:03', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (347, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-17 14:16:03', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (348, 'ModifyNamespace', 'depository-agent-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-05-17 14:18:29', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (349, 'ReleaseNamespace', 'depository-agent-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-05-17 14:18:29', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (350, 'ModifyNamespace', 'depository-agent-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-05-17 14:18:29', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (351, 'ReleaseNamespace', 'depository-agent-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-05-17 14:18:29', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (352, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-17 14:18:57', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (353, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-17 14:18:57', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (354, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-17 14:18:57', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (355, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-17 14:18:58', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (356, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-17 14:19:07', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (357, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-17 14:19:07', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (358, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-17 14:19:07', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (359, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-17 14:19:07', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (360, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-05-17 14:19:13', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (361, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-05-17 14:19:13', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (362, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-05-17 14:19:14', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (363, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-05-17 14:19:14', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (364, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-17 15:20:49', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (365, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-17 15:20:49', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (366, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-17 15:20:49', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (367, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-17 15:20:49', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (368, 'ModifyNamespace', 'account-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-18 17:15:14', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (369, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-18 17:15:14', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (370, 'ModifyNamespace', 'account-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-18 17:16:00', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (371, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-18 17:16:00', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (372, 'AssignRole', 'repayment-service', b'1', 'apollo', '2019-05-22 11:28:11', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (373, 'CreateNamespace', 'repayment-service', b'1', 'apollo', '2019-05-22 11:28:11', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (374, 'CreateCluster', 'repayment-service', b'1', 'apollo', '2019-05-22 11:28:11', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (375, 'ModifyNamespace', 'repayment-service+application', b'1', 'apollo', '2019-05-22 11:28:11', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (376, 'ReleaseNamespace', 'repayment-service+application', b'1', 'apollo', '2019-05-22 11:28:11', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (377, 'ModifyNamespace', 'repayment-service+application+DEV', b'1', 'apollo', '2019-05-22 11:28:11', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (378, 'ReleaseNamespace', 'repayment-service+application+DEV', b'1', 'apollo', '2019-05-22 11:28:11', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (379, 'ModifyNamespace', 'repayment-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-22 11:28:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (380, 'ReleaseNamespace', 'repayment-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-05-22 11:28:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (381, 'ModifyNamespace', 'repayment-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-22 11:28:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (382, 'ReleaseNamespace', 'repayment-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-05-22 11:28:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (383, 'ModifyNamespace', 'repayment-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-22 11:28:39', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (384, 'ReleaseNamespace', 'repayment-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-05-22 11:28:39', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (385, 'ModifyNamespace', 'repayment-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-22 11:28:39', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (386, 'ReleaseNamespace', 'repayment-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-05-22 11:28:39', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (387, 'ModifyNamespace', 'repayment-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-05-22 11:28:48', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (388, 'ReleaseNamespace', 'repayment-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-05-22 11:28:48', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (389, 'ModifyNamespace', 'repayment-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-05-22 11:28:48', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (390, 'ReleaseNamespace', 'repayment-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-05-22 11:28:48', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (391, 'ModifyNamespace', 'repayment-service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-22 11:29:01', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (392, 'ReleaseNamespace', 'repayment-service+micro_service.spring-eureka', b'1', 'apollo', '2019-05-22 11:29:01', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (393, 'ModifyNamespace', 'repayment-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-22 11:29:02', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (394, 'ReleaseNamespace', 'repayment-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-05-22 11:29:02', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (395, 'ModifyNamespace', 'repayment-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-22 11:29:10', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (396, 'ReleaseNamespace', 'repayment-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-05-22 11:29:10', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (397, 'ModifyNamespace', 'repayment-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-22 11:29:10', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (398, 'ReleaseNamespace', 'repayment-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-05-22 11:29:10', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (399, 'ModifyNamespace', 'repayment-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-22 11:29:15', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (400, 'ReleaseNamespace', 'repayment-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-05-22 11:29:15', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (401, 'ModifyNamespace', 'repayment-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-22 11:29:15', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (402, 'ReleaseNamespace', 'repayment-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-05-22 11:29:15', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (403, 'ModifyNamespace', 'repayment-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-05-22 11:29:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (404, 'ReleaseNamespace', 'repayment-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-05-22 11:29:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (405, 'ModifyNamespace', 'repayment-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-05-22 11:29:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (406, 'ReleaseNamespace', 'repayment-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-05-22 11:29:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (407, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-cloud-hmily', b'1', 'apollo', '2019-05-28 08:54:57', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (408, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-cloud-hmily', b'1', 'apollo', '2019-05-28 08:54:58', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (409, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-cloud-hmily+DEV', b'1', 'apollo', '2019-05-28 08:54:58', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (410, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-cloud-hmily+DEV', b'1', 'apollo', '2019-05-28 08:54:58', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (411, 'ModifyNamespace', 'repayment-service+micro_service.spring-cloud-hmily', b'1', 'apollo', '2019-05-28 15:52:22', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (412, 'ReleaseNamespace', 'repayment-service+micro_service.spring-cloud-hmily', b'1', 'apollo', '2019-05-28 15:52:22', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (413, 'ModifyNamespace', 'repayment-service+micro_service.spring-cloud-hmily+DEV', b'1', 'apollo', '2019-05-28 15:52:22', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (414, 'ReleaseNamespace', 'repayment-service+micro_service.spring-cloud-hmily+DEV', b'1', 'apollo', '2019-05-28 15:52:22', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `Permission` VALUES (415, 'ModifyNamespace', 'wanxin-depository+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `Permission` VALUES (416, 'ReleaseNamespace', 'wanxin-depository+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `Permission` VALUES (417, 'ModifyNamespace', 'wanxin-depository+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `Permission` VALUES (418, 'ReleaseNamespace', 'wanxin-depository+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `Permission` VALUES (419, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-rocketmq', b'1', 'apollo', '2019-05-31 09:03:33', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (420, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-rocketmq', b'1', 'apollo', '2019-05-31 09:03:33', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (421, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-rocketmq+DEV', b'1', 'apollo', '2019-05-31 09:03:33', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (422, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-rocketmq+DEV', b'1', 'apollo', '2019-05-31 09:03:33', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `Permission` VALUES (423, 'AssignRole', 'test', b'1', 'apollo', '2019-05-31 14:24:24', 'apollo', '2019-05-31 14:26:27');
INSERT INTO `Permission` VALUES (424, 'CreateNamespace', 'test', b'1', 'apollo', '2019-05-31 14:24:24', 'apollo', '2019-05-31 14:26:27');
INSERT INTO `Permission` VALUES (425, 'CreateCluster', 'test', b'1', 'apollo', '2019-05-31 14:24:24', 'apollo', '2019-05-31 14:26:27');
INSERT INTO `Permission` VALUES (426, 'ModifyNamespace', 'test+application', b'1', 'apollo', '2019-05-31 14:24:24', 'apollo', '2019-05-31 14:26:27');
INSERT INTO `Permission` VALUES (427, 'ReleaseNamespace', 'test+application', b'1', 'apollo', '2019-05-31 14:24:24', 'apollo', '2019-05-31 14:26:27');
INSERT INTO `Permission` VALUES (428, 'ModifyNamespace', 'test+application+DEV', b'1', 'apollo', '2019-05-31 14:24:24', 'apollo', '2019-05-31 14:26:27');
INSERT INTO `Permission` VALUES (429, 'ReleaseNamespace', 'test+application+DEV', b'1', 'apollo', '2019-05-31 14:24:24', 'apollo', '2019-05-31 14:26:27');
INSERT INTO `Permission` VALUES (430, 'ModifyNamespace', 'common-template+micro_service.spring-zuul', b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `Permission` VALUES (431, 'ReleaseNamespace', 'common-template+micro_service.spring-zuul', b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `Permission` VALUES (432, 'ModifyNamespace', 'common-template+micro_service.spring-zuul+DEV', b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `Permission` VALUES (433, 'ReleaseNamespace', 'common-template+micro_service.spring-zuul+DEV', b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `Permission` VALUES (434, 'CreateNamespace', 'Balance-service', b'1', 'apollo', '2019-06-20 15:23:57', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (435, 'AssignRole', 'Balance-service', b'1', 'apollo', '2019-06-20 15:23:57', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (436, 'CreateCluster', 'Balance-service', b'1', 'apollo', '2019-06-20 15:23:57', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (437, 'ModifyNamespace', 'Balance-service+application', b'1', 'apollo', '2019-06-20 15:23:57', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (438, 'ReleaseNamespace', 'Balance-service+application', b'1', 'apollo', '2019-06-20 15:23:57', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (439, 'ModifyNamespace', 'Balance-service+application+DEV', b'1', 'apollo', '2019-06-20 15:23:57', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (440, 'ReleaseNamespace', 'Balance-service+application+DEV', b'1', 'apollo', '2019-06-20 15:23:57', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (441, 'ModifyNamespace', 'Balance-service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-06-20 15:33:59', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (442, 'ReleaseNamespace', 'Balance-service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-06-20 15:33:59', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (443, 'ModifyNamespace', 'Balance-service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-06-20 15:33:59', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (444, 'ReleaseNamespace', 'Balance-service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-06-20 15:33:59', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `Permission` VALUES (445, 'CreateNamespace', 'reconciliation-service', b'1', 'apollo', '2019-06-20 15:36:13', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (446, 'CreateCluster', 'reconciliation-service', b'1', 'apollo', '2019-06-20 15:36:13', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (447, 'AssignRole', 'reconciliation-service', b'1', 'apollo', '2019-06-20 15:36:13', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (448, 'ModifyNamespace', 'reconciliation-service+application', b'1', 'apollo', '2019-06-20 15:36:13', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (449, 'ReleaseNamespace', 'reconciliation-service+application', b'1', 'apollo', '2019-06-20 15:36:13', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (450, 'ModifyNamespace', 'reconciliation-service+application+DEV', b'1', 'apollo', '2019-06-20 15:36:13', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (451, 'ReleaseNamespace', 'reconciliation-service+application+DEV', b'1', 'apollo', '2019-06-20 15:36:13', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (452, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-06-20 15:36:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (453, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-06-20 15:36:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (454, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-06-20 15:36:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (455, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-06-20 15:36:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (456, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-06-20 15:36:52', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (457, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-06-20 15:36:52', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (458, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-06-20 15:36:52', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (459, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-06-20 15:36:52', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (460, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-eureka', b'1', 'apollo', '2019-06-20 15:36:56', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (461, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-eureka', b'1', 'apollo', '2019-06-20 15:36:56', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (462, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-06-20 15:36:56', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (463, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-06-20 15:36:56', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (464, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-06-20 15:37:02', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (465, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-06-20 15:37:02', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (466, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-06-20 15:37:02', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (467, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-06-20 15:37:02', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (468, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-06-20 15:37:09', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (469, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-06-20 15:37:09', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (470, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-06-20 15:37:09', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (471, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-06-20 15:37:09', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (472, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-06-20 15:37:14', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (473, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-06-20 15:37:14', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (474, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-06-20 15:37:14', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (475, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-06-20 15:37:14', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (476, 'ModifyNamespace', 'reconciliation-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-06-20 15:37:23', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (477, 'ReleaseNamespace', 'reconciliation-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-06-20 15:37:23', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (478, 'ModifyNamespace', 'reconciliation-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-06-20 15:37:23', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (479, 'ReleaseNamespace', 'reconciliation-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-06-20 15:37:23', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (480, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-06-20 15:37:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (481, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-06-20 15:37:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (482, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-06-20 15:37:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (483, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-06-20 15:37:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (484, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-rocketmq', b'1', 'apollo', '2019-06-20 15:37:48', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (485, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-rocketmq', b'1', 'apollo', '2019-06-20 15:37:48', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (486, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-rocketmq+DEV', b'1', 'apollo', '2019-06-20 15:37:48', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (487, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-rocketmq+DEV', b'1', 'apollo', '2019-06-20 15:37:48', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (488, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-zuul', b'1', 'apollo', '2019-06-20 15:37:59', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (489, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-zuul', b'1', 'apollo', '2019-06-20 15:37:59', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (490, 'ModifyNamespace', 'reconciliation-service+micro_service.spring-zuul+DEV', b'1', 'apollo', '2019-06-20 15:37:59', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (491, 'ReleaseNamespace', 'reconciliation-service+micro_service.spring-zuul+DEV', b'1', 'apollo', '2019-06-20 15:37:59', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `Permission` VALUES (492, 'CreateNamespace', 'file-service', b'1', 'apollo', '2019-06-26 15:48:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (493, 'AssignRole', 'file-service', b'1', 'apollo', '2019-06-26 15:48:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (494, 'CreateCluster', 'file-service', b'1', 'apollo', '2019-06-26 15:48:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (495, 'ModifyNamespace', 'file-service+application', b'1', 'apollo', '2019-06-26 15:48:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (496, 'ReleaseNamespace', 'file-service+application', b'1', 'apollo', '2019-06-26 15:48:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (497, 'ModifyNamespace', 'file-service+application+DEV', b'1', 'apollo', '2019-06-26 15:48:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (498, 'ReleaseNamespace', 'file-service+application+DEV', b'1', 'apollo', '2019-06-26 15:48:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (499, 'ModifyNamespace', 'file-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-06-26 15:48:57', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (500, 'ReleaseNamespace', 'file-service+micro_service.spring-boot-http', b'1', 'apollo', '2019-06-26 15:48:57', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (501, 'ModifyNamespace', 'file-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-06-26 15:48:57', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (502, 'ReleaseNamespace', 'file-service+micro_service.spring-boot-http+DEV', b'1', 'apollo', '2019-06-26 15:48:57', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (503, 'ModifyNamespace', 'file-service+micro_service.spring-zuul', b'1', 'apollo', '2019-06-26 15:49:18', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (504, 'ReleaseNamespace', 'file-service+micro_service.spring-zuul', b'1', 'apollo', '2019-06-26 15:49:18', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (505, 'ModifyNamespace', 'file-service+micro_service.spring-zuul+DEV', b'1', 'apollo', '2019-06-26 15:49:18', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (506, 'ReleaseNamespace', 'file-service+micro_service.spring-zuul+DEV', b'1', 'apollo', '2019-06-26 15:49:18', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (507, 'ModifyNamespace', 'file-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-06-26 15:49:40', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (508, 'ReleaseNamespace', 'file-service+micro_service.spring-boot-druid', b'1', 'apollo', '2019-06-26 15:49:40', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (509, 'ModifyNamespace', 'file-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-06-26 15:49:40', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (510, 'ReleaseNamespace', 'file-service+micro_service.spring-boot-druid+DEV', b'1', 'apollo', '2019-06-26 15:49:40', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (511, 'ModifyNamespace', 'file-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-06-26 15:49:52', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (512, 'ReleaseNamespace', 'file-service+micro_service.mybatis-plus', b'1', 'apollo', '2019-06-26 15:49:52', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (513, 'ModifyNamespace', 'file-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-06-26 15:49:52', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (514, 'ReleaseNamespace', 'file-service+micro_service.mybatis-plus+DEV', b'1', 'apollo', '2019-06-26 15:49:52', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (515, 'ModifyNamespace', 'file-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-06-26 15:50:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (516, 'ReleaseNamespace', 'file-service+micro_service.spring-ribbon', b'1', 'apollo', '2019-06-26 15:50:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (517, 'ModifyNamespace', 'file-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-06-26 15:50:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (518, 'ReleaseNamespace', 'file-service+micro_service.spring-ribbon+DEV', b'1', 'apollo', '2019-06-26 15:50:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (519, 'ModifyNamespace', 'file-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-06-26 15:50:22', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (520, 'ReleaseNamespace', 'file-service+micro_service.spring-hystrix', b'1', 'apollo', '2019-06-26 15:50:22', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (521, 'ModifyNamespace', 'file-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-06-26 15:50:22', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (522, 'ReleaseNamespace', 'file-service+micro_service.spring-hystrix+DEV', b'1', 'apollo', '2019-06-26 15:50:22', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (523, 'ModifyNamespace', 'file-service+micro_service.spring-eureka', b'1', 'apollo', '2019-06-26 15:50:38', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (524, 'ReleaseNamespace', 'file-service+micro_service.spring-eureka', b'1', 'apollo', '2019-06-26 15:50:38', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (525, 'ModifyNamespace', 'file-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-06-26 15:50:38', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (526, 'ReleaseNamespace', 'file-service+micro_service.spring-eureka+DEV', b'1', 'apollo', '2019-06-26 15:50:38', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (527, 'ModifyNamespace', 'file-service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-06-26 15:50:50', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (528, 'ReleaseNamespace', 'file-service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-06-26 15:50:50', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (529, 'ModifyNamespace', 'file-service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-06-26 15:50:50', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (530, 'ReleaseNamespace', 'file-service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-06-26 15:50:50', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (531, 'ModifyNamespace', 'file-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-06-26 16:21:39', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (532, 'ReleaseNamespace', 'file-service+micro_service.spring-cloud-feign', b'1', 'apollo', '2019-06-26 16:21:39', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (533, 'ModifyNamespace', 'file-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-06-26 16:21:39', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (534, 'ReleaseNamespace', 'file-service+micro_service.spring-cloud-feign+DEV', b'1', 'apollo', '2019-06-26 16:21:39', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (535, 'ModifyNamespace', 'consumer-service+micro_service.fileservice', b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `Permission` VALUES (536, 'ReleaseNamespace', 'consumer-service+micro_service.fileservice', b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `Permission` VALUES (537, 'ModifyNamespace', 'consumer-service+micro_service.fileservice+DEV', b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `Permission` VALUES (538, 'ReleaseNamespace', 'consumer-service+micro_service.fileservice+DEV', b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `Permission` VALUES (539, 'ModifyNamespace', 'file-service+micro_service.file', b'1', 'apollo', '2019-06-27 17:30:30', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (540, 'ReleaseNamespace', 'file-service+micro_service.file', b'1', 'apollo', '2019-06-27 17:30:30', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (541, 'ModifyNamespace', 'file-service+micro_service.file+DEV', b'1', 'apollo', '2019-06-27 17:30:30', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (542, 'ReleaseNamespace', 'file-service+micro_service.file+DEV', b'1', 'apollo', '2019-06-27 17:30:30', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `Permission` VALUES (543, 'ModifyNamespace', 'consumer-service+micro_service.files', b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `Permission` VALUES (544, 'ReleaseNamespace', 'consumer-service+micro_service.files', b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `Permission` VALUES (545, 'ModifyNamespace', 'consumer-service+micro_service.files+DEV', b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `Permission` VALUES (546, 'ReleaseNamespace', 'consumer-service+micro_service.files+DEV', b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `Permission` VALUES (547, 'ModifyNamespace', 'account-service+application+DEV', b'1', 'apollo', '2019-06-27 19:07:46', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (548, 'ReleaseNamespace', 'account-service+application+DEV', b'1', 'apollo', '2019-06-27 19:07:46', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (549, 'ModifyNamespace', 'gateway-server+micro_service.gateway-flow-rule', b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `Permission` VALUES (550, 'ReleaseNamespace', 'gateway-server+micro_service.gateway-flow-rule', b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `Permission` VALUES (551, 'ModifyNamespace', 'gateway-server+micro_service.gateway-flow-rule+DEV', b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `Permission` VALUES (552, 'ReleaseNamespace', 'gateway-server+micro_service.gateway-flow-rule+DEV', b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `Permission` VALUES (553, 'ModifyNamespace', 'account-service+micro_service.spring-cloud-hmily', b'1', 'apollo', '2019-07-03 17:57:12', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (554, 'ReleaseNamespace', 'account-service+micro_service.spring-cloud-hmily', b'1', 'apollo', '2019-07-03 17:57:12', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (555, 'ModifyNamespace', 'account-service+micro_service.spring-cloud-hmily+DEV', b'1', 'apollo', '2019-07-03 17:57:12', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (556, 'ReleaseNamespace', 'account-service+micro_service.spring-cloud-hmily+DEV', b'1', 'apollo', '2019-07-03 17:57:12', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `Permission` VALUES (557, 'ModifyNamespace', 'consumer-service+micro_service.spring-cloud-hmily', b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `Permission` VALUES (558, 'ReleaseNamespace', 'consumer-service+micro_service.spring-cloud-hmily', b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `Permission` VALUES (559, 'ModifyNamespace', 'consumer-service+micro_service.spring-cloud-hmily+DEV', b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `Permission` VALUES (560, 'ReleaseNamespace', 'consumer-service+micro_service.spring-cloud-hmily+DEV', b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `Permission` VALUES (561, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-07-04 14:55:17', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (562, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-mysql', b'1', 'apollo', '2019-07-04 14:55:17', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (563, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-07-04 14:55:17', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (564, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-mysql+DEV', b'1', 'apollo', '2019-07-04 14:55:17', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `Permission` VALUES (565, 'CreateNamespace', 'account-service', b'1', 'apollo', '2019-07-16 11:52:35', 'apollo', '2019-07-16 12:03:33');
INSERT INTO `Permission` VALUES (566, 'CreateCluster', 'account-service', b'1', 'apollo', '2019-07-16 11:52:35', 'apollo', '2019-07-16 12:03:33');
INSERT INTO `Permission` VALUES (567, 'AssignRole', 'account-service', b'1', 'apollo', '2019-07-16 11:52:35', 'apollo', '2019-07-16 12:03:33');
INSERT INTO `Permission` VALUES (568, 'ModifyNamespace', 'account-service+application', b'1', 'apollo', '2019-07-16 11:52:35', 'apollo', '2019-07-16 12:03:33');
INSERT INTO `Permission` VALUES (569, 'ReleaseNamespace', 'account-service+application', b'1', 'apollo', '2019-07-16 11:52:35', 'apollo', '2019-07-16 12:03:33');
INSERT INTO `Permission` VALUES (570, 'ModifyNamespace', 'account-service+application+DEV', b'1', 'apollo', '2019-07-16 11:52:35', 'apollo', '2019-07-16 12:03:33');
INSERT INTO `Permission` VALUES (571, 'ReleaseNamespace', 'account-service+application+DEV', b'1', 'apollo', '2019-07-16 11:52:35', 'apollo', '2019-07-16 12:03:33');
INSERT INTO `Permission` VALUES (572, 'CreateApplication', 'SystemRole', b'0', 'apollo', '2020-12-22 06:03:49', 'apollo', '2020-12-22 06:03:49');
INSERT INTO `Permission` VALUES (573, 'AssignRole', 'account-service', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Permission` VALUES (574, 'CreateCluster', 'account-service', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Permission` VALUES (575, 'CreateNamespace', 'account-service', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Permission` VALUES (576, 'ManageAppMaster', 'account-service', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Permission` VALUES (577, 'ModifyNamespace', 'account-service+application', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Permission` VALUES (578, 'ReleaseNamespace', 'account-service+application', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Permission` VALUES (579, 'ModifyNamespace', 'account-service+application+DEV', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Permission` VALUES (580, 'ReleaseNamespace', 'account-service+application+DEV', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Permission` VALUES (581, 'ModifyNamespace', 'account-service+micro_service.spring-boot-mysql', b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `Permission` VALUES (582, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-mysql', b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `Permission` VALUES (583, 'ModifyNamespace', 'account-service+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `Permission` VALUES (584, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `Permission` VALUES (585, 'ModifyNamespace', 'account-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `Permission` VALUES (586, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `Permission` VALUES (587, 'ModifyNamespace', 'account-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `Permission` VALUES (588, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `Permission` VALUES (589, 'ModifyNamespace', 'account-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `Permission` VALUES (590, 'ReleaseNamespace', 'account-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `Permission` VALUES (591, 'ModifyNamespace', 'account-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `Permission` VALUES (592, 'ReleaseNamespace', 'account-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `Permission` VALUES (593, 'ModifyNamespace', 'account-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `Permission` VALUES (594, 'ReleaseNamespace', 'account-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `Permission` VALUES (595, 'ModifyNamespace', 'account-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `Permission` VALUES (596, 'ReleaseNamespace', 'account-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `Permission` VALUES (597, 'ModifyNamespace', 'account-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `Permission` VALUES (598, 'ReleaseNamespace', 'account-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `Permission` VALUES (599, 'ModifyNamespace', 'account-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `Permission` VALUES (600, 'ReleaseNamespace', 'account-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `Permission` VALUES (601, 'ModifyNamespace', 'account-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `Permission` VALUES (602, 'ReleaseNamespace', 'account-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `Permission` VALUES (603, 'ModifyNamespace', 'account-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `Permission` VALUES (604, 'ReleaseNamespace', 'account-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `Permission` VALUES (605, 'ModifyNamespace', 'account-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `Permission` VALUES (606, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `Permission` VALUES (607, 'ModifyNamespace', 'account-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `Permission` VALUES (608, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `Permission` VALUES (609, 'ModifyNamespace', 'account-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `Permission` VALUES (610, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `Permission` VALUES (611, 'ModifyNamespace', 'account-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `Permission` VALUES (612, 'ReleaseNamespace', 'account-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `Permission` VALUES (613, 'ModifyNamespace', 'account-service+micro_service.mybatis-plus', b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `Permission` VALUES (614, 'ReleaseNamespace', 'account-service+micro_service.mybatis-plus', b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `Permission` VALUES (615, 'ModifyNamespace', 'account-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `Permission` VALUES (616, 'ReleaseNamespace', 'account-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `Permission` VALUES (617, 'ModifyNamespace', 'account-service+micro_service.spring-rocketmq', b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `Permission` VALUES (618, 'ReleaseNamespace', 'account-service+micro_service.spring-rocketmq', b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `Permission` VALUES (619, 'ModifyNamespace', 'account-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `Permission` VALUES (620, 'ReleaseNamespace', 'account-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `Permission` VALUES (621, 'CreateCluster', 'uaa-service', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Permission` VALUES (622, 'CreateNamespace', 'uaa-service', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Permission` VALUES (623, 'AssignRole', 'uaa-service', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Permission` VALUES (624, 'ManageAppMaster', 'uaa-service', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Permission` VALUES (625, 'ModifyNamespace', 'uaa-service+application', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Permission` VALUES (626, 'ReleaseNamespace', 'uaa-service+application', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Permission` VALUES (627, 'ModifyNamespace', 'uaa-service+application+DEV', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Permission` VALUES (628, 'ReleaseNamespace', 'uaa-service+application+DEV', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Permission` VALUES (629, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `Permission` VALUES (630, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `Permission` VALUES (631, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `Permission` VALUES (632, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `Permission` VALUES (633, 'ModifyNamespace', 'uaa-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `Permission` VALUES (634, 'ReleaseNamespace', 'uaa-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `Permission` VALUES (635, 'ModifyNamespace', 'uaa-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `Permission` VALUES (636, 'ReleaseNamespace', 'uaa-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `Permission` VALUES (637, 'ModifyNamespace', 'uaa-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `Permission` VALUES (638, 'ReleaseNamespace', 'uaa-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `Permission` VALUES (639, 'ModifyNamespace', 'uaa-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `Permission` VALUES (640, 'ReleaseNamespace', 'uaa-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `Permission` VALUES (641, 'ModifyNamespace', 'uaa-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `Permission` VALUES (642, 'ReleaseNamespace', 'uaa-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `Permission` VALUES (643, 'ModifyNamespace', 'uaa-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `Permission` VALUES (644, 'ReleaseNamespace', 'uaa-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `Permission` VALUES (645, 'ModifyNamespace', 'uaa-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `Permission` VALUES (646, 'ReleaseNamespace', 'uaa-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `Permission` VALUES (647, 'ModifyNamespace', 'uaa-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `Permission` VALUES (648, 'ReleaseNamespace', 'uaa-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `Permission` VALUES (649, 'ModifyNamespace', 'uaa-service+micro_service.spring-freemarker', b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `Permission` VALUES (650, 'ReleaseNamespace', 'uaa-service+micro_service.spring-freemarker', b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `Permission` VALUES (651, 'ModifyNamespace', 'uaa-service+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `Permission` VALUES (652, 'ReleaseNamespace', 'uaa-service+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `Permission` VALUES (653, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `Permission` VALUES (654, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `Permission` VALUES (655, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `Permission` VALUES (656, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `Permission` VALUES (657, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `Permission` VALUES (658, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `Permission` VALUES (659, 'ModifyNamespace', 'uaa-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `Permission` VALUES (660, 'ReleaseNamespace', 'uaa-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `Permission` VALUES (661, 'CreateCluster', 'depository-agent-service', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Permission` VALUES (662, 'CreateNamespace', 'depository-agent-service', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Permission` VALUES (663, 'AssignRole', 'depository-agent-service', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Permission` VALUES (664, 'ManageAppMaster', 'depository-agent-service', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Permission` VALUES (665, 'ModifyNamespace', 'depository-agent-service+application', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Permission` VALUES (666, 'ReleaseNamespace', 'depository-agent-service+application', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Permission` VALUES (667, 'ModifyNamespace', 'depository-agent-service+application+DEV', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Permission` VALUES (668, 'ReleaseNamespace', 'depository-agent-service+application+DEV', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Permission` VALUES (669, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `Permission` VALUES (670, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `Permission` VALUES (671, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `Permission` VALUES (672, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `Permission` VALUES (673, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `Permission` VALUES (674, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `Permission` VALUES (675, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `Permission` VALUES (676, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `Permission` VALUES (677, 'ModifyNamespace', 'depository-agent-service+micro_service.mybatis-plus', b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `Permission` VALUES (678, 'ReleaseNamespace', 'depository-agent-service+micro_service.mybatis-plus', b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `Permission` VALUES (679, 'ModifyNamespace', 'depository-agent-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `Permission` VALUES (680, 'ReleaseNamespace', 'depository-agent-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `Permission` VALUES (681, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `Permission` VALUES (682, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `Permission` VALUES (683, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `Permission` VALUES (684, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `Permission` VALUES (685, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `Permission` VALUES (686, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `Permission` VALUES (687, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `Permission` VALUES (688, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `Permission` VALUES (689, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `Permission` VALUES (690, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `Permission` VALUES (691, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `Permission` VALUES (692, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `Permission` VALUES (693, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-24 17:44:16', 'apollo', '2020-12-24 17:44:16');
INSERT INTO `Permission` VALUES (694, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-24 17:44:16', 'apollo', '2020-12-24 17:44:16');
INSERT INTO `Permission` VALUES (695, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-24 17:44:16', 'apollo', '2020-12-24 17:44:16');
INSERT INTO `Permission` VALUES (696, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-24 17:44:16', 'apollo', '2020-12-24 17:44:16');
INSERT INTO `Permission` VALUES (697, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `Permission` VALUES (698, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `Permission` VALUES (699, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `Permission` VALUES (700, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `Permission` VALUES (701, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-rocketmq', b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `Permission` VALUES (702, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-rocketmq', b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `Permission` VALUES (703, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `Permission` VALUES (704, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `Permission` VALUES (705, 'ModifyNamespace', 'common-template+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `Permission` VALUES (706, 'ReleaseNamespace', 'common-template+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `Permission` VALUES (707, 'ModifyNamespace', 'common-template+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `Permission` VALUES (708, 'ReleaseNamespace', 'common-template+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `Permission` VALUES (709, 'ModifyNamespace', 'consumer-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `Permission` VALUES (710, 'ReleaseNamespace', 'consumer-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `Permission` VALUES (711, 'ModifyNamespace', 'consumer-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `Permission` VALUES (712, 'ReleaseNamespace', 'consumer-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `Permission` VALUES (713, 'ModifyNamespace', 'uaa-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `Permission` VALUES (714, 'ReleaseNamespace', 'uaa-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `Permission` VALUES (715, 'ModifyNamespace', 'uaa-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `Permission` VALUES (716, 'ReleaseNamespace', 'uaa-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `Permission` VALUES (717, 'ModifyNamespace', 'account-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `Permission` VALUES (718, 'ReleaseNamespace', 'account-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `Permission` VALUES (719, 'ModifyNamespace', 'account-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `Permission` VALUES (720, 'ReleaseNamespace', 'account-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `Permission` VALUES (721, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
INSERT INTO `Permission` VALUES (722, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
INSERT INTO `Permission` VALUES (723, 'ModifyNamespace', 'depository-agent-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
INSERT INTO `Permission` VALUES (724, 'ReleaseNamespace', 'depository-agent-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
COMMIT;

-- ----------------------------
-- Table structure for Role
-- ----------------------------
DROP TABLE IF EXISTS `Role`;
CREATE TABLE `Role` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleName` varchar(256) NOT NULL DEFAULT '' COMMENT 'Role name',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_RoleName` (`RoleName`(191)),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=689 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- ----------------------------
-- Records of Role
-- ----------------------------
BEGIN;
INSERT INTO `Role` VALUES (1, 'Master+consumer-service', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Role` VALUES (2, 'ModifyNamespace+consumer-service+application', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Role` VALUES (3, 'ReleaseNamespace+consumer-service+application', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Role` VALUES (4, 'ModifyNamespace+consumer-service+application+DEV', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Role` VALUES (5, 'ReleaseNamespace+consumer-service+application+DEV', b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `Role` VALUES (6, 'Master+common-template', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Role` VALUES (7, 'ModifyNamespace+common-template+application', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Role` VALUES (8, 'ReleaseNamespace+common-template+application', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Role` VALUES (9, 'ModifyNamespace+common-template+application+DEV', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Role` VALUES (10, 'ReleaseNamespace+common-template+application+DEV', b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `Role` VALUES (11, 'ModifyNamespace+common-template+micro_service.spring-boot-mysql', b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `Role` VALUES (12, 'ReleaseNamespace+common-template+micro_service.spring-boot-mysql', b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `Role` VALUES (13, 'ModifyNamespace+common-template+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `Role` VALUES (14, 'ReleaseNamespace+common-template+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `Role` VALUES (15, 'ModifyNamespace+common-template+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `Role` VALUES (16, 'ReleaseNamespace+common-template+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `Role` VALUES (17, 'ModifyNamespace+common-template+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `Role` VALUES (18, 'ReleaseNamespace+common-template+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `Role` VALUES (19, 'ModifyNamespace+common-template+micro_service.spring-eureka', b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `Role` VALUES (20, 'ReleaseNamespace+common-template+micro_service.spring-eureka', b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `Role` VALUES (21, 'ModifyNamespace+common-template+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `Role` VALUES (22, 'ReleaseNamespace+common-template+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `Role` VALUES (23, 'ModifyNamespace+common-template+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `Role` VALUES (24, 'ReleaseNamespace+common-template+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `Role` VALUES (25, 'ModifyNamespace+common-template+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `Role` VALUES (26, 'ReleaseNamespace+common-template+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `Role` VALUES (27, 'ModifyNamespace+common-template+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `Role` VALUES (28, 'ReleaseNamespace+common-template+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `Role` VALUES (29, 'ModifyNamespace+common-template+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `Role` VALUES (30, 'ReleaseNamespace+common-template+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `Role` VALUES (31, 'ModifyNamespace+common-template+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `Role` VALUES (32, 'ReleaseNamespace+common-template+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `Role` VALUES (33, 'ModifyNamespace+common-template+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `Role` VALUES (34, 'ReleaseNamespace+common-template+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `Role` VALUES (35, 'ModifyNamespace+common-template+micro_service.spring-freemarker', b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `Role` VALUES (36, 'ReleaseNamespace+common-template+micro_service.spring-freemarker', b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `Role` VALUES (37, 'ModifyNamespace+common-template+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `Role` VALUES (38, 'ReleaseNamespace+common-template+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `Role` VALUES (39, 'ModifyNamespace+consumer-service+micro_service.spring-boot-mysql', b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `Role` VALUES (40, 'ReleaseNamespace+consumer-service+micro_service.spring-boot-mysql', b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `Role` VALUES (41, 'ModifyNamespace+consumer-service+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `Role` VALUES (42, 'ReleaseNamespace+consumer-service+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `Role` VALUES (43, 'ModifyNamespace+consumer-service+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `Role` VALUES (44, 'ReleaseNamespace+consumer-service+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `Role` VALUES (45, 'ModifyNamespace+consumer-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `Role` VALUES (46, 'ReleaseNamespace+consumer-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `Role` VALUES (47, 'ModifyNamespace+consumer-service+micro_service.spring-eureka', b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `Role` VALUES (48, 'ReleaseNamespace+consumer-service+micro_service.spring-eureka', b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `Role` VALUES (49, 'ModifyNamespace+consumer-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `Role` VALUES (50, 'ReleaseNamespace+consumer-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `Role` VALUES (51, 'ModifyNamespace+consumer-service+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `Role` VALUES (52, 'ReleaseNamespace+consumer-service+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `Role` VALUES (53, 'ModifyNamespace+consumer-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `Role` VALUES (54, 'ReleaseNamespace+consumer-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `Role` VALUES (55, 'ModifyNamespace+consumer-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `Role` VALUES (56, 'ReleaseNamespace+consumer-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `Role` VALUES (57, 'ModifyNamespace+consumer-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `Role` VALUES (58, 'ReleaseNamespace+consumer-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `Role` VALUES (59, 'ModifyNamespace+consumer-service+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `Role` VALUES (60, 'ReleaseNamespace+consumer-service+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `Role` VALUES (61, 'ModifyNamespace+consumer-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `Role` VALUES (62, 'ReleaseNamespace+consumer-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `Role` VALUES (63, 'ModifyNamespace+common-template+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `Role` VALUES (64, 'ReleaseNamespace+common-template+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `Role` VALUES (65, 'ModifyNamespace+common-template+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `Role` VALUES (66, 'ReleaseNamespace+common-template+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `Role` VALUES (67, 'ModifyNamespace+consumer-service+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `Role` VALUES (68, 'ReleaseNamespace+consumer-service+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `Role` VALUES (69, 'ModifyNamespace+consumer-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `Role` VALUES (70, 'ReleaseNamespace+consumer-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `Role` VALUES (71, 'ModifyNamespace+common-template+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `Role` VALUES (72, 'ReleaseNamespace+common-template+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `Role` VALUES (73, 'ModifyNamespace+common-template+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `Role` VALUES (74, 'ReleaseNamespace+common-template+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `Role` VALUES (75, 'ModifyNamespace+consumer-service+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `Role` VALUES (76, 'ReleaseNamespace+consumer-service+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `Role` VALUES (77, 'ModifyNamespace+consumer-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `Role` VALUES (78, 'ReleaseNamespace+consumer-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `Role` VALUES (79, 'ModifyNamespace+common-template+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `Role` VALUES (80, 'ReleaseNamespace+common-template+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `Role` VALUES (81, 'ModifyNamespace+common-template+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `Role` VALUES (82, 'ReleaseNamespace+common-template+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `Role` VALUES (83, 'ModifyNamespace+consumer-service+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `Role` VALUES (84, 'ReleaseNamespace+consumer-service+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `Role` VALUES (85, 'ModifyNamespace+consumer-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `Role` VALUES (86, 'ReleaseNamespace+consumer-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `Role` VALUES (87, 'ModifyNamespace+common-template+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `Role` VALUES (88, 'ReleaseNamespace+common-template+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `Role` VALUES (89, 'ModifyNamespace+common-template+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `Role` VALUES (90, 'ReleaseNamespace+common-template+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `Role` VALUES (91, 'ModifyNamespace+consumer-service+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `Role` VALUES (92, 'ReleaseNamespace+consumer-service+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `Role` VALUES (93, 'ModifyNamespace+consumer-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `Role` VALUES (94, 'ReleaseNamespace+consumer-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `Role` VALUES (132, 'ModifyNamespace+common-template+micro_service.spring-boot-es', b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `Role` VALUES (133, 'ReleaseNamespace+common-template+micro_service.spring-boot-es', b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `Role` VALUES (134, 'ModifyNamespace+common-template+micro_service.spring-boot-es+DEV', b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `Role` VALUES (135, 'ReleaseNamespace+common-template+micro_service.spring-boot-es+DEV', b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `Role` VALUES (136, 'Master+gateway-server', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Role` VALUES (137, 'ModifyNamespace+gateway-server+application', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Role` VALUES (138, 'ReleaseNamespace+gateway-server+application', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Role` VALUES (139, 'ModifyNamespace+gateway-server+application+DEV', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Role` VALUES (140, 'ReleaseNamespace+gateway-server+application+DEV', b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `Role` VALUES (141, 'ModifyNamespace+gateway-server+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `Role` VALUES (142, 'ReleaseNamespace+gateway-server+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `Role` VALUES (143, 'ModifyNamespace+gateway-server+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `Role` VALUES (144, 'ReleaseNamespace+gateway-server+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `Role` VALUES (145, 'ModifyNamespace+gateway-server+micro_service.spring-eureka', b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `Role` VALUES (146, 'ReleaseNamespace+gateway-server+micro_service.spring-eureka', b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `Role` VALUES (147, 'ModifyNamespace+gateway-server+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `Role` VALUES (148, 'ReleaseNamespace+gateway-server+micro_service.spring-eureka+DEV', b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `Role` VALUES (149, 'ModifyNamespace+gateway-server+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `Role` VALUES (150, 'ReleaseNamespace+gateway-server+micro_service.spring-cloud-feign', b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `Role` VALUES (151, 'ModifyNamespace+gateway-server+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `Role` VALUES (152, 'ReleaseNamespace+gateway-server+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `Role` VALUES (153, 'ModifyNamespace+gateway-server+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `Role` VALUES (154, 'ReleaseNamespace+gateway-server+micro_service.spring-hystrix', b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `Role` VALUES (155, 'ModifyNamespace+gateway-server+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `Role` VALUES (156, 'ReleaseNamespace+gateway-server+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `Role` VALUES (157, 'ModifyNamespace+gateway-server+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `Role` VALUES (158, 'ReleaseNamespace+gateway-server+micro_service.spring-ribbon', b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `Role` VALUES (159, 'ModifyNamespace+gateway-server+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `Role` VALUES (160, 'ReleaseNamespace+gateway-server+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `Role` VALUES (161, 'ModifyNamespace+gateway-server+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `Role` VALUES (162, 'ReleaseNamespace+gateway-server+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `Role` VALUES (163, 'ModifyNamespace+gateway-server+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `Role` VALUES (164, 'ReleaseNamespace+gateway-server+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `Role` VALUES (165, 'ModifyNamespace+gateway-server+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `Role` VALUES (166, 'ReleaseNamespace+gateway-server+micro_service.spring-boot-redis', b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `Role` VALUES (167, 'ModifyNamespace+gateway-server+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `Role` VALUES (168, 'ReleaseNamespace+gateway-server+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `Role` VALUES (202, 'Master+wanxin-depository', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Role` VALUES (203, 'ModifyNamespace+wanxin-depository+application', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Role` VALUES (204, 'ReleaseNamespace+wanxin-depository+application', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Role` VALUES (205, 'ModifyNamespace+wanxin-depository+application+DEV', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Role` VALUES (206, 'ReleaseNamespace+wanxin-depository+application+DEV', b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `Role` VALUES (207, 'ModifyNamespace+wanxin-depository+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `Role` VALUES (208, 'ReleaseNamespace+wanxin-depository+micro_service.spring-boot-http', b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `Role` VALUES (209, 'ModifyNamespace+wanxin-depository+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `Role` VALUES (210, 'ReleaseNamespace+wanxin-depository+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `Role` VALUES (211, 'ModifyNamespace+wanxin-depository+micro_service.spring-freemarker', b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `Role` VALUES (212, 'ReleaseNamespace+wanxin-depository+micro_service.spring-freemarker', b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `Role` VALUES (213, 'ModifyNamespace+wanxin-depository+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `Role` VALUES (214, 'ReleaseNamespace+wanxin-depository+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `Role` VALUES (215, 'ModifyNamespace+wanxin-depository+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `Role` VALUES (216, 'ReleaseNamespace+wanxin-depository+micro_service.mybatis-plus', b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `Role` VALUES (217, 'ModifyNamespace+wanxin-depository+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `Role` VALUES (218, 'ReleaseNamespace+wanxin-depository+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `Role` VALUES (219, 'ModifyNamespace+wanxin-depository+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `Role` VALUES (220, 'ReleaseNamespace+wanxin-depository+micro_service.spring-boot-druid', b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `Role` VALUES (221, 'ModifyNamespace+wanxin-depository+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `Role` VALUES (222, 'ReleaseNamespace+wanxin-depository+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `Role` VALUES (395, 'ModifyNamespace+wanxin-depository+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `Role` VALUES (396, 'ReleaseNamespace+wanxin-depository+micro_service.spring-rocketmq', b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `Role` VALUES (397, 'ModifyNamespace+wanxin-depository+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `Role` VALUES (398, 'ReleaseNamespace+wanxin-depository+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `Role` VALUES (408, 'ModifyNamespace+common-template+micro_service.spring-zuul', b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `Role` VALUES (409, 'ReleaseNamespace+common-template+micro_service.spring-zuul', b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `Role` VALUES (410, 'ModifyNamespace+common-template+micro_service.spring-zuul+DEV', b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `Role` VALUES (411, 'ReleaseNamespace+common-template+micro_service.spring-zuul+DEV', b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `Role` VALUES (507, 'ModifyNamespace+consumer-service+micro_service.fileservice', b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `Role` VALUES (508, 'ReleaseNamespace+consumer-service+micro_service.fileservice', b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `Role` VALUES (509, 'ModifyNamespace+consumer-service+micro_service.fileservice+DEV', b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `Role` VALUES (510, 'ReleaseNamespace+consumer-service+micro_service.fileservice+DEV', b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `Role` VALUES (515, 'ModifyNamespace+consumer-service+micro_service.files', b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `Role` VALUES (516, 'ReleaseNamespace+consumer-service+micro_service.files', b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `Role` VALUES (517, 'ModifyNamespace+consumer-service+micro_service.files+DEV', b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `Role` VALUES (518, 'ReleaseNamespace+consumer-service+micro_service.files+DEV', b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `Role` VALUES (521, 'ModifyNamespace+gateway-server+micro_service.gateway-flow-rule', b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `Role` VALUES (522, 'ReleaseNamespace+gateway-server+micro_service.gateway-flow-rule', b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `Role` VALUES (523, 'ModifyNamespace+gateway-server+micro_service.gateway-flow-rule+DEV', b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `Role` VALUES (524, 'ReleaseNamespace+gateway-server+micro_service.gateway-flow-rule+DEV', b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `Role` VALUES (529, 'ModifyNamespace+consumer-service+micro_service.spring-cloud-hmily', b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `Role` VALUES (530, 'ReleaseNamespace+consumer-service+micro_service.spring-cloud-hmily', b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `Role` VALUES (531, 'ModifyNamespace+consumer-service+micro_service.spring-cloud-hmily+DEV', b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `Role` VALUES (532, 'ReleaseNamespace+consumer-service+micro_service.spring-cloud-hmily+DEV', b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `Role` VALUES (542, 'CreateApplication+SystemRole', b'0', 'apollo', '2020-12-22 06:03:50', 'apollo', '2020-12-22 06:03:50');
INSERT INTO `Role` VALUES (543, 'Master+account-service', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Role` VALUES (544, 'ManageAppMaster+account-service', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Role` VALUES (545, 'ModifyNamespace+account-service+application', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Role` VALUES (546, 'ReleaseNamespace+account-service+application', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Role` VALUES (547, 'ModifyNamespace+account-service+application+DEV', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Role` VALUES (548, 'ReleaseNamespace+account-service+application+DEV', b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `Role` VALUES (549, 'ModifyNamespace+account-service+micro_service.spring-boot-mysql', b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `Role` VALUES (550, 'ReleaseNamespace+account-service+micro_service.spring-boot-mysql', b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `Role` VALUES (551, 'ModifyNamespace+account-service+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `Role` VALUES (552, 'ReleaseNamespace+account-service+micro_service.spring-boot-mysql+DEV', b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `Role` VALUES (553, 'ModifyNamespace+account-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `Role` VALUES (554, 'ReleaseNamespace+account-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `Role` VALUES (555, 'ModifyNamespace+account-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `Role` VALUES (556, 'ReleaseNamespace+account-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `Role` VALUES (557, 'ModifyNamespace+account-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `Role` VALUES (558, 'ReleaseNamespace+account-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `Role` VALUES (559, 'ModifyNamespace+account-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `Role` VALUES (560, 'ReleaseNamespace+account-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `Role` VALUES (561, 'ModifyNamespace+account-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `Role` VALUES (562, 'ReleaseNamespace+account-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `Role` VALUES (563, 'ModifyNamespace+account-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `Role` VALUES (564, 'ReleaseNamespace+account-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `Role` VALUES (565, 'ModifyNamespace+account-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `Role` VALUES (566, 'ReleaseNamespace+account-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `Role` VALUES (567, 'ModifyNamespace+account-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `Role` VALUES (568, 'ReleaseNamespace+account-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `Role` VALUES (569, 'ModifyNamespace+account-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `Role` VALUES (570, 'ReleaseNamespace+account-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `Role` VALUES (571, 'ModifyNamespace+account-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `Role` VALUES (572, 'ReleaseNamespace+account-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `Role` VALUES (573, 'ModifyNamespace+account-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `Role` VALUES (574, 'ReleaseNamespace+account-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `Role` VALUES (575, 'ModifyNamespace+account-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `Role` VALUES (576, 'ReleaseNamespace+account-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `Role` VALUES (577, 'ModifyNamespace+account-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `Role` VALUES (578, 'ReleaseNamespace+account-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `Role` VALUES (579, 'ModifyNamespace+account-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `Role` VALUES (580, 'ReleaseNamespace+account-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `Role` VALUES (581, 'ModifyNamespace+account-service+micro_service.mybatis-plus', b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `Role` VALUES (582, 'ReleaseNamespace+account-service+micro_service.mybatis-plus', b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `Role` VALUES (583, 'ModifyNamespace+account-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `Role` VALUES (584, 'ReleaseNamespace+account-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `Role` VALUES (585, 'ModifyNamespace+account-service+micro_service.spring-rocketmq', b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `Role` VALUES (586, 'ReleaseNamespace+account-service+micro_service.spring-rocketmq', b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `Role` VALUES (587, 'ModifyNamespace+account-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `Role` VALUES (588, 'ReleaseNamespace+account-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `Role` VALUES (589, 'Master+uaa-service', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Role` VALUES (590, 'ManageAppMaster+uaa-service', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Role` VALUES (591, 'ModifyNamespace+uaa-service+application', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Role` VALUES (592, 'ReleaseNamespace+uaa-service+application', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Role` VALUES (593, 'ModifyNamespace+uaa-service+application+DEV', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Role` VALUES (594, 'ReleaseNamespace+uaa-service+application+DEV', b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `Role` VALUES (595, 'ModifyNamespace+uaa-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `Role` VALUES (596, 'ReleaseNamespace+uaa-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `Role` VALUES (597, 'ModifyNamespace+uaa-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `Role` VALUES (598, 'ReleaseNamespace+uaa-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `Role` VALUES (599, 'ModifyNamespace+uaa-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `Role` VALUES (600, 'ReleaseNamespace+uaa-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `Role` VALUES (601, 'ModifyNamespace+uaa-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `Role` VALUES (602, 'ReleaseNamespace+uaa-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `Role` VALUES (603, 'ModifyNamespace+uaa-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `Role` VALUES (604, 'ReleaseNamespace+uaa-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `Role` VALUES (605, 'ModifyNamespace+uaa-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `Role` VALUES (606, 'ReleaseNamespace+uaa-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `Role` VALUES (607, 'ModifyNamespace+uaa-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `Role` VALUES (608, 'ReleaseNamespace+uaa-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `Role` VALUES (609, 'ModifyNamespace+uaa-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `Role` VALUES (610, 'ReleaseNamespace+uaa-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `Role` VALUES (611, 'ModifyNamespace+uaa-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `Role` VALUES (612, 'ReleaseNamespace+uaa-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `Role` VALUES (613, 'ModifyNamespace+uaa-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `Role` VALUES (614, 'ReleaseNamespace+uaa-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `Role` VALUES (615, 'ModifyNamespace+uaa-service+micro_service.spring-freemarker', b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `Role` VALUES (616, 'ReleaseNamespace+uaa-service+micro_service.spring-freemarker', b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `Role` VALUES (617, 'ModifyNamespace+uaa-service+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `Role` VALUES (618, 'ReleaseNamespace+uaa-service+micro_service.spring-freemarker+DEV', b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `Role` VALUES (619, 'ModifyNamespace+uaa-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `Role` VALUES (620, 'ReleaseNamespace+uaa-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `Role` VALUES (621, 'ModifyNamespace+uaa-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `Role` VALUES (622, 'ReleaseNamespace+uaa-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `Role` VALUES (623, 'ModifyNamespace+uaa-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `Role` VALUES (624, 'ReleaseNamespace+uaa-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `Role` VALUES (625, 'ModifyNamespace+uaa-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `Role` VALUES (626, 'ReleaseNamespace+uaa-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `Role` VALUES (627, 'Master+depository-agent-service', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Role` VALUES (628, 'ManageAppMaster+depository-agent-service', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Role` VALUES (629, 'ModifyNamespace+depository-agent-service+application', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Role` VALUES (630, 'ReleaseNamespace+depository-agent-service+application', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Role` VALUES (631, 'ModifyNamespace+depository-agent-service+application+DEV', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Role` VALUES (632, 'ReleaseNamespace+depository-agent-service+application+DEV', b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `Role` VALUES (633, 'ModifyNamespace+depository-agent-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `Role` VALUES (634, 'ReleaseNamespace+depository-agent-service+micro_service.spring-boot-http', b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `Role` VALUES (635, 'ModifyNamespace+depository-agent-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `Role` VALUES (636, 'ReleaseNamespace+depository-agent-service+micro_service.spring-boot-http+DEV', b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `Role` VALUES (637, 'ModifyNamespace+depository-agent-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `Role` VALUES (638, 'ReleaseNamespace+depository-agent-service+micro_service.spring-boot-druid', b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `Role` VALUES (639, 'ModifyNamespace+depository-agent-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `Role` VALUES (640, 'ReleaseNamespace+depository-agent-service+micro_service.spring-boot-druid+DEV', b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `Role` VALUES (641, 'ModifyNamespace+depository-agent-service+micro_service.mybatis-plus', b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `Role` VALUES (642, 'ReleaseNamespace+depository-agent-service+micro_service.mybatis-plus', b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `Role` VALUES (643, 'ModifyNamespace+depository-agent-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `Role` VALUES (644, 'ReleaseNamespace+depository-agent-service+micro_service.mybatis-plus+DEV', b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `Role` VALUES (645, 'ModifyNamespace+depository-agent-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `Role` VALUES (646, 'ReleaseNamespace+depository-agent-service+micro_service.spring-eureka', b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `Role` VALUES (647, 'ModifyNamespace+depository-agent-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `Role` VALUES (648, 'ReleaseNamespace+depository-agent-service+micro_service.spring-eureka+DEV', b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `Role` VALUES (649, 'ModifyNamespace+depository-agent-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `Role` VALUES (650, 'ReleaseNamespace+depository-agent-service+micro_service.spring-hystrix', b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `Role` VALUES (651, 'ModifyNamespace+depository-agent-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `Role` VALUES (652, 'ReleaseNamespace+depository-agent-service+micro_service.spring-hystrix+DEV', b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `Role` VALUES (653, 'ModifyNamespace+depository-agent-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `Role` VALUES (654, 'ReleaseNamespace+depository-agent-service+micro_service.spring-cloud-feign', b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `Role` VALUES (655, 'ModifyNamespace+depository-agent-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `Role` VALUES (656, 'ReleaseNamespace+depository-agent-service+micro_service.spring-cloud-feign+DEV', b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `Role` VALUES (657, 'ModifyNamespace+depository-agent-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-24 17:44:16', 'apollo', '2020-12-24 17:44:16');
INSERT INTO `Role` VALUES (658, 'ReleaseNamespace+depository-agent-service+micro_service.spring-ribbon', b'0', 'apollo', '2020-12-24 17:44:16', 'apollo', '2020-12-24 17:44:16');
INSERT INTO `Role` VALUES (659, 'ModifyNamespace+depository-agent-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-24 17:44:16', 'apollo', '2020-12-24 17:44:16');
INSERT INTO `Role` VALUES (660, 'ReleaseNamespace+depository-agent-service+micro_service.spring-ribbon+DEV', b'0', 'apollo', '2020-12-24 17:44:17', 'apollo', '2020-12-24 17:44:17');
INSERT INTO `Role` VALUES (661, 'ModifyNamespace+depository-agent-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `Role` VALUES (662, 'ReleaseNamespace+depository-agent-service+micro_service.spring-boot-redis', b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `Role` VALUES (663, 'ModifyNamespace+depository-agent-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `Role` VALUES (664, 'ReleaseNamespace+depository-agent-service+micro_service.spring-boot-redis+DEV', b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `Role` VALUES (665, 'ModifyNamespace+depository-agent-service+micro_service.spring-rocketmq', b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `Role` VALUES (666, 'ReleaseNamespace+depository-agent-service+micro_service.spring-rocketmq', b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `Role` VALUES (667, 'ModifyNamespace+depository-agent-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `Role` VALUES (668, 'ReleaseNamespace+depository-agent-service+micro_service.spring-rocketmq+DEV', b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `Role` VALUES (669, 'ModifyNamespace+common-template+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `Role` VALUES (670, 'ReleaseNamespace+common-template+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `Role` VALUES (671, 'ModifyNamespace+common-template+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `Role` VALUES (672, 'ReleaseNamespace+common-template+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `Role` VALUES (673, 'ModifyNamespace+consumer-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `Role` VALUES (674, 'ReleaseNamespace+consumer-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `Role` VALUES (675, 'ModifyNamespace+consumer-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `Role` VALUES (676, 'ReleaseNamespace+consumer-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `Role` VALUES (677, 'ModifyNamespace+uaa-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `Role` VALUES (678, 'ReleaseNamespace+uaa-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `Role` VALUES (679, 'ModifyNamespace+uaa-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `Role` VALUES (680, 'ReleaseNamespace+uaa-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `Role` VALUES (681, 'ModifyNamespace+account-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `Role` VALUES (682, 'ReleaseNamespace+account-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `Role` VALUES (683, 'ModifyNamespace+account-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `Role` VALUES (684, 'ReleaseNamespace+account-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `Role` VALUES (685, 'ModifyNamespace+depository-agent-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
INSERT INTO `Role` VALUES (686, 'ReleaseNamespace+depository-agent-service+micro_service.spring-feign', b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
INSERT INTO `Role` VALUES (687, 'ModifyNamespace+depository-agent-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
INSERT INTO `Role` VALUES (688, 'ReleaseNamespace+depository-agent-service+micro_service.spring-feign+DEV', b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
COMMIT;

-- ----------------------------
-- Table structure for RolePermission
-- ----------------------------
DROP TABLE IF EXISTS `RolePermission`;
CREATE TABLE `RolePermission` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `PermissionId` int(10) unsigned DEFAULT NULL COMMENT 'Permission Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`),
  KEY `IX_PermissionId` (`PermissionId`)
) ENGINE=InnoDB AUTO_INCREMENT=725 DEFAULT CHARSET=utf8mb4 COMMENT='角色和权限的绑定表';

-- ----------------------------
-- Records of RolePermission
-- ----------------------------
BEGIN;
INSERT INTO `RolePermission` VALUES (1, 1, 1, b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `RolePermission` VALUES (2, 1, 2, b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `RolePermission` VALUES (3, 1, 3, b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `RolePermission` VALUES (4, 2, 4, b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `RolePermission` VALUES (5, 3, 5, b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `RolePermission` VALUES (6, 4, 6, b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `RolePermission` VALUES (7, 5, 7, b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `RolePermission` VALUES (8, 6, 8, b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `RolePermission` VALUES (9, 6, 9, b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `RolePermission` VALUES (10, 6, 10, b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `RolePermission` VALUES (11, 7, 11, b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `RolePermission` VALUES (12, 8, 12, b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `RolePermission` VALUES (13, 9, 13, b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `RolePermission` VALUES (14, 10, 14, b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `RolePermission` VALUES (15, 11, 15, b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `RolePermission` VALUES (16, 12, 16, b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `RolePermission` VALUES (17, 13, 17, b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `RolePermission` VALUES (18, 14, 18, b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `RolePermission` VALUES (19, 15, 19, b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `RolePermission` VALUES (20, 16, 20, b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `RolePermission` VALUES (21, 17, 21, b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `RolePermission` VALUES (22, 18, 22, b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `RolePermission` VALUES (23, 19, 23, b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `RolePermission` VALUES (24, 20, 24, b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `RolePermission` VALUES (25, 21, 25, b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `RolePermission` VALUES (26, 22, 26, b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `RolePermission` VALUES (27, 23, 27, b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `RolePermission` VALUES (28, 24, 28, b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `RolePermission` VALUES (29, 25, 29, b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `RolePermission` VALUES (30, 26, 30, b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `RolePermission` VALUES (31, 27, 31, b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `RolePermission` VALUES (32, 28, 32, b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `RolePermission` VALUES (33, 29, 33, b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `RolePermission` VALUES (34, 30, 34, b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `RolePermission` VALUES (35, 31, 35, b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `RolePermission` VALUES (36, 32, 36, b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `RolePermission` VALUES (37, 33, 37, b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `RolePermission` VALUES (38, 34, 38, b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `RolePermission` VALUES (39, 35, 39, b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `RolePermission` VALUES (40, 36, 40, b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `RolePermission` VALUES (41, 37, 41, b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `RolePermission` VALUES (42, 38, 42, b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `RolePermission` VALUES (43, 39, 43, b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `RolePermission` VALUES (44, 40, 44, b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `RolePermission` VALUES (45, 41, 45, b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `RolePermission` VALUES (46, 42, 46, b'0', 'apollo', '2019-05-05 19:08:33', 'apollo', '2019-05-05 19:08:33');
INSERT INTO `RolePermission` VALUES (47, 43, 47, b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `RolePermission` VALUES (48, 44, 48, b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `RolePermission` VALUES (49, 45, 49, b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `RolePermission` VALUES (50, 46, 50, b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `RolePermission` VALUES (51, 47, 51, b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `RolePermission` VALUES (52, 48, 52, b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `RolePermission` VALUES (53, 49, 53, b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `RolePermission` VALUES (54, 50, 54, b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `RolePermission` VALUES (55, 51, 55, b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `RolePermission` VALUES (56, 52, 56, b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `RolePermission` VALUES (57, 53, 57, b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `RolePermission` VALUES (58, 54, 58, b'0', 'apollo', '2019-05-05 19:14:16', 'apollo', '2019-05-05 19:14:16');
INSERT INTO `RolePermission` VALUES (59, 55, 59, b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `RolePermission` VALUES (60, 56, 60, b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `RolePermission` VALUES (61, 57, 61, b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `RolePermission` VALUES (62, 58, 62, b'0', 'apollo', '2019-05-05 19:14:47', 'apollo', '2019-05-05 19:14:47');
INSERT INTO `RolePermission` VALUES (63, 59, 63, b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `RolePermission` VALUES (64, 60, 64, b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `RolePermission` VALUES (65, 61, 65, b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `RolePermission` VALUES (66, 62, 66, b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `RolePermission` VALUES (67, 63, 67, b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `RolePermission` VALUES (68, 64, 68, b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `RolePermission` VALUES (69, 65, 69, b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `RolePermission` VALUES (70, 66, 70, b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `RolePermission` VALUES (71, 67, 71, b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `RolePermission` VALUES (72, 68, 72, b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `RolePermission` VALUES (73, 69, 73, b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `RolePermission` VALUES (74, 70, 74, b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `RolePermission` VALUES (75, 71, 75, b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `RolePermission` VALUES (76, 72, 76, b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `RolePermission` VALUES (77, 73, 77, b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `RolePermission` VALUES (78, 74, 78, b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `RolePermission` VALUES (79, 75, 79, b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `RolePermission` VALUES (80, 76, 80, b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `RolePermission` VALUES (81, 77, 81, b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `RolePermission` VALUES (82, 78, 82, b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `RolePermission` VALUES (83, 79, 83, b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `RolePermission` VALUES (84, 80, 84, b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `RolePermission` VALUES (85, 81, 85, b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `RolePermission` VALUES (86, 82, 86, b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `RolePermission` VALUES (87, 83, 87, b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `RolePermission` VALUES (88, 84, 88, b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `RolePermission` VALUES (89, 85, 89, b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `RolePermission` VALUES (90, 86, 90, b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `RolePermission` VALUES (91, 87, 91, b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `RolePermission` VALUES (92, 88, 92, b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `RolePermission` VALUES (93, 89, 93, b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `RolePermission` VALUES (94, 90, 94, b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `RolePermission` VALUES (95, 91, 95, b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `RolePermission` VALUES (96, 92, 96, b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `RolePermission` VALUES (97, 93, 97, b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `RolePermission` VALUES (98, 94, 98, b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `RolePermission` VALUES (138, 132, 138, b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `RolePermission` VALUES (139, 133, 139, b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `RolePermission` VALUES (140, 134, 140, b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `RolePermission` VALUES (141, 135, 141, b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `RolePermission` VALUES (142, 136, 144, b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `RolePermission` VALUES (143, 136, 142, b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `RolePermission` VALUES (144, 136, 143, b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `RolePermission` VALUES (145, 137, 145, b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `RolePermission` VALUES (146, 138, 146, b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `RolePermission` VALUES (147, 139, 147, b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `RolePermission` VALUES (148, 140, 148, b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `RolePermission` VALUES (149, 141, 149, b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `RolePermission` VALUES (150, 142, 150, b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `RolePermission` VALUES (151, 143, 151, b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `RolePermission` VALUES (152, 144, 152, b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `RolePermission` VALUES (153, 145, 153, b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `RolePermission` VALUES (154, 146, 154, b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `RolePermission` VALUES (155, 147, 155, b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `RolePermission` VALUES (156, 148, 156, b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `RolePermission` VALUES (157, 149, 157, b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `RolePermission` VALUES (158, 150, 158, b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `RolePermission` VALUES (159, 151, 159, b'0', 'apollo', '2019-05-07 16:48:23', 'apollo', '2019-05-07 16:48:23');
INSERT INTO `RolePermission` VALUES (160, 152, 160, b'0', 'apollo', '2019-05-07 16:48:24', 'apollo', '2019-05-07 16:48:24');
INSERT INTO `RolePermission` VALUES (161, 153, 161, b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `RolePermission` VALUES (162, 154, 162, b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `RolePermission` VALUES (163, 155, 163, b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `RolePermission` VALUES (164, 156, 164, b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `RolePermission` VALUES (165, 157, 165, b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `RolePermission` VALUES (166, 158, 166, b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `RolePermission` VALUES (167, 159, 167, b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `RolePermission` VALUES (168, 160, 168, b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `RolePermission` VALUES (169, 161, 169, b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `RolePermission` VALUES (170, 162, 170, b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `RolePermission` VALUES (171, 163, 171, b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `RolePermission` VALUES (172, 164, 172, b'0', 'apollo', '2019-05-07 17:07:59', 'apollo', '2019-05-07 17:07:59');
INSERT INTO `RolePermission` VALUES (173, 165, 173, b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `RolePermission` VALUES (174, 166, 174, b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `RolePermission` VALUES (175, 167, 175, b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `RolePermission` VALUES (176, 168, 176, b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `RolePermission` VALUES (212, 202, 212, b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `RolePermission` VALUES (213, 202, 213, b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `RolePermission` VALUES (214, 202, 214, b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `RolePermission` VALUES (215, 203, 215, b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `RolePermission` VALUES (216, 204, 216, b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `RolePermission` VALUES (217, 205, 217, b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `RolePermission` VALUES (218, 206, 218, b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `RolePermission` VALUES (219, 207, 219, b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `RolePermission` VALUES (220, 208, 220, b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `RolePermission` VALUES (221, 209, 221, b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `RolePermission` VALUES (222, 210, 222, b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `RolePermission` VALUES (223, 211, 223, b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `RolePermission` VALUES (224, 212, 224, b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `RolePermission` VALUES (225, 213, 225, b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `RolePermission` VALUES (226, 214, 226, b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `RolePermission` VALUES (227, 215, 227, b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `RolePermission` VALUES (228, 216, 228, b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `RolePermission` VALUES (229, 217, 229, b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `RolePermission` VALUES (230, 218, 230, b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `RolePermission` VALUES (231, 219, 231, b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `RolePermission` VALUES (232, 220, 232, b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `RolePermission` VALUES (233, 221, 233, b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `RolePermission` VALUES (234, 222, 234, b'0', 'apollo', '2019-05-08 21:31:03', 'apollo', '2019-05-08 21:31:03');
INSERT INTO `RolePermission` VALUES (415, 395, 415, b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `RolePermission` VALUES (416, 396, 416, b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `RolePermission` VALUES (417, 397, 417, b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `RolePermission` VALUES (418, 398, 418, b'0', 'apollo', '2019-05-29 16:48:31', 'apollo', '2019-05-29 16:48:31');
INSERT INTO `RolePermission` VALUES (430, 408, 430, b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `RolePermission` VALUES (431, 409, 431, b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `RolePermission` VALUES (432, 410, 432, b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `RolePermission` VALUES (433, 411, 433, b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `RolePermission` VALUES (535, 507, 535, b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `RolePermission` VALUES (536, 508, 536, b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `RolePermission` VALUES (537, 509, 537, b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `RolePermission` VALUES (538, 510, 538, b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `RolePermission` VALUES (543, 515, 543, b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `RolePermission` VALUES (544, 516, 544, b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `RolePermission` VALUES (545, 517, 545, b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `RolePermission` VALUES (546, 518, 546, b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `RolePermission` VALUES (549, 521, 549, b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `RolePermission` VALUES (550, 522, 550, b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `RolePermission` VALUES (551, 523, 551, b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `RolePermission` VALUES (552, 524, 552, b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `RolePermission` VALUES (557, 529, 557, b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `RolePermission` VALUES (558, 530, 558, b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `RolePermission` VALUES (559, 531, 559, b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `RolePermission` VALUES (560, 532, 560, b'0', 'apollo', '2019-07-03 17:59:48', 'apollo', '2019-07-03 17:59:48');
INSERT INTO `RolePermission` VALUES (572, 542, 572, b'0', 'apollo', '2020-12-22 06:03:50', 'apollo', '2020-12-22 06:03:50');
INSERT INTO `RolePermission` VALUES (573, 543, 573, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `RolePermission` VALUES (574, 543, 574, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `RolePermission` VALUES (575, 543, 575, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `RolePermission` VALUES (576, 544, 576, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `RolePermission` VALUES (577, 545, 577, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `RolePermission` VALUES (578, 546, 578, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `RolePermission` VALUES (579, 547, 579, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `RolePermission` VALUES (580, 548, 580, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `RolePermission` VALUES (581, 549, 581, b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `RolePermission` VALUES (582, 550, 582, b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `RolePermission` VALUES (583, 551, 583, b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `RolePermission` VALUES (584, 552, 584, b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `RolePermission` VALUES (585, 553, 585, b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `RolePermission` VALUES (586, 554, 586, b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `RolePermission` VALUES (587, 555, 587, b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `RolePermission` VALUES (588, 556, 588, b'0', 'apollo', '2020-12-23 07:01:49', 'apollo', '2020-12-23 07:01:49');
INSERT INTO `RolePermission` VALUES (589, 557, 589, b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `RolePermission` VALUES (590, 558, 590, b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `RolePermission` VALUES (591, 559, 591, b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `RolePermission` VALUES (592, 560, 592, b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `RolePermission` VALUES (593, 561, 593, b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `RolePermission` VALUES (594, 562, 594, b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `RolePermission` VALUES (595, 563, 595, b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `RolePermission` VALUES (596, 564, 596, b'0', 'apollo', '2020-12-23 07:02:23', 'apollo', '2020-12-23 07:02:23');
INSERT INTO `RolePermission` VALUES (597, 565, 597, b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `RolePermission` VALUES (598, 566, 598, b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `RolePermission` VALUES (599, 567, 599, b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `RolePermission` VALUES (600, 568, 600, b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `RolePermission` VALUES (601, 569, 601, b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `RolePermission` VALUES (602, 570, 602, b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `RolePermission` VALUES (603, 571, 603, b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `RolePermission` VALUES (604, 572, 604, b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `RolePermission` VALUES (605, 573, 605, b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `RolePermission` VALUES (606, 574, 606, b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `RolePermission` VALUES (607, 575, 607, b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `RolePermission` VALUES (608, 576, 608, b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `RolePermission` VALUES (609, 577, 609, b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `RolePermission` VALUES (610, 578, 610, b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `RolePermission` VALUES (611, 579, 611, b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `RolePermission` VALUES (612, 580, 612, b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `RolePermission` VALUES (613, 581, 613, b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `RolePermission` VALUES (614, 582, 614, b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `RolePermission` VALUES (615, 583, 615, b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `RolePermission` VALUES (616, 584, 616, b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `RolePermission` VALUES (617, 585, 617, b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `RolePermission` VALUES (618, 586, 618, b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `RolePermission` VALUES (619, 587, 619, b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `RolePermission` VALUES (620, 588, 620, b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `RolePermission` VALUES (621, 589, 621, b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `RolePermission` VALUES (622, 589, 622, b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `RolePermission` VALUES (623, 589, 623, b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `RolePermission` VALUES (624, 590, 624, b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `RolePermission` VALUES (625, 591, 625, b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `RolePermission` VALUES (626, 592, 626, b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `RolePermission` VALUES (627, 593, 627, b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `RolePermission` VALUES (628, 594, 628, b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `RolePermission` VALUES (629, 595, 629, b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `RolePermission` VALUES (630, 596, 630, b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `RolePermission` VALUES (631, 597, 631, b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `RolePermission` VALUES (632, 598, 632, b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `RolePermission` VALUES (633, 599, 633, b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `RolePermission` VALUES (634, 600, 634, b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `RolePermission` VALUES (635, 601, 635, b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `RolePermission` VALUES (636, 602, 636, b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `RolePermission` VALUES (637, 603, 637, b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `RolePermission` VALUES (638, 604, 638, b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `RolePermission` VALUES (639, 605, 639, b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `RolePermission` VALUES (640, 606, 640, b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `RolePermission` VALUES (641, 607, 641, b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `RolePermission` VALUES (642, 608, 642, b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `RolePermission` VALUES (643, 609, 643, b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `RolePermission` VALUES (644, 610, 644, b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `RolePermission` VALUES (645, 611, 645, b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `RolePermission` VALUES (646, 612, 646, b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `RolePermission` VALUES (647, 613, 647, b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `RolePermission` VALUES (648, 614, 648, b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `RolePermission` VALUES (649, 615, 649, b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `RolePermission` VALUES (650, 616, 650, b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `RolePermission` VALUES (651, 617, 651, b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `RolePermission` VALUES (652, 618, 652, b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `RolePermission` VALUES (653, 619, 653, b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `RolePermission` VALUES (654, 620, 654, b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `RolePermission` VALUES (655, 621, 655, b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `RolePermission` VALUES (656, 622, 656, b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `RolePermission` VALUES (657, 623, 657, b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `RolePermission` VALUES (658, 624, 658, b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `RolePermission` VALUES (659, 625, 659, b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `RolePermission` VALUES (660, 626, 660, b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `RolePermission` VALUES (661, 627, 661, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `RolePermission` VALUES (662, 627, 662, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `RolePermission` VALUES (663, 627, 663, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `RolePermission` VALUES (664, 628, 664, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `RolePermission` VALUES (665, 629, 665, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `RolePermission` VALUES (666, 630, 666, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `RolePermission` VALUES (667, 631, 667, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `RolePermission` VALUES (668, 632, 668, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `RolePermission` VALUES (669, 633, 669, b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `RolePermission` VALUES (670, 634, 670, b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `RolePermission` VALUES (671, 635, 671, b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `RolePermission` VALUES (672, 636, 672, b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `RolePermission` VALUES (673, 637, 673, b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `RolePermission` VALUES (674, 638, 674, b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `RolePermission` VALUES (675, 639, 675, b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `RolePermission` VALUES (676, 640, 676, b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `RolePermission` VALUES (677, 641, 677, b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `RolePermission` VALUES (678, 642, 678, b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `RolePermission` VALUES (679, 643, 679, b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `RolePermission` VALUES (680, 644, 680, b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `RolePermission` VALUES (681, 645, 681, b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `RolePermission` VALUES (682, 646, 682, b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `RolePermission` VALUES (683, 647, 683, b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `RolePermission` VALUES (684, 648, 684, b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `RolePermission` VALUES (685, 649, 685, b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `RolePermission` VALUES (686, 650, 686, b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `RolePermission` VALUES (687, 651, 687, b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `RolePermission` VALUES (688, 652, 688, b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `RolePermission` VALUES (689, 653, 689, b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `RolePermission` VALUES (690, 654, 690, b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `RolePermission` VALUES (691, 655, 691, b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `RolePermission` VALUES (692, 656, 692, b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `RolePermission` VALUES (693, 657, 693, b'0', 'apollo', '2020-12-24 17:44:16', 'apollo', '2020-12-24 17:44:16');
INSERT INTO `RolePermission` VALUES (694, 658, 694, b'0', 'apollo', '2020-12-24 17:44:16', 'apollo', '2020-12-24 17:44:16');
INSERT INTO `RolePermission` VALUES (695, 659, 695, b'0', 'apollo', '2020-12-24 17:44:16', 'apollo', '2020-12-24 17:44:16');
INSERT INTO `RolePermission` VALUES (696, 660, 696, b'0', 'apollo', '2020-12-24 17:44:17', 'apollo', '2020-12-24 17:44:17');
INSERT INTO `RolePermission` VALUES (697, 661, 697, b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `RolePermission` VALUES (698, 662, 698, b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `RolePermission` VALUES (699, 663, 699, b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `RolePermission` VALUES (700, 664, 700, b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `RolePermission` VALUES (701, 665, 701, b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `RolePermission` VALUES (702, 666, 702, b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `RolePermission` VALUES (703, 667, 703, b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `RolePermission` VALUES (704, 668, 704, b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `RolePermission` VALUES (705, 669, 705, b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `RolePermission` VALUES (706, 670, 706, b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `RolePermission` VALUES (707, 671, 707, b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `RolePermission` VALUES (708, 672, 708, b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `RolePermission` VALUES (709, 673, 709, b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `RolePermission` VALUES (710, 674, 710, b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `RolePermission` VALUES (711, 675, 711, b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `RolePermission` VALUES (712, 676, 712, b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `RolePermission` VALUES (713, 677, 713, b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `RolePermission` VALUES (714, 678, 714, b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `RolePermission` VALUES (715, 679, 715, b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `RolePermission` VALUES (716, 680, 716, b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `RolePermission` VALUES (717, 681, 717, b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `RolePermission` VALUES (718, 682, 718, b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `RolePermission` VALUES (719, 683, 719, b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `RolePermission` VALUES (720, 684, 720, b'0', 'apollo', '2020-12-25 00:12:23', 'apollo', '2020-12-25 00:12:23');
INSERT INTO `RolePermission` VALUES (721, 685, 721, b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
INSERT INTO `RolePermission` VALUES (722, 686, 722, b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
INSERT INTO `RolePermission` VALUES (723, 687, 723, b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
INSERT INTO `RolePermission` VALUES (724, 688, 724, b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
COMMIT;

-- ----------------------------
-- Table structure for ServerConfig
-- ----------------------------
DROP TABLE IF EXISTS `ServerConfig`;
CREATE TABLE `ServerConfig` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Key` varchar(64) NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `Value` varchar(2048) NOT NULL DEFAULT 'default' COMMENT '配置项值',
  `Comment` varchar(1024) DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_Key` (`Key`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='配置服务自身配置';

-- ----------------------------
-- Records of ServerConfig
-- ----------------------------
BEGIN;
INSERT INTO `ServerConfig` VALUES (1, 'apollo.portal.envs', 'dev', '可支持的环境列表', b'0', 'default', '2019-07-13 08:30:54', '', '2019-07-13 08:30:54');
INSERT INTO `ServerConfig` VALUES (2, 'organizations', '[{\"orgId\":\"micro_service\",\"orgName\":\"万信金融项目组\"}]', '部门名称', b'0', 'default', '2019-07-13 08:30:54', 'apollo', '2019-07-16 11:53:44');
INSERT INTO `ServerConfig` VALUES (3, 'superAdmin', 'apollo', 'Portal超级管理员', b'0', 'default', '2019-07-13 08:30:54', '', '2019-07-13 08:30:54');
INSERT INTO `ServerConfig` VALUES (4, 'api.readTimeout', '10000', 'http接口read timeout', b'0', 'default', '2019-07-13 08:30:54', '', '2019-07-13 08:30:54');
INSERT INTO `ServerConfig` VALUES (5, 'consumer.token.salt', 'someSalt', 'consumer token salt', b'0', 'default', '2019-07-13 08:30:54', '', '2019-07-13 08:30:54');
INSERT INTO `ServerConfig` VALUES (6, 'admin.createPrivateNamespace.switch', 'true', '是否允许项目管理员创建私有namespace', b'0', 'default', '2019-07-13 08:30:54', '', '2019-07-13 08:30:54');
INSERT INTO `ServerConfig` VALUES (7, 'configView.memberOnly.envs', 'pro', '只对项目成员显示配置信息的环境列表，多个env以英文逗号分隔', b'0', 'default', '2019-07-13 08:30:54', '', '2019-07-13 08:30:54');
COMMIT;

-- ----------------------------
-- Table structure for UserRole
-- ----------------------------
DROP TABLE IF EXISTS `UserRole`;
CREATE TABLE `UserRole` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `UserId` varchar(128) DEFAULT '' COMMENT '用户身份标识',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`),
  KEY `IX_UserId_RoleId` (`UserId`,`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=351 DEFAULT CHARSET=utf8mb4 COMMENT='用户和role的绑定表';

-- ----------------------------
-- Records of UserRole
-- ----------------------------
BEGIN;
INSERT INTO `UserRole` VALUES (1, 'apollo', 1, b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `UserRole` VALUES (2, 'apollo', 2, b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `UserRole` VALUES (3, 'apollo', 3, b'0', 'apollo', '2019-05-01 00:55:29', 'apollo', '2019-05-01 00:55:29');
INSERT INTO `UserRole` VALUES (4, 'apollo', 6, b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `UserRole` VALUES (5, 'apollo', 7, b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `UserRole` VALUES (6, 'apollo', 8, b'0', 'apollo', '2019-05-05 18:05:17', 'apollo', '2019-05-05 18:05:17');
INSERT INTO `UserRole` VALUES (7, 'apollo', 11, b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `UserRole` VALUES (8, 'apollo', 12, b'0', 'apollo', '2019-05-05 18:47:05', 'apollo', '2019-05-05 18:47:05');
INSERT INTO `UserRole` VALUES (9, 'apollo', 15, b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `UserRole` VALUES (10, 'apollo', 16, b'0', 'apollo', '2019-05-05 18:48:30', 'apollo', '2019-05-05 18:48:30');
INSERT INTO `UserRole` VALUES (11, 'apollo', 19, b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `UserRole` VALUES (12, 'apollo', 20, b'0', 'apollo', '2019-05-05 18:49:34', 'apollo', '2019-05-05 18:49:34');
INSERT INTO `UserRole` VALUES (13, 'apollo', 23, b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `UserRole` VALUES (14, 'apollo', 24, b'0', 'apollo', '2019-05-05 18:51:22', 'apollo', '2019-05-05 18:51:22');
INSERT INTO `UserRole` VALUES (15, 'apollo', 27, b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `UserRole` VALUES (16, 'apollo', 28, b'0', 'apollo', '2019-05-05 18:52:14', 'apollo', '2019-05-05 18:52:14');
INSERT INTO `UserRole` VALUES (17, 'apollo', 31, b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `UserRole` VALUES (18, 'apollo', 32, b'0', 'apollo', '2019-05-05 18:53:09', 'apollo', '2019-05-05 18:53:09');
INSERT INTO `UserRole` VALUES (19, 'apollo', 35, b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `UserRole` VALUES (20, 'apollo', 36, b'0', 'apollo', '2019-05-05 18:54:58', 'apollo', '2019-05-05 18:54:58');
INSERT INTO `UserRole` VALUES (21, 'apollo', 39, b'0', 'apollo', '2019-05-05 19:08:34', 'apollo', '2019-05-05 19:08:34');
INSERT INTO `UserRole` VALUES (22, 'apollo', 40, b'0', 'apollo', '2019-05-05 19:08:34', 'apollo', '2019-05-05 19:08:34');
INSERT INTO `UserRole` VALUES (23, 'apollo', 43, b'0', 'apollo', '2019-05-05 19:10:01', 'apollo', '2019-05-05 19:10:01');
INSERT INTO `UserRole` VALUES (24, 'apollo', 44, b'0', 'apollo', '2019-05-05 19:10:02', 'apollo', '2019-05-05 19:10:02');
INSERT INTO `UserRole` VALUES (25, 'apollo', 47, b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `UserRole` VALUES (26, 'apollo', 48, b'0', 'apollo', '2019-05-05 19:11:30', 'apollo', '2019-05-05 19:11:30');
INSERT INTO `UserRole` VALUES (27, 'apollo', 51, b'0', 'apollo', '2019-05-05 19:14:17', 'apollo', '2019-05-05 19:14:17');
INSERT INTO `UserRole` VALUES (28, 'apollo', 52, b'0', 'apollo', '2019-05-05 19:14:17', 'apollo', '2019-05-05 19:14:17');
INSERT INTO `UserRole` VALUES (29, 'apollo', 55, b'0', 'apollo', '2019-05-05 19:14:48', 'apollo', '2019-05-05 19:14:48');
INSERT INTO `UserRole` VALUES (30, 'apollo', 56, b'0', 'apollo', '2019-05-05 19:14:48', 'apollo', '2019-05-05 19:14:48');
INSERT INTO `UserRole` VALUES (31, 'apollo', 59, b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `UserRole` VALUES (32, 'apollo', 60, b'0', 'apollo', '2019-05-05 19:15:58', 'apollo', '2019-05-05 19:15:58');
INSERT INTO `UserRole` VALUES (33, 'apollo', 63, b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `UserRole` VALUES (34, 'apollo', 64, b'0', 'apollo', '2019-05-05 19:18:32', 'apollo', '2019-05-05 19:18:32');
INSERT INTO `UserRole` VALUES (35, 'apollo', 67, b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `UserRole` VALUES (36, 'apollo', 68, b'0', 'apollo', '2019-05-05 19:20:41', 'apollo', '2019-05-05 19:20:41');
INSERT INTO `UserRole` VALUES (37, 'apollo', 71, b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `UserRole` VALUES (38, 'apollo', 72, b'0', 'apollo', '2019-05-05 22:24:11', 'apollo', '2019-05-05 22:24:11');
INSERT INTO `UserRole` VALUES (39, 'apollo', 75, b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `UserRole` VALUES (40, 'apollo', 76, b'0', 'apollo', '2019-05-05 22:59:39', 'apollo', '2019-05-05 22:59:39');
INSERT INTO `UserRole` VALUES (41, 'apollo', 79, b'0', 'apollo', '2019-05-06 20:55:40', 'apollo', '2019-05-06 20:55:40');
INSERT INTO `UserRole` VALUES (42, 'apollo', 80, b'0', 'apollo', '2019-05-06 20:55:41', 'apollo', '2019-05-06 20:55:41');
INSERT INTO `UserRole` VALUES (43, 'apollo', 83, b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `UserRole` VALUES (44, 'apollo', 84, b'0', 'apollo', '2019-05-06 21:05:53', 'apollo', '2019-05-06 21:05:53');
INSERT INTO `UserRole` VALUES (45, 'apollo', 87, b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `UserRole` VALUES (46, 'apollo', 88, b'0', 'apollo', '2019-05-06 22:58:50', 'apollo', '2019-05-06 22:58:50');
INSERT INTO `UserRole` VALUES (47, 'apollo', 91, b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `UserRole` VALUES (48, 'apollo', 92, b'0', 'apollo', '2019-05-06 23:00:34', 'apollo', '2019-05-06 23:00:34');
INSERT INTO `UserRole` VALUES (49, 'apollo', 95, b'1', 'apollo', '2019-05-07 00:40:14', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (50, 'apollo', 96, b'1', 'apollo', '2019-05-07 00:40:14', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (51, 'apollo', 97, b'1', 'apollo', '2019-05-07 00:40:14', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (52, 'apollo', 100, b'1', 'apollo', '2019-05-07 00:41:19', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (53, 'apollo', 101, b'1', 'apollo', '2019-05-07 00:41:19', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (54, 'apollo', 104, b'1', 'apollo', '2019-05-07 00:41:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (55, 'apollo', 105, b'1', 'apollo', '2019-05-07 00:41:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (56, 'apollo', 108, b'1', 'apollo', '2019-05-07 00:42:18', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (57, 'apollo', 109, b'1', 'apollo', '2019-05-07 00:42:18', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (58, 'apollo', 112, b'1', 'apollo', '2019-05-07 00:42:28', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (59, 'apollo', 113, b'1', 'apollo', '2019-05-07 00:42:28', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (60, 'apollo', 116, b'1', 'apollo', '2019-05-07 00:42:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (61, 'apollo', 117, b'1', 'apollo', '2019-05-07 00:42:39', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (62, 'apollo', 120, b'1', 'apollo', '2019-05-07 00:43:05', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (63, 'apollo', 121, b'1', 'apollo', '2019-05-07 00:43:05', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (64, 'apollo', 124, b'1', 'apollo', '2019-05-07 00:43:17', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (65, 'apollo', 125, b'1', 'apollo', '2019-05-07 00:43:17', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (66, 'apollo', 128, b'1', 'apollo', '2019-05-07 00:43:34', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (67, 'apollo', 129, b'1', 'apollo', '2019-05-07 00:43:34', 'apollo', '2019-07-14 17:16:07');
INSERT INTO `UserRole` VALUES (68, 'apollo', 132, b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `UserRole` VALUES (69, 'apollo', 133, b'0', 'apollo', '2019-05-07 00:52:50', 'apollo', '2019-05-07 00:52:50');
INSERT INTO `UserRole` VALUES (70, 'apollo', 136, b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `UserRole` VALUES (71, 'apollo', 137, b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `UserRole` VALUES (72, 'apollo', 138, b'0', 'apollo', '2019-05-07 01:31:40', 'apollo', '2019-05-07 01:31:40');
INSERT INTO `UserRole` VALUES (73, 'apollo', 141, b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `UserRole` VALUES (74, 'apollo', 142, b'0', 'apollo', '2019-05-07 16:44:27', 'apollo', '2019-05-07 16:44:27');
INSERT INTO `UserRole` VALUES (75, 'apollo', 145, b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `UserRole` VALUES (76, 'apollo', 146, b'0', 'apollo', '2019-05-07 16:47:38', 'apollo', '2019-05-07 16:47:38');
INSERT INTO `UserRole` VALUES (77, 'apollo', 149, b'0', 'apollo', '2019-05-07 16:48:24', 'apollo', '2019-05-07 16:48:24');
INSERT INTO `UserRole` VALUES (78, 'apollo', 150, b'0', 'apollo', '2019-05-07 16:48:24', 'apollo', '2019-05-07 16:48:24');
INSERT INTO `UserRole` VALUES (79, 'apollo', 153, b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `UserRole` VALUES (80, 'apollo', 154, b'0', 'apollo', '2019-05-07 16:48:30', 'apollo', '2019-05-07 16:48:30');
INSERT INTO `UserRole` VALUES (81, 'apollo', 157, b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `UserRole` VALUES (82, 'apollo', 158, b'0', 'apollo', '2019-05-07 16:48:39', 'apollo', '2019-05-07 16:48:39');
INSERT INTO `UserRole` VALUES (83, 'apollo', 161, b'0', 'apollo', '2019-05-07 17:08:00', 'apollo', '2019-05-07 17:08:00');
INSERT INTO `UserRole` VALUES (84, 'apollo', 162, b'0', 'apollo', '2019-05-07 17:08:00', 'apollo', '2019-05-07 17:08:00');
INSERT INTO `UserRole` VALUES (85, 'apollo', 165, b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `UserRole` VALUES (86, 'apollo', 166, b'0', 'apollo', '2019-05-07 17:08:38', 'apollo', '2019-05-07 17:08:38');
INSERT INTO `UserRole` VALUES (87, 'apollo', 169, b'1', 'apollo', '2019-05-07 19:03:38', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (88, 'apollo', 170, b'1', 'apollo', '2019-05-07 19:03:38', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (89, 'apollo', 171, b'1', 'apollo', '2019-05-07 19:03:38', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (90, 'apollo', 174, b'1', 'apollo', '2019-05-07 19:05:50', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (91, 'apollo', 175, b'1', 'apollo', '2019-05-07 19:05:51', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (92, 'apollo', 178, b'1', 'apollo', '2019-05-07 19:06:40', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (93, 'apollo', 179, b'1', 'apollo', '2019-05-07 19:06:40', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (94, 'apollo', 182, b'1', 'apollo', '2019-05-07 19:07:49', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (95, 'apollo', 183, b'1', 'apollo', '2019-05-07 19:07:49', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (96, 'apollo', 186, b'1', 'apollo', '2019-05-07 19:10:30', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (97, 'apollo', 187, b'1', 'apollo', '2019-05-07 19:10:30', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (98, 'apollo', 190, b'1', 'apollo', '2019-05-07 19:12:12', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (99, 'apollo', 191, b'1', 'apollo', '2019-05-07 19:12:12', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (100, 'apollo', 194, b'1', 'apollo', '2019-05-07 19:12:20', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (101, 'apollo', 195, b'1', 'apollo', '2019-05-07 19:12:20', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (102, 'apollo', 198, b'1', 'apollo', '2019-05-07 19:12:26', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (103, 'apollo', 199, b'1', 'apollo', '2019-05-07 19:12:26', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (104, 'apollo', 202, b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `UserRole` VALUES (105, 'apollo', 203, b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `UserRole` VALUES (106, 'apollo', 204, b'0', 'apollo', '2019-05-08 21:29:39', 'apollo', '2019-05-08 21:29:39');
INSERT INTO `UserRole` VALUES (107, 'apollo', 207, b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `UserRole` VALUES (108, 'apollo', 208, b'0', 'apollo', '2019-05-08 21:30:16', 'apollo', '2019-05-08 21:30:16');
INSERT INTO `UserRole` VALUES (109, 'apollo', 211, b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `UserRole` VALUES (110, 'apollo', 212, b'0', 'apollo', '2019-05-08 21:30:34', 'apollo', '2019-05-08 21:30:34');
INSERT INTO `UserRole` VALUES (111, 'apollo', 215, b'0', 'apollo', '2019-05-08 21:30:55', 'apollo', '2019-05-08 21:30:55');
INSERT INTO `UserRole` VALUES (112, 'apollo', 216, b'0', 'apollo', '2019-05-08 21:30:56', 'apollo', '2019-05-08 21:30:56');
INSERT INTO `UserRole` VALUES (113, 'apollo', 219, b'0', 'apollo', '2019-05-08 21:31:04', 'apollo', '2019-05-08 21:31:04');
INSERT INTO `UserRole` VALUES (114, 'apollo', 220, b'0', 'apollo', '2019-05-08 21:31:04', 'apollo', '2019-05-08 21:31:04');
INSERT INTO `UserRole` VALUES (115, 'apollo', 223, b'1', 'apollo', '2019-05-17 10:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (116, 'apollo', 224, b'1', 'apollo', '2019-05-17 10:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (117, 'apollo', 225, b'1', 'apollo', '2019-05-17 10:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (118, 'apollo', 228, b'1', 'apollo', '2019-05-17 10:32:21', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (119, 'apollo', 229, b'1', 'apollo', '2019-05-17 10:32:21', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (120, 'apollo', 230, b'1', 'apollo', '2019-05-17 10:32:21', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (121, 'apollo', 233, b'1', 'apollo', '2019-05-17 11:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (122, 'apollo', 234, b'1', 'apollo', '2019-05-17 11:10:29', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (123, 'apollo', 237, b'1', 'apollo', '2019-05-17 11:10:38', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (124, 'apollo', 238, b'1', 'apollo', '2019-05-17 11:10:38', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (125, 'apollo', 241, b'1', 'apollo', '2019-05-17 11:10:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (126, 'apollo', 242, b'1', 'apollo', '2019-05-17 11:10:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (127, 'apollo', 245, b'1', 'apollo', '2019-05-17 11:10:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (128, 'apollo', 246, b'1', 'apollo', '2019-05-17 11:10:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (129, 'apollo', 249, b'1', 'apollo', '2019-05-17 11:11:13', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (130, 'apollo', 250, b'1', 'apollo', '2019-05-17 11:11:13', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (131, 'apollo', 253, b'1', 'apollo', '2019-05-17 11:11:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (132, 'apollo', 254, b'1', 'apollo', '2019-05-17 11:11:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (133, 'apollo', 257, b'1', 'apollo', '2019-05-17 11:11:39', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (134, 'apollo', 258, b'1', 'apollo', '2019-05-17 11:11:40', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (135, 'apollo', 261, b'1', 'apollo', '2019-05-17 11:11:51', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (136, 'apollo', 262, b'1', 'apollo', '2019-05-17 11:11:51', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (137, 'apollo', 265, b'1', 'apollo', '2019-05-17 11:12:00', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (138, 'apollo', 266, b'1', 'apollo', '2019-05-17 11:12:00', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (139, 'apollo', 269, b'1', 'apollo', '2019-05-17 11:12:14', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (140, 'apollo', 270, b'1', 'apollo', '2019-05-17 11:12:14', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (141, 'apollo', 273, b'1', 'apollo', '2019-05-17 13:06:12', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `UserRole` VALUES (142, 'apollo', 274, b'1', 'apollo', '2019-05-17 13:06:12', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (143, 'apollo', 275, b'1', 'apollo', '2019-05-17 13:06:12', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (144, 'apollo', 278, b'1', 'apollo', '2019-05-17 13:09:24', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (145, 'apollo', 279, b'1', 'apollo', '2019-05-17 13:09:24', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (146, 'apollo', 282, b'1', 'apollo', '2019-05-17 13:09:31', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (147, 'apollo', 283, b'1', 'apollo', '2019-05-17 13:09:31', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (148, 'apollo', 286, b'1', 'apollo', '2019-05-17 13:09:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (149, 'apollo', 287, b'1', 'apollo', '2019-05-17 13:09:45', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (150, 'apollo', 290, b'1', 'apollo', '2019-05-17 13:09:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (151, 'apollo', 291, b'1', 'apollo', '2019-05-17 13:09:53', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (152, 'apollo', 294, b'1', 'apollo', '2019-05-17 13:10:01', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (153, 'apollo', 295, b'1', 'apollo', '2019-05-17 13:10:01', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (154, 'apollo', 298, b'1', 'apollo', '2019-05-17 13:10:08', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (155, 'apollo', 299, b'1', 'apollo', '2019-05-17 13:10:08', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (156, 'apollo', 302, b'1', 'apollo', '2019-05-17 13:10:20', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (157, 'apollo', 303, b'1', 'apollo', '2019-05-17 13:10:20', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (158, 'apollo', 306, b'1', 'apollo', '2019-05-17 13:10:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (159, 'apollo', 307, b'1', 'apollo', '2019-05-17 13:10:27', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (160, 'apollo', 310, b'1', 'apollo', '2019-05-17 13:10:40', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (161, 'apollo', 311, b'1', 'apollo', '2019-05-17 13:10:40', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (162, 'apollo', 314, b'1', 'apollo', '2019-05-17 13:10:58', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (163, 'apollo', 315, b'1', 'apollo', '2019-05-17 13:10:58', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (164, 'apollo', 318, b'1', 'apollo', '2019-05-17 13:11:11', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (165, 'apollo', 319, b'1', 'apollo', '2019-05-17 13:11:11', 'apollo', '2019-05-17 13:18:04');
INSERT INTO `UserRole` VALUES (166, 'apollo', 322, b'1', 'apollo', '2019-05-17 13:57:00', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (167, 'apollo', 323, b'1', 'apollo', '2019-05-17 13:57:00', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (168, 'apollo', 326, b'1', 'apollo', '2019-05-17 14:16:03', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (169, 'apollo', 327, b'1', 'apollo', '2019-05-17 14:16:03', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (170, 'apollo', 330, b'1', 'apollo', '2019-05-17 14:18:29', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (171, 'apollo', 331, b'1', 'apollo', '2019-05-17 14:18:29', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (172, 'apollo', 334, b'1', 'apollo', '2019-05-17 14:18:58', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (173, 'apollo', 335, b'1', 'apollo', '2019-05-17 14:18:58', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (174, 'apollo', 338, b'1', 'apollo', '2019-05-17 14:19:07', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (175, 'apollo', 339, b'1', 'apollo', '2019-05-17 14:19:07', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (176, 'apollo', 342, b'1', 'apollo', '2019-05-17 14:19:14', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (177, 'apollo', 343, b'1', 'apollo', '2019-05-17 14:19:14', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (178, 'apollo', 346, b'1', 'apollo', '2019-05-17 15:20:49', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (179, 'apollo', 347, b'1', 'apollo', '2019-05-17 15:20:49', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (180, 'apollo', 352, b'1', 'apollo', '2019-05-18 17:16:33', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `UserRole` VALUES (181, 'apollo', 353, b'1', 'apollo', '2019-05-18 17:16:40', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `UserRole` VALUES (182, 'apollo', 354, b'1', 'apollo', '2019-05-22 11:28:11', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (183, 'apollo', 355, b'1', 'apollo', '2019-05-22 11:28:11', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (184, 'apollo', 356, b'1', 'apollo', '2019-05-22 11:28:11', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (185, 'apollo', 359, b'1', 'apollo', '2019-05-22 11:28:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (186, 'apollo', 360, b'1', 'apollo', '2019-05-22 11:28:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (187, 'apollo', 363, b'1', 'apollo', '2019-05-22 11:28:40', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (188, 'apollo', 364, b'1', 'apollo', '2019-05-22 11:28:40', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (189, 'apollo', 367, b'1', 'apollo', '2019-05-22 11:28:49', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (190, 'apollo', 368, b'1', 'apollo', '2019-05-22 11:28:49', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (191, 'apollo', 371, b'1', 'apollo', '2019-05-22 11:29:02', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (192, 'apollo', 372, b'1', 'apollo', '2019-05-22 11:29:02', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (193, 'apollo', 375, b'1', 'apollo', '2019-05-22 11:29:10', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (194, 'apollo', 376, b'1', 'apollo', '2019-05-22 11:29:10', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (195, 'apollo', 379, b'1', 'apollo', '2019-05-22 11:29:16', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (196, 'apollo', 380, b'1', 'apollo', '2019-05-22 11:29:16', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (197, 'apollo', 383, b'1', 'apollo', '2019-05-22 11:29:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (198, 'apollo', 384, b'1', 'apollo', '2019-05-22 11:29:25', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (199, 'apollo', 387, b'1', 'apollo', '2019-05-28 08:54:58', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (200, 'apollo', 388, b'1', 'apollo', '2019-05-28 08:54:58', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (201, 'apollo', 391, b'1', 'apollo', '2019-05-28 15:52:22', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (202, 'apollo', 392, b'1', 'apollo', '2019-05-28 15:52:22', 'apollo', '2019-07-14 17:17:49');
INSERT INTO `UserRole` VALUES (203, 'apollo', 395, b'0', 'apollo', '2019-05-29 16:48:32', 'apollo', '2019-05-29 16:48:32');
INSERT INTO `UserRole` VALUES (204, 'apollo', 396, b'0', 'apollo', '2019-05-29 16:48:32', 'apollo', '2019-05-29 16:48:32');
INSERT INTO `UserRole` VALUES (205, 'apollo', 399, b'1', 'apollo', '2019-05-31 09:03:34', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (206, 'apollo', 400, b'1', 'apollo', '2019-05-31 09:03:34', 'apollo', '2019-07-14 17:19:15');
INSERT INTO `UserRole` VALUES (207, 'apollo', 403, b'1', 'apollo', '2019-05-31 14:24:24', 'apollo', '2019-05-31 14:26:27');
INSERT INTO `UserRole` VALUES (208, 'apollo', 404, b'1', 'apollo', '2019-05-31 14:24:24', 'apollo', '2019-05-31 14:26:27');
INSERT INTO `UserRole` VALUES (209, 'apollo', 405, b'1', 'apollo', '2019-05-31 14:24:24', 'apollo', '2019-05-31 14:26:27');
INSERT INTO `UserRole` VALUES (210, 'apollo', 408, b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `UserRole` VALUES (211, 'apollo', 409, b'0', 'apollo', '2019-06-03 11:40:35', 'apollo', '2019-06-03 11:40:35');
INSERT INTO `UserRole` VALUES (212, 'apollo', 412, b'1', 'apollo', '2019-06-20 15:23:57', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `UserRole` VALUES (213, 'apollo', 413, b'1', 'apollo', '2019-06-20 15:23:57', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `UserRole` VALUES (214, 'apollo', 414, b'1', 'apollo', '2019-06-20 15:23:57', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `UserRole` VALUES (215, 'apollo', 417, b'1', 'apollo', '2019-06-20 15:33:59', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `UserRole` VALUES (216, 'apollo', 418, b'1', 'apollo', '2019-06-20 15:33:59', 'apollo', '2019-06-20 15:35:37');
INSERT INTO `UserRole` VALUES (217, 'apollo', 421, b'1', 'apollo', '2019-06-20 15:36:13', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (218, 'apollo', 422, b'1', 'apollo', '2019-06-20 15:36:13', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (219, 'apollo', 423, b'1', 'apollo', '2019-06-20 15:36:13', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (220, 'apollo', 426, b'1', 'apollo', '2019-06-20 15:36:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (221, 'apollo', 427, b'1', 'apollo', '2019-06-20 15:36:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (222, 'apollo', 430, b'1', 'apollo', '2019-06-20 15:36:52', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (223, 'apollo', 431, b'1', 'apollo', '2019-06-20 15:36:52', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (224, 'apollo', 434, b'1', 'apollo', '2019-06-20 15:36:56', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (225, 'apollo', 435, b'1', 'apollo', '2019-06-20 15:36:56', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (226, 'apollo', 438, b'1', 'apollo', '2019-06-20 15:37:02', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (227, 'apollo', 439, b'1', 'apollo', '2019-06-20 15:37:02', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (228, 'apollo', 442, b'1', 'apollo', '2019-06-20 15:37:09', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (229, 'apollo', 443, b'1', 'apollo', '2019-06-20 15:37:09', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (230, 'apollo', 446, b'1', 'apollo', '2019-06-20 15:37:14', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (231, 'apollo', 447, b'1', 'apollo', '2019-06-20 15:37:14', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (232, 'apollo', 450, b'1', 'apollo', '2019-06-20 15:37:23', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (233, 'apollo', 451, b'1', 'apollo', '2019-06-20 15:37:23', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (234, 'apollo', 454, b'1', 'apollo', '2019-06-20 15:37:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (235, 'apollo', 455, b'1', 'apollo', '2019-06-20 15:37:42', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (236, 'apollo', 458, b'1', 'apollo', '2019-06-20 15:37:48', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (237, 'apollo', 459, b'1', 'apollo', '2019-06-20 15:37:48', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (238, 'apollo', 462, b'1', 'apollo', '2019-06-20 15:37:59', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (239, 'apollo', 463, b'1', 'apollo', '2019-06-20 15:38:00', 'apollo', '2019-07-14 17:18:52');
INSERT INTO `UserRole` VALUES (240, 'apollo', 466, b'1', 'apollo', '2019-06-26 15:48:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (241, 'apollo', 467, b'1', 'apollo', '2019-06-26 15:48:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (242, 'apollo', 468, b'1', 'apollo', '2019-06-26 15:48:12', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (243, 'apollo', 471, b'1', 'apollo', '2019-06-26 15:48:58', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (244, 'apollo', 472, b'1', 'apollo', '2019-06-26 15:48:58', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (245, 'apollo', 475, b'1', 'apollo', '2019-06-26 15:49:18', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (246, 'apollo', 476, b'1', 'apollo', '2019-06-26 15:49:18', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (247, 'apollo', 479, b'1', 'apollo', '2019-06-26 15:49:40', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (248, 'apollo', 480, b'1', 'apollo', '2019-06-26 15:49:40', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (249, 'apollo', 483, b'1', 'apollo', '2019-06-26 15:49:52', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (250, 'apollo', 484, b'1', 'apollo', '2019-06-26 15:49:52', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (251, 'apollo', 487, b'1', 'apollo', '2019-06-26 15:50:13', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (252, 'apollo', 488, b'1', 'apollo', '2019-06-26 15:50:13', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (253, 'apollo', 491, b'1', 'apollo', '2019-06-26 15:50:22', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (254, 'apollo', 492, b'1', 'apollo', '2019-06-26 15:50:22', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (255, 'apollo', 495, b'1', 'apollo', '2019-06-26 15:50:38', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (256, 'apollo', 496, b'1', 'apollo', '2019-06-26 15:50:38', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (257, 'apollo', 499, b'1', 'apollo', '2019-06-26 15:50:50', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (258, 'apollo', 500, b'1', 'apollo', '2019-06-26 15:50:50', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (259, 'apollo', 503, b'1', 'apollo', '2019-06-26 16:21:39', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (260, 'apollo', 504, b'1', 'apollo', '2019-06-26 16:21:40', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (261, 'apollo', 507, b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `UserRole` VALUES (262, 'apollo', 508, b'0', 'apollo', '2019-06-27 17:24:32', 'apollo', '2019-06-27 17:24:32');
INSERT INTO `UserRole` VALUES (263, 'apollo', 511, b'1', 'apollo', '2019-06-27 17:30:30', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (264, 'apollo', 512, b'1', 'apollo', '2019-06-27 17:30:30', 'apollo', '2019-07-14 17:18:26');
INSERT INTO `UserRole` VALUES (265, 'apollo', 515, b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `UserRole` VALUES (266, 'apollo', 516, b'0', 'apollo', '2019-06-27 18:43:05', 'apollo', '2019-06-27 18:43:05');
INSERT INTO `UserRole` VALUES (267, 'apollo', 521, b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `UserRole` VALUES (268, 'apollo', 522, b'0', 'apollo', '2019-07-03 14:43:17', 'apollo', '2019-07-03 14:43:17');
INSERT INTO `UserRole` VALUES (269, 'apollo', 525, b'1', 'apollo', '2019-07-03 17:57:13', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `UserRole` VALUES (270, 'apollo', 526, b'1', 'apollo', '2019-07-03 17:57:13', 'apollo', '2019-07-14 17:19:32');
INSERT INTO `UserRole` VALUES (271, 'apollo', 529, b'0', 'apollo', '2019-07-03 17:59:49', 'apollo', '2019-07-03 17:59:49');
INSERT INTO `UserRole` VALUES (272, 'apollo', 530, b'0', 'apollo', '2019-07-03 17:59:49', 'apollo', '2019-07-03 17:59:49');
INSERT INTO `UserRole` VALUES (273, 'apollo', 533, b'1', 'apollo', '2019-07-04 14:55:18', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (274, 'apollo', 534, b'1', 'apollo', '2019-07-04 14:55:18', 'apollo', '2019-07-14 17:17:14');
INSERT INTO `UserRole` VALUES (275, 'apollo', 537, b'1', 'apollo', '2019-07-16 11:52:35', 'apollo', '2019-07-16 12:03:33');
INSERT INTO `UserRole` VALUES (276, 'apollo', 538, b'1', 'apollo', '2019-07-16 11:52:35', 'apollo', '2019-07-16 12:03:33');
INSERT INTO `UserRole` VALUES (277, 'apollo', 539, b'1', 'apollo', '2019-07-16 11:52:35', 'apollo', '2019-07-16 12:03:33');
INSERT INTO `UserRole` VALUES (278, 'apollo', 543, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `UserRole` VALUES (279, 'apollo', 545, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `UserRole` VALUES (280, 'apollo', 546, b'0', 'apollo', '2020-12-23 06:45:47', 'apollo', '2020-12-23 06:45:47');
INSERT INTO `UserRole` VALUES (281, 'apollo', 549, b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `UserRole` VALUES (282, 'apollo', 550, b'0', 'apollo', '2020-12-23 06:49:00', 'apollo', '2020-12-23 06:49:00');
INSERT INTO `UserRole` VALUES (283, 'apollo', 553, b'0', 'apollo', '2020-12-23 07:01:50', 'apollo', '2020-12-23 07:01:50');
INSERT INTO `UserRole` VALUES (284, 'apollo', 554, b'0', 'apollo', '2020-12-23 07:01:50', 'apollo', '2020-12-23 07:01:50');
INSERT INTO `UserRole` VALUES (285, 'apollo', 557, b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `UserRole` VALUES (286, 'apollo', 558, b'0', 'apollo', '2020-12-23 07:02:11', 'apollo', '2020-12-23 07:02:11');
INSERT INTO `UserRole` VALUES (287, 'apollo', 561, b'0', 'apollo', '2020-12-23 07:02:24', 'apollo', '2020-12-23 07:02:24');
INSERT INTO `UserRole` VALUES (288, 'apollo', 562, b'0', 'apollo', '2020-12-23 07:02:24', 'apollo', '2020-12-23 07:02:24');
INSERT INTO `UserRole` VALUES (289, 'apollo', 565, b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `UserRole` VALUES (290, 'apollo', 566, b'0', 'apollo', '2020-12-23 07:02:38', 'apollo', '2020-12-23 07:02:38');
INSERT INTO `UserRole` VALUES (291, 'apollo', 569, b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `UserRole` VALUES (292, 'apollo', 570, b'0', 'apollo', '2020-12-23 07:02:51', 'apollo', '2020-12-23 07:02:51');
INSERT INTO `UserRole` VALUES (293, 'apollo', 573, b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `UserRole` VALUES (294, 'apollo', 574, b'0', 'apollo', '2020-12-23 07:03:07', 'apollo', '2020-12-23 07:03:07');
INSERT INTO `UserRole` VALUES (295, 'apollo', 577, b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `UserRole` VALUES (296, 'apollo', 578, b'0', 'apollo', '2020-12-23 07:03:32', 'apollo', '2020-12-23 07:03:32');
INSERT INTO `UserRole` VALUES (297, 'apollo', 581, b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `UserRole` VALUES (298, 'apollo', 582, b'0', 'apollo', '2020-12-23 07:04:09', 'apollo', '2020-12-23 07:04:09');
INSERT INTO `UserRole` VALUES (299, 'apollo', 585, b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `UserRole` VALUES (300, 'apollo', 586, b'0', 'apollo', '2020-12-23 07:04:24', 'apollo', '2020-12-23 07:04:24');
INSERT INTO `UserRole` VALUES (301, 'apollo', 589, b'0', 'apollo', '2020-12-24 09:02:25', 'apollo', '2020-12-24 09:02:25');
INSERT INTO `UserRole` VALUES (302, 'apollo', 591, b'0', 'apollo', '2020-12-24 09:02:26', 'apollo', '2020-12-24 09:02:26');
INSERT INTO `UserRole` VALUES (303, 'apollo', 592, b'0', 'apollo', '2020-12-24 09:02:26', 'apollo', '2020-12-24 09:02:26');
INSERT INTO `UserRole` VALUES (304, 'apollo', 595, b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `UserRole` VALUES (305, 'apollo', 596, b'0', 'apollo', '2020-12-24 09:02:47', 'apollo', '2020-12-24 09:02:47');
INSERT INTO `UserRole` VALUES (306, 'apollo', 599, b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `UserRole` VALUES (307, 'apollo', 600, b'0', 'apollo', '2020-12-24 09:02:59', 'apollo', '2020-12-24 09:02:59');
INSERT INTO `UserRole` VALUES (308, 'apollo', 603, b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `UserRole` VALUES (309, 'apollo', 604, b'0', 'apollo', '2020-12-24 09:03:13', 'apollo', '2020-12-24 09:03:13');
INSERT INTO `UserRole` VALUES (310, 'apollo', 607, b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `UserRole` VALUES (311, 'apollo', 608, b'0', 'apollo', '2020-12-24 09:03:23', 'apollo', '2020-12-24 09:03:23');
INSERT INTO `UserRole` VALUES (312, 'apollo', 611, b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `UserRole` VALUES (313, 'apollo', 612, b'0', 'apollo', '2020-12-24 09:03:38', 'apollo', '2020-12-24 09:03:38');
INSERT INTO `UserRole` VALUES (314, 'apollo', 615, b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `UserRole` VALUES (315, 'apollo', 616, b'0', 'apollo', '2020-12-24 09:03:50', 'apollo', '2020-12-24 09:03:50');
INSERT INTO `UserRole` VALUES (316, 'apollo', 619, b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `UserRole` VALUES (317, 'apollo', 620, b'0', 'apollo', '2020-12-24 09:04:04', 'apollo', '2020-12-24 09:04:04');
INSERT INTO `UserRole` VALUES (318, 'apollo', 623, b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `UserRole` VALUES (319, 'apollo', 624, b'0', 'apollo', '2020-12-24 09:36:39', 'apollo', '2020-12-24 09:36:39');
INSERT INTO `UserRole` VALUES (320, 'apollo', 627, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `UserRole` VALUES (321, 'apollo', 629, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `UserRole` VALUES (322, 'apollo', 630, b'0', 'apollo', '2020-12-24 17:31:12', 'apollo', '2020-12-24 17:31:12');
INSERT INTO `UserRole` VALUES (323, 'apollo', 633, b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `UserRole` VALUES (324, 'apollo', 634, b'0', 'apollo', '2020-12-24 17:42:25', 'apollo', '2020-12-24 17:42:25');
INSERT INTO `UserRole` VALUES (325, 'apollo', 637, b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `UserRole` VALUES (326, 'apollo', 638, b'0', 'apollo', '2020-12-24 17:42:37', 'apollo', '2020-12-24 17:42:37');
INSERT INTO `UserRole` VALUES (327, 'apollo', 641, b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `UserRole` VALUES (328, 'apollo', 642, b'0', 'apollo', '2020-12-24 17:42:52', 'apollo', '2020-12-24 17:42:52');
INSERT INTO `UserRole` VALUES (329, 'apollo', 645, b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `UserRole` VALUES (330, 'apollo', 646, b'0', 'apollo', '2020-12-24 17:43:36', 'apollo', '2020-12-24 17:43:36');
INSERT INTO `UserRole` VALUES (331, 'apollo', 649, b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `UserRole` VALUES (332, 'apollo', 650, b'0', 'apollo', '2020-12-24 17:43:44', 'apollo', '2020-12-24 17:43:44');
INSERT INTO `UserRole` VALUES (333, 'apollo', 653, b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `UserRole` VALUES (334, 'apollo', 654, b'0', 'apollo', '2020-12-24 17:44:07', 'apollo', '2020-12-24 17:44:07');
INSERT INTO `UserRole` VALUES (335, 'apollo', 657, b'0', 'apollo', '2020-12-24 17:44:17', 'apollo', '2020-12-24 17:44:17');
INSERT INTO `UserRole` VALUES (336, 'apollo', 658, b'0', 'apollo', '2020-12-24 17:44:17', 'apollo', '2020-12-24 17:44:17');
INSERT INTO `UserRole` VALUES (337, 'apollo', 661, b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `UserRole` VALUES (338, 'apollo', 662, b'0', 'apollo', '2020-12-24 17:44:43', 'apollo', '2020-12-24 17:44:43');
INSERT INTO `UserRole` VALUES (339, 'apollo', 665, b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `UserRole` VALUES (340, 'apollo', 666, b'0', 'apollo', '2020-12-24 19:22:47', 'apollo', '2020-12-24 19:22:47');
INSERT INTO `UserRole` VALUES (341, 'apollo', 669, b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `UserRole` VALUES (342, 'apollo', 670, b'0', 'apollo', '2020-12-25 00:04:40', 'apollo', '2020-12-25 00:04:40');
INSERT INTO `UserRole` VALUES (343, 'apollo', 673, b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `UserRole` VALUES (344, 'apollo', 674, b'0', 'apollo', '2020-12-25 00:09:18', 'apollo', '2020-12-25 00:09:18');
INSERT INTO `UserRole` VALUES (345, 'apollo', 677, b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `UserRole` VALUES (346, 'apollo', 678, b'0', 'apollo', '2020-12-25 00:12:04', 'apollo', '2020-12-25 00:12:04');
INSERT INTO `UserRole` VALUES (347, 'apollo', 681, b'0', 'apollo', '2020-12-25 00:12:24', 'apollo', '2020-12-25 00:12:24');
INSERT INTO `UserRole` VALUES (348, 'apollo', 682, b'0', 'apollo', '2020-12-25 00:12:24', 'apollo', '2020-12-25 00:12:24');
INSERT INTO `UserRole` VALUES (349, 'apollo', 685, b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
INSERT INTO `UserRole` VALUES (350, 'apollo', 686, b'0', 'apollo', '2020-12-25 00:21:46', 'apollo', '2020-12-25 00:21:46');
COMMIT;

-- ----------------------------
-- Table structure for Users
-- ----------------------------
DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) NOT NULL DEFAULT 'default' COMMENT '用户名',
  `Password` varchar(64) NOT NULL DEFAULT 'default' COMMENT '密码',
  `Email` varchar(64) NOT NULL DEFAULT 'default' COMMENT '邮箱地址',
  `Enabled` tinyint(4) DEFAULT NULL COMMENT '是否有效',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- Records of Users
-- ----------------------------
BEGIN;
INSERT INTO `Users` VALUES (1, 'apollo', '$2a$10$7r20uS.BQ9uBpf3Baj3uQOZvMVvB1RN3PYoKE94gtz2.WAOuiiwXS', 'apollo@acme.com', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
