/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost
 Source Database       : guest

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : utf-8

 Date: 11/03/2017 18:25:21 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `auth_permission`
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry'), ('2', 'Can change log entry', '1', 'change_logentry'), ('3', 'Can delete log entry', '1', 'delete_logentry'), ('4', 'Can add permission', '2', 'add_permission'), ('5', 'Can change permission', '2', 'change_permission'), ('6', 'Can delete permission', '2', 'delete_permission'), ('7', 'Can add group', '3', 'add_group'), ('8', 'Can change group', '3', 'change_group'), ('9', 'Can delete group', '3', 'delete_group'), ('10', 'Can add user', '4', 'add_user'), ('11', 'Can change user', '4', 'change_user'), ('12', 'Can delete user', '4', 'delete_user'), ('13', 'Can add content type', '5', 'add_contenttype'), ('14', 'Can change content type', '5', 'change_contenttype'), ('15', 'Can delete content type', '5', 'delete_contenttype'), ('16', 'Can add session', '6', 'add_session'), ('17', 'Can change session', '6', 'change_session'), ('18', 'Can delete session', '6', 'delete_session'), ('19', 'Can add event', '7', 'add_event'), ('20', 'Can change event', '7', 'change_event'), ('21', 'Can delete event', '7', 'delete_event'), ('22', 'Can add guest', '8', 'add_guest'), ('23', 'Can change guest', '8', 'change_guest'), ('24', 'Can delete guest', '8', 'delete_guest'), ('25', 'Can add result', '9', 'add_result'), ('26', 'Can change result', '9', 'change_result'), ('27', 'Can delete result', '9', 'delete_result'), ('28', 'Can add test value', '10', 'add_testvalue'), ('29', 'Can change test value', '10', 'change_testvalue'), ('30', 'Can delete test value', '10', 'delete_testvalue'), ('31', 'Can add version', '11', 'add_version'), ('32', 'Can change version', '11', 'change_version'), ('33', 'Can delete version', '11', 'delete_version');
COMMIT;

-- ----------------------------
--  Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `auth_user`
-- ----------------------------
BEGIN;
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$36000$Rri280nvY0p2$ARuEvJ+OWkDe/cHjykr+grHrEhxmGfQPOe5Npcl9e74=', '2017-10-20 00:08:06.157967', '1', 'admin', '', '', 'admin@mail.com', '1', '1', '2017-10-14 23:39:31.886195');
COMMIT;

-- ----------------------------
--  Table structure for `auth_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `auth_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `django_admin_log`
-- ----------------------------
BEGIN;
INSERT INTO `django_admin_log` VALUES ('1', '2017-10-14 23:42:05.037317', '2', '中文', '1', '[{\"added\": {}}]', '7', '1'), ('2', '2017-10-20 00:09:10.936765', '16', '中文', '1', '[{\"added\": {}}]', '7', '1'), ('3', '2017-10-31 09:24:55.084280', '8', 'tom', '1', '[{\"added\": {}}]', '8', '1');
COMMIT;

-- ----------------------------
--  Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `django_content_type`
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry'), ('3', 'auth', 'group'), ('2', 'auth', 'permission'), ('4', 'auth', 'user'), ('5', 'contenttypes', 'contenttype'), ('6', 'sessions', 'session'), ('7', 'sign', 'event'), ('8', 'sign', 'guest'), ('9', 'sign', 'result'), ('10', 'sign', 'testvalue'), ('11', 'sign', 'version');
COMMIT;

-- ----------------------------
--  Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `django_migrations`
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2017-10-14 23:38:52.879703'), ('2', 'auth', '0001_initial', '2017-10-14 23:38:53.201085'), ('3', 'admin', '0001_initial', '2017-10-14 23:38:53.282825'), ('4', 'admin', '0002_logentry_remove_auto_add', '2017-10-14 23:38:53.330317'), ('5', 'contenttypes', '0002_remove_content_type_name', '2017-10-14 23:38:53.401928'), ('6', 'auth', '0002_alter_permission_name_max_length', '2017-10-14 23:38:53.430353'), ('7', 'auth', '0003_alter_user_email_max_length', '2017-10-14 23:38:53.476016'), ('8', 'auth', '0004_alter_user_username_opts', '2017-10-14 23:38:53.504176'), ('9', 'auth', '0005_alter_user_last_login_null', '2017-10-14 23:38:53.552230'), ('10', 'auth', '0006_require_contenttypes_0002', '2017-10-14 23:38:53.563488'), ('11', 'auth', '0007_alter_validators_add_error_messages', '2017-10-14 23:38:53.581856'), ('12', 'auth', '0008_alter_user_username_max_length', '2017-10-14 23:38:53.639333'), ('13', 'sessions', '0001_initial', '2017-10-14 23:38:53.698666'), ('14', 'sign', '0001_initial', '2017-10-14 23:38:53.807016'), ('15', 'sign', '0002_result_testvalue_version', '2017-10-15 04:16:23.009816'), ('16', 'sign', '0003_auto_20170819_2121', '2017-10-15 04:16:23.123030'), ('17', 'sign', '0004_auto_20170819_2208', '2017-10-15 04:16:23.188093'), ('18', 'sign', '0005_auto_20170819_2211', '2017-10-15 04:16:23.295908'), ('19', 'sign', '0006_auto_20170821_1119', '2017-10-15 04:16:23.361479');
COMMIT;

