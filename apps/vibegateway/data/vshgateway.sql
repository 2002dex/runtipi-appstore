CREATE DATABASE  IF NOT EXISTS `vshgateway` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `vshgateway`;
-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: vshgateway
-- ------------------------------------------------------
-- Server version	5.5.44-0+deb7u1

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

--
-- Create database `vshgateway`
--
DROP DATABASE IF EXISTS `vshgateway`;
CREATE DATABASE `vshgateway`;
USE `vshgateway`;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices` (
  `device_id` char(20) NOT NULL,
  `room_id` char(36) NOT NULL,
  `device_type` char(64) NOT NULL,
  `device_state` char(16) NOT NULL,
  `device_intensity` char(4) NOT NULL,
  `device_name` char(64) NOT NULL,
  `device_frozen` tinyint(1) NOT NULL DEFAULT 0,
  `device_version` smallint(4) NOT NULL DEFAULT 0x0100,
  PRIMARY KEY (`device_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `devices_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

/*Table structure for table `wifi_devices` */
DROP TABLE IF EXISTS `wifi_devices`;

CREATE TABLE `wifi_devices` (
  `wifi_device_id` char(36) NOT NULL,
  `room_id` char(36) DEFAULT NULL,
  `wifi_device_type` char(64) NOT NULL,
  `wifi_device_attributes` text DEFAULT NULL,
  `wifi_device_name` char(64) NOT NULL,
  `wifi_device_frozen` tinyint(1) NOT NULL DEFAULT 0,
  `is_scene` tinyint(1) NOT NULL DEFAULT 1,
  `is_schedule` tinyint(1) NOT NULL DEFAULT 1,
  `assigned_device_id` char(20) DEFAULT NULL,
  `wifi_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`wifi_device_id`),
  KEY `wifi_device_fk_1` (`room_id`),
  KEY `wifi_assigned_fk_2` (`assigned_device_id`),
  CONSTRAINT `wifi_assigned_fk_2` FOREIGN KEY (`assigned_device_id`) REFERENCES `devices` (`device_id`) ON DELETE SET NULL,
  CONSTRAINT `wifi_device_fk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `wifi_devices` */

LOCK TABLES `wifi_devices` WRITE;

UNLOCK TABLES;

--
-- Table structure for table `device_details`
--

DROP TABLE IF EXISTS `device_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `device_details` (
  `device_addr` char(16) NOT NULL,
  `device_version` smallint(8) NOT NULL DEFAULT 0,
  `device_heapsize` smallint(8) NOT NULL DEFAULT 0,
  `device_ota_status` smallint(4) NOT NULL DEFAULT 0,
  `device_ota_try_count` smallint(4) NOT NULL DEFAULT 0,
  `device_ota_updated_at` datetime DEFAULT NULL,
  `device_reboot_count` smallint(4) NOT NULL DEFAULT 0,
  `device_last_reboot_at` datetime DEFAULT NULL,
  `device_mesh_connected_ms` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`device_addr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_details`
--

LOCK TABLES `device_details` WRITE;
/*!40000 ALTER TABLE `device_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_rssi`
--

DROP TABLE IF EXISTS `device_rssi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_rssi` (
  `device_addr` char(16) NOT NULL,
  `room_id` char(36) NOT NULL,
  `rssi_at_gateway` tinyint(3)  NOT NULL,
  `rssi_from_gateway` tinyint(3) NOT NULL,
  `is_relay` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`device_addr`),
  CONSTRAINT `device_rssi_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_rssi`
--

LOCK TABLES `device_rssi` WRITE;
/*!40000 ALTER TABLE `device_rssi` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_rssi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gateway_queue`
--

DROP TABLE IF EXISTS `gateway_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gateway_queue` (
  `gateway_queue_data` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gateway_queue`
--

LOCK TABLES `gateway_queue` WRITE;
/*!40000 ALTER TABLE `gateway_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `gateway_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gateways`
--

DROP TABLE IF EXISTS `gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gateways` (
  `gateway_id` char(20) NOT NULL,
  `master_password` char(36) NOT NULL,
  `gateway_version` char(20) NOT NULL DEFAULT "2.3",
  `gateway_wifi_id` char(20) NULL,
  `gateway_wifi_version` char(20) NOT NULL DEFAULT "1.2",
  `full_sync` char(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`gateway_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES `gateways` WRITE;
/*!40000 ALTER TABLE `gateways` DISABLE KEYS */;
INSERT INTO `gateways` VALUES ('041e7aff0002','fcea920f7412b5da7be0cf42b8c93759', "1.0", NULL, "1.0", 1);
/*!40000 ALTER TABLE `gateways` ENABLE KEYS */;
UNLOCK TABLES;

/*Table structure for table `master_gateways` */
DROP TABLE IF EXISTS `master_gateways`;

CREATE TABLE `master_gateways` (
  `master_id` char(36) NOT NULL,
  `master_name` char(36) NOT NULL,
  `master_password` char(36) NOT NULL,
  `gateway_ids` longtext DEFAULT NULL,
  PRIMARY KEY (`master_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `master_gateways` */

LOCK TABLES `master_gateways` WRITE;

UNLOCK TABLES;

--
-- Table structure for table `ir_emitter_device_mapping`
--

DROP TABLE IF EXISTS `ir_emitter_device_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ir_emitter_device_mapping` (
  `associated_device_id` char(20) NOT NULL,
  `device_id` char(20) NOT NULL,
  `device_type` char(64) NOT NULL,
  `ir_commands_file` char(255) NOT NULL,
  PRIMARY KEY (`associated_device_id`),
  KEY `device_id` (`device_id`),
  KEY `associated_device_id` (`associated_device_id`),
  CONSTRAINT `ir_emitter_device_mapping_ibfk_2` FOREIGN KEY (`associated_device_id`) REFERENCES `devices` (`device_id`) ON DELETE CASCADE,
  CONSTRAINT `ir_emitter_device_mapping_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `sensors` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ir_emitter_device_mapping`
--

LOCK TABLES `ir_emitter_device_mapping` WRITE;
/*!40000 ALTER TABLE `ir_emitter_device_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `ir_emitter_device_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ir_emitters`
--

DROP TABLE IF EXISTS `ir_emitters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ir_emitters` (
  `device_id` char(20) NOT NULL,
  `temperature` float(4,1) DEFAULT NULL,
  `humidity` float(4,1) DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `ir_emitters_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `sensors` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ir_emitters`
--

LOCK TABLES `ir_emitters` WRITE;
/*!40000 ALTER TABLE `ir_emitters` DISABLE KEYS */;
/*!40000 ALTER TABLE `ir_emitters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motion_sensor_trigger`
--

DROP TABLE IF EXISTS `motion_sensor_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motion_sensor_trigger` (
  `device_id` char(20) NOT NULL,
  `trigger_type` enum('device','scene','none') NOT NULL DEFAULT 'device',
  `trigger_device_id` char(20) DEFAULT NULL,
  `trigger_scene_id` char(36) DEFAULT NULL,
  `trigger_end_scene_id` char(36) DEFAULT NULL,
  `trigger_device_state` char(16) DEFAULT NULL,
  `trigger_device_intensity` char(4) DEFAULT NULL,
  KEY `device_id` (`device_id`),
  KEY `trigger_device_id` (`trigger_device_id`),
  KEY `trigger_scene_id` (`trigger_scene_id`),
  KEY `trigger_end_scene_id` (`trigger_end_scene_id`),
  CONSTRAINT `motion_sensor_trigger_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `sensors` (`device_id`) ON DELETE CASCADE,
  CONSTRAINT `motion_sensor_trigger_ibfk_2` FOREIGN KEY (`trigger_device_id`) REFERENCES `devices` (`device_id`) ON DELETE CASCADE,
  CONSTRAINT `motion_sensor_trigger_ibfk_3` FOREIGN KEY (`trigger_scene_id`) REFERENCES `scenes` (`scene_id`) ON DELETE CASCADE,
  CONSTRAINT `motion_sensor_trigger_ibfk_4` FOREIGN KEY (`trigger_end_scene_id`) REFERENCES `scenes` (`scene_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motion_sensor_trigger`
--

LOCK TABLES `motion_sensor_trigger` WRITE;
/*!40000 ALTER TABLE `motion_sensor_trigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `motion_sensor_trigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motion_sensors`
--

DROP TABLE IF EXISTS `motion_sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motion_sensors` (
  `device_id` char(20) NOT NULL,
  `retrigger` tinyint(1) NOT NULL,
  `duration` smallint unsigned NOT NULL,
  `sensitivity` enum('low','high') NOT NULL DEFAULT 'low',
  `triggered` tinyint(1) NOT NULL,
  `armed` tinyint(1) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  KEY `device_id` (`device_id`),
  CONSTRAINT `motion_sensors_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `sensors` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motion_sensors`
--

LOCK TABLES `motion_sensors` WRITE;
/*!40000 ALTER TABLE `motion_sensors` DISABLE KEYS */;
/*!40000 ALTER TABLE `motion_sensors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remote_device_mapping`
--

DROP TABLE IF EXISTS `remote_device_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remote_device_mapping` (
  `remote_id` char(20) NOT NULL,
  `device_id` char(20) NOT NULL,
  `remote_key` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`remote_id`,`remote_key`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `remote_device_mapping_ibfk_1` FOREIGN KEY (`remote_id`) REFERENCES `sensors` (`device_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `remote_device_mapping_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remote_device_mapping`
--

LOCK TABLES `remote_device_mapping` WRITE;
/*!40000 ALTER TABLE `remote_device_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `remote_device_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remote_scene_mapping`
--

DROP TABLE IF EXISTS `remote_scene_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remote_scene_mapping` (
  `remote_id` char(20) NOT NULL,
  `scene_id` char(36) NOT NULL,
  `remote_key` char(8) NOT NULL,
  PRIMARY KEY (`remote_id`,`remote_key`),
  KEY `scene_id` (`scene_id`),
  CONSTRAINT `remote_scene_mapping_ibfk_2` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`scene_id`) ON DELETE CASCADE,
  CONSTRAINT `remote_scene_mapping_ibfk_1` FOREIGN KEY (`remote_id`) REFERENCES `sensors` (`device_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remote_scene_mapping`
--

LOCK TABLES `remote_scene_mapping` WRITE;
/*!40000 ALTER TABLE `remote_scene_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `remote_scene_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restricted_access_passwords`
--

DROP TABLE IF EXISTS `restricted_access_passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restricted_access_passwords` (
  `password_id` char(36) NOT NULL,
  `password_hash` char(32) NOT NULL,
  PRIMARY KEY (`password_id`),
  UNIQUE KEY `password_hash` (`password_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restricted_access_passwords`
--

LOCK TABLES `restricted_access_passwords` WRITE;
/*!40000 ALTER TABLE `restricted_access_passwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `restricted_access_passwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restricted_access_rooms_mapping`
--

DROP TABLE IF EXISTS `restricted_access_rooms_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restricted_access_rooms_mapping` (
  `password_id` char(36) NOT NULL,
  `room_id` char(36) NOT NULL,
  PRIMARY KEY (`password_id`,`room_id`),
  KEY `password_id` (`password_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `restricted_access_rooms_mapping_ibfk_1` FOREIGN KEY (`password_id`) REFERENCES `restricted_access_passwords` (`password_id`) ON DELETE CASCADE,
  CONSTRAINT `restricted_access_rooms_mapping_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restricted_access_rooms_mapping`
--

LOCK TABLES `restricted_access_rooms_mapping` WRITE;
/*!40000 ALTER TABLE `restricted_access_rooms_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `restricted_access_rooms_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restricted_access_users_mapping`
--

DROP TABLE IF EXISTS `restricted_access_users_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restricted_access_users_mapping` (
  `password_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`password_id`,`user_id`),
  KEY `password_id` (`password_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `restricted_access_users_mapping_ibfk_1` FOREIGN KEY (`password_id`) REFERENCES `restricted_access_passwords` (`password_id`) ON DELETE CASCADE,
  CONSTRAINT `restricted_access_users_mapping_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restricted_access_users_mapping`
--

LOCK TABLES `restricted_access_users_mapping` WRITE;
/*!40000 ALTER TABLE `restricted_access_users_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `restricted_access_users_mapping` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `rgbw`
--

DROP TABLE IF EXISTS `rgbw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rgbw` (
  `device_id` char(20) NOT NULL,
  `rgbw_mode` enum('static','breathing','strobe','flash','fade','smooth') NOT NULL DEFAULT 'static',
  `rgbw_speed` tinyint(1) NOT NULL DEFAULT '1',
  `red_intensity` char(4) NOT NULL DEFAULT '0',
  `green_intensity` char(4) NOT NULL DEFAULT '0',
  `blue_intensity` char(4) NOT NULL DEFAULT '0',
  `white_intensity` char(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`device_id`),
  CONSTRAINT `rgbw_fk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
LOCK TABLES `rgbw` WRITE;
/*!40000 ALTER TABLE `rgbw` DISABLE KEYS */;
/*!40000 ALTER TABLE `rgbw` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rooms` (
  `room_id` char(36) NOT NULL,
  `room_name` char(64) NOT NULL,
  `room_night_mode` enum('on','off') NOT NULL DEFAULT 'off',
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES ('00000000000000000000-000000000000000','HOME','off');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scanned_devices`
--

DROP TABLE IF EXISTS `scanned_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scanned_devices` (
  `device_id` char(20) NOT NULL,
  `room_id` char(36) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `device_type` char(64) NOT NULL,
  `device_state` char(16) NOT NULL,
  `device_intensity` char(4) NOT NULL,
  `device_version` smallint(4) NOT NULL DEFAULT 0x0100,
  PRIMARY KEY (`device_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `scanned_devices_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scanned_devices`
--

LOCK TABLES `scanned_devices` WRITE;
/*!40000 ALTER TABLE `scanned_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `scanned_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scene_device_mapping`
--

DROP TABLE IF EXISTS `scene_device_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scene_device_mapping` (
  `scene_id` char(36) NOT NULL,
  `device_id` char(20) NOT NULL,
  `device_state` char(16) NOT NULL,
  `device_intensity` char(4) NOT NULL,
  PRIMARY KEY (`scene_id`,`device_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `scene_device_mapping_ibfk_1` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`scene_id`) ON DELETE CASCADE,
  CONSTRAINT `scene_device_mapping_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scene_device_mapping`
--

LOCK TABLES `scene_device_mapping` WRITE;
/*!40000 ALTER TABLE `scene_device_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `scene_device_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scene_rgbw_mapping`
--

DROP TABLE IF EXISTS `scene_rgbw_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scene_rgbw_mapping` (
  `scene_id` char(36) NOT NULL,
  `device_id` char(20) NOT NULL,
  `rgbw_mode` enum('static','breathing','strobe','flash','fade','smooth') NOT NULL DEFAULT 'static',
  `rgbw_speed` tinyint(1) NOT NULL DEFAULT '1',
  `red_intensity` char(4) NOT NULL DEFAULT '0',
  `green_intensity` char(4) NOT NULL DEFAULT '0',
  `blue_intensity` char(4) NOT NULL DEFAULT '0',
  `white_intensity` char(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`scene_id`,`device_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `scene_rgbw_mapping_ibfk_1` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`scene_id`) ON DELETE CASCADE,
  CONSTRAINT `scene_rgbw_mapping_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `rgbw` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scene_rgbw_mapping`
--

LOCK TABLES `scene_rgbw_mapping` WRITE;
/*!40000 ALTER TABLE `scene_rgbw_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `scene_rgbw_mapping` ENABLE KEYS */;
UNLOCK TABLES;

/*Table structure for table `scene_wifi_mapping` */
DROP TABLE IF EXISTS `scene_wifi_mapping`;

CREATE TABLE `scene_wifi_mapping` (
  `scene_id` char(36) NOT NULL,
  `wifi_device_id` char(36) NOT NULL,
  `wifi_device_attributes` text DEFAULT NULL,
  PRIMARY KEY (`scene_id`,`wifi_device_id`),
  KEY `scene_wifi_mapping_ibfk_1` (`wifi_device_id`),
  CONSTRAINT `scene_wifi_mapping_ibfk_1` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`scene_id`) ON DELETE CASCADE,
  CONSTRAINT `scene_wifi_mapping_ibfk_2` FOREIGN KEY (`wifi_device_id`) REFERENCES `wifi_devices` (`wifi_device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `scene_wifi_mapping` */

LOCK TABLES `scene_wifi_mapping` WRITE;

UNLOCK TABLES;

--
-- Table structure for table `scenes`
--

DROP TABLE IF EXISTS `scenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenes` (
  `scene_id` char(36) NOT NULL,
  `room_id` char(36) NOT NULL,
  `scene_name` char(64) NOT NULL,
  `master_id` char(36) DEFAULT NULL,
  PRIMARY KEY (`scene_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `scenes_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenes`
--

LOCK TABLES `scenes` WRITE;
/*!40000 ALTER TABLE `scenes` DISABLE KEYS */;
/*!40000 ALTER TABLE `scenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_device_mapping`
--

DROP TABLE IF EXISTS `schedule_device_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_device_mapping` (
  `schedule_id` char(36) NOT NULL,
  `device_id` char(20) NOT NULL,
  `device_state` char(16) NOT NULL,
  `device_intensity` char(4) NOT NULL,
  PRIMARY KEY (`schedule_id`,`device_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `schedule_device_mapping_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`schedule_id`) ON DELETE CASCADE,
  CONSTRAINT `schedule_device_mapping_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_device_mapping`
--

LOCK TABLES `schedule_device_mapping` WRITE;
/*!40000 ALTER TABLE `schedule_device_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_device_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_rgbw_mapping`
--

DROP TABLE IF EXISTS `schedule_rgbw_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_rgbw_mapping` (
  `schedule_id` char(36) NOT NULL,
  `device_id` char(20) NOT NULL,
  `rgbw_mode` enum('static','breathing','strobe','flash','fade','smooth') NOT NULL DEFAULT 'static',
  `rgbw_speed` tinyint(1) NOT NULL DEFAULT '1',
  `red_intensity` char(4) NOT NULL DEFAULT '0',
  `green_intensity` char(4) NOT NULL DEFAULT '0',
  `blue_intensity` char(4) NOT NULL DEFAULT '0',
  `white_intensity` char(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`schedule_id`,`device_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `schedule_rgbw_mapping_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`schedule_id`) ON DELETE CASCADE,
  CONSTRAINT `schedule_rgbw_mapping_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `rgbw` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule_rgbw_mapping`
--

LOCK TABLES `schedule_rgbw_mapping` WRITE;
/*!40000 ALTER TABLE `schedule_rgbw_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_rgbw_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_scene_mapping`
--

DROP TABLE IF EXISTS `schedule_scene_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_scene_mapping` (
  `schedule_id` char(36) NOT NULL,
  `scene_id` char(36) NOT NULL,
  PRIMARY KEY (`schedule_id`,`scene_id`),
  KEY `scene_id` (`scene_id`),
  CONSTRAINT `schedule_scene_mapping_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`schedule_id`) ON DELETE CASCADE,
  CONSTRAINT `schedule_scene_mapping_ibfk_2` FOREIGN KEY (`scene_id`) REFERENCES `scenes` (`scene_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_scene_mapping`
--

LOCK TABLES `schedule_scene_mapping` WRITE;
/*!40000 ALTER TABLE `schedule_scene_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_scene_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_motion_sensor_mapping`
--

DROP TABLE IF EXISTS `schedule_motion_sensor_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_motion_sensor_mapping` (
  `schedule_id` char(36) NOT NULL,
  `device_id` char(20) NOT NULL,
  `armed` tinyint(1) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`schedule_id`,`device_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `schedule_motion_sensor_mapping_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`schedule_id`) ON DELETE CASCADE,
  CONSTRAINT `schedule_motion_sensor_mapping_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `motion_sensors` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule_motion_sensor_mapping`
--

LOCK TABLES `schedule_motion_sensor_mapping` WRITE;
/*!40000 ALTER TABLE `schedule_motion_sensor_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_motion_sensor_mapping` ENABLE KEYS */;
UNLOCK TABLES;

/*Table structure for table `schedule_wifi_mapping` */
DROP TABLE IF EXISTS `schedule_wifi_mapping`;

CREATE TABLE `schedule_wifi_mapping` (
  `schedule_id` char(36) NOT NULL,
  `wifi_device_id` char(36) NOT NULL,
  `wifi_device_attributes` text DEFAULT NULL,
  PRIMARY KEY (`schedule_id`,`wifi_device_id`),
  KEY `schedule_wifi_mapping_ibfk_1` (`wifi_device_id`),
  CONSTRAINT `schedule_wifi_mapping_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`schedule_id`) ON DELETE CASCADE,
  CONSTRAINT `schedule_wifi_mapping_ibfk_2` FOREIGN KEY (`wifi_device_id`) REFERENCES `wifi_devices` (`wifi_device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `schedule_wifi_mapping` */

LOCK TABLES `schedule_wifi_mapping` WRITE;

UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedules` (
  `schedule_id` char(36) NOT NULL,
  `master_id` char(36) DEFAULT NULL,
  `start_time` time NOT NULL,
  `duration` time DEFAULT NULL,
  `type` enum('device','wifi_device','scene','temperature','motion_sensor','rgbw') NOT NULL,
  `is_enabled` tinyint(1) NOT NULL,
  `monday` tinyint(1) NOT NULL,
  `tuesday` tinyint(1) NOT NULL,
  `wednesday` tinyint(1) NOT NULL,
  `thursday` tinyint(1) NOT NULL,
  `friday` tinyint(1) NOT NULL,
  `saturday` tinyint(1) NOT NULL,
  `sunday` tinyint(1) NOT NULL,
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temperature_profiles`
--

DROP TABLE IF EXISTS `temperature_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temperature_profiles` (
  `temperature_profile_id` char(36) NOT NULL,
  `temperature_profile_name` char(36) NOT NULL DEFAULT '',
  `profile_temperature` float(4,1) NOT NULL,
  `temperature_profile_fan_speed` char(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`temperature_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temperature_profiles`
--

LOCK TABLES `temperature_profiles` WRITE;
/*!40000 ALTER TABLE `temperature_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `temperature_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_temperature_mapping`
--

DROP TABLE IF EXISTS `room_temperature_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_temperature_mapping` (
  `temperature_profile_id` char(36) DEFAULT NULL,
  `room_id` char(36) NOT NULL DEFAULT '',
  PRIMARY KEY (`room_id`),
  KEY `room_temperature_mapping_ibfk_2` (`temperature_profile_id`),
  CONSTRAINT `room_temperature_mapping_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE,
  CONSTRAINT `room_temperature_mapping_ibfk_2` FOREIGN KEY (`temperature_profile_id`) REFERENCES `temperature_profiles` (`temperature_profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room_temperature_mapping`
--

LOCK TABLES `room_temperature_mapping` WRITE;
/*!40000 ALTER TABLE `room_temperature_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_temperature_mapping` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `schedule_temperature_mapping`
--

DROP TABLE IF EXISTS `schedule_temperature_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_temperature_mapping` (
  `schedule_id` char(36) DEFAULT NULL,
  `temperature_profile_id` char(36) DEFAULT NULL,
  `room_id` char(36) DEFAULT NULL,
  KEY `temperature_profile_id` (`temperature_profile_id`),
  KEY `room_id` (`room_id`),
  KEY `schedule_id` (`schedule_id`),
  CONSTRAINT `schedule_temperature_mapping_ibfk_1` FOREIGN KEY (`temperature_profile_id`) REFERENCES `temperature_profiles` (`temperature_profile_id`) ON DELETE CASCADE,
  CONSTRAINT `schedule_temperature_mapping_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE,
  CONSTRAINT `schedule_temperature_mapping_ibfk_3` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`schedule_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule_temperature_mapping`
--

LOCK TABLES `schedule_temperature_mapping` WRITE;
/*!40000 ALTER TABLE `schedule_temperature_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_temperature_mapping` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `sensors`
--

DROP TABLE IF EXISTS `sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensors` (
  `device_id` char(20) NOT NULL,
  `room_id` char(36) NOT NULL,
  `device_type` enum('remote','scene_selector','gas_sensor','motion_sensor','ir_emitter','bell', 'vdp', 'repeater') NOT NULL DEFAULT 'remote',
  `device_name` char(64) DEFAULT NULL,
  `device_version` smallint(4) NOT NULL DEFAULT 0x0100,
  PRIMARY KEY (`device_id`),
  KEY `roomid` (`room_id`),
  CONSTRAINT `roomid` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensors`
--

LOCK TABLES `sensors` WRITE;
/*!40000 ALTER TABLE `sensors` DISABLE KEYS */;
/*!40000 ALTER TABLE `sensors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminder_device_mapping`
--

DROP TABLE IF EXISTS `reminder_device_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminder_device_mapping` (
  `reminder_id` char(36) NOT NULL,
  `device_id` char(20) NOT NULL,
  `device_state` char(16) NOT NULL,
  `device_intensity` char(4) NOT NULL DEFAULT '255',
  PRIMARY KEY (`reminder_id`),
  KEY `reminder_device_mapping_ibfk_2` (`device_id`),
  CONSTRAINT `reminder_device_mapping_ibfk_1` FOREIGN KEY (`reminder_id`) REFERENCES `reminders` (`reminder_id`) ON DELETE CASCADE,
  CONSTRAINT `reminder_device_mapping_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reminder_device_mapping`
--

LOCK TABLES `reminder_device_mapping` WRITE;
/*!40000 ALTER TABLE `reminder_device_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminder_device_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminders` (
  `reminder_id` char(36) NOT NULL,
  `last_update_time` datetime NOT NULL,
  `type` enum('device') DEFAULT 'device',
  `duration` smallint(3) NOT NULL,
  `trigger_once` tinyint(1) NOT NULL DEFAULT '0',
  `notification` tinyint(1) NOT NULL DEFAULT '1',
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`reminder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reminders`
--

LOCK TABLES `reminders` WRITE;
/*!40000 ALTER TABLE `reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` char(36) NOT NULL,
  `user_login` char(36) NOT NULL,
  `user_role` enum('admin','user') NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cameras`
--

DROP TABLE IF EXISTS `cameras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cameras` (
  `camera_id` char(36) NOT NULL,
  `gateway_id` char(20) DEFAULT NULL,
  `camera_name` varchar(64) DEFAULT NULL,
  `camera_username` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`camera_id`),
  KEY `camera_fk_1` (`gateway_id`),
  CONSTRAINT `camera_fk_1` FOREIGN KEY (`gateway_id`) REFERENCES `gateways` (`gateway_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cameras`
--

LOCK TABLES `cameras` WRITE;
/*!40000 ALTER TABLE `cameras` DISABLE KEYS */;
/*!40000 ALTER TABLE `cameras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bells`
--

DROP TABLE IF EXISTS `bells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bells` (
  `device_id` char(36) NOT NULL,
  `camera_id` char(36) DEFAULT NULL,
  `is_notification_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  `muted_until` datetime DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  KEY `bells_fk_2` (`camera_id`),
  CONSTRAINT `bells_fk_1` FOREIGN KEY (`device_id`) REFERENCES `sensors` (`device_id`) ON DELETE CASCADE,
  CONSTRAINT `bells_fk_2` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`camera_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bells`
--

LOCK TABLES `bells` WRITE;
/*!40000 ALTER TABLE `bells` DISABLE KEYS */;
/*!40000 ALTER TABLE `bells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `table_name` char(64) NOT NULL,
  `gateway_version` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

CREATE TABLE `activity_log` (
  `user_id` char(36) NOT NULL,
  `activity_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activity_type` char(36) DEFAULT NULL,
  `action` char(16) DEFAULT NULL,
  `attributes` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES ('devices',0),('ir_emitters',0),('motion_sensors',0),('motion_sensor_trigger',0),('sensors',0),('reminder_device_mapping',0),('reminders',0),('remote_device_mapping',0),('remote_scene_mapping',0),('restricted_access_passwords',0),('restricted_access_rooms_mapping',0),('restricted_access_users_mapping',0),('rgbw',0),('rooms',0),('scenes',0),('scene_device_mapping',0),('scene_rgbw_mapping',0),('schedules',0),('schedule_device_mapping',0),('schedule_motion_sensor_mapping', 0),('schedule_rgbw_mapping',0),('schedule_scene_mapping',0),('temperature_profiles',0),('room_temperature_mapping',0),('schedule_temperature_mapping',0),('users',0),('cameras',0),('bells',0),('version',1);
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-29 17:41:45

