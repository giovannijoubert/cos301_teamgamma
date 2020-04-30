-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: teamgamma.ga    Database: teamgamma_usermanagementapi
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.44-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Profile_Template`
--

DROP TABLE IF EXISTS `Profile_Template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Profile_Template` (
  `user_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  PRIMARY KEY (`template_id`,`user_id`),
  KEY `Profile_Template_User_Profile_user_id_fk` (`user_id`),
  CONSTRAINT `Profile_Template_User_Profile_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `User_Profile` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Profile_Template`
--

LOCK TABLES `Profile_Template` WRITE;
/*!40000 ALTER TABLE `Profile_Template` DISABLE KEYS */;
/*!40000 ALTER TABLE `Profile_Template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Templates`
--

DROP TABLE IF EXISTS `Templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Templates` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(50) NOT NULL,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `Templates_template_id_uindex` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Templates`
--

LOCK TABLES `Templates` WRITE;
/*!40000 ALTER TABLE `Templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `Templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_Profile`
--

DROP TABLE IF EXISTS `User_Profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `User_Profile` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_name` varchar(50) NOT NULL,
  `l_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `User_Profile_user_id_uindex` (`user_id`),
  UNIQUE KEY `User_Profile_username_uindex` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1234567895 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Profile`
--

LOCK TABLES `User_Profile` WRITE;
/*!40000 ALTER TABLE `User_Profile` DISABLE KEYS */;
INSERT INTO `User_Profile` VALUES (1234567894,'John2','Doe2','Johndoe2','add98976ec701582276823d35a99e3de','Johndoe2@gmail.com','2020-03-12 19:40:39','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `User_Profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-12 21:39:16
