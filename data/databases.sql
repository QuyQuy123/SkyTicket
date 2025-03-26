-- Tạo database
-- CREATE DATABASE SkyTickets;
-- use SkyTickets;


-- Bảng Roles
CREATE TABLE Roles (
    RoleId INT PRIMARY KEY AUTO_INCREMENT,
    RoleName VARCHAR(50) NOT NULL
);
INSERT INTO Roles (RoleId, RoleName) VALUES 
(1, 'Admin'),
(2, 'Member');

INSERT INTO Roles (RoleName) VALUES
('Aircraft and Airport Manager'),
('Flight Manager'),
('Booking Manager');

-- Bảng Accounts
CREATE TABLE Accounts (
    AccountId INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    Address TEXT,
    Img VARCHAR(255),
    Dob DATE,
    Status TINYINT DEFAULT 1,
    RoleId INT,
    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
);
INSERT INTO Accounts (FullName, Email, Password, Phone, Address, Img, Dob, Status, RoleId) VALUES
('Admin User', 'admin@example.com', 'admin123', '0123456789', '123 Admin St', 'admin.jpg', '1990-01-01', 1, 1),
('Member User', 'member@example.com', 'member123', '0987654321', '456 Member St', 'member.jpg', '1995-05-05', 1, 2);

-- Bảng Discounts
CREATE TABLE Discounts (
    DiscountId INT PRIMARY KEY AUTO_INCREMENT,
    Percent DECIMAL(5,2) NOT NULL,
    AccountId INT,
    Points INT DEFAULT 0,
    FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId)
);



-- Bảng Bookings
CREATE TABLE Bookings (
    BookingId INT PRIMARY KEY AUTO_INCREMENT,
    Code varchar(50),
    ContactName nvarchar(50),
    ContactPhone nvarchar(15),
    ContactEmail nvarchar(50),
    TotalPrice DECIMAL(10,2) NOT NULL,
    BookingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status TINYINT DEFAULT 1,
    AccountId INT,
    FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId)
);

-- Bảng Passengers
CREATE TABLE Passengers (
    PassengerId INT PRIMARY KEY AUTO_INCREMENT,
    PassengerName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    IDNumber VARCHAR(50),
    Address TEXT,
    Dob DATE,
    Gender ENUM('Male', 'Female'),
    AccountId INT,
    BookingId int,
    FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId),
    FOREIGN KEY (BookingId) REFERENCES Bookings(BookingId)
);
-- Bảng Payments
CREATE TABLE Payments (
    PaymentId INT PRIMARY KEY AUTO_INCREMENT,
    BookingId INT NOT NULL,
    PaymentMethod VARCHAR(50),
    PaymentStatus int default 1,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Email nvarchar(50),
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (BookingId) REFERENCES Bookings(BookingId)
);

-- Bảng Airlines
CREATE TABLE Airlines (
    AirlineId INT PRIMARY KEY AUTO_INCREMENT,
    AirlineName VARCHAR(100) NOT NULL,
    Image VARCHAR(255),
    Information TEXT,
    Status TINYINT DEFAULT 1,
	NumberOfSeatsOnVipRow int,
    NumberOfSeatsOnVipColumn int,
    NumberOfSeatsOnEconomyRow int,
    NumberOfSeatsOnEconomyColumn int
);
INSERT INTO Airlines (AirlineId, AirlineName, Image, Information, Status, NumberOfSeatsOnVipRow, NumberOfSeatsOnVipColumn,NumberOfSeatsOnEconomyRow,NumberOfSeatsOnEconomyColumn) 
VALUES 
(1, 'Airbus A320C1', 'news_bamboo_1.jpg', 'Hãng hàng không tư nhân đầu tiên tại Việt Nam.', 1, 4, 5,6,7),
(2, 'Airbus A320C2', 'news_bamboo_1.jpg', 'Hãng hàng không quốc gia Việt Nam với dịch vụ chất lượng cao.',1, 4, 5,6,7),
(3, 'Airbus A320C3', 'news_bamboo_1.jpg', 'Hãng hàng không tư nhân đầu tiên tại Việt Nam.', 1, 4, 5,6,7),
(4, 'Airbus A320C4', 'news_bamboo_1.jpg', 'Hãng hàng không quốc gia Việt Nam với dịch vụ chất lượng cao.', 1, 4, 5,6,7);



-- Bảng Baggages
CREATE TABLE Baggages (
    BaggageId INT PRIMARY KEY AUTO_INCREMENT,
    Weight DECIMAL(5,2),
    Price DECIMAL(10,2),
    AirlineId int ,
    Status int default 1,
     FOREIGN KEY (AirlineId) REFERENCES Airlines(AirlineId)
);


INSERT INTO Baggages ( Weight, Price,AirlineId) 
VALUES 
    ( 15.50, 300000,1),
    ( 2.30, 50000,2),
    (10.00, 200000,3),
    ( 5.20, 150000,4),
    ( 7.80, 180000,1);

-- Bảng Countries
CREATE TABLE Countries (
    CountryId INT PRIMARY KEY AUTO_INCREMENT,
    CountryName VARCHAR(100) NOT NULL,
    Status TINYINT DEFAULT 1
);
INSERT INTO Countries (CountryId, CountryName) VALUES
    (1, 'Viet Nam'),
    (2, 'Nhat Ban'),
    (3, 'Han Quoc'),
    (4, 'Thai Lan'),
    (5, 'Singapore'),
    (6, 'Malaysia'),
    (7, 'Trung Quoc'),
    (8, 'An Do'),
    (9, 'Uc'),
    (10, 'My'),
    (11, 'Anh'),
    (12, 'Phap'),
    (13, 'Đuc'),
    (14, 'Canada'),
    (15, 'Indonesia');

-- Bảng Locations
CREATE TABLE Locations (
    LocationId INT PRIMARY KEY AUTO_INCREMENT,
    LocationName VARCHAR(100) NOT NULL,
    CountryId INT NOT NULL,
    Status TINYINT DEFAULT 1,
    FOREIGN KEY (CountryId) REFERENCES Countries(CountryId)
);
INSERT INTO Locations (LocationId, LocationName, CountryId) VALUES
    (1, 'Ha Noi', 1),
    (2, 'Ho Chi Minh', 1),
    (3, 'Tokyo', 2),
    (4, 'Osaka', 2),
    (5, 'Seoul', 3),
    (6, 'Busan', 3),
    (7, 'Bangkok', 4),
    (8, 'Singapore', 5),
    (9, 'Kuala Lumpur', 6),
    (10, 'Bac Kinh', 7),
    (11, 'Mumbai', 8),
    (12, 'Sydney', 9),
    (13, 'New York', 10),
    (14, 'London', 11),
    (15, 'Paris', 12);

