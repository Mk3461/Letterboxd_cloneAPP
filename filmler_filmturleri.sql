-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: filmler
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `filmturleri`
--

DROP TABLE IF EXISTS `filmturleri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filmturleri` (
  `film_id` int NOT NULL,
  `tur_id` int NOT NULL,
  PRIMARY KEY (`film_id`,`tur_id`),
  KEY `tur_id` (`tur_id`),
  CONSTRAINT `filmturleri_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `filmler` (`id`),
  CONSTRAINT `filmturleri_ibfk_2` FOREIGN KEY (`tur_id`) REFERENCES `turler` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filmturleri`
--

LOCK TABLES `filmturleri` WRITE;
/*!40000 ALTER TABLE `filmturleri` DISABLE KEYS */;
INSERT INTO `filmturleri` VALUES (1,1),(3,1),(4,1),(5,1),(12,1),(15,1),(16,1),(25,1),(26,1),(27,1),(28,1),(29,1),(31,1),(33,1),(34,1),(35,1),(36,1),(39,1),(40,1),(41,1),(42,1),(43,1),(44,1),(46,1),(47,1),(48,1),(49,1),(51,1),(52,1),(53,1),(59,1),(62,1),(65,1),(67,1),(68,1),(69,1),(70,1),(71,1),(72,1),(73,1),(74,1),(75,1),(1,2),(23,2),(24,2),(69,2),(70,2),(72,2),(73,2),(74,2),(75,2),(2,3),(15,3),(19,3),(20,3),(21,3),(22,3),(25,3),(32,3),(33,3),(35,3),(36,3),(37,3),(38,3),(39,3),(40,3),(42,3),(43,3),(71,3),(72,3),(73,3),(75,3),(3,4),(27,4),(35,4),(38,4),(40,4),(41,4),(42,4),(43,4),(46,4),(47,4),(48,4),(49,4),(51,4),(52,4),(4,5),(11,5),(17,5),(54,5),(55,5),(59,5),(60,5),(70,5),(4,6),(11,6),(12,6),(13,6),(14,6),(15,6),(16,6),(17,6),(18,6),(37,6),(38,6),(47,6),(48,6),(61,6),(63,6),(64,6),(66,6),(67,6),(5,7),(62,7),(5,8),(12,8),(13,8),(61,8),(63,8),(64,8),(65,8),(66,8),(74,9),(28,10),(29,10),(30,10),(31,10),(32,10),(34,10),(54,10),(62,10),(11,11),(13,11),(14,11),(17,11),(18,11),(16,12),(19,12),(20,12),(21,12),(22,12),(23,12),(24,12),(25,12),(26,12),(27,12),(19,13),(20,13),(23,13),(26,13),(29,13),(30,13),(36,13),(19,14),(30,14),(34,14),(44,14),(39,15);
/*!40000 ALTER TABLE `filmturleri` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-12 16:00:43
