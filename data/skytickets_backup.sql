-- MySQL dump 10.13  Distrib 9.1.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: skytickets
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `AccountId` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address` text,
  `Img` varchar(255) DEFAULT NULL,
  `Dob` date DEFAULT NULL,
  `Status` tinyint DEFAULT '1',
  `RoleId` int DEFAULT NULL,
  PRIMARY KEY (`AccountId`),
  UNIQUE KEY `Email` (`Email`),
  KEY `RoleId` (`RoleId`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'Admin User','admin@example.com','$2a$12$h849FSoyKU2DY1AQvIIruOo6TFHpt1oa6ls.dSRReu0OsHvhczYea','0123456789','123 Admin St','1743298500035_1743288565386_news_bamboo_2.jpg','1990-01-01',1,1),(2,'Member User','member@example.com','$2a$12$h849FSoyKU2DY1AQvIIruOo6TFHpt1oa6ls.dSRReu0OsHvhczYea','0987654321','456 Member St','defaultlogo.jpg','1995-05-05',1,2),(3,'NGUYỄN VĂN QUÝ','quynvhe18627203@fpt.edu.vn','$2a$12$FjIWTjh3KEbouFLPjOYJnuBw3qJu5n2b/rvkc4sEFZPjvnlSp9DZ6','0946217801','','1745932839475_33.jpg','2025-04-11',1,2),(4,'Nguyen Van Y','admiiin@example.com','12345678','0946217801','THPT BÌNH SƠN','1743299224739_1743183390993_sieu-pham-hoat-hinh-trung-quoc-na-tra-ma-dong-giang-the-chinh-thuc-do-bo-phong-chieu-viet-nam-182897.jpeg','2004-05-11',1,2),(5,'Sky Ticket','skyticket.work@gmail.com','123456','0946217801','THPT BÌNH SƠN','1749282832134_2.jpg','2025-06-04',1,1),(7,'Quý Quý','quyhslc111@gmail.com','123456',NULL,NULL,'defaultlogo.jpg',NULL,1,2),(8,'NGUYỄN VĂN QUÝ','quyhslc11@gmail.com','$2a$12$.wayMbKC8A5g6.KoyrUQPedIbDg7YhJdpujMqeixTrOU.tmoekW5W','0946217805','','1749388540313_488758483_582244584873548_379893282750725779_n.jpg','2025-06-04',1,2),(9,'Quy Quy','quynvhe186703@fpt.edu.vn','123456','0989149536','','1749398020896_1.jpg','2025-06-07',1,2),(10,'Quy Quy','quy905844@gmail.com','123456',NULL,NULL,'defaultlogo.jpg',NULL,1,1);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airlines`
--