-- Bảng Airports
CREATE TABLE Airports (
    AirportId INT PRIMARY KEY AUTO_INCREMENT,
    AirportName VARCHAR(100) NOT NULL,
    LocationId INT NOT NULL,
    Status TINYINT DEFAULT 1,
    FOREIGN KEY (LocationId) REFERENCES Locations(LocationId)
);
INSERT INTO Airports (AirportId, AirportName, LocationId) VALUES
    (1, 'Nội Bài International Airport', 1),
    (2, 'Tân Sơn Nhất International Airport', 2),
    (3, 'Narita International Airport', 3),
    (4, 'Kansai International Airport', 4),
    (5, 'Incheon International Airport', 5),
    (6, 'Gimhae International Airport', 6),
    (7, 'Suvarnabhumi Airport', 7),
    (8, 'Changi Airport', 8),
    (9, 'Kuala Lumpur International Airport', 9),
    (10, 'Beijing Capital International Airport', 10),
    (11, 'Chhatrapati Shivaji International Airport', 11),
    (12, 'Sydney Kingsford Smith Airport', 12),
    (13, 'John F. Kennedy International Airport', 13),
    (14, 'Heathrow Airport', 14),
    (15, 'Charles de Gaulle Airport', 15);

-- Bảng Flights
CREATE TABLE Flights (
    FlightId INT PRIMARY KEY AUTO_INCREMENT,
    ArrivalTime DATETIME,
    DepartureTime DATETIME,
    ArrivalAirportId INT NOT NULL,
    DepartureAirportId INT NOT NULL,
    Status VARCHAR(50),
    AirlineId INT,
    ClassVipPrice DECIMAL(10,2),
    ClassEconomyPrice DECIMAL(10,2),
    FOREIGN KEY (AirlineId) REFERENCES Airlines(AirlineId),
    FOREIGN KEY (ArrivalAirportId) REFERENCES Airports(AirportId),
    FOREIGN KEY (DepartureAirportId) REFERENCES Airports(AirportId)
);
INSERT INTO Flights (ArrivalTime, DepartureTime, ArrivalAirportId, DepartureAirportId, Status, AirlineId, ClassVipPrice, ClassEconomyPrice)
VALUES 
('2025-03-27 10:00:00', '2025-03-27 07:30:00', 2, 1, 1, 1, 2000000.00, 1000000.00),
('2025-03-27 15:00:00', '2025-03-27 12:00:00', 3, 2, 1, 2, 2500000.00, 1200000.00),
('2025-03-27 18:30:00', '2025-03-27 16:00:00', 4, 3, 1, 3, 2800000.00, 1500000.00),
('2025-03-27 08:45:00', '2025-03-27 06:20:00', 2, 4, 1, 4, 3000000.00, 17000000.00),
('2025-03-27 12:15:00', '2025-03-27 09:45:00', 1, 4, 1, 2, 2200000.00, 11000000.00),
('2025-03-27 17:00:00', '2025-03-27 14:30:00', 3, 1, 1, 1, 2600000.00, 13000000.00),
('2025-03-27 22:10:00', '2025-03-27 19:45:00', 5, 1, 1, 2, 2900000.00, 1400000.00),
('2025-03-27 05:30:00', '2025-03-27 03:00:00', 5, 1, 1, 3, 3100000.00, 1800000.00),
('2025-03-27 09:20:00', '2025-03-27 06:50:00', 5, 1, 1, 4, 2400000.00, 1150000.00),
('2025-03-27 14:00:00', '2025-03-27 11:30:00', 7, 2, 1, 1, 2300000.00, 1150000.00),
('2025-03-27 19:00:00', '2025-03-27 16:15:00', 8, 3, 1, 2, 2700000.00, 1350000.00),
('2025-03-27 09:30:00', '2025-03-27 07:00:00', 9, 5, 1, 3, 3000000.00, 1500000.00),
('2025-03-27 15:45:00', '2025-03-27 13:00:00', 10, 4, 1, 4, 3200000.00, 1600000.00),
('2025-03-27 21:00:00', '2025-03-27 18:30:00', 11, 6, 1, 1, 3500000.00, 1750000.00),
('2025-03-27 06:00:00', '2025-03-27 03:30:00', 12, 7, 1, 2, 4000000.00, 200000.00),
('2025-03-27 23:30:00', '2025-03-27 21:00:00', 5, 1, 1, 2, 2900000.00, 1400000.00),
('2025-03-27 01:45:00', '2025-03-27 23:15:00', 5, 1, 1, 3, 3100000.00, 1800000.00),
('2025-03-27 03:50:00', '2025-03-27 01:20:00', 5, 1, 1, 4, 2400000.00, 1150000.00),
('2025-03-27 11:00:00', '2025-03-27 08:30:00', 5, 1, 1, 2, 2900000.00, 1400000.00),
('2025-03-27 13:15:00', '2025-03-27 10:45:00', 5, 1, 1, 3, 3100000.00, 1800000.00),
('2025-03-27 15:30:00', '2025-03-27 13:00:00', 5, 1, 1, 4, 2400000.00, 1150000.00),
('2025-03-27 11:00:00', '2025-03-27 09:30:00', 1, 5, 1, 1, 2900000.00, 1400000.00),
('2025-03-27 14:00:00', '2025-03-27 12:30:00', 1, 5, 1, 2, 3100000.00, 1800000.00),
('2025-03-27 17:00:00', '2025-03-27 15:30:00', 1, 5, 1, 3, 2400000.00, 1150000.00),
('2025-03-27 20:00:00', '2025-03-27 18:30:00', 1, 5, 1, 4, 2900000.00, 1400000.00),
('2025-03-27 23:00:00', '2025-03-27 21:30:00', 1, 5, 1, 1, 3100000.00, 1800000.00),
('2025-03-27 09:00:00', '2025-03-27 07:30:00', 1, 5, 1, 1, 2400000.00, 1150000.00);
-- Bảng Seats
CREATE TABLE Seats (
    SeatId INT PRIMARY KEY AUTO_INCREMENT,
    AirlineId INT NOT NULL,  -- Thay FlightId bằng AirlineId
    Status INT DEFAULT 1,
    SeatNumber INT NOT NULL,
    SeatClass VARCHAR(80) NOT NULL,
    IsBooked INT DEFAULT 0,
    FOREIGN KEY (AirlineId) REFERENCES Airlines(AirlineId)  -- Khóa ngoại liên kết với Airlines
);

