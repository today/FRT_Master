# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.16)
# Database: frt
# Generation Time: 2015-04-29 12:18:24 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table t_booking
# ------------------------------------------------------------

CREATE TABLE `t_booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_date` varchar(32) NOT NULL,
  `booking_index` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `patient_no` varchar(64) NOT NULL,
  `case_no` varchar(64) NOT NULL,
  `mobile` varchar(64) NOT NULL,
  `comment` varchar(256) DEFAULT NULL,
  `treat_date` datetime NOT NULL,
  `upload_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_customer
# ------------------------------------------------------------

CREATE TABLE `t_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_no` varchar(32) NOT NULL,
  `patient_name` varchar(64) NOT NULL,
  `mobile` varchar(64) NOT NULL,
  `sex` varchar(16) DEFAULT NULL,
  `age` varchar(16) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `remark` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_patient_no` (`patient_no`),
  KEY `i_customer_patient_no` (`patient_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_image
# ------------------------------------------------------------

CREATE TABLE `t_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `binarydata` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_json
# ------------------------------------------------------------

CREATE TABLE `t_json` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `json_string` varchar(21000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_json_temp
# ------------------------------------------------------------

CREATE TABLE `t_json_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `json_string` varchar(21000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_medicine
# ------------------------------------------------------------

CREATE TABLE `t_medicine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_name` varchar(32) NOT NULL,
  `price` varchar(32) NOT NULL,
  `short_name` varchar(32) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_medicine_name` (`medicine_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_patient
# ------------------------------------------------------------

CREATE TABLE `t_patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_no` varchar(32) NOT NULL,
  `patient_name` varchar(64) NOT NULL,
  `sex` varchar(16) DEFAULT NULL,
  `age` varchar(16) DEFAULT NULL,
  `mobile` varchar(32) NOT NULL,
  `old_mobile` varchar(1024) DEFAULT NULL,
  `comment` varchar(256) DEFAULT NULL,
  `json_id` int(11) DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_recipe
# ------------------------------------------------------------

CREATE TABLE `t_recipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_no` varchar(32) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `patient_no` varchar(64) NOT NULL,
  `patient_name` varchar(64) DEFAULT NULL,
  `mobile` varchar(32) DEFAULT NULL,
  `age` varchar(16) DEFAULT NULL,
  `sex` varchar(16) DEFAULT NULL,
  `patient_comment` varchar(256) DEFAULT NULL,
  `dingxing` varchar(64) DEFAULT NULL,
  `dingbing` varchar(64) DEFAULT NULL,
  `dingzheng` varchar(64) DEFAULT NULL,
  `comment` varchar(256) DEFAULT NULL,
  `suitnum` varchar(32) DEFAULT NULL,
  `doctor_name` varchar(32) DEFAULT NULL,
  `json_id` int(11) DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_recipe_no` (`recipe_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_recipe_item
# ------------------------------------------------------------

CREATE TABLE `t_recipe_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `medicine` varchar(32) DEFAULT NULL,
  `count` int(11) NOT NULL,
  `unit` varchar(16) NOT NULL,
  `remark` varchar(64) DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_setting
# ------------------------------------------------------------

CREATE TABLE `t_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(64) NOT NULL,
  `value` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_test
# ------------------------------------------------------------

CREATE TABLE `t_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aaa` varchar(64) NOT NULL,
  `bbb` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table t_user
# ------------------------------------------------------------

CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `t_quiz_IDX_0` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
