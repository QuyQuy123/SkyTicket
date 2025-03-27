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
    Status VARCHAR(50),
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
('2025-03-28 10:00:00', '2025-03-28 07:30:00', 2, 1, 1, 1, 2000000.00, 1000000.00),
('2025-03-28 15:00:00', '2025-03-28 12:00:00', 3, 2, 1, 2, 2500000.00, 1200000.00),
('2025-03-28 18:30:00', '2025-03-28 16:00:00', 4, 3, 1, 3, 2800000.00, 1500000.00),
('2025-03-28 08:45:00', '2025-03-28 06:20:00', 2, 4, 1, 4, 3000000.00, 17000000.00),
('2025-03-28 12:15:00', '2025-03-28 09:45:00', 1, 4, 1, 2, 2200000.00, 11000000.00),
('2025-03-28 17:00:00', '2025-03-28 14:30:00', 3, 1, 1, 1, 2600000.00, 13000000.00),
('2025-03-28 22:10:00', '2025-03-28 19:45:00', 5, 1, 1, 2, 2900000.00, 1400000.00),
('2025-03-28 05:30:00', '2025-03-28 03:00:00', 5, 1, 1, 3, 3100000.00, 1800000.00),
('2025-03-28 09:20:00', '2025-03-28 06:50:00', 5, 1, 1, 4, 2400000.00, 1150000.00),
('2025-03-28 14:00:00', '2025-03-28 11:30:00', 7, 2, 1, 1, 2300000.00, 1150000.00),
('2025-03-28 19:00:00', '2025-03-28 16:15:00', 8, 3, 1, 2, 2700000.00, 1350000.00),
('2025-03-28 09:30:00', '2025-03-28 07:00:00', 9, 5, 1, 3, 3000000.00, 1500000.00),
('2025-03-28 15:45:00', '2025-03-28 13:00:00', 10, 4, 1, 4, 3200000.00, 1600000.00),
('2025-03-28 21:00:00', '2025-03-28 18:30:00', 11, 6, 1, 1, 3500000.00, 1750000.00),
('2025-03-28 06:00:00', '2025-03-28 03:30:00', 12, 7, 1, 2, 4000000.00, 200000.00),
('2025-03-28 23:30:00', '2025-03-28 21:00:00', 5, 1, 1, 2, 2900000.00, 1400000.00),
('2025-03-28 01:45:00', '2025-03-28 23:15:00', 5, 1, 1, 3, 3100000.00, 1800000.00),
('2025-03-28 03:50:00', '2025-03-28 01:20:00', 5, 1, 1, 4, 2400000.00, 1150000.00),
('2025-03-28 11:00:00', '2025-03-28 08:30:00', 5, 1, 1, 2, 2900000.00, 1400000.00),
('2025-03-28 13:15:00', '2025-03-28 10:45:00', 5, 1, 1, 3, 3100000.00, 1800000.00),
('2025-03-28 15:30:00', '2025-03-28 13:00:00', 5, 1, 1, 4, 2400000.00, 1150000.00),
('2025-03-28 11:00:00', '2025-03-28 09:30:00', 1, 5, 1, 1, 2900000.00, 1400000.00),
('2025-03-28 14:00:00', '2025-03-28 12:30:00', 1, 5, 1, 2, 3100000.00, 1800000.00),
('2025-03-28 17:00:00', '2025-03-28 15:30:00', 1, 5, 1, 3, 2400000.00, 1150000.00),
('2025-03-28 20:00:00', '2025-03-28 18:30:00', 1, 5, 1, 4, 2900000.00, 1400000.00),
('2025-03-28 23:00:00', '2025-03-28 21:30:00', 1, 5, 1, 1, 3100000.00, 1800000.00),
('2025-03-28 09:00:00', '2025-03-28 07:30:00', 1, 5, 1, 1, 2400000.00, 1150000.00);
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
    Status VARCHAR(50),
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
    Status int default 1 ,
    FOREIGN KEY (TicketId) REFERENCES Tickets(TicketId)
);
