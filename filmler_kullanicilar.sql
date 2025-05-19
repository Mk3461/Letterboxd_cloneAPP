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
-- Table structure for table `kullanicilar`
--

DROP TABLE IF EXISTS `kullanicilar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kullanicilar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kullanici_adi` varchar(100) NOT NULL,
  `isim` varchar(50) DEFAULT NULL,
  `soyisim` varchar(50) DEFAULT NULL,
  `yas` int DEFAULT NULL,
  `cinsiyet` enum('Erkek','Kadın','Atak Helikopteri') DEFAULT NULL,
  `password_hash` varchar(512) DEFAULT NULL,
  `password_salt` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kullanici_adi` (`kullanici_adi`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kullanicilar`
--

LOCK TABLES `kullanicilar` WRITE;
/*!40000 ALTER TABLE `kullanicilar` DISABLE KEYS */;
INSERT INTO `kullanicilar` VALUES (9,'deneme1','deneme','deneme',14,'Erkek','5//j8IqiBxRd48yiYbqCyyEjFJzy44AwLMAl/6XWiBosfcerLJUMUjAbUOZZJ101vgyewhmcPZls1iPvqcY6Eg==','2iGDrH5cHa58HBXp17Tg/Pe+1PYr7itt2Dyds48AkaiTYpKxv2x1JFiXuaEb4norw+2OIu50DtH4lN91kwXsU24XbTgjyk/1Jb7517GmC778I4WwcrSfz79w22/6vfJsLCu+8obZipM2oAqOCkIuvsLL+5aOCFkgyaKPU9Nj72Y='),(10,'Murat','Murat','Karabeyaz',98,'Atak Helikopteri','vPuqY7RzxDvKXiSWop6OVacBUOlvg9vD0+wFtMzBSk8Gy/uNHAd21JVarbe1M2zb1G5lwFMq6XMn6jFcQqCG9A==','qVoIV3TQOHKpFAY6ZAiAyJX7fmawky9zY6csKROpbJorxeFxvlgNoC0GK1RxQ59WcIj1IX9R66dEXdIgh2MAGdUfTTOw4nyUop35i414hU7KQ12iQ8vBEYeuFGg4PabQdBvw2ZNBPFXNP5w7peeVJHoxcrkgKO+7H5e8dNALtH4='),(11,'Ufuk','Uufk','Soydan',21,'Erkek','OPCnHY+QnBS2LL1cMd8E1G3J79poaLsIvjx9XM+fxC10SfKV6MPXAqEzNldn8wYPqdWNRzsrlYc0iToTIMV9Sw==','SuYnrSwclrC6ejrnwSKN6pWqKLLJkGaxO/aCP4o66CgGAr30qeNqJwSArh051bFWJ88FSxYw/W0B40MdKHc+DYXkSBemjfKf+7vseOHeqDxENpJPa+ueDrVrYLy//aW0fjZqocNJDH0BcrNM0oyBZOH2oh5nEd8VG7Nrdz3VJlE='),(12,'Mustafa','Mustafa','Kaner',21,'Erkek','dgT7LKHU6V7VSKVfIXDs7PaeDUt8pJIAU1vzfYOtrcsKBnwiMMY8KoZ6sPxO7QZG6JqiX9JCOyRNpeZ3fH+sWA==','yyXOc8VwRK1KSK5PoW3mqRaiV1Srftssdc0QXFeTvRZFavuyzSq3VxaW0JnhFuSGNXw5hZHqwyciRuzVNNVJEbYMn1br2NZjduXleIJCHX9WKjxj1U1hpVGz1JK+VyHsNpEuJ7Tu921Q5r4oPF6774rB9LcKsNK4/Equ9/XJK90='),(13,'Taha','Taha','Demir',13,'Erkek','94vYDp5aSpEUCOdOSbBeN6jeTLKZG82WFdOKitM795F6qpU1Wxy5NVkF6wi9ZmrZF5c5U7AXrXkjR5IQzNH8eA==','607lmq9pvSzpGQbaoIcvOy3XaiR5ZeZGiT0qomHbm0NF0vpQXbShUb5UOLBwxoJVCB9aHmj8pE8jr7O8HWh9jtndGQhXsG4gr9x4WXbdnmBC9a+8WlmLOdj5Vrk+ztrwv5uDeRKDgs1Vu1/eWNehPnL1+3rAE+dhc3lw207/ROU=');
/*!40000 ALTER TABLE `kullanicilar` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-19 19:59:20
