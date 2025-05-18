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
  `id` int NOT NULL,
  `ad_soyad` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oyuncular`
--

LOCK TABLES `oyuncular` WRITE;
/*!40000 ALTER TABLE `oyuncular` DISABLE KEYS */;
INSERT INTO `oyuncular` VALUES (1,'Tim Robbins'),(2,'Morgan Freeman'),(3,'William Sadler'),(4,'Clancy Brown'),(5,'Henry Fonda'),(6,'Lee J. Cobb'),(7,'Martin Balsam'),(8,'John Fiedler'),(9,'Tom Hanks'),(10,'Robin Wright'),(11,'Gary Sinise'),(12,'Sally Field'),(13,'Matthew McConaughey'),(14,'Anne Hathaway'),(15,'Jessica Chastain'),(16,'Michael Caine'),(17,'James Stewart'),(18,'Donna Reed'),(19,'Lionel Barrymore'),(20,'Thomas Mitchell'),(21,'Jodie Foster'),(22,'Anthony Hopkins'),(23,'Scott Glenn'),(24,'Ted Levine'),(25,'Adrien Brody'),(26,'Thomas Kretschmann'),(27,'Frank Finlay'),(28,'Maureen Lipman'),(29,'Çetin Tekindor'),(30,'Fikret Kuşkan'),(31,'Tuba Büyüküstün'),(32,'Barış Bağcı'),(33,'Viggo Mortensen'),(34,'Mahershala Ali'),(35,'Linda Cardellini'),(36,'Sebastian Maniscalco'),(37,'Roberto Benigni'),(38,'Nicoletta Braschi'),(39,'Giorgio Cantarini'),(40,'Giustino Durano'),(41,'Anthony Perkins'),(42,'Janet Leigh'),(43,'Vera Miles'),(44,'John Gavin'),(45,'Brad Pitt'),(46,'Morgan Freeman'),(47,'Gwyneth Paltrow'),(48,'Kevin Spacey'),(49,'Kevin Spacey'),(50,'Gabriel Byrne'),(51,'Benicio del Toro'),(52,'Stephen Baldwin'),(53,'Guy Pearce'),(54,'Carrie-Anne Moss'),(55,'Joe Pantoliano'),(56,'Mark Boone Junior'),(57,'Choi Min-sik'),(58,'Yoo Ji-tae'),(59,'Kang Hye-jung'),(60,'Ji Dae-han'),(61,'Christian Bale'),(62,'Hugh Jackman'),(63,'Scarlett Johansson'),(64,'Michael Caine'),(65,'Vera Farmiga'),(66,'Peter Sarsgaard'),(67,'Isabelle Fuhrman'),(68,'CCH Pounder'),(69,'Leonardo DiCaprio'),(70,'Mark Ruffalo'),(71,'Ben Kingsley'),(72,'Michelle Williams'),(73,'Ewan McGregor'),(74,'Natalie Portman'),(75,'Hayden Christensen'),(76,'Ian McDiarmid'),(77,'Leonardo DiCaprio'),(78,'Joseph Gordon-Levitt'),(79,'Ellen Page'),(80,'Tom Hardy'),(81,'Keanu Reeves'),(82,'Laurence Fishburne'),(83,'Carrie-Anne Moss'),(84,'Hugo Weaving'),(85,'Arnold Schwarzenegger'),(86,'Linda Hamilton'),(87,'Edward Furlong'),(88,'Robert Patrick'),(89,'Michael J. Fox'),(90,'Christopher Lloyd'),(91,'Lea Thompson'),(92,'Crispin Glover'),(93,'Cem Yılmaz'),(94,'Ozan Güven'),(95,'Özkan Uğur'),(96,'Özge Özberk'),(97,'Natalie Portman'),(98,'Hugo Weaving'),(99,'Stephen Rea'),(100,'John Hurt'),(101,'Timothée Chalamet'),(102,'Rebecca Ferguson'),(103,'Oscar Isaac'),(104,'Zendaya'),(105,'Malcolm McDowell'),(106,'Patrick Magee'),(107,'Michael Bates'),(108,'Warren Clarke'),(109,'Tom Hanks'),(110,'Matt Damon'),(111,'Tom Sizemore'),(112,'Edward Burns'),(113,'Brad Pitt'),(114,'Christoph Waltz'),(115,'Mélanie Laurent'),(116,'Michael Fassbender'),(117,'Peter O\'Toole'),(118,'Alec Guinness'),(119,'Anthony Quinn'),(120,'Jack Hawkins'),(121,'George MacKay'),(122,'Dean-Charles Chapman'),(123,'Mark Strong'),(124,'Benedict Cumberbatch'),(125,'Çağlar Ertuğrul'),(126,'Ufuk Bayraktar'),(127,'Serkan Çayoğlu'),(128,'Deniz Celiloğlu'),(129,'Necati Şaşmaz'),(130,'Erdal Beşikçioğlu'),(131,'Yıldıray Şahinler'),(132,'İsmail Hacıoğlu'),(133,'Yuliya Peresild'),(134,'Evgeny Tsyganov'),(135,'Katerina Shpitsa'),(136,'Aleksandr Metyolkin'),(137,'Christian Bale'),(138,'Heath Ledger'),(139,'Aaron Eckhart'),(140,'Michael Caine'),(141,'Russell Crowe'),(142,'Joaquin Phoenix'),(143,'Connie Nielsen'),(144,'Richard Harris'),(145,'Bob Odenkirk'),(146,'Aleksey Serebryakov'),(147,'Connie Nielsen'),(148,'RZA'),(149,'Keanu Reeves'),(150,'Michael Nyqvist'),(151,'Alfie Allen'),(152,'Willem Dafoe'),(153,'Scott Adkins'),(154,'Mykel Shannon Jenkins'),(155,'Mark Ivanir'),(156,'Ben Cross'),(157,'Jean Reno'),(158,'Gary Oldman'),(159,'Natalie Portman'),(160,'Danny Aiello'),(161,'Al Pacino'),(162,'Michelle Pfeiffer'),(163,'Steven Bauer'),(164,'Mary Elizabeth Mastrantonio'),(165,'Uma Thurman'),(166,'Lucy Liu'),(167,'Vivica A. Fox'),(168,'Daryl Hannah'),(169,'Lucas Black'),(170,'Bow Wow'),(171,'Nathalie Kelley'),(172,'Sung Kang'),(173,'Jamie Foxx'),(174,'Christoph Waltz'),(175,'Leonardo DiCaprio'),(176,'Kerry Washington'),(177,'Robert De Niro'),(178,'Al Pacino'),(179,'Joe Pesci'),(180,'Harvey Keitel'),(181,'Robert De Niro'),(182,'Ray Liotta'),(183,'Joe Pesci'),(184,'Lorraine Bracco'),(185,'Leonardo DiCaprio'),(186,'Matt Damon'),(187,'Jack Nicholson'),(188,'Mark Wahlberg'),(189,'Harvey Keitel'),(190,'Tim Roth'),(191,'Michael Madsen'),(192,'Steve Buscemi'),(193,'Şener Şen'),(194,'Uğur Yücel'),(195,'Sermin Hürmeriç'),(196,'Rutkay Aziz'),(197,'Kevin Costner'),(198,'Sean Connery'),(199,'Robert De Niro'),(200,'Andy Garcia'),(201,'Robert De Niro'),(202,'James Woods'),(203,'Elizabeth McGovern'),(204,'Joe Pesci'),(205,'Robert De Niro'),(206,'Sharon Stone'),(207,'Joe Pesci'),(208,'James Woods'),(209,'Ahmet Kural'),(210,'Murat Cemcir'),(211,'Rasim Öztekin'),(212,'Mert Fırat'),(213,'Cem Yılmaz'),(214,'Özkan Uğur'),(215,'Zafer Algöz'),(216,'Özge Özberk'),(217,'Şahan Gökbakar'),(218,'Ahu Türkpençe'),(219,'Rasim Öztekin'),(220,'Tamer Karadağlı'),(221,'Yılmaz Erdoğan'),(222,'Tolga Çevik'),(223,'Demet Akbağ'),(224,'Altan Erkekli'),(225,'Togan Gökbakar'),(226,'Ahmet Kural'),(227,'Murat Cemcir'),(228,'Tülin Özen'),(229,'Murat Tokgöz'),(230,'Tuba Ünsal'),(231,'Barış Kılıç'),(232,'Caner Özyurtlu'),(233,'Aamir Khan'),(234,'R. Madhavan'),(235,'Sharman Joshi'),(236,'Kareena Kapoor'),(237,'Münir Özkul'),(238,'Tarık Akan'),(239,'Adile Naşit'),(240,'Kemal Sunal'),(241,'Cary Elwes'),(242,'Leigh Whannell'),(243,'Danny Glover'),(244,'Monica Potter'),(245,'Keanu Reeves'),(246,'Rachel Weisz'),(247,'Shia LaBeouf'),(248,'Tilda Swinton'),(249,'Annabelle Wallis'),(250,'Ward Horton'),(251,'Tony Amendola'),(252,'Alfre Woodard'),(253,'Devon Sawa'),(254,'Ali Larter'),(255,'Kerr Smith'),(256,'Seann William Scott'),(257,'Bill Skarsgård'),(258,'Jaeden Martell'),(259,'Finn Wolfhard'),(260,'Sophia Lillis'),(261,'Katie Featherston'),(262,'Micah Sloat'),(263,'Mark Fredrichs'),(264,'Amber Armstrong'),(265,'Keanu Reeves'),(266,'Al Pacino'),(267,'Charlize Theron'),(268,'Jeffrey Jones'),(269,'Will Smith'),(270,'Jaden Smith'),(271,'Thandie Newton'),(272,'Brian Howe'),(273,'Leonardo DiCaprio'),(274,'Tom Hanks'),(275,'Christopher Walken'),(276,'Martin Sheen'),(277,'İsmail Hacıoğlu'),(278,'Lee Kyung-jin'),(279,'Çetin Tekindor'),(280,'Emre Üçel'),(281,'Sandra Bullock'),(282,'Tim McGraw'),(283,'Quinton Aaron'),(284,'Jae Head'),(285,'Hayat Van Eck'),(286,'Birol Ünel'),(287,'Yetkin Dikinciler'),(288,'Funda Eryiğit'),(289,'Rami Malek'),(290,'Lucy Boynton'),(291,'Gwilym Lee'),(292,'Ben Hardy'),(293,'Cillian Murphy'),(294,'Emily Blunt'),(295,'Matt Damon');
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

-- Dump completed on 2025-05-19  1:17:36
