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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `doctor_id` bigint NOT NULL,
  `appointment_time` time NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `appointment_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1750 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1543,14,'16:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1544,14,'15:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1545,14,'14:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1546,14,'11:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1547,14,'10:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1548,14,'09:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1549,15,'16:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1550,15,'15:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1551,15,'14:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1552,15,'11:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1553,15,'10:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1554,15,'09:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1555,16,'16:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1556,16,'15:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1557,16,'14:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1558,16,'11:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1559,16,'10:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1560,16,'09:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1561,17,'16:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1562,17,'15:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1563,17,'14:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1564,17,'11:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1565,17,'10:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1566,17,'09:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1567,18,'16:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1568,18,'15:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1569,18,'14:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1570,18,'11:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1571,18,'10:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1572,18,'09:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1573,19,'16:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1574,19,'15:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1575,19,'14:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1576,19,'11:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1577,19,'10:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1578,19,'09:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1579,20,'16:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1580,20,'15:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1581,20,'14:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1582,20,'11:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1583,20,'10:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1584,20,'09:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1585,21,'16:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1586,21,'15:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1587,21,'14:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1588,21,'11:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1589,21,'10:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1590,21,'09:00:00',NULL,'2024-11-12 03:51:20','2024-11-15'),(1606,14,'16:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1607,14,'15:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1608,14,'14:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1609,14,'11:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1610,14,'10:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1611,14,'09:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1612,15,'16:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1613,15,'15:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1614,15,'14:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1615,15,'11:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1616,15,'10:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1617,15,'09:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1618,16,'16:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1619,16,'15:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1620,16,'14:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1621,16,'11:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1622,16,'10:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1623,16,'09:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1624,17,'16:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1625,17,'15:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1626,17,'14:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1627,17,'11:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1628,17,'10:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1629,17,'09:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1630,18,'16:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1631,18,'15:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1632,18,'14:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1633,18,'11:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1634,18,'10:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1635,18,'09:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1636,19,'16:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1637,19,'15:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1638,19,'14:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1639,19,'11:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1640,19,'10:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1641,19,'09:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1642,20,'16:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1643,20,'15:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1644,20,'14:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1645,20,'11:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1646,20,'10:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1647,20,'09:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1648,21,'16:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1649,21,'15:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1650,21,'14:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1651,21,'11:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1652,21,'10:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1653,21,'09:00:00',NULL,'2024-11-13 03:55:50','2024-11-16'),(1654,14,'16:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1655,14,'15:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1656,14,'14:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1657,14,'11:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1658,14,'10:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1659,14,'09:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1660,15,'16:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1661,15,'15:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1662,15,'14:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1663,15,'11:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1664,15,'10:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1665,15,'09:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1666,16,'16:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1667,16,'15:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1668,16,'14:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1669,16,'11:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1670,16,'10:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1671,16,'09:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1672,17,'16:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1673,17,'15:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1674,17,'14:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1675,17,'11:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1676,17,'10:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1677,17,'09:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1678,18,'16:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1679,18,'15:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1680,18,'14:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1681,18,'11:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1682,18,'10:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1683,18,'09:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1684,19,'16:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1685,19,'15:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1686,19,'14:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1687,19,'11:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1688,19,'10:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1689,19,'09:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1690,20,'16:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1691,20,'15:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1692,20,'14:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1693,20,'11:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1694,20,'10:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1695,20,'09:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1696,21,'16:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1697,21,'15:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1698,21,'14:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1699,21,'11:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1700,21,'10:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1701,21,'09:00:00',NULL,'2024-11-13 17:00:00','2024-11-17'),(1702,14,'16:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1703,14,'15:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1704,14,'14:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1705,14,'11:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1706,14,'10:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1707,14,'09:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1708,15,'16:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1709,15,'15:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1710,15,'14:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1711,15,'11:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1712,15,'10:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1713,15,'09:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1714,16,'16:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1715,16,'15:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1716,16,'14:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1717,16,'11:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1718,16,'10:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1719,16,'09:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1720,17,'16:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1721,17,'15:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1722,17,'14:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1723,17,'11:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1724,17,'10:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1725,17,'09:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1726,18,'16:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1727,18,'15:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1728,18,'14:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1729,18,'11:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1730,18,'10:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1731,18,'09:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1732,19,'16:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1733,19,'15:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1734,19,'14:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1735,19,'11:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1736,19,'10:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1737,19,'09:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1738,20,'16:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1739,20,'15:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1740,20,'14:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1741,20,'11:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1742,20,'10:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1743,20,'09:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1744,21,'16:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1745,21,'15:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1746,21,'14:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1747,21,'11:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1748,21,'10:00:00',NULL,'2024-11-14 17:00:00','2024-11-18'),(1749,21,'09:00:00',NULL,'2024-11-14 17:00:00','2024-11-18');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-15 12:07:27