-- Dữ liệu mẫu cho bảng Seats (cập nhật để sử dụng AirlineId)
INSERT INTO Seats (AirlineId, SeatNumber, SeatClass) VALUES
(1, 1, 'Economy'), (1, 2, 'Economy'), (1, 3, 'Business'), (1, 4, 'Business'), (1, 5, 'Economy'),
(2, 1, 'Economy'), (2, 2, 'Business'), (2, 3, 'Business'), (2, 4, 'Economy'), (2, 5, 'Economy'),
(3, 1, 'Business'), (3, 2, 'Economy'), (3, 3, 'Economy'), (3, 4, 'Business'), (3, 5, 'Economy'),
(4, 1, 'Business'), (4, 2, 'Business'), (4, 3, 'Economy'), (4, 4, 'Economy'), (4, 5, 'Economy'),
(2, 1, 'Economy'), (2, 2, 'Economy'), (2, 3, 'Business'), (2, 4, 'Business'), (2, 5, 'Economy');

-- Bảng Tickets
CREATE TABLE Tickets (
    TicketId INT PRIMARY KEY AUTO_INCREMENT,
    SeatId INT NOT NULL,
    PassengerId INT NOT NULL,
    Code VARCHAR(50) ,
    Status TINYINT DEFAULT 1,
    CreateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    BookingId INT,
    FlightId INT,
    BaggageId int,
    Price float,
    CancelledAT datetime,
    FOREIGN KEY (SeatId) REFERENCES Seats(SeatId),
    FOREIGN KEY (PassengerId) REFERENCES Passengers(PassengerId),
    FOREIGN KEY (BaggageId) REFERENCES Baggages(BaggageId),
    FOREIGN KEY (FlightId) REFERENCES Flights(FlightId)
);

-- Bảng News
CREATE TABLE News (
    NewId INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Img VARCHAR(255),
    Content TEXT,
    AirlineId INT,
    Status TINYINT DEFAULT 1,
    FOREIGN KEY (AirlineId) REFERENCES Airlines(AirlineId)
);
INSERT INTO `News` VALUES 

 (1,'Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo','img/news_bamboo_1.jpg','<p>Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo</p><p style=\"text-align:justify;\"><i>Bằng thủ đoạn mạo danh Cục Hàng không Việt Nam và thông báo chuyến bay bị hủy, các đối tượng lừa đảo sẽ yêu cầu người dân truy cập vào website giả mạo để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản...</i></p><p style=\"text-align:justify;\">Ngày 29/10/2024, Công an TP. Đà Nẵng đưa thông tin cảnh báo đến người dân về những chiêu lừa đảo mới và khuyến cáo nguyên tắc “3 không” để phòng tránh. Đơn cử, trên không gian mạng đã xuất hiện hình thức lừa đảo trực tuyến mới giả mạo Cục Hàng không Việt Nam thông báo chuyến bay bị hủy.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/canh-giac-voi-thu-oan-gia-mao-cuc-hang-khong-viet-nam-jpg\" alt=\"\" width=\"626\" height=\"368\"></p><p style=\"text-align:center;\"><i>Đối tượng giả mạo Cục Hàng không Việt Nam để lừa đảo chiếm đoạt tài sản</i></p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Theo đó, các đối tượng lừa đảo thu thập dữ liệu thông tin chuyến bay của khách hàng sau đó tạo lập các tài khoản Facebook giả mạo Cục Hàng không Việt Nam để gọi điện, nhắn tin cho khách hàng. Sau đó thông báo chuyến bay bị hủy và yêu cầu người dân truy cập vào trang website giả mạo <a href=\"https://cuchangkhongvietnam.com/\">https://cuchangkhongvietnam.com/</a> để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản.</p><p style=\"text-align:justify;\">Thực tế website chính thức của Cục Hàng không Việt Nam có địa chỉ là: <a href=\"https://caa.gov.vn/\">https://caa.gov.vn/</a></p><p style=\"text-align:justify;\">Trước tình hình này, Phòng An ninh mạng và phòng, chống tội phạm sử dụng công nghệ cao – Công an TP.Đà Nẵng khuyến cáo người dân cần nâng cao cảnh giác hơn nữa khi sử dụng các nền tảng mạng xã hội. Người dân cần tuân thủ theo nguyên tắc “3<strong> </strong>KHÔNG”: <strong>Không</strong> cung cấp thông tin cá nhân, tài khoản ngân hàng, số thẻ tín dụng qua điện thoại, tin nhắn hay email - <strong>Không</strong> truy cập đường link thanh toán từ tin nhắn hoặc email không rõ nguồn gốc - <strong>Không </strong>tải về những app không rõ nguồn gốc để tránh bị đánh cắp thông tin cá nhân. Khi thực hiện thanh toán hóa đơn trực tuyến, người dân cần truy cập trực tiếp vào website hoặc ứng dụng chính thức của đơn vị cung cấp dịch vụ.</p><p style=\"text-align:justify;\">Bamboo Airways trân trọng khuyến nghị hành khách luôn nâng cao cảnh giác với các thủ đoạn lừa đảo công nghệ cao. Nếu nhận thấy có dấu hiệu đáng ngờ hoặc phát hiện bị lừa đảo, hành khách cần ngay lập tức trình báo cho cơ quan Công an gần nhất để được hỗ trợ.&nbsp;</p><p style=\"text-align:justify;\">Để biết thông tin chính thức về các chuyến bay và đường bay của Bamboo Airways, vui lòng truy cập Website: <a href=\"https://www.bambooairways.com/\">https://www.bambooairways.com/</a>&nbsp;hoặc liên hệ:</p><ul><li><p style=\"text-align:justify;\">Fanpage chính thức: <a href=\"https://www.facebook.com/BambooAirwaysFanpage\">https://www.facebook.com/BambooAirwaysFanpage</a></p></li><li><p style=\"text-align:justify;\">Hotline: <a href=\"tel:8419001166\">19001166</a></p></li><li><p style=\"text-align:justify;\">Email: <a href=\"mailto:19001166@bambooairways.com\">19001166@bambooairways.com</a></p></li></ul>',1,1),


 (2,'Cục thuế tỉnh Bình Định hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways','img/news_bamboo_1.jpg','<p style=\"text-align:justify;\"><i>Ngày 16/10/2024, Cục thuế tỉnh Bình Định đã có văn bản gửi Cục Quản lý xuất nhập cảnh – Bộ Công An thông báo hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways – ông Lương Hoài Nam.</i></p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/449853545_484792347399617_8667786688385885570_n-jpg\" alt=\"\" width=\"2048\" height=\"1152\"></p><p style=\"text-align:justify;\">Sau các văn bản báo cáo, kiến nghị của hãng hàng không Bamboo Airways gửi Cục thuế tỉnh Bình Định và các cơ quan quản lý hữu quan, sáng ngày 15/10/2024 tại TP. Quy Nhơn, lãnh đạo Cục thuế tỉnh Bình Định và Bamboo Airways đã có buổi làm việc trực tiếp dưới sự chủ trì của ông Phạm Anh Tuấn - Chủ tịch UBND tỉnh Bình Định.</p><p style=\"text-align:justify;\">Tại buổi làm việc, hai bên đã tích cực trao đổi, tìm biện pháp tháo gỡ các khó khăn vướng mắc liên quan đến nợ thuế, trên tinh thần hỗ trợ, tạo điều kiện cho Bamboo Airways thực hiện thành công đề án tái cấu trúc toàn diện theo ý kiến chỉ đạo của Thủ tướng Chính phủ.</p><p style=\"text-align:justify;\">Trên cơ sở Bamboo Airways cam kết trả nợ thuế theo lộ trình và được ngân hàng bảo lãnh nghĩa vụ trả dần nợ thuế hàng tháng, ngay chiều ngày 16/10/2024, Cục thuế tỉnh Bình Định đã ban hành văn bản chính thức huỷ bỏ tạm hoãn xuất cảnh đối với ông Lương Hoài Nam. Trong thời gian Bamboo Airways thực hiện trả dần nợ thuế theo đúng cam kết, Cục Thuế tỉnh Bình Định sẽ không áp dụng các biện pháp cưỡng chế thuế khác đối với hãng hàng không, tạo điều kiện cho Bamboo Airways ổn định hoạt động, tái cấu trúc thành công và phát triển hiệu quả.</p>',2,1),


