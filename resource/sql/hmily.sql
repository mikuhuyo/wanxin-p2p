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
