-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: skytickets
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.24.04.1

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
-- Table structure for table `Accounts`
--

DROP TABLE IF EXISTS `Accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Accounts` (
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
  CONSTRAINT `Accounts_ibfk_1` FOREIGN KEY (`RoleId`) REFERENCES `Roles` (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Accounts`
--

/*!40000 ALTER TABLE `Accounts` DISABLE KEYS */;
INSERT INTO `Accounts` VALUES (1,'Admin User','admin@example.com','$2a$12$h849FSoyKU2DY1AQvIIruOo6TFHpt1oa6ls.dSRReu0OsHvhczYea','0123456789','123 Admin St','1743287230962_defaultlogo.jpg','1990-01-01',1,1),(2,'Member User','member@example.com','$2a$12$h849FSoyKU2DY1AQvIIruOo6TFHpt1oa6ls.dSRReu0OsHvhczYea','0987654321','456 Member St','defaultlogo.jpg','1995-05-05',1,2),(3,'duy','hoangduy20407@gmail.com','$2a$12$LDdg4yJEGFkxWGoluAlX0.v7T3qoh0Je2RTw9FHStWKq.D3RwWVCO','0382458534',NULL,'defaultlogo.jpg',NULL,1,1);
/*!40000 ALTER TABLE `Accounts` ENABLE KEYS */;

--
-- Table structure for table `Airlines`
--

DROP TABLE IF EXISTS `Airlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airlines` (
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Airlines`
--

/*!40000 ALTER TABLE `Airlines` DISABLE KEYS */;
INSERT INTO `Airlines` VALUES (1,'Airbus A320C1','news_bamboo_1.jpg','Hãng hàng không tư nhân đầu tiên tại Việt Nam.',1,4,5,6,7),(2,'Airbus A320C2','news_bamboo_1.jpg','Hãng hàng không quốc gia Việt Nam với dịch vụ chất lượng cao.',1,4,5,6,7),(3,'Airbus A320C3','news_bamboo_1.jpg','Hãng hàng không tư nhân đầu tiên tại Việt Nam.',1,4,5,6,7),(4,'Airbus A320C4','news_bamboo_1.jpg','Hãng hàng không quốc gia Việt Nam với dịch vụ chất lượng cao.',1,4,5,6,7);
/*!40000 ALTER TABLE `Airlines` ENABLE KEYS */;

--
-- Table structure for table `Airports`
--

DROP TABLE IF EXISTS `Airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airports` (
  `AirportId` int NOT NULL AUTO_INCREMENT,
  `AirportName` varchar(100) NOT NULL,
  `LocationId` int NOT NULL,
  `Status` tinyint DEFAULT '1',
  PRIMARY KEY (`AirportId`),
  KEY `LocationId` (`LocationId`),
  CONSTRAINT `Airports_ibfk_1` FOREIGN KEY (`LocationId`) REFERENCES `Locations` (`LocationId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Airports`
--

/*!40000 ALTER TABLE `Airports` DISABLE KEYS */;
INSERT INTO `Airports` VALUES (1,'Nội Bài International Airport',1,1),(2,'Tân Sơn Nhất International Airport',2,1),(3,'Narita International Airport',3,1),(4,'Kansai International Airport',4,1),(5,'Incheon International Airport',5,1),(6,'Gimhae International Airport',6,1),(7,'Suvarnabhumi Airport',7,1),(8,'Changi Airport',8,1),(9,'Kuala Lumpur International Airport',9,1),(10,'Beijing Capital International Airport',10,1),(11,'Chhatrapati Shivaji International Airport',11,1),(12,'Sydney Kingsford Smith Airport',12,1),(13,'John F. Kennedy International Airport',13,1),(14,'Heathrow Airport',14,1),(15,'Charles de Gaulle Airport',15,1);
/*!40000 ALTER TABLE `Airports` ENABLE KEYS */;

--
-- Table structure for table `Baggages`
--

DROP TABLE IF EXISTS `Baggages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Baggages` (
  `BaggageId` int NOT NULL AUTO_INCREMENT,
  `Weight` decimal(5,2) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `AirlineId` int DEFAULT NULL,
  `Status` int DEFAULT '1',
  PRIMARY KEY (`BaggageId`),
  KEY `AirlineId` (`AirlineId`),
  CONSTRAINT `Baggages_ibfk_1` FOREIGN KEY (`AirlineId`) REFERENCES `Airlines` (`AirlineId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Baggages`
--

/*!40000 ALTER TABLE `Baggages` DISABLE KEYS */;
INSERT INTO `Baggages` VALUES (1,15.50,300000.00,1,1),(2,2.30,50000.00,2,1),(3,10.00,200000.00,3,1),(4,5.20,150000.00,4,1),(5,7.80,180000.00,1,1);
/*!40000 ALTER TABLE `Baggages` ENABLE KEYS */;

--
-- Table structure for table `Bookings`
--

DROP TABLE IF EXISTS `Bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bookings` (
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
  CONSTRAINT `Bookings_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `Accounts` (`AccountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bookings`
--

/*!40000 ALTER TABLE `Bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `Bookings` ENABLE KEYS */;

--
-- Table structure for table `Countries`
--

DROP TABLE IF EXISTS `Countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Countries` (
  `CountryId` int NOT NULL AUTO_INCREMENT,
  `CountryName` varchar(100) NOT NULL,
  `Status` tinyint DEFAULT '1',
  PRIMARY KEY (`CountryId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Countries`
--

/*!40000 ALTER TABLE `Countries` DISABLE KEYS */;
INSERT INTO `Countries` VALUES (1,'Viet Nam',1),(2,'Nhat Ban',1),(3,'Han Quoc',1),(4,'Thai Lan',1),(5,'Singapore',1),(6,'Malaysia',1),(7,'Trung Quoc',1),(8,'An Do',1),(9,'Uc',1),(10,'My',1),(11,'Anh',1),(12,'Phap',1),(13,'Đuc',1),(14,'Canada',1),(15,'Indonesia',1);
/*!40000 ALTER TABLE `Countries` ENABLE KEYS */;

--
-- Table structure for table `Discounts`
--

DROP TABLE IF EXISTS `Discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Discounts` (
  `DiscountId` int NOT NULL AUTO_INCREMENT,
  `Percent` decimal(5,2) NOT NULL,
  `AccountId` int DEFAULT NULL,
  `Points` int DEFAULT '0',
  PRIMARY KEY (`DiscountId`),
  KEY `AccountId` (`AccountId`),
  CONSTRAINT `Discounts_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `Accounts` (`AccountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Discounts`
--

/*!40000 ALTER TABLE `Discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `Discounts` ENABLE KEYS */;

--
-- Table structure for table `Flights`
--

DROP TABLE IF EXISTS `Flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Flights` (
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
  CONSTRAINT `Flights_ibfk_1` FOREIGN KEY (`AirlineId`) REFERENCES `Airlines` (`AirlineId`),
  CONSTRAINT `Flights_ibfk_2` FOREIGN KEY (`ArrivalAirportId`) REFERENCES `Airports` (`AirportId`),
  CONSTRAINT `Flights_ibfk_3` FOREIGN KEY (`DepartureAirportId`) REFERENCES `Airports` (`AirportId`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Flights`
--

/*!40000 ALTER TABLE `Flights` DISABLE KEYS */;
INSERT INTO `Flights` VALUES (1,'2025-03-31 10:00:00','2025-03-31 07:30:00',2,1,'1',1,2000000.00,1000000.00),(2,'2025-03-31 15:00:00','2025-03-31 12:00:00',3,2,'1',2,2500000.00,1200000.00),(3,'2025-03-31 18:30:00','2025-03-31 16:00:00',4,3,'1',3,2800000.00,1500000.00),(4,'2025-03-31 08:45:00','2025-03-31 06:20:00',2,4,'1',4,3000000.00,17000000.00),(5,'2025-03-31 12:15:00','2025-03-31 09:45:00',1,4,'1',2,2200000.00,11000000.00),(6,'2025-03-31 17:00:00','2025-03-31 14:30:00',3,1,'1',1,2600000.00,13000000.00),(7,'2025-03-31 22:10:00','2025-03-31 19:45:00',5,1,'1',2,2900000.00,1400000.00),(8,'2025-03-31 05:30:00','2025-03-31 03:00:00',5,1,'1',3,3100000.00,1800000.00),(9,'2025-03-31 09:20:00','2025-03-31 06:50:00',5,1,'1',4,2400000.00,1150000.00),(10,'2025-03-31 14:00:00','2025-03-31 11:30:00',7,2,'1',1,2300000.00,1150000.00),(11,'2025-03-31 19:00:00','2025-03-31 16:15:00',8,3,'1',2,2700000.00,1350000.00),(12,'2025-03-31 09:30:00','2025-03-31 07:00:00',9,5,'1',3,3000000.00,1500000.00),(13,'2025-03-31 15:45:00','2025-03-31 13:00:00',10,4,'1',4,3200000.00,1600000.00),(14,'2025-03-31 21:00:00','2025-03-31 18:30:00',11,6,'1',1,3500000.00,1750000.00),(15,'2025-03-31 06:00:00','2025-03-31 03:30:00',12,7,'1',2,4000000.00,200000.00),(16,'2025-03-31 23:30:00','2025-03-31 21:00:00',5,1,'1',2,2900000.00,1400000.00),(17,'2025-03-31 01:45:00','2025-03-31 23:15:00',5,1,'1',3,3100000.00,1800000.00),(18,'2025-03-31 03:50:00','2025-03-31 01:20:00',5,1,'1',4,2400000.00,1150000.00),(19,'2025-03-31 11:00:00','2025-03-31 08:30:00',5,1,'1',2,2900000.00,1400000.00),(20,'2025-03-31 13:15:00','2025-03-31 10:45:00',5,1,'1',3,3100000.00,1800000.00),(21,'2025-03-31 15:30:00','2025-03-31 13:00:00',5,1,'1',4,2400000.00,1150000.00),(22,'2025-03-31 11:00:00','2025-03-31 09:30:00',1,5,'1',1,2900000.00,1400000.00),(23,'2025-03-31 14:00:00','2025-03-31 12:30:00',1,5,'1',2,3100000.00,1800000.00),(24,'2025-03-31 17:00:00','2025-03-31 15:30:00',1,5,'1',3,2400000.00,1150000.00),(25,'2025-03-31 20:00:00','2025-03-31 18:30:00',1,5,'1',4,2900000.00,1400000.00),(26,'2025-03-31 23:00:00','2025-03-31 21:30:00',1,5,'1',1,3100000.00,1800000.00),(27,'2025-03-31 09:00:00','2025-03-31 07:30:00',1,5,'1',1,2400000.00,1150000.00);
/*!40000 ALTER TABLE `Flights` ENABLE KEYS */;

--
-- Table structure for table `Locations`
--

DROP TABLE IF EXISTS `Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Locations` (
  `LocationId` int NOT NULL AUTO_INCREMENT,
  `LocationName` varchar(100) NOT NULL,
  `CountryId` int NOT NULL,
  `Status` tinyint DEFAULT '1',
  PRIMARY KEY (`LocationId`),
  KEY `CountryId` (`CountryId`),
  CONSTRAINT `Locations_ibfk_1` FOREIGN KEY (`CountryId`) REFERENCES `Countries` (`CountryId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Locations`
--

/*!40000 ALTER TABLE `Locations` DISABLE KEYS */;
INSERT INTO `Locations` VALUES (1,'Ha Noi',1,1),(2,'Ho Chi Minh',1,1),(3,'Tokyo',2,1),(4,'Osaka',2,1),(5,'Seoul',3,1),(6,'Busan',3,1),(7,'Bangkok',4,1),(8,'Singapore',5,1),(9,'Kuala Lumpur',6,1),(10,'Bac Kinh',7,1),(11,'Mumbai',8,1),(12,'Sydney',9,1),(13,'New York',10,1),(14,'London',11,1),(15,'Paris',12,1);
/*!40000 ALTER TABLE `Locations` ENABLE KEYS */;

--
-- Table structure for table `News`
--

DROP TABLE IF EXISTS `News`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `News` (
  `NewId` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Img` varchar(255) DEFAULT NULL,
  `Content` text,
  `AirlineId` int DEFAULT NULL,
  `Status` tinyint DEFAULT '1',
  PRIMARY KEY (`NewId`),
  KEY `AirlineId` (`AirlineId`),
  CONSTRAINT `News_ibfk_1` FOREIGN KEY (`AirlineId`) REFERENCES `Airlines` (`AirlineId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `News`
--

/*!40000 ALTER TABLE `News` DISABLE KEYS */;
INSERT INTO `News` VALUES (1,'Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo','img/news_bamboo_1.jpg','<p>Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo</p><p style=\"text-align:justify;\"><i>Bằng thủ đoạn mạo danh Cục Hàng không Việt Nam và thông báo chuyến bay bị hủy, các đối tượng lừa đảo sẽ yêu cầu người dân truy cập vào website giả mạo để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản...</i></p><p style=\"text-align:justify;\">Ngày 29/10/2024, Công an TP. Đà Nẵng đưa thông tin cảnh báo đến người dân về những chiêu lừa đảo mới và khuyến cáo nguyên tắc “3 không” để phòng tránh. Đơn cử, trên không gian mạng đã xuất hiện hình thức lừa đảo trực tuyến mới giả mạo Cục Hàng không Việt Nam thông báo chuyến bay bị hủy.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/canh-giac-voi-thu-oan-gia-mao-cuc-hang-khong-viet-nam-jpg\" alt=\"\" width=\"626\" height=\"368\"></p><p style=\"text-align:center;\"><i>Đối tượng giả mạo Cục Hàng không Việt Nam để lừa đảo chiếm đoạt tài sản</i></p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Theo đó, các đối tượng lừa đảo thu thập dữ liệu thông tin chuyến bay của khách hàng sau đó tạo lập các tài khoản Facebook giả mạo Cục Hàng không Việt Nam để gọi điện, nhắn tin cho khách hàng. Sau đó thông báo chuyến bay bị hủy và yêu cầu người dân truy cập vào trang website giả mạo <a href=\"https://cuchangkhongvietnam.com/\">https://cuchangkhongvietnam.com/</a> để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản.</p><p style=\"text-align:justify;\">Thực tế website chính thức của Cục Hàng không Việt Nam có địa chỉ là: <a href=\"https://caa.gov.vn/\">https://caa.gov.vn/</a></p><p style=\"text-align:justify;\">Trước tình hình này, Phòng An ninh mạng và phòng, chống tội phạm sử dụng công nghệ cao – Công an TP.Đà Nẵng khuyến cáo người dân cần nâng cao cảnh giác hơn nữa khi sử dụng các nền tảng mạng xã hội. Người dân cần tuân thủ theo nguyên tắc “3<strong> </strong>KHÔNG”: <strong>Không</strong> cung cấp thông tin cá nhân, tài khoản ngân hàng, số thẻ tín dụng qua điện thoại, tin nhắn hay email - <strong>Không</strong> truy cập đường link thanh toán từ tin nhắn hoặc email không rõ nguồn gốc - <strong>Không </strong>tải về những app không rõ nguồn gốc để tránh bị đánh cắp thông tin cá nhân. Khi thực hiện thanh toán hóa đơn trực tuyến, người dân cần truy cập trực tiếp vào website hoặc ứng dụng chính thức của đơn vị cung cấp dịch vụ.</p><p style=\"text-align:justify;\">Bamboo Airways trân trọng khuyến nghị hành khách luôn nâng cao cảnh giác với các thủ đoạn lừa đảo công nghệ cao. Nếu nhận thấy có dấu hiệu đáng ngờ hoặc phát hiện bị lừa đảo, hành khách cần ngay lập tức trình báo cho cơ quan Công an gần nhất để được hỗ trợ.&nbsp;</p><p style=\"text-align:justify;\">Để biết thông tin chính thức về các chuyến bay và đường bay của Bamboo Airways, vui lòng truy cập Website: <a href=\"https://www.bambooairways.com/\">https://www.bambooairways.com/</a>&nbsp;hoặc liên hệ:</p><ul><li><p style=\"text-align:justify;\">Fanpage chính thức: <a href=\"https://www.facebook.com/BambooAirwaysFanpage\">https://www.facebook.com/BambooAirwaysFanpage</a></p></li><li><p style=\"text-align:justify;\">Hotline: <a href=\"tel:8419001166\">19001166</a></p></li><li><p style=\"text-align:justify;\">Email: <a href=\"mailto:19001166@bambooairways.com\">19001166@bambooairways.com</a></p></li></ul>',1,1),(2,'Cục thuế tỉnh Bình Định hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways','img/news_bamboo_1.jpg','<p style=\"text-align:justify;\"><i>Ngày 16/10/2024, Cục thuế tỉnh Bình Định đã có văn bản gửi Cục Quản lý xuất nhập cảnh – Bộ Công An thông báo hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways – ông Lương Hoài Nam.</i></p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/449853545_484792347399617_8667786688385885570_n-jpg\" alt=\"\" width=\"2048\" height=\"1152\"></p><p style=\"text-align:justify;\">Sau các văn bản báo cáo, kiến nghị của hãng hàng không Bamboo Airways gửi Cục thuế tỉnh Bình Định và các cơ quan quản lý hữu quan, sáng ngày 15/10/2024 tại TP. Quy Nhơn, lãnh đạo Cục thuế tỉnh Bình Định và Bamboo Airways đã có buổi làm việc trực tiếp dưới sự chủ trì của ông Phạm Anh Tuấn - Chủ tịch UBND tỉnh Bình Định.</p><p style=\"text-align:justify;\">Tại buổi làm việc, hai bên đã tích cực trao đổi, tìm biện pháp tháo gỡ các khó khăn vướng mắc liên quan đến nợ thuế, trên tinh thần hỗ trợ, tạo điều kiện cho Bamboo Airways thực hiện thành công đề án tái cấu trúc toàn diện theo ý kiến chỉ đạo của Thủ tướng Chính phủ.</p><p style=\"text-align:justify;\">Trên cơ sở Bamboo Airways cam kết trả nợ thuế theo lộ trình và được ngân hàng bảo lãnh nghĩa vụ trả dần nợ thuế hàng tháng, ngay chiều ngày 16/10/2024, Cục thuế tỉnh Bình Định đã ban hành văn bản chính thức huỷ bỏ tạm hoãn xuất cảnh đối với ông Lương Hoài Nam. Trong thời gian Bamboo Airways thực hiện trả dần nợ thuế theo đúng cam kết, Cục Thuế tỉnh Bình Định sẽ không áp dụng các biện pháp cưỡng chế thuế khác đối với hãng hàng không, tạo điều kiện cho Bamboo Airways ổn định hoạt động, tái cấu trúc thành công và phát triển hiệu quả.</p>',2,1),(3,'Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo','img/news_bamboo_1.jpg','<p>Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo</p><p style=\"text-align:justify;\"><i>Bằng thủ đoạn mạo danh Cục Hàng không Việt Nam và thông báo chuyến bay bị hủy, các đối tượng lừa đảo sẽ yêu cầu người dân truy cập vào website giả mạo để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản...</i></p><p style=\"text-align:justify;\">Ngày 29/10/2024, Công an TP. Đà Nẵng đưa thông tin cảnh báo đến người dân về những chiêu lừa đảo mới và khuyến cáo nguyên tắc “3 không” để phòng tránh. Đơn cử, trên không gian mạng đã xuất hiện hình thức lừa đảo trực tuyến mới giả mạo Cục Hàng không Việt Nam thông báo chuyến bay bị hủy.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/canh-giac-voi-thu-oan-gia-mao-cuc-hang-khong-viet-nam-jpg\" alt=\"\" width=\"626\" height=\"368\"></p><p style=\"text-align:center;\"><i>Đối tượng giả mạo Cục Hàng không Việt Nam để lừa đảo chiếm đoạt tài sản</i></p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Theo đó, các đối tượng lừa đảo thu thập dữ liệu thông tin chuyến bay của khách hàng sau đó tạo lập các tài khoản Facebook giả mạo Cục Hàng không Việt Nam để gọi điện, nhắn tin cho khách hàng. Sau đó thông báo chuyến bay bị hủy và yêu cầu người dân truy cập vào trang website giả mạo <a href=\"https://cuchangkhongvietnam.com/\">https://cuchangkhongvietnam.com/</a> để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản.</p><p style=\"text-align:justify;\">Thực tế website chính thức của Cục Hàng không Việt Nam có địa chỉ là: <a href=\"https://caa.gov.vn/\">https://caa.gov.vn/</a></p><p style=\"text-align:justify;\">Trước tình hình này, Phòng An ninh mạng và phòng, chống tội phạm sử dụng công nghệ cao – Công an TP.Đà Nẵng khuyến cáo người dân cần nâng cao cảnh giác hơn nữa khi sử dụng các nền tảng mạng xã hội. Người dân cần tuân thủ theo nguyên tắc “3<strong> </strong>KHÔNG”: <strong>Không</strong> cung cấp thông tin cá nhân, tài khoản ngân hàng, số thẻ tín dụng qua điện thoại, tin nhắn hay email - <strong>Không</strong> truy cập đường link thanh toán từ tin nhắn hoặc email không rõ nguồn gốc - <strong>Không </strong>tải về những app không rõ nguồn gốc để tránh bị đánh cắp thông tin cá nhân. Khi thực hiện thanh toán hóa đơn trực tuyến, người dân cần truy cập trực tiếp vào website hoặc ứng dụng chính thức của đơn vị cung cấp dịch vụ.</p><p style=\"text-align:justify;\">Bamboo Airways trân trọng khuyến nghị hành khách luôn nâng cao cảnh giác với các thủ đoạn lừa đảo công nghệ cao. Nếu nhận thấy có dấu hiệu đáng ngờ hoặc phát hiện bị lừa đảo, hành khách cần ngay lập tức trình báo cho cơ quan Công an gần nhất để được hỗ trợ.&nbsp;</p><p style=\"text-align:justify;\">Để biết thông tin chính thức về các chuyến bay và đường bay của Bamboo Airways, vui lòng truy cập Website: <a href=\"https://www.bambooairways.com/\">https://www.bambooairways.com/</a>&nbsp;hoặc liên hệ:</p><ul><li><p style=\"text-align:justify;\">Fanpage chính thức: <a href=\"https://www.facebook.com/BambooAirwaysFanpage\">https://www.facebook.com/BambooAirwaysFanpage</a></p></li><li><p style=\"text-align:justify;\">Hotline: <a href=\"tel:8419001166\">19001166</a></p></li><li><p style=\"text-align:justify;\">Email: <a href=\"mailto:19001166@bambooairways.com\">19001166@bambooairways.com</a></p></li></ul>',3,1),(4,'Cục thuế tỉnh Bình Định hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways','img/news_bamboo_1.jpg','<p style=\"text-align:justify;\"><i>Ngày 16/10/2024, Cục thuế tỉnh Bình Định đã có văn bản gửi Cục Quản lý xuất nhập cảnh – Bộ Công An thông báo hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways – ông Lương Hoài Nam.</i></p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/449853545_484792347399617_8667786688385885570_n-jpg\" alt=\"\" width=\"2048\" height=\"1152\"></p><p style=\"text-align:justify;\">Sau các văn bản báo cáo, kiến nghị của hãng hàng không Bamboo Airways gửi Cục thuế tỉnh Bình Định và các cơ quan quản lý hữu quan, sáng ngày 15/10/2024 tại TP. Quy Nhơn, lãnh đạo Cục thuế tỉnh Bình Định và Bamboo Airways đã có buổi làm việc trực tiếp dưới sự chủ trì của ông Phạm Anh Tuấn - Chủ tịch UBND tỉnh Bình Định.</p><p style=\"text-align:justify;\">Tại buổi làm việc, hai bên đã tích cực trao đổi, tìm biện pháp tháo gỡ các khó khăn vướng mắc liên quan đến nợ thuế, trên tinh thần hỗ trợ, tạo điều kiện cho Bamboo Airways thực hiện thành công đề án tái cấu trúc toàn diện theo ý kiến chỉ đạo của Thủ tướng Chính phủ.</p><p style=\"text-align:justify;\">Trên cơ sở Bamboo Airways cam kết trả nợ thuế theo lộ trình và được ngân hàng bảo lãnh nghĩa vụ trả dần nợ thuế hàng tháng, ngay chiều ngày 16/10/2024, Cục thuế tỉnh Bình Định đã ban hành văn bản chính thức huỷ bỏ tạm hoãn xuất cảnh đối với ông Lương Hoài Nam. Trong thời gian Bamboo Airways thực hiện trả dần nợ thuế theo đúng cam kết, Cục Thuế tỉnh Bình Định sẽ không áp dụng các biện pháp cưỡng chế thuế khác đối với hãng hàng không, tạo điều kiện cho Bamboo Airways ổn định hoạt động, tái cấu trúc thành công và phát triển hiệu quả.</p>',4,1);
/*!40000 ALTER TABLE `News` ENABLE KEYS */;

--
-- Table structure for table `Passengers`
--

DROP TABLE IF EXISTS `Passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Passengers` (
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
  CONSTRAINT `Passengers_ibfk_1` FOREIGN KEY (`AccountId`) REFERENCES `Accounts` (`AccountId`),
  CONSTRAINT `Passengers_ibfk_2` FOREIGN KEY (`BookingId`) REFERENCES `Bookings` (`BookingId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Passengers`
--

/*!40000 ALTER TABLE `Passengers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Passengers` ENABLE KEYS */;

--
-- Table structure for table `Payments`
--

DROP TABLE IF EXISTS `Payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payments` (
  `PaymentId` int NOT NULL AUTO_INCREMENT,
  `BookingId` int NOT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL,
  `PaymentStatus` int DEFAULT '1',
  `PaymentDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `Email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `TotalPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`PaymentId`),
  KEY `BookingId` (`BookingId`),
  CONSTRAINT `Payments_ibfk_1` FOREIGN KEY (`BookingId`) REFERENCES `Bookings` (`BookingId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payments`
--

/*!40000 ALTER TABLE `Payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Payments` ENABLE KEYS */;

--
-- Table structure for table `Refund`
--

DROP TABLE IF EXISTS `Refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Refund` (
  `RefundId` int NOT NULL AUTO_INCREMENT,
  `TicketId` int NOT NULL,
  `BankAccount` varchar(50) DEFAULT NULL,
  `BankName` varchar(50) DEFAULT NULL,
  `RequestDate` datetime DEFAULT NULL,
  `RefundDate` datetime DEFAULT NULL,
  `RefundPrice` decimal(10,2) DEFAULT NULL,
  `Status` int DEFAULT '1',
  PRIMARY KEY (`RefundId`),
  KEY `TicketId` (`TicketId`),
  CONSTRAINT `Refund_ibfk_1` FOREIGN KEY (`TicketId`) REFERENCES `Tickets` (`TicketId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Refund`
--

/*!40000 ALTER TABLE `Refund` DISABLE KEYS */;
/*!40000 ALTER TABLE `Refund` ENABLE KEYS */;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Roles` (
  `RoleId` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(50) NOT NULL,
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES (1,'Admin'),(2,'Member');
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;

--
-- Table structure for table `Seats`
--

DROP TABLE IF EXISTS `Seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Seats` (
  `SeatId` int NOT NULL AUTO_INCREMENT,
  `AirlineId` int NOT NULL,
  `Status` int DEFAULT '1',
  `SeatNumber` int NOT NULL,
  `SeatClass` varchar(80) NOT NULL,
  `IsBooked` int DEFAULT '0',
  PRIMARY KEY (`SeatId`),
  KEY `AirlineId` (`AirlineId`),
  CONSTRAINT `Seats_ibfk_1` FOREIGN KEY (`AirlineId`) REFERENCES `Airlines` (`AirlineId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Seats`
--

/*!40000 ALTER TABLE `Seats` DISABLE KEYS */;
INSERT INTO `Seats` VALUES (1,1,1,1,'Economy',0),(2,1,1,2,'Economy',0),(3,1,1,3,'Economy',0),(4,1,1,1,'Business',0),(5,1,1,2,'Business',0),(6,1,1,3,'Business',0),(7,2,1,1,'Economy',0),(8,2,1,2,'Economy',0),(9,2,1,3,'Economy',0),(10,2,1,1,'Business',0),(11,2,1,2,'Business',0),(12,2,1,3,'Business',0),(13,3,1,1,'Economy',0),(14,3,1,2,'Economy',0),(15,3,1,3,'Economy',0),(16,3,1,1,'Business',0),(17,3,1,2,'Business',0),(18,3,1,3,'Business',0),(19,4,1,1,'Economy',0),(20,4,1,2,'Economy',0),(21,4,1,3,'Economy',0),(22,4,1,1,'Business',0),(23,4,1,2,'Business',0),(24,4,1,3,'Business',0);
/*!40000 ALTER TABLE `Seats` ENABLE KEYS */;

--
-- Table structure for table `Tickets`
--

DROP TABLE IF EXISTS `Tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tickets` (
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
  CONSTRAINT `Tickets_ibfk_1` FOREIGN KEY (`SeatId`) REFERENCES `Seats` (`SeatId`),
  CONSTRAINT `Tickets_ibfk_2` FOREIGN KEY (`PassengerId`) REFERENCES `Passengers` (`PassengerId`),
  CONSTRAINT `Tickets_ibfk_3` FOREIGN KEY (`BaggageId`) REFERENCES `Baggages` (`BaggageId`),
  CONSTRAINT `Tickets_ibfk_4` FOREIGN KEY (`FlightId`) REFERENCES `Flights` (`FlightId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tickets`
--

/*!40000 ALTER TABLE `Tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `Tickets` ENABLE KEYS */;

--
-- Dumping routines for database 'skytickets'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-08 13:09:46