(3,'Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo','img/news_bamboo_1.jpg','<p>Cảnh giác với thủ đoạn giả mạo Cục Hàng không Việt Nam thông báo hủy chuyến bay để lừa đảo</p><p style=\"text-align:justify;\"><i>Bằng thủ đoạn mạo danh Cục Hàng không Việt Nam và thông báo chuyến bay bị hủy, các đối tượng lừa đảo sẽ yêu cầu người dân truy cập vào website giả mạo để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản...</i></p><p style=\"text-align:justify;\">Ngày 29/10/2024, Công an TP. Đà Nẵng đưa thông tin cảnh báo đến người dân về những chiêu lừa đảo mới và khuyến cáo nguyên tắc “3 không” để phòng tránh. Đơn cử, trên không gian mạng đã xuất hiện hình thức lừa đảo trực tuyến mới giả mạo Cục Hàng không Việt Nam thông báo chuyến bay bị hủy.</p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/canh-giac-voi-thu-oan-gia-mao-cuc-hang-khong-viet-nam-jpg\" alt=\"\" width=\"626\" height=\"368\"></p><p style=\"text-align:center;\"><i>Đối tượng giả mạo Cục Hàng không Việt Nam để lừa đảo chiếm đoạt tài sản</i></p><p style=\"text-align:justify;\">&nbsp;</p><p style=\"text-align:justify;\">Theo đó, các đối tượng lừa đảo thu thập dữ liệu thông tin chuyến bay của khách hàng sau đó tạo lập các tài khoản Facebook giả mạo Cục Hàng không Việt Nam để gọi điện, nhắn tin cho khách hàng. Sau đó thông báo chuyến bay bị hủy và yêu cầu người dân truy cập vào trang website giả mạo <a href=\"https://cuchangkhongvietnam.com/\">https://cuchangkhongvietnam.com/</a> để đặt lại vé, nhằm thu thập dữ liệu cá nhân và lừa đảo chiếm đoạt tài sản.</p><p style=\"text-align:justify;\">Thực tế website chính thức của Cục Hàng không Việt Nam có địa chỉ là: <a href=\"https://caa.gov.vn/\">https://caa.gov.vn/</a></p><p style=\"text-align:justify;\">Trước tình hình này, Phòng An ninh mạng và phòng, chống tội phạm sử dụng công nghệ cao – Công an TP.Đà Nẵng khuyến cáo người dân cần nâng cao cảnh giác hơn nữa khi sử dụng các nền tảng mạng xã hội. Người dân cần tuân thủ theo nguyên tắc “3<strong> </strong>KHÔNG”: <strong>Không</strong> cung cấp thông tin cá nhân, tài khoản ngân hàng, số thẻ tín dụng qua điện thoại, tin nhắn hay email - <strong>Không</strong> truy cập đường link thanh toán từ tin nhắn hoặc email không rõ nguồn gốc - <strong>Không </strong>tải về những app không rõ nguồn gốc để tránh bị đánh cắp thông tin cá nhân. Khi thực hiện thanh toán hóa đơn trực tuyến, người dân cần truy cập trực tiếp vào website hoặc ứng dụng chính thức của đơn vị cung cấp dịch vụ.</p><p style=\"text-align:justify;\">Bamboo Airways trân trọng khuyến nghị hành khách luôn nâng cao cảnh giác với các thủ đoạn lừa đảo công nghệ cao. Nếu nhận thấy có dấu hiệu đáng ngờ hoặc phát hiện bị lừa đảo, hành khách cần ngay lập tức trình báo cho cơ quan Công an gần nhất để được hỗ trợ.&nbsp;</p><p style=\"text-align:justify;\">Để biết thông tin chính thức về các chuyến bay và đường bay của Bamboo Airways, vui lòng truy cập Website: <a href=\"https://www.bambooairways.com/\">https://www.bambooairways.com/</a>&nbsp;hoặc liên hệ:</p><ul><li><p style=\"text-align:justify;\">Fanpage chính thức: <a href=\"https://www.facebook.com/BambooAirwaysFanpage\">https://www.facebook.com/BambooAirwaysFanpage</a></p></li><li><p style=\"text-align:justify;\">Hotline: <a href=\"tel:8419001166\">19001166</a></p></li><li><p style=\"text-align:justify;\">Email: <a href=\"mailto:19001166@bambooairways.com\">19001166@bambooairways.com</a></p></li></ul>',3,1),


