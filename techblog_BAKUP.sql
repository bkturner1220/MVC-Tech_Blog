-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: techblog_db
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `blog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
INSERT INTO `blog` VALUES (1,'ASP.NET Core 2.1.0-preview1: Introducing compatibility version in MVC','This post was written by Ryan Nowak In 2.1 we\'re adding a feature to address a long-standing problem for maintaining MVC - how do we make improvements to framework code without making it too hard for developers to upgrade to the latest version?','2022-01-08 23:10:56',3),(2,'Testing ASP.NET Core MVC web apps in-memory','This post was written and submitted by Javier Calvarro Nelson, a developer on the ASP.NET Core MVC team Testing is an important part of the development process of any application.','2022-01-08 23:10:56',2),(3,'ASP.NET MVC 5.2.3, Web Pages 3.2.3 and Web API 5.2.3 Release','It\'s been about two months since we released the first beta of ASP.NET 5, and today we happy to announce that ASP.NET 5 Beta2 is available.','2022-01-08 23:10:56',1);
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `user_id` int NOT NULL,
  `blog_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `blog_id` (`blog_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'This is comment text #1','2022-01-08 23:10:56',1,2,'2022-01-08 23:10:56','2022-01-08 23:10:56'),(2,'This is comment text #2','2022-01-08 23:10:56',2,2,'2022-01-08 23:10:56','2022-01-08 23:10:56'),(3,'This is comment text #3','2022-01-08 23:10:56',3,2,'2022-01-08 23:10:56','2022-01-08 23:10:56'),(4,'waqd','2022-01-08 23:23:58',4,2,'2022-01-08 23:23:58','2022-01-08 23:23:58'),(5,'test','2022-01-08 23:42:35',4,1,'2022-01-08 23:42:35','2022-01-08 23:42:35'),(6,'my comment from Brian Turner','2022-01-09 02:08:44',4,1,'2022-01-09 02:08:44','2022-01-09 02:08:44');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `sid` varchar(36) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` text,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('-Kh6-L71BDG5oAefWyo0FgjPHtOSiL3m','2022-01-10 02:12:11','{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}','2022-01-09 02:06:02','2022-01-09 02:12:11'),('5ArHZc5yeG1ltF1jZaV638ETiwuAQVZ8','2022-01-10 23:31:28','{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"}}','2022-01-09 23:31:26','2022-01-09 23:31:28'),('QPoMUA1sPEwWIzfw9TLXFLQTaDoe_YmW','2022-01-10 02:12:04','{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"user_id\":4,\"logged_in\":true}','2022-01-09 02:09:31','2022-01-09 02:12:04');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Daniel Roth','droth1222@gmail.com','$2b$10$GyFBDhlk2MwWc/IUqslxtuBJSLj8WFqtdRuvgq6sPSoV5zLAnuRG2'),(2,'Jeffrey Fritz','jff333rtz1100@yahoo.com','$2b$10$LVZX4f8DGkgif8UF/dQ4t.rYySGEcwK/Wd1iUSvFBdr/t4JebhrP6'),(3,'Yishai G_','yis22haig@telecom.com','$2b$10$hGiGWScJb8LrfkoUsw6.wOIAiDeh60RDPk9lmRPKpigJNsRFs9kwC'),(4,'Brian Turner','bturner@texascdlprep.com','$2b$10$ND9tYuU2E9gAwC8UMqmBsepubmJy54obgflfe10QPItQMCbR6vVyi');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-09 17:44:23
