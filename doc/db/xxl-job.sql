/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : xxl-job

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-06-14 10:34:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_permission`
-- ----------------------------
DROP TABLE IF EXISTS `tb_permission`;
CREATE TABLE `tb_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `权限唯一` (`permission`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_permission
-- ----------------------------
INSERT INTO `tb_permission` VALUES ('1', 'index', '访问首页的权利');
INSERT INTO `tb_permission` VALUES ('2', 'jobgroup', '执行器管理页面');
INSERT INTO `tb_permission` VALUES ('3', 'jobinfo', '任务管理页面');
INSERT INTO `tb_permission` VALUES ('4', 'joblog', '调度日志页面');
INSERT INTO `tb_permission` VALUES ('5', 'help', '使用教程页面');
INSERT INTO `tb_permission` VALUES ('6', 'usermanage', '用户管理权限');

-- ----------------------------
-- Table structure for `tb_role`
-- ----------------------------
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role唯一` (`role`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_role
-- ----------------------------
INSERT INTO `tb_role` VALUES ('1', 'superadmin', '超级管理员');
INSERT INTO `tb_role` VALUES ('2', 'admin', '管理员');
INSERT INTO `tb_role` VALUES ('3', 'guest', '游客');

-- ----------------------------
-- Table structure for `tb_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `tb_role_permission`;
CREATE TABLE `tb_role_permission` (
  `permission_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  KEY `权限外键` (`permission_id`),
  KEY `角色外键` (`role_id`),
  CONSTRAINT `权限外键` FOREIGN KEY (`permission_id`) REFERENCES `tb_permission` (`id`),
  CONSTRAINT `角色外键` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_role_permission
-- ----------------------------
INSERT INTO `tb_role_permission` VALUES ('1', '1');
INSERT INTO `tb_role_permission` VALUES ('5', '1');
INSERT INTO `tb_role_permission` VALUES ('6', '1');
INSERT INTO `tb_role_permission` VALUES ('1', '2');
INSERT INTO `tb_role_permission` VALUES ('2', '2');
INSERT INTO `tb_role_permission` VALUES ('3', '2');
INSERT INTO `tb_role_permission` VALUES ('4', '2');
INSERT INTO `tb_role_permission` VALUES ('5', '2');
INSERT INTO `tb_role_permission` VALUES ('1', '3');
INSERT INTO `tb_role_permission` VALUES ('5', '3');
INSERT INTO `tb_role_permission` VALUES ('6', '2');

-- ----------------------------
-- Table structure for `tb_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `account` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `帐号唯一` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('1', 'hcn', 'admin', '2afec23ca48b19fef1e908f73ceccfb5', 'dc6a792240292e92e03f764e4cf05f52', '2');
INSERT INTO `tb_user` VALUES ('2', '游客1', 'guest', '610e3093a3b854ceaa46d676ad30f73a', '966bb0357fa5f0fab5024563710acb74', '3');
INSERT INTO `tb_user` VALUES ('3', '超管', 'superadmin1', '0d4f838a0ab3d04eabbc4d7dd3d90252', '627cd4490c150b648a825cbead0d8b7c', '1');
INSERT INTO `tb_user` VALUES ('4', '范德萨', '9999999', '161ae78c351bceb460c64332f36e6768', 'ec50a876949d03fc97c46ba564f6ee4a', '3');
INSERT INTO `tb_user` VALUES ('5', '是的放松法', 'tttttt', '16be9a76fef5cf13754b84401ca79f17', '7e2178d7df3d63d5d3d909ecfc2b2152', '2');
INSERT INTO `tb_user` VALUES ('6', '你好运气', '2323433', 'bf4f56eacf92aacadd437501b44db2e6', '7c09b5f52218de8db4566f5f87bae199', '1');
INSERT INTO `tb_user` VALUES ('7', '测试1', 'test', 'f2d9a4ca11512659a889ed8acd7ba477', '3b4d66914880016d5f01c9b4e58a1e4a', '2');
INSERT INTO `tb_user` VALUES ('8', '覃燕芬', 'qinyf', 'c6ada2ea3a3d27c575c8d5799d8b67d9', '78e3436b51f51b41533f7761a4f138d8', '2');

-- ----------------------------
-- Table structure for `xxl_job_qrtz_blob_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_blob_triggers`;
CREATE TABLE `xxl_job_qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `xxl_job_qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `xxl_job_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_calendars`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_calendars`;
CREATE TABLE `xxl_job_qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_cron_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_cron_triggers`;
CREATE TABLE `xxl_job_qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `xxl_job_qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `xxl_job_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_fired_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_fired_triggers`;
CREATE TABLE `xxl_job_qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_job_details`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_job_details`;
CREATE TABLE `xxl_job_qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_locks`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_locks`;
CREATE TABLE `xxl_job_qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_locks
-- ----------------------------
INSERT INTO `xxl_job_qrtz_locks` VALUES ('quartzScheduler', 'STATE_ACCESS');
INSERT INTO `xxl_job_qrtz_locks` VALUES ('quartzScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for `xxl_job_qrtz_paused_trigger_grps`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_paused_trigger_grps`;
CREATE TABLE `xxl_job_qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_scheduler_state`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_scheduler_state`;
CREATE TABLE `xxl_job_qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_scheduler_state
-- ----------------------------
INSERT INTO `xxl_job_qrtz_scheduler_state` VALUES ('quartzScheduler', 'DESKTOP-R7JUU781528799547939', '1528799568428', '5000');

-- ----------------------------
-- Table structure for `xxl_job_qrtz_simple_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_simple_triggers`;
CREATE TABLE `xxl_job_qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `xxl_job_qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `xxl_job_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_simprop_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_simprop_triggers`;
CREATE TABLE `xxl_job_qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `xxl_job_qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `xxl_job_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_triggers`;
CREATE TABLE `xxl_job_qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `xxl_job_qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `xxl_job_qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_trigger_group`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_trigger_group`;
CREATE TABLE `xxl_job_qrtz_trigger_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(64) NOT NULL COMMENT '执行器AppName',
  `title` varchar(12) NOT NULL COMMENT '执行器名称',
  `order` tinyint(4) NOT NULL DEFAULT '0' COMMENT '排序',
  `address_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '执行器地址类型：0=自动注册、1=手动录入',
  `address_list` varchar(512) DEFAULT NULL COMMENT '执行器地址列表，多地址逗号分隔',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_trigger_group
-- ----------------------------
INSERT INTO `xxl_job_qrtz_trigger_group` VALUES ('1', 'xxl-job-executor-sample', '示例执行器', '1', '0', null);

-- ----------------------------
-- Table structure for `xxl_job_qrtz_trigger_info`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_trigger_info`;
CREATE TABLE `xxl_job_qrtz_trigger_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` varchar(255) NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` text COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` varchar(255) DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_trigger_info
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_trigger_log`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_trigger_log`;
CREATE TABLE `xxl_job_qrtz_trigger_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) DEFAULT NULL COMMENT 'GLUE类型',
  `executor_address` varchar(255) DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `trigger_time` datetime DEFAULT NULL COMMENT '调度-时间',
  `trigger_code` varchar(255) NOT NULL DEFAULT '0' COMMENT '调度-结果',
  `trigger_msg` varchar(2048) DEFAULT NULL COMMENT '调度-日志',
  `handle_time` datetime DEFAULT NULL COMMENT '执行-时间',
  `handle_code` varchar(255) NOT NULL DEFAULT '0' COMMENT '执行-状态',
  `handle_msg` varchar(2048) DEFAULT NULL COMMENT '执行-日志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_trigger_log
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_trigger_logglue`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_trigger_logglue`;
CREATE TABLE `xxl_job_qrtz_trigger_logglue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) DEFAULT NULL COMMENT 'GLUE类型',
  `glue_source` text COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) NOT NULL COMMENT 'GLUE备注',
  `add_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_trigger_logglue
-- ----------------------------

-- ----------------------------
-- Table structure for `xxl_job_qrtz_trigger_registry`
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_qrtz_trigger_registry`;
CREATE TABLE `xxl_job_qrtz_trigger_registry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `registry_group` varchar(255) NOT NULL,
  `registry_key` varchar(255) NOT NULL,
  `registry_value` varchar(255) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xxl_job_qrtz_trigger_registry
-- ----------------------------
