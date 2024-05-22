-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `birthday` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(3,'cc@cc','oh',NULL,NULL,28,NULL,'user',NULL,NULL,0),
(6,'lee245252@gmail.com','홍길동',NULL,NULL,120,NULL,'user',NULL,NULL,0),
(7,'honggildong','lee',NULL,NULL,240,NULL,'user',NULL,NULL,0),
(10,'abc@abc.com',NULL,NULL,NULL,25,NULL,'user',NULL,NULL,0),
(11,'test@test.com',NULL,NULL,NULL,12,NULL,'user',NULL,NULL,0),
(12,'test1@test.com',NULL,NULL,NULL,30,NULL,'user',NULL,NULL,0),
(13,'test2@test.com',NULL,NULL,NULL,37,NULL,'user','2000-11-16',NULL,0),
(16,'test4@test.com',NULL,NULL,NULL,24,NULL,'user','2000-05-16','2024-05-17 12:31:31',0),
(17,'test5@test.com','lee',NULL,NULL,27,NULL,'user',NULL,'2024-05-17 16:15:37',0),
(55,'hh@gg','honghong',NULL,NULL,25,NULL,'user',NULL,NULL,0),
(56,'kim@naver.com','kim',NULL,NULL,38,NULL,'user',NULL,'2024-05-20 15:40:21',NULL),
(57,NULL,NULL,NULL,NULL,17,NULL,'user',NULL,'2024-05-20 17:42:17',NULL);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'t1','c1',NULL,3000.000,'2024-11-06 00:00:00','02fd95a2-141f-11ef-a6c7-8cb0e9d8db1a'),
(2,'t3','c3',3,1500.000,'2020-05-20 00:00:00','02fd96cd-141f-11ef-a6c7-8cb0e9d8db1a'),
(4,'hello','c5',3,2000.000,NULL,'02fd9771-141f-11ef-a6c7-8cb0e9d8db1a'),
(5,'hello java',NULL,55,1234.100,'2020-03-15 00:00:00','02fd97e5-141f-11ef-a6c7-8cb0e9d8db1a'),
(6,'head1','text1',55,5500.000,'2024-05-17 12:25:00','02fd9833-141f-11ef-a6c7-8cb0e9d8db1a'),
(7,'head1','text1',NULL,11000.000,'2024-05-17 12:32:01','02fd9871-141f-11ef-a6c7-8cb0e9d8db1a'),
(8,'abc',NULL,NULL,3000.000,'2024-05-17 16:28:32','1164f16b-141f-11ef-a6c7-8cb0e9d8db1a'),
(9,'abc',NULL,NULL,150.000,'2024-05-17 16:28:38','150123f5-141f-11ef-a6c7-8cb0e9d8db1a'),
(22,'hello word!',NULL,3,6000.000,'2024-05-20 12:48:23','d033611b-165b-11ef-a6c7-8cb0e9d8db1a');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 16:28:42
