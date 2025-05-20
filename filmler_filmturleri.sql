-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (arm64)
--
-- Host: localhost    Database: filmler
-- ------------------------------------------------------
-- Server version	9.3.0

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
INSERT INTO `filmturleri` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(11,1),(12,1),(13,1),(14,1),(18,1),(20,1),(24,1),(29,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(38,1),(40,1),(44,1),(45,1),(49,1),(51,1),(52,1),(54,1),(55,1),(59,1),(60,1),(67,1),(75,1),(76,1),(77,1),(79,1),(80,1),(81,1),(82,1),(83,1),(1,2),(2,2),(13,2),(17,2),(19,2),(33,2),(44,2),(45,2),(46,2),(49,2),(51,2),(52,2),(53,2),(55,2),(59,2),(60,2),(3,4),(4,5),(23,5),(25,5),(26,5),(27,5),(28,5),(30,5),(34,5),(4,6),(20,6),(23,6),(24,6),(25,6),(26,6),(27,6),(28,6),(29,6),(30,6),(39,6),(62,6),(70,6),(5,7),(23,8),(73,8),(6,9),(16,9),(21,9),(22,9),(25,9),(26,9),(31,9),(39,9),(41,9),(42,9),(72,9),(15,10),(21,10),(69,10),(70,10),(71,10),(72,10),(73,10),(74,10),(75,10),(6,11),(15,11),(16,11),(18,11),(20,11),(22,11),(24,11),(69,11),(29,19),(37,19),(39,19),(40,19),(41,19),(42,19),(43,19),(46,19),(47,19),(48,19),(3,21),(13,21),(27,21),(28,21),(47,21),(61,21),(62,21),(63,21),(64,21),(65,21),(66,21),(67,21),(68,21),(11,22),(14,22),(32,22),(33,22),(35,22),(36,22),(37,22),(38,22),(48,22),(79,22),(83,22),(77,23),(81,23),(82,23),(83,23),(17,24),(19,24),(31,24);
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

-- Dump completed on 2025-05-19 19:59:19
