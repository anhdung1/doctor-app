-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: doctor
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'dungvl76','$2a$12$D7NuoJgPr0N8yX.WE95QUOd9gwXMgt9kYmOt/.rCl7fiNJJAnAufC',1),(3,'luuvandung','$2a$10$Jx.roppfk.rs9ct313IqLuuOcriuz6FdEfuQwTt2loE3eJvhF2zQu',2),(8,'dungvl75','$2a$12$D7NuoJgPr0N8yX.WE95QUOd9gwXMgt9kYmOt/.rCl7fiNJJAnAufC',2),(14,'dung','$2a$12$D7NuoJgPr0N8yX.WE95QUOd9gwXMgt9kYmOt/.rCl7fiNJJAnAufC',3),(15,'dung1','$12$D7NuoJgPr0N8yX.WE95QUOd9gwXMgt9kYmOt/.rCl7fiNJJAnAufC',3),(16,'dung2','$2a$12$D7NuoJgPr0N8yX.WE95QUOd9gwXMgt9kYmOt/.rCl7fiNJJAnAufC',3),(17,'dung3','$12$D7NuoJgPr0N8yX.WE95QUOd9gwXMgt9kYmOt/.rCl7fiNJJAnAufC',3),(18,'dung4','$12$D7NuoJgPr0N8yX.WE95QUOd9gwXMgt9kYmOt/.rCl7fiNJJAnAufC',3),(19,'dung5','$12$D7NuoJgPr0N8yX.WE95QUOd9gwXMgt9kYmOt/.rCl7fiNJJAnAufC',3),(20,'dung6','$12$D7NuoJgPr0N8yX.WE95QUOd9gwXMgt9kYmOt/.rCl7fiNJJAnAufC',3),(21,'dung7','$12$D7NuoJgPr0N8yX.WE95QUOd9gwXMgt9kYmOt/.rCl7fiNJJAnAufC',3),(28,'123456','$2a$10$Vxay5mK9To8W5yB4Kk2yqe2ZzTo99uXhIhn3Iz1riCdJ6Fm4CHcP6',2),(36,'111111','$2a$10$RLON2aD58vgi7rABzBa6mudkxH6iSQjUEpkVsGjhSai.V.GxK7kRG',2),(37,'1111111','$2a$10$5QwXMgzB61GTlVHT12GY/uhZyHVMmAJASSYWy/y/ehgik8fbcHYQq',2),(38,'anhyeuem','$2a$10$xN6GjEiG1RVCHKND.kKl8OKoFhgHHVNNj/m5VJVjHZH30U/NKEK4.',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-15 12:07:26