DROP TABLE IF EXISTS `airlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airlines` (
  `AirlineId` int NOT NULL AUTO_INCREMENT,
  `AirlineName` varchar(100) NOT NULL,
  `Image` varchar(255) DEFAULT NULL,
  `Information` text,
  `Status` tinyint DEFAULT '1',
  `NumberOfSeatsOnVipRow` int DEFAULT NULL,
  `NumberOfSeatsOnVipColumn` int DEFAULT NULL,
  `NumberOfSeatsOnEconomyRow` int DEFAULT NULL,
  `NumberOfSeatsOnEconomyColumn` int DEFAULT NULL,
  PRIMARY KEY (`AirlineId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airlines`
--

LOCK TABLES `airlines` WRITE;
/*!40000 ALTER TABLE `airlines` DISABLE KEYS */;
INSERT INTO `airlines` VALUES (1,'Airbus A320C1','news_bamboo_1.jpg','Hãng hàng không tư nhân đầu tiên tại Việt Nam.',1,4,5,6,7),(2,'Airbus A320C2','news_bamboo_1.jpg','Hãng hàng không quốc gia Việt Nam với dịch vụ chất lượng cao.',1,4,5,6,7),(3,'Airbus A320C3','news_bamboo_1.jpg','Hãng hàng không tư nhân đầu tiên tại Việt Nam.',1,4,5,6,7),(4,'Airbus A320C4','news_bamboo_1.jpg','Hãng hàng không quốc gia Việt Nam với dịch vụ chất lượng cao.',1,4,5,6,7),(5,'Airbus A320C5','news_bamboo_1.jpg','May Bay',1,4,8,8,12),(6,'Airbus A320C6','news_bamboo_1.jpg','maybay',1,4,8,5,12),(7,'Airbus A350B17','1743288704618_news_bamboo_3.jpg','Tốt',1,4,5,5,15);
/*!40000 ALTER TABLE `airlines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `AirportId` int NOT NULL AUTO_INCREMENT,
  `AirportName` varchar(100) NOT NULL,
  `LocationId` int NOT NULL,
  `Status` tinyint DEFAULT '1',
  PRIMARY KEY (`AirportId`),
  KEY `LocationId` (`LocationId`),
  CONSTRAINT `airports_ibfk_1` FOREIGN KEY (`LocationId`) REFERENCES `locations` (`LocationId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES (1,'Nội Bài International Airport',1,1),(2,'Tân Sơn Nhất International Airport',2,1),(3,'Narita International Airport',3,1),(4,'Kansai International Airport',4,0),(5,'Incheon International Airport',5,1),(6,'Gimhae International Airport',6,1),(7,'Suvarnabhumi Airport',7,1),(8,'Changi Airport',8,1),(9,'Kuala Lumpur International Airport',9,1),(10,'Beijing Capital International Airport',10,1),(11,'Chhatrapati Shivaji International Airport',11,1),(12,'Sydney Kingsford Smith Airport',12,1),(13,'John F. Kennedy International Airport',13,1),(14,'Heathrow Airport',14,1),(15,'Charles de Gaulle Airport',15,0),(16,'ABC International Airport',3,1);
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `baggages`
--

DROP TABLE IF EXISTS `baggages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `baggages` (
  `BaggageId` int NOT NULL AUTO_INCREMENT,
  `Weight` decimal(5,2) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `AirlineId` int DEFAULT NULL,
  `Status` int DEFAULT '1',
  PRIMARY KEY (`BaggageId`),
  KEY `AirlineId` (`AirlineId`),
  CONSTRAINT `baggages_ibfk_1` FOREIGN KEY (`AirlineId`) REFERENCES `airlines` (`AirlineId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baggages`
--

LOCK TABLES `baggages` WRITE;
/*!40000 ALTER TABLE `baggages` DISABLE KEYS */;
INSERT INTO `baggages` VALUES (1,15.50,300000.00,1,1),(2,2.30,50000.00,2,1),(3,10.00,200000.00,3,1),(4,5.20,150000.00,4,1),(5,7.80,180000.00,1,1),(6,10.00,300000.00,6,1),(7,99.00,9999.00,1,1);
/*!40000 ALTER TABLE `baggages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `BookingId` int NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) DEFAULT NULL,
  `ContactName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ContactPhone` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ContactEmail` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `TotalPrice` decimal(10,2) NOT NULL,
  `BookingDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `Status` varchar(50) DEFAULT NULL,
  `AccountId` int DEFAULT NULL,
  PRIMARY KEY (`BookingId`),
  KEY `AccountId` (`AccountId`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `accounts` (`AccountId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,'0CJ91O04','Admin User','0123456789','admin@example.com',2300000.00,'2025-03-30 06:49:28','1',1),(2,'NY3AENLR','Admin User','0123456789','admin@example.com',550000.00,'2025-03-30 08:06:16','5',1),(3,'8EMZM4AR','Admin User','0123456789','quyhslc11@gmail.com',2000000.00,'2025-03-30 08:30:47','5',1),(4,'TP3E9KA9','NGUYỄN VĂN QUÝ','0946217801','quyhslc11@gmail.com',2300000.00,'2025-06-07 14:58:11','1',NULL),(5,'I5RQL1UT','NGUYỄN VĂN QUÝ','0946217801','quyhslc11@gmail.com',2300000.00,'2025-06-07 14:59:52','1',NULL),(6,'5DY1EMGK','Sky Ticket','0946217801','skyticket.work@gmail.com',2300000.00,'2025-06-07 15:02:45','5',5),(7,'IQZTDCGX','NGUYỄN VĂN QUÝ','0946217801','quyhslc11@gmail.com',2300000.00,'2025-06-07 16:20:14','1',NULL),(8,'Z0B7Y0YX','Sky Ticket','0946217801','quyhslc11@gmail.com',2300000.00,'2025-06-07 17:06:03','5',5),(9,'5SDQI55K','Sky Ticket','0946217801','skyticket.work@gmail.com',2300000.00,'2025-06-08 12:50:50','4',5),(10,'HJQIO0IL','Sky Ticket','0946217801','skyticket.work@gmail.com',2300000.00,'2025-06-08 12:51:48','4',5),(11,'HY10U1LL','Sky Ticket','0946217801','skyticket.work@gmail.com',450000.00,'2025-06-08 13:09:37','4',5),(12,'EBYHAK75','Sky Ticket','0946217801','skyticket.work@gmail.com',2300000.00,'2025-06-08 14:19:28','4',5),(13,'OFE431FT','Sky Ticket','0946217801','skyticket.work@gmail.com',2300000.00,'2025-06-08 15:06:17','4',5),(14,'776NYP9S','NGUYỄN VĂN QUÝ','0946217801','admin@example.com',2300000.00,'2025-06-08 15:48:26','1',NULL),(15,'47RK98L8','Sky Ticket','0946217801','skyticket.work@gmail.com',2300000.00,'2025-06-08 17:33:37','3',5),(16,'BNSVFUFJ','Sky Ticket','0946217801','skyticket.work@gmail.com',450000.00,'2025-06-08 18:10:04','5',5),(17,'BA2DGA2N','Sky Ticket','0946217801','skyticket.work@gmail.com',200000.00,'2025-06-08 18:12:48','1',5),(18,'1YGYBO6V','Sky Ticket','0946217801','skyticket.work@gmail.com',200000.00,'2025-06-08 18:17:27','1',5),(19,'6EZCCKI0','Sky Ticket','0946217801','skyticket.work@gmail.com',2300000.00,'2025-06-08 18:23:36','2',5),(20,'Q1ZENNON','Sky Ticket','0946217801','skyticket.work@gmail.com',2300000.00,'2025-06-08 19:14:17','4',5),(21,'0UYYBC0O','Sky Ticket','0946217801','skyticket.work@gmail.com',2300000.00,'2025-06-08 19:16:54','2',5),(22,'RQKR6CF5','Quy Quy','0989149536','quynvhe186703@fpt.edu.vn',450000.00,'2025-06-09 23:12:59','1',9),(23,'J95HC6BL','Sky Ticket','0946217801','skyticket.work@gmail.com',2180000.00,'2025-06-10 13:09:04','1',5),(24,'93KR1SW1','Quy Quy','null','quy905844@gmail.com',2009999.00,'2025-06-10 13:10:03','4',10);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_update_refund_status` AFTER UPDATE ON `bookings` FOR EACH ROW BEGIN
    IF NEW.Status IN (2, 6) AND (OLD.Status IS NULL OR OLD.Status NOT IN (2, 6)) THEN
        UPDATE Refund r
        JOIN Tickets t ON r.TicketId = t.TicketId
        JOIN Bookings b ON t.BookingId = b.BookingId
        SET r.Status = 3
        WHERE t.BookingId = NEW.BookingId
        AND r.Status != 3;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_update_refund_on_approval` AFTER UPDATE ON `bookings` FOR EACH ROW BEGIN
    IF NEW.Status IN (5) AND (OLD.Status IS NULL OR OLD.Status NOT IN (5)) THEN
        UPDATE Refund r
        JOIN Tickets t ON r.TicketId = t.TicketId
        JOIN Bookings b ON t.BookingId = b.BookingId
        SET r.Status = 2
        WHERE t.BookingId = NEW.BookingId
        AND r.Status != 2;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `CountryId` int NOT NULL AUTO_INCREMENT,
  `CountryName` varchar(100) NOT NULL,
  `Status` tinyint DEFAULT '1',
  PRIMARY KEY (`CountryId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Viet Nam',1),(2,'Nhat Ban',1),(3,'Han Quoc',1),(4,'Thai Lan',1),(5,'Singapore',1),(6,'Malaysia',1),(7,'Trung Quoc',1),(8,'An Do',1),(9,'Uc',1),(10,'My',1),(11,'Anh',1),(12,'Phap',1),(13,'Đuc',1),(14,'Canada',1),(15,'Indonesia',1),(16,'Ai Cap',1);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `DiscountId` int NOT NULL AUTO_INCREMENT,
  `Percent` decimal(5,2) NOT NULL,
  `AccountId` int DEFAULT NULL,
  `Points` int DEFAULT '0',
  PRIMARY KEY (`DiscountId`),
  KEY `AccountId` (`AccountId`),
  CONSTRAINT `discounts_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `accounts` (`AccountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `FlightId` int NOT NULL AUTO_INCREMENT,
  `ArrivalTime` datetime DEFAULT NULL,
  `DepartureTime` datetime DEFAULT NULL,
  `ArrivalAirportId` int NOT NULL,
  `DepartureAirportId` int NOT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `AirlineId` int DEFAULT NULL,
  `ClassVipPrice` decimal(10,2) DEFAULT NULL,
  `ClassEconomyPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`FlightId`),
  KEY `AirlineId` (`AirlineId`),
  KEY `ArrivalAirportId` (`ArrivalAirportId`),
  KEY `DepartureAirportId` (`DepartureAirportId`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`AirlineId`) REFERENCES `airlines` (`AirlineId`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`ArrivalAirportId`) REFERENCES `airports` (`AirportId`),
  CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`DepartureAirportId`) REFERENCES `airports` (`AirportId`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'2025-06-11 10:00:00','2025-06-11 07:30:00',2,1,'1',1,2000000.00,1000000.00),(2,'2025-03-31 15:00:00','2025-03-31 12:00:00',3,2,'1',2,2500000.00,1200000.00),(3,'2025-03-31 18:30:00','2025-03-31 16:00:00',4,3,'1',3,2800000.00,1500000.00),(4,'2025-03-31 08:45:00','2025-03-31 06:20:00',2,4,'1',4,3000000.00,17000000.00),(5,'2025-03-31 12:15:00','2025-03-31 09:45:00',1,4,'1',2,2200000.00,11000000.00),(6,'2025-03-31 17:00:00','2025-03-31 14:30:00',3,1,'1',1,2600000.00,13000000.00),(7,'2025-03-31 22:10:00','2025-03-31 19:45:00',5,1,'1',2,2900000.00,1400000.00),(8,'2025-03-31 05:30:00','2025-03-31 03:00:00',5,1,'1',3,3100000.00,1800000.00),(9,'2025-03-31 09:20:00','2025-03-31 06:50:00',5,1,'1',4,2400000.00,1150000.00),(10,'2025-03-31 14:00:00','2025-03-31 11:30:00',7,2,'1',1,2300000.00,1150000.00),(11,'2025-03-31 19:00:00','2025-03-31 16:15:00',8,3,'1',2,2700000.00,1350000.00),(12,'2025-03-31 09:30:00','2025-03-31 07:00:00',9,5,'1',3,3000000.00,1500000.00),(13,'2025-03-31 15:45:00','2025-03-31 13:00:00',10,4,'1',4,3200000.00,1600000.00),(14,'2025-03-31 21:00:00','2025-03-31 18:30:00',11,6,'1',1,3500000.00,1750000.00),(15,'2025-03-31 06:00:00','2025-03-31 03:30:00',12,7,'1',2,4000000.00,200000.00),(16,'2025-03-31 23:30:00','2025-03-31 21:00:00',5,1,'1',2,2900000.00,1400000.00),(17,'2025-03-31 01:45:00','2025-03-31 23:15:00',5,1,'1',3,3100000.00,1800000.00),(18,'2025-03-31 03:50:00','2025-03-31 01:20:00',5,1,'1',4,2400000.00,1150000.00),(19,'2025-03-31 11:00:00','2025-03-31 08:30:00',5,1,'1',2,2900000.00,1400000.00),(20,'2025-03-31 13:15:00','2025-03-31 10:45:00',5,1,'1',3,3100000.00,1800000.00),(21,'2025-03-31 15:30:00','2025-03-31 13:00:00',5,1,'1',4,2400000.00,1150000.00),(22,'2025-03-31 11:00:00','2025-03-31 09:30:00',1,5,'1',1,2900000.00,1400000.00),(23,'2025-03-31 14:00:00','2025-03-31 12:30:00',1,5,'1',2,3100000.00,1800000.00),(24,'2025-03-31 17:00:00','2025-03-31 15:30:00',1,5,'1',3,2400000.00,1150000.00),(25,'2025-03-31 20:00:00','2025-03-31 18:30:00',1,5,'1',4,2900000.00,1400000.00),(26,'2025-03-31 23:00:00','2025-03-31 21:30:00',1,5,'1',1,3100000.00,1800000.00),(27,'2025-03-31 09:00:00','2025-03-31 07:30:00',1,5,'1',1,2400000.00,1150000.00),(28,'2025-06-09 11:08:00','2025-06-09 10:05:00',2,1,'1',6,150000.00,250000.00),(29,'2025-06-09 10:38:00','2025-06-09 08:38:00',2,1,'1',7,200000.00,100000.00);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `LocationId` int NOT NULL AUTO_INCREMENT,
  `LocationName` varchar(100) NOT NULL,
  `CountryId` int NOT NULL,
  `Status` tinyint DEFAULT '1',
  PRIMARY KEY (`LocationId`),
  KEY `CountryId` (`CountryId`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`CountryId`) REFERENCES `countries` (`CountryId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Ha Noi',1,1),(2,'Ho Chi Minh',1,1),(3,'Tokyo',2,1),(4,'Osaka',2,1),(5,'Seoul',3,1),(6,'Busan',3,1),(7,'Bangkok',4,1),(8,'Singapore',5,1),(9,'Kuala Lumpur',6,1),(10,'Bac Kinh',7,1),(11,'Mumbai',8,1),(12,'Sydney',9,1),(13,'New York',10,1),(14,'London',11,1),(15,'Paris',12,1),(16,'Hue',1,1);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `NewId` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Img` varchar(255) DEFAULT NULL,
  `Content` text,
  `AirlineId` int DEFAULT NULL,
  `Status` tinyint DEFAULT '1',
  PRIMARY KEY (`NewId`),
  KEY `AirlineId` (`AirlineId`),
  CONSTRAINT `news_ibfk_1` FOREIGN KEY (`AirlineId`) REFERENCES `airlines` (`AirlineId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo','img/news_bamboo_1.jpg','<p>Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo</p><p style=\"text-align:justify;\"><i>Bằng thủ đoạn mạo danh Cục Hàng không Việt Nam và thông báo chuyến bay bị hủy, các đối tượng lừa đảo sẽ yêu cầu người dân truy cập vào website giả mạo để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản...</i></p><p style=\"text-align:justify;\">Ngày 29/10/2024, Công an TP. Đà Nẵng đưa thông tin cảnh báo đến người dân về những chiêu lừa đảo mới và khuyến cáo nguyên tắc “3 không” để phòng tránh. Đơn cử, trên không gian mạng đã xuất hiện hình thức lừa đảo trực tuyến mới giả mạo Cục Hàng không Việt Nam thông báo chuyến bay bị hủy.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/canh-giac-voi-thu-oan-gia-mao-cuc-hang-khong-viet-nam-jpg\" alt=\"\" width=\"626\" height=\"368\"></p><p style=\"text-align:center;\"><i>Đối tượng giả mạo Cục Hàng không Việt Nam để lừa đảo chiếm đoạt tài sản</i></p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Theo đó, các đối tượng lừa đảo thu thập dữ liệu thông tin chuyến bay của khách hàng sau đó tạo lập các tài khoản Facebook giả mạo Cục Hàng không Việt Nam để gọi điện, nhắn tin cho khách hàng. Sau đó thông báo chuyến bay bị hủy và yêu cầu người dân truy cập vào trang website giả mạo <a href=\"https://cuchangkhongvietnam.com/\">https://cuchangkhongvietnam.com/</a> để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản.</p><p style=\"text-align:justify;\">Thực tế website chính thức của Cục Hàng không Việt Nam có địa chỉ là: <a href=\"https://caa.gov.vn/\">https://caa.gov.vn/</a></p><p style=\"text-align:justify;\">Trước tình hình này, Phòng An ninh mạng và phòng, chống tội phạm sử dụng công nghệ cao – Công an TP.Đà Nẵng khuyến cáo người dân cần nâng cao cảnh giác hơn nữa khi sử dụng các nền tảng mạng xã hội. Người dân cần tuân thủ theo nguyên tắc “3<strong> </strong>KHÔNG”: <strong>Không</strong> cung cấp thông tin cá nhân, tài khoản ngân hàng, số thẻ tín dụng qua điện thoại, tin nhắn hay email - <strong>Không</strong> truy cập đường link thanh toán từ tin nhắn hoặc email không rõ nguồn gốc - <strong>Không </strong>tải về những app không rõ nguồn gốc để tránh bị đánh cắp thông tin cá nhân. Khi thực hiện thanh toán hóa đơn trực tuyến, người dân cần truy cập trực tiếp vào website hoặc ứng dụng chính thức của đơn vị cung cấp dịch vụ.</p><p style=\"text-align:justify;\">Bamboo Airways trân trọng khuyến nghị hành khách luôn nâng cao cảnh giác với các thủ đoạn lừa đảo công nghệ cao. Nếu nhận thấy có dấu hiệu đáng ngờ hoặc phát hiện bị lừa đảo, hành khách cần ngay lập tức trình báo cho cơ quan Công an gần nhất để được hỗ trợ.&nbsp;</p><p style=\"text-align:justify;\">Để biết thông tin chính thức về các chuyến bay và đường bay của Bamboo Airways, vui lòng truy cập Website: <a href=\"https://www.bambooairways.com/\">https://www.bambooairways.com/</a>&nbsp;hoặc liên hệ:</p><ul><li><p style=\"text-align:justify;\">Fanpage chính thức: <a href=\"https://www.facebook.com/BambooAirwaysFanpage\">https://www.facebook.com/BambooAirwaysFanpage</a></p></li><li><p style=\"text-align:justify;\">Hotline: <a href=\"tel:8419001166\">19001166</a></p></li><li><p style=\"text-align:justify;\">Email: <a href=\"mailto:19001166@bambooairways.com\">19001166@bambooairways.com</a></p></li></ul>',1,1),(2,'Cục thuế tỉnh Bình Định hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways','img/news_bamboo_1.jpg','<p style=\"text-align:justify;\"><i>Ngày 16/10/2024, Cục thuế tỉnh Bình Định đã có văn bản gửi Cục Quản lý xuất nhập cảnh – Bộ Công An thông báo hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways – ông Lương Hoài Nam.</i></p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/449853545_484792347399617_8667786688385885570_n-jpg\" alt=\"\" width=\"2048\" height=\"1152\"></p><p style=\"text-align:justify;\">Sau các văn bản báo cáo, kiến nghị của hãng hàng không Bamboo Airways gửi Cục thuế tỉnh Bình Định và các cơ quan quản lý hữu quan, sáng ngày 15/10/2024 tại TP. Quy Nhơn, lãnh đạo Cục thuế tỉnh Bình Định và Bamboo Airways đã có buổi làm việc trực tiếp dưới sự chủ trì của ông Phạm Anh Tuấn - Chủ tịch UBND tỉnh Bình Định.</p><p style=\"text-align:justify;\">Tại buổi làm việc, hai bên đã tích cực trao đổi, tìm biện pháp tháo gỡ các khó khăn vướng mắc liên quan đến nợ thuế, trên tinh thần hỗ trợ, tạo điều kiện cho Bamboo Airways thực hiện thành công đề án tái cấu trúc toàn diện theo ý kiến chỉ đạo của Thủ tướng Chính phủ.</p><p style=\"text-align:justify;\">Trên cơ sở Bamboo Airways cam kết trả nợ thuế theo lộ trình và được ngân hàng bảo lãnh nghĩa vụ trả dần nợ thuế hàng tháng, ngay chiều ngày 16/10/2024, Cục thuế tỉnh Bình Định đã ban hành văn bản chính thức huỷ bỏ tạm hoãn xuất cảnh đối với ông Lương Hoài Nam. Trong thời gian Bamboo Airways thực hiện trả dần nợ thuế theo đúng cam kết, Cục Thuế tỉnh Bình Định sẽ không áp dụng các biện pháp cưỡng chế thuế khác đối với hãng hàng không, tạo điều kiện cho Bamboo Airways ổn định hoạt động, tái cấu trúc thành công và phát triển hiệu quả.</p>',2,1),(3,'Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo','img/news_bamboo_1.jpg','<p>Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo</p><p style=\"text-align:justify;\"><i>Bằng thủ đoạn mạo danh Cục Hàng không Việt Nam và thông báo chuyến bay bị hủy, các đối tượng lừa đảo sẽ yêu cầu người dân truy cập vào website giả mạo để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản...</i></p><p style=\"text-align:justify;\">Ngày 29/10/2024, Công an TP. Đà Nẵng đưa thông tin cảnh báo đến người dân về những chiêu lừa đảo mới và khuyến cáo nguyên tắc “3 không” để phòng tránh. Đơn cử, trên không gian mạng đã xuất hiện hình thức lừa đảo trực tuyến mới giả mạo Cục Hàng không Việt Nam thông báo chuyến bay bị hủy.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/canh-giac-voi-thu-oan-gia-mao-cuc-hang-khong-viet-nam-jpg\" alt=\"\" width=\"626\" height=\"368\"></p><p style=\"text-align:center;\"><i>Đối tượng giả mạo Cục Hàng không Việt Nam để lừa đảo chiếm đoạt tài sản</i></p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Theo đó, các đối tượng lừa đảo thu thập dữ liệu thông tin chuyến bay của khách hàng sau đó tạo lập các tài khoản Facebook giả mạo Cục Hàng không Việt Nam để gọi điện, nhắn tin cho khách hàng. Sau đó thông báo chuyến bay bị hủy và yêu cầu người dân truy cập vào trang website giả mạo <a href=\"https://cuchangkhongvietnam.com/\">https://cuchangkhongvietnam.com/</a> để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản.</p><p style=\"text-align:justify;\">Thực tế website chính thức của Cục Hàng không Việt Nam có địa chỉ là: <a href=\"https://caa.gov.vn/\">https://caa.gov.vn/</a></p><p style=\"text-align:justify;\">Trước tình hình này, Phòng An ninh mạng và phòng, chống tội phạm sử dụng công nghệ cao – Công an TP.Đà Nẵng khuyến cáo người dân cần nâng cao cảnh giác hơn nữa khi sử dụng các nền tảng mạng xã hội. Người dân cần tuân thủ theo nguyên tắc “3<strong> </strong>KHÔNG”: <strong>Không</strong> cung cấp thông tin cá nhân, tài khoản ngân hàng, số thẻ tín dụng qua điện thoại, tin nhắn hay email - <strong>Không</strong> truy cập đường link thanh toán từ tin nhắn hoặc email không rõ nguồn gốc - <strong>Không </strong>tải về những app không rõ nguồn gốc để tránh bị đánh cắp thông tin cá nhân. Khi thực hiện thanh toán hóa đơn trực tuyến, người dân cần truy cập trực tiếp vào website hoặc ứng dụng chính thức của đơn vị cung cấp dịch vụ.</p><p style=\"text-align:justify;\">Bamboo Airways trân trọng khuyến nghị hành khách luôn nâng cao cảnh giác với các thủ đoạn lừa đảo công nghệ cao. Nếu nhận thấy có dấu hiệu đáng ngờ hoặc phát hiện bị lừa đảo, hành khách cần ngay lập tức trình báo cho cơ quan Công an gần nhất để được hỗ trợ.&nbsp;</p><p style=\"text-align:justify;\">Để biết thông tin chính thức về các chuyến bay và đường bay của Bamboo Airways, vui lòng truy cập Website: <a href=\"https://www.bambooairways.com/\">https://www.bambooairways.com/</a>&nbsp;hoặc liên hệ:</p><ul><li><p style=\"text-align:justify;\">Fanpage chính thức: <a href=\"https://www.facebook.com/BambooAirwaysFanpage\">https://www.facebook.com/BambooAirwaysFanpage</a></p></li><li><p style=\"text-align:justify;\">Hotline: <a href=\"tel:8419001166\">19001166</a></p></li><li><p style=\"text-align:justify;\">Email: <a href=\"mailto:19001166@bambooairways.com\">19001166@bambooairways.com</a></p></li></ul>',3,1),(4,'Cục thuế tỉnh Bình Định hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways','img/news_bamboo_1.jpg','<p style=\"text-align:justify;\"><i>Ngày 16/10/2024, Cục thuế tỉnh Bình Định đã có văn bản gửi Cục Quản lý xuất nhập cảnh – Bộ Công An thông báo hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways – ông Lương Hoài Nam.</i></p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/449853545_484792347399617_8667786688385885570_n-jpg\" alt=\"\" width=\"2048\" height=\"1152\"></p><p style=\"text-align:justify;\">Sau các văn bản báo cáo, kiến nghị của hãng hàng không Bamboo Airways gửi Cục thuế tỉnh Bình Định và các cơ quan quản lý hữu quan, sáng ngày 15/10/2024 tại TP. Quy Nhơn, lãnh đạo Cục thuế tỉnh Bình Định và Bamboo Airways đã có buổi làm việc trực tiếp dưới sự chủ trì của ông Phạm Anh Tuấn - Chủ tịch UBND tỉnh Bình Định.</p><p style=\"text-align:justify;\">Tại buổi làm việc, hai bên đã tích cực trao đổi, tìm biện pháp tháo gỡ các khó khăn vướng mắc liên quan đến nợ thuế, trên tinh thần hỗ trợ, tạo điều kiện cho Bamboo Airways thực hiện thành công đề án tái cấu trúc toàn diện theo ý kiến chỉ đạo của Thủ tướng Chính phủ.</p><p style=\"text-align:justify;\">Trên cơ sở Bamboo Airways cam kết trả nợ thuế theo lộ trình và được ngân hàng bảo lãnh nghĩa vụ trả dần nợ thuế hàng tháng, ngay chiều ngày 16/10/2024, Cục thuế tỉnh Bình Định đã ban hành văn bản chính thức huỷ bỏ tạm hoãn xuất cảnh đối với ông Lương Hoài Nam. Trong thời gian Bamboo Airways thực hiện trả dần nợ thuế theo đúng cam kết, Cục Thuế tỉnh Bình Định sẽ không áp dụng các biện pháp cưỡng chế thuế khác đối với hãng hàng không, tạo điều kiện cho Bamboo Airways ổn định hoạt động, tái cấu trúc thành công và phát triển hiệu quả.</p>',4,1);
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passengers`
--

DROP TABLE IF EXISTS `passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passengers` (
  `PassengerId` int NOT NULL AUTO_INCREMENT,
  `PassengerName` varchar(100) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `IDNumber` varchar(50) DEFAULT NULL,
  `Address` text,
  `Dob` date DEFAULT NULL,
  `Gender` enum('Male','Female') DEFAULT NULL,
  `AccountId` int DEFAULT NULL,
  `BookingId` int DEFAULT NULL,
  PRIMARY KEY (`PassengerId`),
  KEY `AccountId` (`AccountId`),
  KEY `BookingId` (`BookingId`),
  CONSTRAINT `passengers_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `accounts` (`AccountId`),
  CONSTRAINT `passengers_ibfk_2` FOREIGN KEY (`BookingId`) REFERENCES `bookings` (`BookingId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passengers`
--

LOCK TABLES `passengers` WRITE;
/*!40000 ALTER TABLE `passengers` DISABLE KEYS */;
INSERT INTO `passengers` VALUES (1,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-03-15','Male',1,1),(2,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-03-09','Male',1,2),(3,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-02-15','Male',1,3),(4,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-01','Male',NULL,4),(5,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-01','Male',NULL,5),(6,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-05-31','Male',5,6),(7,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-01','Male',NULL,7),(8,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-01','Male',5,8),(9,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-08','Male',5,9),(10,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-08','Male',5,10),(11,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-07','Male',5,11),(12,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-06','Male',5,12),(13,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-06','Male',5,13),(14,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-07','Male',NULL,14),(15,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-07','Male',5,15),(16,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-06','Male',5,16),(17,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-07','Male',5,17),(18,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-07','Male',5,18),(19,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-04','Male',5,19),(20,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-06','Male',5,20),(21,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-06','Male',5,21),(22,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-05','Male',9,22),(23,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-05','Male',5,23),(24,'NGUYỄN VĂN QUÝ','0946217801',NULL,NULL,NULL,'2013-06-02','Male',10,24);
/*!40000 ALTER TABLE `passengers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `PaymentId` int NOT NULL AUTO_INCREMENT,
  `BookingId` int NOT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL,
  `PaymentStatus` int DEFAULT '1',
  `PaymentDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `Email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `TotalPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`PaymentId`),
  KEY `BookingId` (`BookingId`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`BookingId`) REFERENCES `bookings` (`BookingId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,2,'QRCode',2,'2025-03-30 08:06:21','admin@example.com',550000.00),(2,2,'QRCode',2,'2025-03-30 08:06:26','admin@example.com',550000.00),(3,3,'QRCode',2,'2025-03-30 08:31:29','quyhslc11@gmail.com',2000000.00),(4,6,'QRCode',1,'2025-06-07 15:02:57','skyticket.work@gmail.com',2300000.00),(5,7,'QRCode',1,'2025-06-07 16:20:21','quyhslc11@gmail.com',2300000.00),(6,8,'QRCode',2,'2025-06-07 17:06:12','quyhslc11@gmail.com',2300000.00),(7,9,'QRCode',2,'2025-06-08 12:50:55','skyticket.work@gmail.com',2300000.00),(8,10,'QRCode',1,'2025-06-08 12:51:50','skyticket.work@gmail.com',2300000.00),(9,11,'QRCode',2,'2025-06-08 13:09:40','skyticket.work@gmail.com',450000.00),(10,12,'QRCode',2,'2025-06-08 14:19:32','skyticket.work@gmail.com',2300000.00),(11,13,'QRCode',2,'2025-06-08 15:06:20','skyticket.work@gmail.com',2300000.00),(12,15,'QRCode',2,'2025-06-08 17:33:40','skyticket.work@gmail.com',2300000.00),(13,16,'QRCode',2,'2025-06-08 18:10:08','skyticket.work@gmail.com',450000.00),(14,17,'QRCode',1,'2025-06-08 18:12:51','skyticket.work@gmail.com',200000.00),(15,18,'QRCode',1,'2025-06-08 18:17:36','skyticket.work@gmail.com',200000.00),(16,19,'QRCode',2,'2025-06-08 18:23:38','skyticket.work@gmail.com',2300000.00),(17,20,'QRCode',2,'2025-06-08 19:14:21','skyticket.work@gmail.com',2300000.00),(18,21,'QRCode',2,'2025-06-08 19:16:57','skyticket.work@gmail.com',2300000.00),(19,23,'QRCode',1,'2025-06-10 13:09:12','skyticket.work@gmail.com',2180000.00),(20,24,'QRCode',2,'2025-06-10 13:10:06','quy905844@gmail.com',2009999.00);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refund`
--

DROP TABLE IF EXISTS `refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refund` (
  `RefundId` int NOT NULL AUTO_INCREMENT,
  `TicketId` int NOT NULL,
  `BankAccount` varchar(50) DEFAULT NULL,
  `BankName` varchar(50) DEFAULT NULL,
  `RequestDate` datetime DEFAULT NULL,
  `RefundDate` datetime DEFAULT NULL,
  `RefundPrice` decimal(10,2) DEFAULT NULL,
  `Status` int DEFAULT '1',
  `AccountHolder` varchar(100) DEFAULT NULL,
  `CreatedBy` varchar(255) DEFAULT NULL,
  `AcceptedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RefundId`),
  KEY `TicketId` (`TicketId`),
  CONSTRAINT `refund_ibfk_1` FOREIGN KEY (`TicketId`) REFERENCES `tickets` (`TicketId`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refund`
--

LOCK TABLES `refund` WRITE;
/*!40000 ALTER TABLE `refund` DISABLE KEYS */;
INSERT INTO `refund` VALUES (20,19,'00000119496','MBBank','2025-06-08 18:24:57',NULL,2300000.00,3,'Nguyen Van A','Sky Ticket',NULL),(21,20,'00000119495','TPBank','2025-06-08 19:15:24',NULL,2300000.00,1,'Nguyen vAN QUY','Sky Ticket',NULL),(22,21,'123456789','TPBank','2025-06-08 19:18:06',NULL,2300000.00,3,'QUY QUY','Sky Ticket',NULL),(23,24,'00000119496','TPBank','2025-06-10 13:12:25',NULL,2010000.00,1,'Nguyen vAN QUY','Quy Quy',NULL);
/*!40000 ALTER TABLE `refund` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_set_created_by` BEFORE INSERT ON `refund` FOR EACH ROW BEGIN
    SET NEW.CreatedBy = (
        SELECT a.FullName
        FROM Tickets t
        JOIN Bookings b ON t.BookingId = b.BookingId
        JOIN Accounts a ON b.AccountId = a.AccountId
        WHERE t.TicketId = NEW.TicketId
        LIMIT 1
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `RoleId` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(50) NOT NULL,
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Member');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seats` (
  `SeatId` int NOT NULL AUTO_INCREMENT,
  `AirlineId` int NOT NULL,
  `Status` int DEFAULT '1',
  `SeatNumber` int NOT NULL,
  `SeatClass` varchar(80) NOT NULL,
  `IsBooked` int DEFAULT '0',
  PRIMARY KEY (`SeatId`),
  KEY `AirlineId` (`AirlineId`),
  CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`AirlineId`) REFERENCES `airlines` (`AirlineId`)
) ENGINE=InnoDB AUTO_INCREMENT=340 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seats`
--

LOCK TABLES `seats` WRITE;
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
INSERT INTO `seats` VALUES (1,1,1,1,'Economy',1),(2,1,1,2,'Economy',1),(3,1,1,3,'Economy',0),(4,1,1,1,'Business',1),(5,1,1,2,'Business',1),(6,1,1,3,'Business',0),(7,2,1,1,'Economy',0),(8,2,1,2,'Economy',0),(9,2,1,3,'Economy',0),(10,2,1,1,'Business',0),(11,2,1,2,'Business',0),(12,2,1,3,'Business',0),(13,3,1,1,'Economy',0),(14,3,1,2,'Economy',1),(15,3,1,3,'Economy',0),(16,3,1,1,'Business',0),(17,3,1,2,'Business',0),(18,3,1,3,'Business',0),(19,4,1,1,'Economy',0),(20,4,1,2,'Economy',0),(21,4,1,3,'Economy',0),(22,4,1,1,'Business',0),(23,4,1,2,'Business',0),(24,4,1,3,'Business',0),(25,5,1,1,'Bussiness',0),(26,5,1,2,'Bussiness',0),(27,5,1,3,'Bussiness',0),(28,5,1,4,'Bussiness',0),(29,5,1,5,'Bussiness',0),(30,5,1,6,'Bussiness',0),(31,5,1,7,'Bussiness',0),(32,5,1,8,'Bussiness',0),(33,5,1,9,'Bussiness',0),(34,5,1,10,'Bussiness',0),(35,5,1,11,'Bussiness',0),(36,5,1,12,'Bussiness',0),(37,5,1,13,'Bussiness',0),(38,5,1,14,'Bussiness',0),(39,5,1,15,'Bussiness',0),(40,5,1,16,'Bussiness',0),(41,5,1,17,'Bussiness',0),(42,5,1,18,'Bussiness',0),(43,5,1,19,'Bussiness',0),(44,5,1,20,'Bussiness',0),(45,5,1,21,'Bussiness',0),(46,5,1,22,'Bussiness',0),(47,5,1,23,'Bussiness',0),(48,5,1,24,'Bussiness',0),(49,5,1,25,'Bussiness',0),(50,5,1,26,'Bussiness',0),(51,5,1,27,'Bussiness',0),(52,5,1,28,'Bussiness',0),(53,5,1,29,'Bussiness',0),(54,5,1,30,'Bussiness',0),(55,5,1,31,'Bussiness',0),(56,5,1,32,'Bussiness',0),(57,5,1,1,'Economy',0),(58,5,1,2,'Economy',0),(59,5,1,3,'Economy',0),(60,5,1,4,'Economy',0),(61,5,1,5,'Economy',0),(62,5,1,6,'Economy',0),(63,5,1,7,'Economy',0),(64,5,1,8,'Economy',0),(65,5,1,9,'Economy',0),(66,5,1,10,'Economy',0),(67,5,1,11,'Economy',0),(68,5,1,12,'Economy',0),(69,5,1,13,'Economy',0),(70,5,1,14,'Economy',0),(71,5,1,15,'Economy',0),(72,5,1,16,'Economy',0),(73,5,1,17,'Economy',0),(74,5,1,18,'Economy',0),(75,5,1,19,'Economy',0),(76,5,1,20,'Economy',0),(77,5,1,21,'Economy',0),(78,5,1,22,'Economy',0),(79,5,1,23,'Economy',0),(80,5,1,24,'Economy',0),(81,5,1,25,'Economy',0),(82,5,1,26,'Economy',0),(83,5,1,27,'Economy',0),(84,5,1,28,'Economy',0),(85,5,1,29,'Economy',0),(86,5,1,30,'Economy',0),(87,5,1,31,'Economy',0),(88,5,1,32,'Economy',0),(89,5,1,33,'Economy',0),(90,5,1,34,'Economy',0),(91,5,1,35,'Economy',0),(92,5,1,36,'Economy',0),(93,5,1,37,'Economy',0),(94,5,1,38,'Economy',0),(95,5,1,39,'Economy',0),(96,5,1,40,'Economy',0),(97,5,1,41,'Economy',0),(98,5,1,42,'Economy',0),(99,5,1,43,'Economy',0),(100,5,1,44,'Economy',0),(101,5,1,45,'Economy',0),(102,5,1,46,'Economy',0),(103,5,1,47,'Economy',0),(104,5,1,48,'Economy',0),(105,5,1,49,'Economy',0),(106,5,1,50,'Economy',0),(107,5,1,51,'Economy',0),(108,5,1,52,'Economy',0),(109,5,1,53,'Economy',0),(110,5,1,54,'Economy',0),(111,5,1,55,'Economy',0),(112,5,1,56,'Economy',0),(113,5,1,57,'Economy',0),(114,5,1,58,'Economy',0),(115,5,1,59,'Economy',0),(116,5,1,60,'Economy',0),(117,5,1,61,'Economy',0),(118,5,1,62,'Economy',0),(119,5,1,63,'Economy',0),(120,5,1,64,'Economy',0),(121,5,1,65,'Economy',0),(122,5,1,66,'Economy',0),(123,5,1,67,'Economy',0),(124,5,1,68,'Economy',0),(125,5,1,69,'Economy',0),(126,5,1,70,'Economy',0),(127,5,1,71,'Economy',0),(128,5,1,72,'Economy',0),(129,5,1,73,'Economy',0),(130,5,1,74,'Economy',0),(131,5,1,75,'Economy',0),(132,5,1,76,'Economy',0),(133,5,1,77,'Economy',0),(134,5,1,78,'Economy',0),(135,5,1,79,'Economy',0),(136,5,1,80,'Economy',0),(137,5,1,81,'Economy',0),(138,5,1,82,'Economy',0),(139,5,1,83,'Economy',0),(140,5,1,84,'Economy',0),(141,5,1,85,'Economy',0),(142,5,1,86,'Economy',0),(143,5,1,87,'Economy',0),(144,5,1,88,'Economy',0),(145,5,1,89,'Economy',0),(146,5,1,90,'Economy',0),(147,5,1,91,'Economy',0),(148,5,1,92,'Economy',0),(149,5,1,93,'Economy',0),(150,5,1,94,'Economy',0),(151,5,1,95,'Economy',0),(152,5,1,96,'Economy',0),(153,6,1,1,'Business',1),(154,6,1,2,'Business',1),(155,6,1,3,'Business',0),(156,6,1,4,'Business',0),(157,6,1,5,'Business',0),(158,6,1,6,'Business',0),(159,6,1,7,'Business',0),(160,6,1,8,'Business',0),(161,6,1,9,'Business',0),(162,6,1,10,'Business',0),(163,6,1,11,'Business',0),(164,6,1,12,'Business',0),(165,6,1,13,'Business',0),(166,6,1,14,'Business',0),(167,6,1,15,'Business',0),(168,6,1,16,'Business',0),(169,6,1,17,'Business',0),(170,6,1,18,'Business',0),(171,6,1,19,'Business',0),(172,6,1,20,'Business',0),(173,6,1,21,'Business',0),(174,6,1,22,'Business',0),(175,6,1,23,'Business',0),(176,6,1,24,'Business',0),(177,6,1,25,'Business',0),(178,6,1,26,'Business',0),(179,6,1,27,'Business',0),(180,6,1,28,'Business',0),(181,6,1,29,'Business',0),(182,6,1,30,'Business',0),(183,6,1,31,'Business',0),(184,6,1,32,'Business',0),(185,6,1,1,'Economy',0),(186,6,1,2,'Economy',0),(187,6,1,3,'Economy',0),(188,6,1,4,'Economy',1),(189,6,1,5,'Economy',0),(190,6,1,6,'Economy',0),(191,6,1,7,'Economy',0),(192,6,1,8,'Economy',0),(193,6,1,9,'Economy',0),(194,6,1,10,'Economy',0),(195,6,1,11,'Economy',0),(196,6,1,12,'Economy',0),(197,6,1,13,'Economy',0),(198,6,1,14,'Economy',0),(199,6,1,15,'Economy',0),(200,6,1,16,'Economy',0),(201,6,1,17,'Economy',0),(202,6,1,18,'Economy',0),(203,6,1,19,'Economy',0),(204,6,1,20,'Economy',0),(205,6,1,21,'Economy',0),(206,6,1,22,'Economy',0),(207,6,1,23,'Economy',0),(208,6,1,24,'Economy',0),(209,6,1,25,'Economy',0),(210,6,1,26,'Economy',0),(211,6,1,27,'Economy',0),(212,6,1,28,'Economy',0),(213,6,1,29,'Economy',0),(214,6,1,30,'Economy',0),(215,6,1,31,'Economy',0),(216,6,1,32,'Economy',0),(217,6,1,33,'Economy',0),(218,6,1,34,'Economy',0),(219,6,1,35,'Economy',0),(220,6,1,36,'Economy',0),(221,6,1,37,'Economy',0),(222,6,1,38,'Economy',0),(223,6,1,39,'Economy',0),(224,6,1,40,'Economy',0),(225,6,1,41,'Economy',0),(226,6,1,42,'Economy',0),(227,6,1,43,'Economy',0),(228,6,1,44,'Economy',0),(229,6,1,45,'Economy',0),(230,6,1,46,'Economy',0),(231,6,1,47,'Economy',0),(232,6,1,48,'Economy',0),(233,6,1,49,'Economy',0),(234,6,1,50,'Economy',0),(235,6,1,51,'Economy',0),(236,6,1,52,'Economy',0),(237,6,1,53,'Economy',0),(238,6,1,54,'Economy',0),(239,6,1,55,'Economy',0),(240,6,1,56,'Economy',0),(241,6,1,57,'Economy',0),(242,6,1,58,'Economy',0),(243,6,1,59,'Economy',0),(244,6,1,60,'Economy',0),(245,7,1,1,'Business',0),(246,7,1,2,'Business',0),(247,7,1,3,'Business',0),(248,7,0,4,'Business',0),(249,7,1,5,'Business',0),(250,7,1,6,'Business',0),(251,7,1,7,'Business',0),(252,7,1,8,'Business',0),(253,7,1,9,'Business',0),(254,7,1,10,'Business',0),(255,7,1,11,'Business',0),(256,7,1,12,'Business',0),(257,7,1,13,'Business',0),(258,7,1,14,'Business',0),(259,7,1,15,'Business',0),(260,7,1,16,'Business',0),(261,7,1,17,'Business',0),(262,7,1,18,'Business',0),(263,7,1,19,'Business',0),(264,7,1,20,'Business',0),(265,7,1,1,'Economy',0),(266,7,1,2,'Economy',0),(267,7,1,3,'Economy',0),(268,7,1,4,'Economy',0),(269,7,1,5,'Economy',0),(270,7,1,6,'Economy',0),(271,7,1,7,'Economy',0),(272,7,1,8,'Economy',0),(273,7,1,9,'Economy',0),(274,7,1,10,'Economy',0),(275,7,1,11,'Economy',0),(276,7,1,12,'Economy',0),(277,7,1,13,'Economy',0),(278,7,1,14,'Economy',0),(279,7,1,15,'Economy',0),(280,7,1,16,'Economy',0),(281,7,1,17,'Economy',0),(282,7,1,18,'Economy',0),(283,7,1,19,'Economy',0),(284,7,1,20,'Economy',0),(285,7,1,21,'Economy',0),(286,7,1,22,'Economy',0),(287,7,1,23,'Economy',0),(288,7,1,24,'Economy',0),(289,7,1,25,'Economy',0),(290,7,1,26,'Economy',0),(291,7,1,27,'Economy',0),(292,7,1,28,'Economy',0),(293,7,1,29,'Economy',0),(294,7,1,30,'Economy',0),(295,7,1,31,'Economy',0),(296,7,1,32,'Economy',0),(297,7,1,33,'Economy',0),(298,7,1,34,'Economy',0),(299,7,1,35,'Economy',0),(300,7,1,36,'Economy',0),(301,7,1,37,'Economy',0),(302,7,1,38,'Economy',0),(303,7,1,39,'Economy',0),(304,7,1,40,'Economy',0),(305,7,1,41,'Economy',0),(306,7,1,42,'Economy',0),(307,7,1,43,'Economy',0),(308,7,1,44,'Economy',0),(309,7,1,45,'Economy',0),(310,7,1,46,'Economy',0),(311,7,1,47,'Economy',0),(312,7,1,48,'Economy',0),(313,7,1,49,'Economy',0),(314,7,1,50,'Economy',0),(315,7,1,51,'Economy',0),(316,7,1,52,'Economy',0),(317,7,1,53,'Economy',0),(318,7,1,54,'Economy',0),(319,7,1,55,'Economy',0),(320,7,1,56,'Economy',0),(321,7,1,57,'Economy',0),(322,7,1,58,'Economy',0),(323,7,1,59,'Economy',0),(324,7,1,60,'Economy',0),(325,7,1,61,'Economy',0),(326,7,1,62,'Economy',0),(327,7,1,63,'Economy',0),(328,7,1,64,'Economy',0),(329,7,1,65,'Economy',0),(330,7,1,66,'Economy',0),(331,7,1,67,'Economy',0),(332,7,1,68,'Economy',0),(333,7,1,69,'Economy',0),(334,7,1,70,'Economy',0),(335,7,1,71,'Economy',0),(336,7,1,72,'Economy',0),(337,7,1,73,'Economy',0),(338,7,1,74,'Economy',0),(339,7,1,75,'Economy',0);
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `TicketId` int NOT NULL AUTO_INCREMENT,
  `SeatId` int NOT NULL,
  `PassengerId` int NOT NULL,
  `Code` varchar(50) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `CreateAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `BookingId` int DEFAULT NULL,
  `FlightId` int DEFAULT NULL,
  `BaggageId` int DEFAULT NULL,
  `Price` float DEFAULT NULL,
  `CancelledAT` datetime DEFAULT NULL,
  PRIMARY KEY (`TicketId`),
  KEY `SeatId` (`SeatId`),
  KEY `PassengerId` (`PassengerId`),
  KEY `BaggageId` (`BaggageId`),
  KEY `FlightId` (`FlightId`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`SeatId`) REFERENCES `seats` (`SeatId`),
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`PassengerId`) REFERENCES `passengers` (`PassengerId`),
  CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`BaggageId`) REFERENCES `baggages` (`BaggageId`),
  CONSTRAINT `tickets_ibfk_4` FOREIGN KEY (`FlightId`) REFERENCES `flights` (`FlightId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (19,5,19,'Airbus A320C1_1_19','2','2025-06-08 18:23:36',19,1,1,2300000,'2025-06-08 18:24:48'),(20,4,20,'Airbus A320C1_1_20','2','2025-06-08 19:14:17',20,1,1,2300000,'2025-06-08 19:15:09'),(21,1,21,'Airbus A320C1_1_21','2','2025-06-08 19:16:54',21,1,1,2300000,'2025-06-08 19:17:22'),(22,153,22,'Airbus A320C6_28_22','1','2025-06-09 23:12:59',22,28,6,450000,NULL),(23,5,23,'Airbus A320C1_1_23','1','2025-06-10 13:09:04',23,1,5,2180000,NULL),(24,5,24,'Airbus A320C1_1_24','2','2025-06-10 13:10:03',24,1,7,2010000,'2025-06-10 13:12:14');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-10 13:23:15