-- ----------------------------
--  Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `django_session`
-- ----------------------------
BEGIN;
INSERT INTO `django_session` VALUES ('s1iey1x4itlpagbz3kxz9vfyzntkfh0k', 'NzI2NmY3OTRjNDRiOTYxNjdiN2U4Zjg0NmQzNTkyYTFjNGFiMWY3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5N2Q2M2JlZThkYjAxZjRkMTYwOWEzNzhiNzFkMDAzZjQ5YjliNjI2IiwidXNlciI6ImFkbWluIn0=', '2017-11-03 00:08:06.168002');
COMMIT;

-- ----------------------------
--  Table structure for `sign_event`
-- ----------------------------
DROP TABLE IF EXISTS `sign_event`;
CREATE TABLE `sign_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `limit` int(11) NOT NULL,
  `status` int(1) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sign_event`
-- ----------------------------
BEGIN;
INSERT INTO `sign_event` VALUES ('1', '红米Pro发布会', '2000', '1', '北京会展中心', '2018-09-20 14:00:00.000000', null), ('2', '可参加人数为0', '0', '1', '北京会展中心', '2018-09-20 14:00:00.000000', null), ('3', '当前状态为0关闭', '2000', '0', '北京会展中心', '2018-09-20 14:00:00.000000', null), ('4', '发布会已结束', '2000', '1', '北京会展中心', '2001-09-20 14:00:00.000000', null), ('5', '小米5发布会', '2000', '1', '北京国家会议中心', '2018-09-20 14:00:00.000000', null);
COMMIT;

-- ----------------------------
--  Table structure for `sign_guest`
-- ----------------------------
DROP TABLE IF EXISTS `sign_guest`;
CREATE TABLE `sign_guest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `realname` varchar(64) NOT NULL,
  `phone` varchar(16) NOT NULL,
  `email` varchar(254) NOT NULL,
  `sign` tinyint(1) NOT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `event_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sign_guest_phone_event_id_b9ec4150_uniq` (`phone`,`event_id`),
  KEY `sign_guest_event_id_fa7638b3_fk_sign_event_id` (`event_id`),
  CONSTRAINT `sign_guest_event_id_fa7638b3_fk_sign_event_id` FOREIGN KEY (`event_id`) REFERENCES `sign_event` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sign_guest`
-- ----------------------------
BEGIN;
INSERT INTO `sign_guest` VALUES ('1', 'alen', '13511001100', 'alen@mail.com', '0', null, '1'), ('2', 'has sign', '13511001101', 'sign@mail.com', '1', null, '1'), ('3', 'tom', '13511001102', 'tom@mail.com', '0', null, '5');
COMMIT;

-- ----------------------------
--  Table structure for `sign_result`
-- ----------------------------
DROP TABLE IF EXISTS `sign_result`;
CREATE TABLE `sign_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productName` varchar(64) NOT NULL,
  `versionID` int(11) NOT NULL,
  `networkType` varchar(10) NOT NULL,
  `logintime` decimal(10,2) NOT NULL,
  `receivetime` decimal(10,2) NOT NULL,
  `readtime` decimal(10,2) NOT NULL,
  `downtime` decimal(10,2) NOT NULL,
  `sendtime` decimal(10,2) NOT NULL,
  `loginflow` decimal(10,2) NOT NULL,
  `brushflow` decimal(10,2) NOT NULL,
  `standynoelectric` decimal(10,2) NOT NULL,
  `standynoflow` decimal(10,2) NOT NULL,
  `standyelectric` decimal(10,2) NOT NULL,
  `standyflow` decimal(10,2) NOT NULL,
  `maxmem` decimal(10,2) NOT NULL,
  `maxcpu` decimal(10,2) NOT NULL,
  `avgmem` decimal(10,2) NOT NULL,
  `avgtime` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sign_testvalue`
-- ----------------------------
DROP TABLE IF EXISTS `sign_testvalue`;
CREATE TABLE `sign_testvalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productName` varchar(64) NOT NULL,
  `versionID` int(11) NOT NULL,
  `networkType` varchar(10) NOT NULL,
  `logintime` decimal(10,2) NOT NULL,
  `receivetime` decimal(10,2) NOT NULL,
  `readtime` decimal(10,2) NOT NULL,
  `downtime` decimal(10,2) NOT NULL,
  `sendtime` decimal(10,2) NOT NULL,
  `loginflow` decimal(10,2) NOT NULL,
  `brushflow` decimal(10,2) NOT NULL,
  `standynoelectric` decimal(10,2) NOT NULL,
  `standynoflow` decimal(10,2) NOT NULL,
  `standyelectric` decimal(10,2) NOT NULL,
  `standyflow` decimal(10,2) NOT NULL,
  `maxmem` decimal(10,2) NOT NULL,
  `maxcpu` decimal(10,2) NOT NULL,
  `avgmem` decimal(10,2) NOT NULL,
  `avgtime` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sign_version`
-- ----------------------------
DROP TABLE IF EXISTS `sign_version`;
CREATE TABLE `sign_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productName` varchar(64) NOT NULL,
  `versionID` int(11) NOT NULL,
  `versionName` varchar(64) NOT NULL,
  `tdesc` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
