-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: tlh
-- ------------------------------------------------------
-- Server version	5.6.38

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
use tlh;
--
-- Table structure for table `sys_menus`
--

DROP TABLE IF EXISTS `sys_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menus` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `is_show` bit(1) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `serials` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqvahr9k2gjbgu5x0hqo665ifv` (`parent_id`),
  CONSTRAINT `FKqvahr9k2gjbgu5x0hqo665ifv` FOREIGN KEY (`parent_id`) REFERENCES `sys_menus` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menus`
--

LOCK TABLES `sys_menus` WRITE;
/*!40000 ALTER TABLE `sys_menus` DISABLE KEYS */;
INSERT INTO `sys_menus` VALUES ('0','292c8ae55f9705dd015f9705fab00000',NULL,NULL,'','base',NULL,0,0,NULL,'功能菜单',NULL,NULL),('292c8ae45faee9bb015faeebc3bf0000','292c8ae55f9705dd015f9705fab00000',NULL,'','\0','sys:menu:form','',NULL,1,'','菜单添加','','292c8ae55f970932015f9719b5530003'),('292c8ae45faee9bb015faeec98140001','292c8ae55f9705dd015f9705fab00000',NULL,'','\0','sys:role:form','',NULL,1,'','角色添加','','292c8ae55f970932015f971688970002'),('292c8ae45faee9bb015faeed039e0002','292c8ae55f9705dd015f9705fab00000',NULL,'','\0','sys:role:edit','',NULL,2,'','角色编辑','','292c8ae55f970932015f971688970002'),('292c8ae45faee9bb015faeede1b90003','292c8ae55f9705dd015f9705fab00000',NULL,'','\0','sys:user:form','',NULL,1,'','用户添加','','292c8ae55f972a5a015f972f31860001'),('292c8ae45faee9bb015faeee4b170004','292c8ae55f9705dd015f9705fab00000',NULL,'','\0','sys:user:edit','',NULL,1,'','用户编辑','','292c8ae55f972a5a015f972f31860001'),('292c8ae45faee9bb015faef012850005','292c8ae55f9705dd015f9705fab00000',NULL,'','\0','sys:menu:edit','',NULL,1,'','菜单编辑','','292c8ae55f970932015f9719b5530003'),('292c8ae55f970932015f97107be70000','292c8ae55f9705dd015f9705fab00000',NULL,'cog','','sys:set','',NULL,0,'','系统设置','','292c8ae55f9bdcac015f9be10eef0001'),('292c8ae55f970932015f971688970002','292c8ae55f9705dd015f9705fab00000',NULL,'lock','','sys:role:index','',NULL,0,'mainFrame','角色管理','sys/role/index','292c8ae55f970932015f97107be70000'),('292c8ae55f970932015f9719b5530003','292c8ae55f9705dd015f9705fab00000',NULL,'list-alt','','sys:menu:index','',NULL,0,'mainFrame','菜单管理','sys/menu/index','292c8ae55f970932015f97107be70000'),('292c8ae55f972a5a015f972bb2460000','292c8ae55f9705dd015f9705fab00000',NULL,'group','','sys:user:main','',NULL,0,'mainFrame','机构用户','','292c8ae55f9bdcac015f9be10eef0001'),('292c8ae55f972a5a015f972f31860001','292c8ae55f9705dd015f9705fab00000',NULL,'user','','sys:user:index','',NULL,0,'mainFrame','用户管理','sys/user/index','292c8ae55f972a5a015f972bb2460000'),('292c8ae55f9bdcac015f9be10eef0001','292c8ae55f9705dd015f9705fab00000',NULL,'','','sys:main','',NULL,1,'','系统设置','','0'),('292c8ae55f9c0e4f015f9c148fc30000','292c8ae55f9705dd015f9705fab00000',NULL,'','','dashboard:main','',NULL,0,'','我的面板','','0'),('292c8ae55f9c0e4f015f9c152a550001','292c8ae55f9705dd015f9705fab00000',NULL,'','','dashboard:user:main','',NULL,1,'','个人信息','','292c8ae55f9c0e4f015f9c148fc30000'),('292c8ae55f9c0e4f015f9c15f2e60002','292c8ae55f9705dd015f9705fab00000',NULL,'user','','dashboard:user:info','',NULL,0,'mainFrame','个人信息','sys/user/info','292c8ae55f9c0e4f015f9c152a550001'),('292c8ae65faabbd8015faabe29dc0001','292c8ae55f9705dd015f9705fab00000',NULL,'lock','','dashboard:user:pwd','',NULL,1,'mainFrame','修改密码','sys/user/modifyPwd','292c8ae55f9c0e4f015f9c152a550001');
/*!40000 ALTER TABLE `sys_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_roles`
--

DROP TABLE IF EXISTS `sys_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_roles` (
  `role_id` varchar(255) NOT NULL,
  `role_desc` varchar(255) DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `role_value` varchar(255) DEFAULT NULL,
  `en_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `UK_3i4uf5mcxfn2mve9obk57o2u2` (`role_name`),
  UNIQUE KEY `UK_7ui4u3k5gcop83a1ft5gq4d4o` (`en_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_roles`
--

LOCK TABLES `sys_roles` WRITE;
/*!40000 ALTER TABLE `sys_roles` DISABLE KEYS */;
INSERT INTO `sys_roles` VALUES ('292c8ae45faec617015faec8b9220000','','测试','0','test'),('292c8ae55f973500015f9735cac50000','具有所有权限','超级用户','－1','admin');
/*!40000 ALTER TABLE `sys_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_roles_menus`
--

DROP TABLE IF EXISTS `sys_roles_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_roles_menus` (
  `role_role_id` varchar(255) NOT NULL,
  `menus_id` varchar(255) NOT NULL,
  PRIMARY KEY (`role_role_id`,`menus_id`),
  KEY `FK6w984a6s9uofvolb62fgjygvc` (`menus_id`),
  CONSTRAINT `FK4o54spmf9ijamwkmnsk1dqgyb` FOREIGN KEY (`role_role_id`) REFERENCES `sys_roles` (`role_id`),
  CONSTRAINT `FK6w984a6s9uofvolb62fgjygvc` FOREIGN KEY (`menus_id`) REFERENCES `sys_menus` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_roles_menus`
--

LOCK TABLES `sys_roles_menus` WRITE;
/*!40000 ALTER TABLE `sys_roles_menus` DISABLE KEYS */;
INSERT INTO `sys_roles_menus` VALUES ('292c8ae45faec617015faec8b9220000','0'),('292c8ae55f973500015f9735cac50000','0'),('292c8ae55f973500015f9735cac50000','292c8ae45faee9bb015faeebc3bf0000'),('292c8ae55f973500015f9735cac50000','292c8ae45faee9bb015faeec98140001'),('292c8ae55f973500015f9735cac50000','292c8ae45faee9bb015faeed039e0002'),('292c8ae55f973500015f9735cac50000','292c8ae45faee9bb015faeede1b90003'),('292c8ae55f973500015f9735cac50000','292c8ae45faee9bb015faeee4b170004'),('292c8ae55f973500015f9735cac50000','292c8ae45faee9bb015faef012850005'),('292c8ae55f973500015f9735cac50000','292c8ae55f970932015f97107be70000'),('292c8ae55f973500015f9735cac50000','292c8ae55f970932015f971688970002'),('292c8ae55f973500015f9735cac50000','292c8ae55f970932015f9719b5530003'),('292c8ae55f973500015f9735cac50000','292c8ae55f972a5a015f972bb2460000'),('292c8ae55f973500015f9735cac50000','292c8ae55f972a5a015f972f31860001'),('292c8ae55f973500015f9735cac50000','292c8ae55f9bdcac015f9be10eef0001'),('292c8ae45faec617015faec8b9220000','292c8ae55f9c0e4f015f9c148fc30000'),('292c8ae55f973500015f9735cac50000','292c8ae55f9c0e4f015f9c148fc30000'),('292c8ae45faec617015faec8b9220000','292c8ae55f9c0e4f015f9c152a550001'),('292c8ae55f973500015f9735cac50000','292c8ae55f9c0e4f015f9c152a550001'),('292c8ae45faec617015faec8b9220000','292c8ae55f9c0e4f015f9c15f2e60002'),('292c8ae55f973500015f9735cac50000','292c8ae55f9c0e4f015f9c15f2e60002'),('292c8ae55f973500015f9735cac50000','292c8ae65faabbd8015faabe29dc0001');
/*!40000 ALTER TABLE `sys_roles_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_users`
--

DROP TABLE IF EXISTS `sys_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_users` (
  `user_id` varchar(255) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `enabled` bit(1) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `national_id` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone_num` varchar(255) DEFAULT NULL,
  `real_name` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UK_4hfk66d9netbffi5dgli7o3jq` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_users`
--

LOCK TABLES `sys_users` WRITE;
/*!40000 ALTER TABLE `sys_users` DISABLE KEYS */;
INSERT INTO `sys_users` VALUES ('292c8ae55f9705dd015f9705fab00000','2017-11-07 23:07:52','1567894313@tlh.com','',NULL,NULL,NULL,'c87f97035d762d106f43357bd50d7c8a','110','系统管理员','admineee1106450af742aa86b3ddd11e11f43','admin'),('292c8ae55fa12b96015fa131b11f0002','2017-11-09 22:31:49','','','2017-11-09 22:31:49','2017-11-09 22:31:49',NULL,'bbda5ec9c755dac17f76f0bc8d8df715','','张三','zhangsan2b10c51ee098939ebb84f4543f9b05c2','zhangsan');
/*!40000 ALTER TABLE `sys_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_users_roles`
--

DROP TABLE IF EXISTS `sys_users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_users_roles` (
  `user_user_id` varchar(255) NOT NULL,
  `roles_role_id` varchar(255) NOT NULL,
  PRIMARY KEY (`user_user_id`,`roles_role_id`),
  KEY `FKoplp1my1ovsuu2dnhn5c7oh0w` (`roles_role_id`),
  CONSTRAINT `FK15wx93a8dvs2k0pqck6uqyk8h` FOREIGN KEY (`user_user_id`) REFERENCES `sys_users` (`user_id`),
  CONSTRAINT `FKoplp1my1ovsuu2dnhn5c7oh0w` FOREIGN KEY (`roles_role_id`) REFERENCES `sys_roles` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_users_roles`
--

LOCK TABLES `sys_users_roles` WRITE;
/*!40000 ALTER TABLE `sys_users_roles` DISABLE KEYS */;
INSERT INTO `sys_users_roles` VALUES ('292c8ae55fa12b96015fa131b11f0002','292c8ae45faec617015faec8b9220000'),('292c8ae55f9705dd015f9705fab00000','292c8ae55f973500015f9735cac50000');
/*!40000 ALTER TABLE `sys_users_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-12 15:52:30