(4,'Cục thuế tỉnh Bình Định hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways','img/news_bamboo_1.jpg','<p style=\"text-align:justify;\"><i>Ngày 16/10/2024, Cục thuế tỉnh Bình Định đã có văn bản gửi Cục Quản lý xuất nhập cảnh – Bộ Công An thông báo hủy bỏ tạm hoãn xuất cảnh với CEO Bamboo Airways – ông Lương Hoài Nam.</i></p><p style=\"text-align:center;\"><img src=\"https://www.bambooairways.com/documents/d/global/449853545_484792347399617_8667786688385885570_n-jpg\" alt=\"\" width=\"2048\" height=\"1152\"></p><p style=\"text-align:justify;\">Sau các văn bản báo cáo, kiến nghị của hãng hàng không Bamboo Airways gửi Cục thuế tỉnh Bình Định và các cơ quan quản lý hữu quan, sáng ngày 15/10/2024 tại TP. Quy Nhơn, lãnh đạo Cục thuế tỉnh Bình Định và Bamboo Airways đã có buổi làm việc trực tiếp dưới sự chủ trì của ông Phạm Anh Tuấn - Chủ tịch UBND tỉnh Bình Định.</p><p style=\"text-align:justify;\">Tại buổi làm việc, hai bên đã tích cực trao đổi, tìm biện pháp tháo gỡ các khó khăn vướng mắc liên quan đến nợ thuế, trên tinh thần hỗ trợ, tạo điều kiện cho Bamboo Airways thực hiện thành công đề án tái cấu trúc toàn diện theo ý kiến chỉ đạo của Thủ tướng Chính phủ.</p><p style=\"text-align:justify;\">Trên cơ sở Bamboo Airways cam kết trả nợ thuế theo lộ trình và được ngân hàng bảo lãnh nghĩa vụ trả dần nợ thuế hàng tháng, ngay chiều ngày 16/10/2024, Cục thuế tỉnh Bình Định đã ban hành văn bản chính thức huỷ bỏ tạm hoãn xuất cảnh đối với ông Lương Hoài Nam. Trong thời gian Bamboo Airways thực hiện trả dần nợ thuế theo đúng cam kết, Cục Thuế tỉnh Bình Định sẽ không áp dụng các biện pháp cưỡng chế thuế khác đối với hãng hàng không, tạo điều kiện cho Bamboo Airways ổn định hoạt động, tái cấu trúc thành công và phát triển hiệu quả.</p>',4,1);


-- Bảng Refund (bổ sung mới)
CREATE TABLE Refund (
    RefundId INT PRIMARY KEY AUTO_INCREMENT,
    TicketId INT NOT NULL,
    BankAccount VARCHAR(50),
    BankName VARCHAR(50),
    RequestDate DATETIME,
    RefundDate DATETIME,
    RefundPrice DECIMAL(10,2),
    Status TINYINT DEFAULT 1,
    FOREIGN KEY (TicketId) REFERENCES Tickets(TicketId)
);

INSERT INTO Baggages (Weight, Price, AirlineId, Status) VALUES
-- Liên kết với Airbus A320C1 (AirlineId = 1)
(5.00, 100000, 1, 1),
(10.00, 200000, 1, 1),
(15.00, 300000, 1, 1),
(20.00, 400000, 1, 1),
(25.00, 500000, 1, 1),
-- Liên kết với Airbus A320C2 (AirlineId = 2)
(7.50, 150000, 2, 1),
(12.50, 250000, 2, 1),
(17.50, 350000, 2, 1),
(22.50, 450000, 2, 1),
(30.00, 600000, 2, 1),
-- Liên kết với Airbus A320C3 (AirlineId = 3)
(8.00, 160000, 3, 1),
(13.00, 260000, 3, 1),
(18.00, 360000, 3, 1),
(23.00, 460000, 3, 1),
(28.00, 560000, 3, 1),
-- Liên kết với Airbus A320C4 (AirlineId = 4)
(6.50, 130000, 4, 1),
(11.50, 230000, 4, 1),
(16.50, 330000, 4, 1),
(21.50, 430000, 4, 1),
(27.00, 540000, 4, 1);

