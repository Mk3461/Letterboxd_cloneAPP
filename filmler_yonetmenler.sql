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
-- Table structure for table `yonetmenler`
--

DROP TABLE IF EXISTS `yonetmenler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yonetmenler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ad_soyad` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yonetmenler`
--

LOCK TABLES `yonetmenler` WRITE;
/*!40000 ALTER TABLE `yonetmenler` DISABLE KEYS */;
INSERT INTO `yonetmenler` VALUES (1,'Frank Darabont'),(2,'Sidney Lumet'),(3,'Robert Zemeckis'),(4,'Christopher Nolan'),(5,'Frank Capra'),(6,'Jonathan Demme'),(7,'Peter Farrelly'),(8,'Peter Farrelly'),(9,'Peter Farrelly'),(10,'Peter Farrelly'),(11,'Roman Polanski'),(12,'Çağan Irmak'),(13,'Peter Farrelly'),(14,'Roberto Benigni'),(15,'Alfred Hitchcock'),(16,'David Fincher'),(17,'Bryan Singer'),(18,'Christopher Nolan'),(19,'Park Chan-wook'),(20,'Jaume Collet-Serra'),(21,'Martin Scorsese'),(22,'Irvin Kershner'),(23,'Lana Wachowski & Lilly Wachowski'),(24,'James Cameron'),(25,'Robert Zemeckis'),(26,'Ömer Faruk Sorak'),(27,'James McTeigue'),(28,'Denis Villeneuve'),(29,'Stanley Kubrick'),(30,'Steven Spielberg'),(31,'Quentin Tarantino'),(32,'David Lean'),(33,'Sam Mendes'),(34,'Alper Çağlar'),(35,'Zübeyr Şaşmaz'),(36,'Sergey Mokritskiy'),(37,'Christopher Nolan'),(38,'Ridley Scott'),(39,'Ilya Naishuller'),(40,'Chad Stahelski'),(41,'Isaac Florentine'),(42,'Luc Besson'),(43,'Brian De Palma'),(44,'Quentin Tarantino'),(45,'Justin Lin'),(46,'Quentin Tarantino'),(47,'Martin Scorsese'),(48,'Martin Scorsese'),(49,'Martin Scorsese'),(50,'Martin Scorsese'),(51,'Quentin Tarantino'),(52,'Yılmaz Güney'),(53,'Brian De Palma'),(54,'Brian De Palma'),(55,'Brian De Palma'),(56,'Brian De Palma'),(57,'Sergio Leone'),(58,'Martin Scorsese'),(59,'Can Ulkay'),(60,'Cem Yılmaz'),(61,'Togan Gökbakar'),(62,'Yılmaz Erdoğan'),(63,'Ömer Faruk Sorak'),(64,'Kamil Çetin'),(65,'Murat Şeker'),(66,'Rajkumar Hirani'),(67,'Ertem Eğilmez'),(68,'James Wan'),(69,'Francis Lawrence'),(70,'John R. Leonetti'),(71,'James Wong'),(72,'Andy Muschietti'),(73,'Oren Peli'),(74,'Taylor Hackford'),(75,'Gabriele Muccino'),(76,'Steven Spielberg'),(77,'Peter Farrelly'),(78,'Can Ulkay'),(79,'John Lee Hancock'),(80,'Ömer Faruk Sorak'),(81,'Bryan Singer'),(82,'Christopher Nolan');
/*!40000 ALTER TABLE `yonetmenler` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-12 16:00:44
