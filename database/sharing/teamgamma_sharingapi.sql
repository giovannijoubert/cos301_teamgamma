-- MySQL dump 10.13  Distrib 8.0.19, for osx10.14 (x86_64)
--
-- Host: teamgamma.ga    Database: teamgamma_sharingapi
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.44-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `MockTable`
--

DROP TABLE IF EXISTS `MockTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MockTable` (
  `id` varchar(30) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `author` varchar(30) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `imageURL` varchar(200) DEFAULT NULL,
  `ratings` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MockTable`
--

LOCK TABLES `MockTable` WRITE;
/*!40000 ALTER TABLE `MockTable` DISABLE KEYS */;
INSERT INTO `MockTable` VALUES ('123abc','mockmouth1','anonymous','2020-03-11','http://teamgamma.ga/mouthpacks/123abc',3),('123abd','mockmouth2','Jared Gratz','2020-03-11','http://teamgamma.ga/mouthpacks/123abd',2);
/*!40000 ALTER TABLE `MockTable` ENABLE KEYS */;
UNLOCK TABLES;