INSERT INTO Accounts (FullName, Email, Password, Phone, Address, Img, Dob, Status, RoleId) VALUES
('Nguyễn Văn Hùng', 'nguyenvanhung@example.com', 'hung123', '0912345001', '123 Nguyễn Trãi, Hà Nội', 'hung.jpg', '1990-03-15', 1, 2),
('Trần Thị Mai', 'tranthimai@example.com', 'mai456', '0912345002', '456 Lê Lợi, TP.HCM', 'mai.jpg', '1988-07-20', 1, 2),
('Lê Văn Nam', 'levannam@example.com', 'nam789', '0912345003', '789 Trần Phú, Đà Nẵng', 'nam.jpg', '1995-11-10', 1, 2),
('Phạm Thị Lan', 'phamthilan@example.com', 'lan101', '0912345004', '321 Hùng Vương, Huế', 'lan.jpg', '1992-04-25', 1, 2),
('Hoàng Văn Tuấn', 'hoangvantuan@example.com', 'tuan102', '0912345005', '654 Nguyễn Huệ, Nha Trang', 'tuan.jpg', '1985-09-30', 1, 2),
('Bùi Thị Ngọc', 'buithingoc@example.com', 'ngoc103', '0912345006', '987 Lý Thường Kiệt, Cần Thơ', 'ngoc.jpg', '1993-12-05', 1, 2),
('Đặng Văn Long', 'dangvanlong@example.com', 'long104', '0912345007', '147 Bà Triệu, Vũng Tàu', 'long.jpg', '1987-06-15', 1, 2),
('Vũ Thị Hương', 'vuthihuong@example.com', 'huong105', '0912345008', '258 Nguyễn Văn Cừ, Phú Quốc', 'huong.jpg', '1996-08-20', 1, 2),
('Ngô Văn Bình', 'ngovanbinh@example.com', 'binh106', '0912345009', '369 Trần Hưng Đạo, Hải Phòng', 'binh.jpg', '1991-01-10', 1, 2),
('Đỗ Thị Thảo', 'dothithao@example.com', 'thao107', '0912345010', '741 Lê Đại Hành, Quảng Ninh', 'thao.jpg', '1989-02-14', 1, 2),
('Nguyễn Thị Hoa', 'nguyenthihoa@example.com', 'hoa108', '0912345011', '852 Phạm Ngũ Lão, Hà Nội', 'hoa.jpg', '1994-05-18', 1, 2),
('Trần Văn Đức', 'tranvanduc@example.com', 'duc109', '0912345012', '963 Nguyễn Thị Minh Khai, TP.HCM', 'duc.jpg', '1986-08-22', 1, 2),
('Lê Thị Minh', 'lethiminh@example.com', 'minh110', '0912345013', '147 Lê Thánh Tôn, Đà Nẵng', 'minh.jpg', '1997-11-30', 1, 2),
('Phạm Văn Tâm', 'phamvantam@example.com', 'tam111', '0912345014', '258 Trần Cao Vân, Huế', 'tam.jpg', '1990-03-10', 1, 2),
('Hoàng Thị Linh', 'hoangthilinh@example.com', 'linh112', '0912345015', '369 Nguyễn Đình Chiểu, Nha Trang', 'linh.jpg', '1995-07-15', 1, 2),
('Bùi Văn Phong', 'buivanphong@example.com', 'phong113', '0912345016', '741 Lê Hồng Phong, Cần Thơ', 'phong.jpg', '1988-09-25', 1, 2),
('Đặng Thị Thu', 'dangthithu@example.com', 'thu114', '0912345017', '852 Trần Quốc Toàn, Vũng Tàu', 'thu.jpg', '1992-12-20', 1, 2),
('Vũ Văn Hải', 'vuvanhai@example.com', 'hai115', '0912345018', '963 Nguyễn Công Trứ, Phú Quốc', 'hai.jpg', '1987-01-05', 1, 2),
('Ngô Thị Yến', 'ngothiyen@example.com', 'yen116', '0912345019', '147 Phạm Văn Đồng, Hải Phòng', 'yen.jpg', '1993-04-12', 1, 2),
('Đỗ Văn Sơn', 'dovanson@example.com', 'son117', '0912345020', '258 Bạch Đằng, Quảng Ninh', 'son.jpg', '1989-06-18', 1, 2);

INSERT INTO Discounts (Percent, AccountId, Points) VALUES
(5.00, 3, 50),    -- Nguyễn Văn Hùng
(10.00, 4, 100),  -- Trần Thị Mai
(15.00, 5, 150),  -- Lê Văn Nam
(7.50, 6, 75),    -- Phạm Thị Lan
(20.00, 7, 200),  -- Hoàng Văn Tuấn
(12.50, 8, 125),  -- Bùi Thị Ngọc
(8.00, 9, 80),    -- Đặng Văn Long
(25.00, 10, 250), -- Vũ Thị Hương
(10.00, 11, 100), -- Ngô Văn Bình
(18.00, 12, 180), -- Đỗ Thị Thảo
(6.00, 13, 60),   -- Nguyễn Thị Hoa
(14.00, 14, 140), -- Trần Văn Đức
(9.00, 15, 90),   -- Lê Thị Minh
(22.00, 16, 220), -- Phạm Văn Tâm
(11.00, 17, 110), -- Hoàng Thị Linh
(17.00, 18, 170), -- Bùi Văn Phong
(13.00, 19, 130), -- Đặng Thị Thu
(19.00, 20, 190), -- Vũ Văn Hải
(8.50, 21, 85),   -- Ngô Thị Yến
(16.00, 22, 160); -- Đỗ Văn Sơn

INSERT INTO Bookings (Code, ContactName, ContactPhone, ContactEmail, TotalPrice, BookingDate, Status, AccountId) VALUES
('BK001', 'Nguyễn Văn Hùng', '0912345001', 'nguyenvanhung@example.com', 1500000.00, '2025-03-25 08:00:00', 2, 3),  -- Payment Success
('BK002', 'Trần Thị Mai', '0912345002', 'tranthimai@example.com', 2000000.00, '2025-03-25 08:15:00', 1, 4),    -- Is Pending
('BK003', 'Lê Văn Nam', '0912345003', 'levannam@example.com', 1200000.00, '2025-03-25 08:30:00', 2, 5),     -- Payment Success
('BK004', 'Phạm Thị Lan', '0912345004', 'phamthilan@example.com', 1800000.00, '2025-03-25 08:45:00', 3, 6),   -- Is Cancelled
('BK005', 'Hoàng Văn Tuấn', '0912345005', 'hoangvantuan@example.com', 2200000.00, '2025-03-25 09:00:00', 2, 7), -- Payment Success
('BK006', 'Bùi Thị Ngọc', '0912345006', 'buithingoc@example.com', 1300000.00, '2025-03-25 09:15:00', 1, 8),    -- Is Pending
('BK007', 'Đặng Văn Long', '0912345007', 'dangvanlong@example.com', 1700000.00, '2025-03-25 09:30:00', 2, 9),  -- Payment Success
('BK008', 'Vũ Thị Hương', '0912345008', 'vuthihuong@example.com', 2500000.00, '2025-03-25 09:45:00', 4, 10),  -- Refund Pending
('BK009', 'Ngô Văn Bình', '0912345009', 'ngovanbinh@example.com', 1400000.00, '2025-03-25 10:00:00', 1, 11),  -- Is Pending
('BK010', 'Đỗ Thị Thảo', '0912345010', 'dothithao@example.com', 1900000.00, '2025-03-25 10:15:00', 5, 12),   -- Refund Complete
('BK011', 'Nguyễn Thị Hoa', '0912345011', 'nguyenthihoa@example.com', 1600000.00, '2025-03-25 10:30:00', 2, 13), -- Payment Success
('BK012', 'Trần Văn Đức', '0912345012', 'tranvanduc@example.com', 2100000.00, '2025-03-25 10:45:00', 1, 14),   -- Is Pending
('BK013', 'Lê Thị Minh', '0912345013', 'lethiminh@example.com', 1150000.00, '2025-03-25 11:00:00', 2, 15),   -- Payment Success
('BK014', 'Phạm Văn Tâm', '0912345014', 'phamvantam@example.com', 2300000.00, '2025-03-25 11:15:00', 3, 16),  -- Is Cancelled
('BK015', 'Hoàng Thị Linh', '0912345015', 'hoangthilinh@example.com', 1750000.00, '2025-03-25 11:30:00', 4, 17), -- Refund Pending
('BK016', 'Bùi Văn Phong', '0912345016', 'buivanphong@example.com', 1450000.00, '2025-03-25 11:45:00', 1, 18), -- Is Pending
('BK017', 'Đặng Thị Thu', '0912345017', 'dangthithu@example.com', 1850000.00, '2025-03-25 12:00:00', 2, 19),  -- Payment Success
('BK018', 'Vũ Văn Hải', '0912345018', 'vuvanhai@example.com', 3000000.00, '2025-03-25 12:15:00', 5, 20),    -- Refund Complete
('BK019', 'Ngô Thị Yến', '0912345019', 'ngothiyen@example.com', 1250000.00, '2025-03-25 12:30:00', 1, 21),   -- Is Pending
('BK020', 'Đỗ Văn Sơn', '0912345020', 'dovanson@example.com', 1650000.00, '2025-03-25 12:45:00', 2, 22);    -- Payment Success

