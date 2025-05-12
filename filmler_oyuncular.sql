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
-- Table structure for table `oyuncular`
--

DROP TABLE IF EXISTS `oyuncular`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oyuncular` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ad_soyad` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oyuncular`
--

LOCK TABLES `oyuncular` WRITE;
/*!40000 ALTER TABLE `oyuncular` DISABLE KEYS */;
INSERT INTO `oyuncular` VALUES (1,'Tim Robbins'),(2,'Morgan Freeman'),(3,'Bob Gunton'),(4,'William Sadler'),(5,'Henry Fonda'),(6,'Lee J. Cobb'),(7,'Martin Balsam'),(8,'John Fiedler'),(9,'Tom Hanks'),(10,'Robin Wright'),(11,'Gary Sinise'),(12,'Sally Field'),(13,'Matthew McConaughey'),(14,'Anne Hathaway'),(15,'Jessica Chastain'),(16,'Michael Caine'),(17,'James Stewart'),(18,'Donna Reed'),(19,'Lionel Barrymore'),(20,'Thomas Mitchell'),(21,'Jodie Foster'),(22,'Anthony Hopkins'),(23,'Scott Glenn'),(24,'Ted Levine'),(25,'Viggo Mortensen'),(26,'Mahershala Ali'),(27,'Linda Cardellini'),(28,'Sebastian Maniscalco'),(29,'Viggo Mortensen'),(30,'Mahershala Ali'),(31,'Linda Cardellini'),(32,'Sebastian Maniscalco'),(33,'Adrien Brody'),(34,'Thomas Kretschmann'),(35,'Frank Finlay'),(36,'Maureen Lipman'),(37,'Fikret Kuşkan'),(38,'Çetin Tekindor'),(39,'Hümeyra'),(40,'Özge Özberk'),(41,'Viggo Mortensen'),(42,'Mahershala Ali'),(43,'Linda Cardellini'),(44,'Sebastian Maniscalco'),(45,'Roberto Benigni'),(46,'Nicoletta Braschi'),(47,'Giorgio Cantarini'),(48,'Giustino Durano'),(49,'Anthony Perkins'),(50,'Janet Leigh'),(51,'Vera Miles'),(52,'John Gavin'),(53,'Brad Pitt'),(54,'Morgan Freeman'),(55,'Kevin Spacey'),(56,'Gwyneth Paltrow'),(57,'Kevin Spacey'),(58,'Gabriel Byrne'),(59,'Benicio Del Toro'),(60,'Stephen Baldwin'),(61,'Guy Pearce'),(62,'Carrie-Anne Moss'),(63,'Joe Pantoliano'),(64,'Mark Boone Junior'),(65,'Choi Min-sik'),(66,'Yoo Ji-tae'),(67,'Kang Hye-jeong'),(68,'Kim Byeong-ok'),(69,'Christian Bale'),(70,'Hugh Jackman'),(71,'Scarlett Johansson'),(72,'Michael Caine'),(73,'Vera Farmiga'),(74,'Peter Sarsgaard'),(75,'Isabelle Fuhrman'),(76,'CCH Pounder'),(77,'Leonardo DiCaprio'),(78,'Mark Ruffalo'),(79,'Ben Kingsley'),(80,'Michelle Williams'),(81,'Mark Hamill'),(82,'Harrison Ford'),(83,'Carrie Fisher'),(84,'Billy Dee Williams'),(85,'Leonardo DiCaprio'),(86,'Joseph Gordon-Levitt'),(87,'Ellen Page'),(88,'Tom Hardy'),(89,'Keanu Reeves'),(90,'Laurence Fishburne'),(91,'Carrie-Anne Moss'),(92,'Hugo Weaving'),(93,'Arnold Schwarzenegger'),(94,'Linda Hamilton'),(95,'Edward Furlong'),(96,'Robert Patrick'),(97,'Michael J. Fox'),(98,'Christopher Lloyd'),(99,'Lea Thompson'),(100,'Crispin Glover'),(101,'Cem Yılmaz'),(102,'Ozan Güven'),(103,'Özkan Uğur'),(104,'Rasim Öztekin'),(105,'Natalie Portman'),(106,'Hugo Weaving'),(107,'Stephen Rea'),(108,'Stephen Fry'),(109,'Timothée Chalamet'),(110,'Rebecca Ferguson'),(111,'Oscar Isaac'),(112,'Jason Momoa'),(113,'Malcolm McDowell'),(114,'Patrick Magee'),(115,'Michael Bates'),(116,'Warren Clarke'),(117,'Tom Hanks'),(118,'Matt Damon'),(119,'Tom Sizemore'),(120,'Edward Burns'),(121,'Brad Pitt'),(122,'Mélanie Laurent'),(123,'Christoph Waltz'),(124,'Diane Kruger'),(125,'Peter O\'Toole'),(126,'Alec Guinness'),(127,'Anthony Quinn'),(128,'Jack Hawkins'),(129,'George MacKay'),(130,'Dean-Charles Chapman'),(131,'Mark Strong'),(132,'Benedict Cumberbatch'),(133,'Çağlar Ertuğrul'),(134,'Ufuk Bayraktar'),(135,'Ahu Türkpençe'),(136,'Murat Serezli'),(137,'Necati Şaşmaz'),(138,'Erdal Beşikçioğlu'),(139,'Nur Fettahoğlu'),(140,'Gürkan Uygun'),(141,'Yulia Peresild'),(142,'Evgeniy Tsyganov'),(143,'Oleg Vasilkov'),(144,'Joan Blackham'),(145,'Christian Bale'),(146,'Heath Ledger'),(147,'Aaron Eckhart'),(148,'Gary Oldman'),(149,'Russell Crowe'),(150,'Joaquin Phoenix'),(151,'Connie Nielsen'),(152,'Oliver Reed'),(153,'Bob Odenkirk'),(154,'Connie Nielsen'),(155,'RZA'),(156,'Christopher Lloyd'),(157,'Keanu Reeves'),(158,'Michael Nyqvist'),(159,'Alfie Allen'),(160,'Willem Dafoe'),(161,'Scott Adkins'),(162,'Mykel Shannon Jenkins'),(163,'Marko Zaror'),(164,'Ben Cross'),(165,'Jean Reno'),(166,'Natalie Portman'),(167,'Gary Oldman'),(168,'Danny Aiello'),(169,'Al Pacino'),(170,'Michelle Pfeiffer'),(171,'Steven Bauer'),(172,'Robert Loggia'),(173,'Uma Thurman'),(174,'David Carradine'),(175,'Lucy Liu'),(176,'Michael Madsen'),(177,'Lucas Black'),(178,'Bow Wow'),(179,'Sung Kang'),(180,'Nathalie Kelley'),(181,'Jamie Foxx'),(182,'Christoph Waltz'),(183,'Leonardo DiCaprio'),(184,'Kerry Washington'),(185,'Robert De Niro'),(186,'Al Pacino'),(187,'Joe Pesci'),(188,'Harvey Keitel'),(189,'Robert De Niro'),(190,'Al Pacino'),(191,'Joe Pesci'),(192,'Harvey Keitel'),(193,'Robert De Niro'),(194,'Ray Liotta'),(195,'Joe Pesci'),(196,'Lorraine Bracco'),(197,'Leonardo DiCaprio'),(198,'Matt Damon'),(199,'Jack Nicholson'),(200,'Mark Wahlberg'),(201,'Harvey Keitel'),(202,'Tim Roth'),(203,'Michael Madsen'),(204,'Steve Buscemi'),(205,'Şener Şen'),(206,'Ugur Yücel'),(207,'Rasim Öztekin'),(208,'İsmail Hakkı'),(209,'Kevin Costner'),(210,'Sean Connery'),(211,'Robert De Niro'),(212,'Andy Garcia'),(213,'Kevin Costner'),(214,'Sean Connery'),(215,'Robert De Niro'),(216,'Andy Garcia'),(217,'Kevin Costner'),(218,'Sean Connery'),(219,'Robert De Niro'),(220,'Andy Garcia'),(221,'Kevin Costner'),(222,'Sean Connery'),(223,'Robert De Niro'),(224,'Andy Garcia'),(225,'Robert De Niro'),(226,'James Woods'),(227,'Elizabeth McGovern'),(228,'Treat Williams'),(229,'Robert De Niro'),(230,'Sharon Stone'),(231,'Joe Pesci'),(232,'James Woods'),(233,'Erdal Özyağcılar'),(234,'Vildan Atasever'),(235,'Salih Güney'),(236,'Burak Sergen'),(237,'Cem Yılmaz'),(238,'Ozan Güven'),(239,'Zafer Algöz'),(240,'Demet Evgar'),(241,'Şahan Gökbakar'),(242,'Demet Evgar'),(243,'Fırat Tanış'),(244,'İsmail Hakkı'),(245,'Tolga Çevik'),(246,'Yılmaz Erdoğan'),(247,'Demet Evgar'),(248,'İsmail Hakkı'),(249,'Tolga Çevik'),(250,'Alper Kul'),(251,'Şinasi Yılmaz'),(252,'Haldun Dormen'),(253,'Sadi Celil Cengiz'),(254,'Seda Bakan'),(255,'Rasim Öztekin'),(256,'Demet Evgar'),(257,'Aamir Khan'),(258,'R. Madhavan'),(259,'Sharman Joshi'),(260,'Kareena Kapoor'),(261,'Münir Özkul'),(262,'Kemal Sunal'),(263,'Şener Şen'),(264,'Ayşen Gruda'),(265,'Cary Elwes'),(266,'Leigh Whannell'),(267,'Danny Glover'),(268,'Monica Potter'),(269,'Keanu Reeves'),(270,'Rachel Weisz'),(271,'Shia LaBeouf'),(272,'Tilda Swinton'),(273,'Annabelle Wallis'),(274,'Ward Horton'),(275,'Alfre Woodard'),(276,'Tony Amendola'),(277,'Devon Sawa'),(278,'Ali Larter'),(279,'Kerr Smith'),(280,'Tony Todd'),(281,'Bill Skarsgård'),(282,'Jaeden Lieberher'),(283,'Finn Wolfhard'),(284,'Sophia Lillis'),(285,'Katie Featherston'),(286,'Micah Sloat'),(287,'Mark Fredrichs'),(288,'Amber Armstrong'),(289,'Keanu Reeves'),(290,'Al Pacino'),(291,'Charlize Theron'),(292,'Jeffrey Jones'),(293,'Will Smith'),(294,'Jaden Smith'),(295,'Thandie Newton'),(296,'Brian Howe'),(297,'Leonardo DiCaprio'),(298,'Tom Hanks'),(299,'Christopher Walken'),(300,'Martin Sheen'),(301,'Viggo Mortensen'),(302,'Mahershala Ali'),(303,'Linda Cardellini'),(304,'Dimiter D. Marinov'),(305,'Çetin Tekindor'),(306,'İsmail Hakkı'),(307,'Sümeyye Aydoğan'),(308,'Ali Atay'),(309,'Sandra Bullock'),(310,'Tim McGraw'),(311,'Quinton Aaron'),(312,'Jae Head'),(313,'Haldun Dormen'),(314,'Ekin Koç'),(315,'İsmail Hakkı'),(316,'Demet Evgar'),(317,'Rami Malek'),(318,'Lucy Boynton'),(319,'Gwilym Lee'),(320,'Ben Hardy'),(321,'Cillian Murphy'),(322,'Emily Blunt'),(323,'Matt Damon'),(324,'Robert Downey Jr.');
/*!40000 ALTER TABLE `oyuncular` ENABLE KEYS */;
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