INSERT INTO Passengers (PassengerName, Phone, Email, IDNumber, Address, Dob, Gender, AccountId, BookingId) VALUES
('Nguyễn Thị An', '0912345001', 'nguyenthian@example.com', '123456789', '123 Nguyễn Trãi, Hà Nội', '1992-05-10', 'Female', 3, 1),
('Trần Văn Bảo', '0912345002', 'tranvanbao@example.com', '987654321', '456 Lê Lợi, TP.HCM', '1987-08-15', 'Male', 4, 2),
('Lê Thị Cẩm', '0912345003', 'lethicam@example.com', '456789123', '789 Trần Phú, Đà Nẵng', '1994-11-20', 'Female', 5, 3),
('Phạm Văn Duy', '0912345004', 'phamvanduy@example.com', '321654987', '321 Hùng Vương, Huế', '1990-03-25', 'Male', 6, 4),
('Hoàng Thị Hà', '0912345005', 'hoangthiha@example.com', '789123456', '654 Nguyễn Huệ, Nha Trang', '1995-07-30', 'Female', 7, 5),
('Bùi Văn Khánh', '0912345006', 'buivankhanh@example.com', '654987321', '987 Lý Thường Kiệt, Cần Thơ', '1988-09-05', 'Male', 8, 6),
('Đặng Thị Linh', '0912345007', 'dangthilinh@example.com', '147258369', '147 Bà Triệu, Vũng Tàu', '1993-12-10', 'Female', 9, 7),
('Vũ Văn Minh', '0912345008', 'vuvanminh@example.com', '258369147', '258 Nguyễn Văn Cừ, Phú Quốc', '1989-01-15', 'Male', 10, 8),
('Ngô Thị Ngọc', '0912345009', 'ngothingoc@example.com', '369147258', '369 Trần Hưng Đạo, Hải Phòng', '1996-04-20', 'Female', 11, 9),
('Đỗ Văn Phong', '0912345010', 'dovanphong@example.com', '741852963', '741 Lê Đại Hành, Quảng Ninh', '1987-06-25', 'Male', 12, 10),
('Nguyễn Thị Quyên', '0912345011', 'nguyenthiquyen@example.com', '852963741', '852 Phạm Ngũ Lão, Hà Nội', '1991-05-18', 'Female', 13, 11),
('Trần Văn Sơn', '0912345012', 'tranvanson@example.com', '963741852', '963 Nguyễn Thị Minh Khai, TP.HCM', '1986-08-22', 'Male', 14, 12),
('Lê Thị Thảo', '0912345013', 'lethithao@example.com', '741963852', '147 Lê Thánh Tôn, Đà Nẵng', '1997-11-30', 'Female', 15, 13),
('Phạm Văn Tiến', '0912345014', 'phamvantien@example.com', '852741963', '258 Trần Cao Vân, Huế', '1990-03-10', 'Male', 16, 14),
('Hoàng Thị Uyên', '0912345015', 'hoangthiuyen@example.com', '963852741', '369 Nguyễn Đình Chiểu, Nha Trang', '1995-07-15', 'Female', 17, 15),
('Bùi Văn Vinh', '0912345016', 'buivanvinh@example.com', '147852963', '741 Lê Hồng Phong, Cần Thơ', '1988-09-25', 'Male', 18, 16),
('Đặng Thị Xuân', '0912345017', 'dangthixuan@example.com', '258963741', '852 Trần Quốc Toàn, Vũng Tàu', '1992-12-20', 'Female', 19, 17),
('Vũ Văn Yên', '0912345018', 'vuvanyen@example.com', '369741852', '963 Nguyễn Công Trứ, Phú Quốc', '1987-01-05', 'Male', 20, 18),
('Ngô Thị Ánh', '0912345019', 'ngothianh@example.com', '741852369', '147 Phạm Văn Đồng, Hải Phòng', '1993-04-12', 'Female', 21, 19),
('Đỗ Văn Bảo', '0912345020', 'dovanbao@example.com', '852369741', '258 Bạch Đằng, Quảng Ninh', '1989-06-18', 'Male', 22, 20);



INSERT INTO Tickets (SeatId, PassengerId, Code, Status, CreateAt, BookingId, FlightId, BaggageId, Price, CancelledAT) VALUES
(1, 1, 'TK001', 1, '2025-03-25 08:00:00', 1, 1, 1, 1000000.00, NULL),   -- Booking 2: Payment Success
(2, 2, 'TK002', 1, '2025-03-25 08:15:00', 2, 2, 2, 1200000.00, NULL),   -- Booking 1: Is Pending
(3, 3, 'TK003', 1, '2025-03-25 08:30:00', 3, 3, 3, 1500000.00, NULL),   -- Booking 2: Payment Success
(4, 4, 'TK004', 0, '2025-03-25 08:45:00', 4, 4, 4, 1700000.00, '2025-03-26 09:00:00'), -- Booking 3: Is Cancelled
(5, 5, 'TK005', 1, '2025-03-25 09:00:00', 5, 5, 5, 1100000.00, NULL),   -- Booking 2: Payment Success
(6, 6, 'TK006', 1, '2025-03-25 09:15:00', 6, 6, 6, 1300000.00, NULL),   -- Booking 1: Is Pending
(7, 7, 'TK007', 1, '2025-03-25 09:30:00', 7, 7, 7, 1400000.00, NULL),   -- Booking 2: Payment Success
(8, 8, 'TK008', 0, '2025-03-25 09:45:00', 8, 8, 8, 1800000.00, '2025-03-26 10:00:00'), -- Booking 4: Refund Pending
(9, 9, 'TK009', 1, '2025-03-25 10:00:00', 9, 9, 9, 1150000.00, NULL),   -- Booking 1: Is Pending
(10, 10, 'TK010', 0, '2025-03-25 10:15:00', 10, 10, 10, 1600000.00, '2025-03-26 11:00:00'), -- Booking 5: Refund Complete
(11, 11, 'TK011', 1, '2025-03-25 10:30:00', 11, 11, 11, 1350000.00, NULL), -- Booking 2: Payment Success
(12, 12, 'TK012', 1, '2025-03-25 10:45:00', 12, 12, 12, 1500000.00, NULL), -- Booking 1: Is Pending
(13, 13, 'TK013', 1, '2025-03-25 11:00:00', 13, 13, 13, 1600000.00, NULL), -- Booking 2: Payment Success
(14, 14, 'TK014', 0, '2025-03-25 11:15:00', 14, 14, 14, 1750000.00, '2025-03-26 12:00:00'), -- Booking 3: Is Cancelled
(15, 15, 'TK015', 0, '2025-03-25 11:30:00', 15, 15, 15, 2000000.00, '2025-03-26 13:00:00'), -- Booking 4: Refund Pending
(16, 16, 'TK016', 1, '2025-03-25 11:45:00', 16, 16, 16, 1400000.00, NULL), -- Booking 1: Is Pending
(17, 17, 'TK017', 1, '2025-03-25 12:00:00', 17, 17, 17, 1800000.00, NULL), -- Booking 2: Payment Success
(18, 18, 'TK018', 0, '2025-03-25 12:15:00', 18, 18, 18, 1150000.00, '2025-03-26 14:00:00'), -- Booking 5: Refund Complete
(19, 19, 'TK019', 1, '2025-03-25 12:30:00', 19, 19, 19, 1400000.00, NULL), -- Booking 1: Is Pending
(20, 20, 'TK020', 1, '2025-03-25 12:45:00', 20, 20, 20, 1800000.00, NULL); -- Booking 2: Payment Success

INSERT INTO Refund (TicketId, BankAccount, BankName, RequestDate, RefundDate, RefundPrice, Status) VALUES
-- Các vé đã hủy từ Tickets (Status = 0)
(4, '1234567890', 'Vietcombank', '2025-03-26 08:30:00', '2025-03-27 09:00:00', 1700000.00, 2), -- TK004: Refund Success
(8, '0987654321', 'Techcombank', '2025-03-26 09:30:00', NULL, 1800000.00, 1),                  -- TK008: Refund Pending
(10, '4567891230', 'MB Bank', '2025-03-26 10:30:00', '2025-03-27 11:00:00', 1600000.00, 2),   -- TK010: Refund Success
(14, '3216549870', 'BIDV', '2025-03-26 11:30:00', NULL, 1750000.00, 3),                       -- TK014: Failed
(15, '7891234560', 'Vietinbank', '2025-03-26 12:30:00', NULL, 2000000.00, 1),                 -- TK015: Refund Pending
(18, '6549873210', 'Sacombank', '2025-03-26 13:30:00', '2025-03-27 14:00:00', 1150000.00, 2), -- TK018: Refund Success

-- Các vé khác (Status = 1) giả định yêu cầu hoàn tiền
(1, '1472583690', 'TP Bank', '2025-03-26 08:00:00', NULL, 1000000.00, 1),                     -- TK001: Refund Pending
(2, '2583691470', 'ACB', '2025-03-26 08:15:00', '2025-03-27 08:30:00', 1200000.00, 2),       -- TK002: Refund Success
(3, '3691472580', 'VP Bank', '2025-03-26 08:30:00', NULL, 1500000.00, 3),                     -- TK003: Failed
(5, '7418529630', 'HDBank', '2025-03-26 09:00:00', '2025-03-27 09:30:00', 1100000.00, 2),     -- TK005: Refund Success
(6, '8529637410', 'Vietcombank', '2025-03-26 09:15:00', NULL, 1300000.00, 1),                 -- TK006: Refund Pending
(7, '9637418520', 'Techcombank', '2025-03-26 09:30:00', NULL, 1400000.00, 3),                 -- TK007: Failed
(9, '1478529630', 'MB Bank', '2025-03-26 10:00:00', '2025-03-27 10:30:00', 1150000.00, 2),    -- TK009: Refund Success
(11, '2589637410', 'BIDV', '2025-03-26 10:30:00', NULL, 1350000.00, 1),                       -- TK011: Refund Pending
(12, '3697418520', 'Vietinbank', '2025-03-26 10:45:00', '2025-03-27 11:30:00', 1500000.00, 2),-- TK012: Refund Success
(13, '7419638520', 'Sacombank', '2025-03-26 11:00:00', NULL, 1600000.00, 3),                  -- TK013: Failed
(16, '8527419630', 'TP Bank', '2025-03-26 11:45:00', NULL, 1400000.00, 1),                    -- TK016: Refund Pending
(17, '9638527410', 'ACB', '2025-03-26 12:00:00', '2025-03-27 13:00:00', 1800000.00, 2),      -- TK017: Refund Success
(19, '1479638520', 'VP Bank', '2025-03-26 12:30:00', NULL, 1400000.00, 1),                    -- TK019: Refund Pending
(20, '2587419630', 'HDBank', '2025-03-26 12:45:00', NULL, 1800000.00, 3);                     -- TK020: Failed
