-- Tạo database
 -- CREATE DATABASE SkyTicket;
USE SkyTickets;

-- Bảng Roles
CREATE TABLE Roles (
    RoleId INT PRIMARY KEY AUTO_INCREMENT,
    RoleName VARCHAR(50) NOT NULL
);
INSERT INTO `Roles` VALUES 
(1,'Admin'),
(2,'Member');



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
    TotalPrice DECIMAL(10,2) NOT NULL,
    BookingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50),
    AccountId INT,
    FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId)
);
-- Bảng Payments
CREATE TABLE Payments (
    PaymentId INT PRIMARY KEY AUTO_INCREMENT,
    BookingId INT NOT NULL,
    PaymentMethod VARCHAR(50),
    PaymentStatus VARCHAR(50),
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (BookingId) REFERENCES Bookings(BookingId)
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
    FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId)
);

-- Bảng Baggages
CREATE TABLE Baggages (
    BaggageId INT PRIMARY KEY AUTO_INCREMENT,
    Weight DECIMAL(5,2),
    Price DECIMAL(10,2)
);

-- Bảng BookingDetails
CREATE TABLE BookingDetails (
    BookingDetailId INT PRIMARY KEY AUTO_INCREMENT,
    BookingId INT NOT NULL,
    PassengerId INT NOT NULL,
    BaggageId INT,
    FOREIGN KEY (BookingId) REFERENCES Bookings(BookingId),
    FOREIGN KEY (PassengerId) REFERENCES Passengers(PassengerId),
    FOREIGN KEY (BaggageId) REFERENCES Baggages(BaggageId)
);

-- Bảng Airlines
CREATE TABLE Airlines (
    AirlineId INT PRIMARY KEY AUTO_INCREMENT,
    AirlineName VARCHAR(100) NOT NULL,
    Image VARCHAR(255),
    Information TEXT,
    Status TINYINT DEFAULT 1,
    ClassVipCapacity INT,
    ClassEconomyCapacity INT
);


INSERT INTO Airlines (AirlineId, AirlineName, Image, Information, Status, ClassVipCapacity, ClassEconomyCapacity) 
VALUES 
(1, 'Bamboo Airways', 'bamboo_1.jpg', 'Hãng hàng không tư nhân đầu tiên tại Việt Nam.', 1, 20, 180),
(2, 'Bamboo Airlines', 'bamboo_1.jpg', 'Hãng hàng không quốc gia Việt Nam với dịch vụ chất lượng cao.', 1, 30, 250),
(3, 'Bamboo Airways', 'bamboo_1.jpg', 'Hãng hàng không tư nhân đầu tiên tại Việt Nam.', 1, 20, 180),
(4, 'Bamboo Airlines', 'bamboo_1.jpg', 'Hãng hàng không quốc gia Việt Nam với dịch vụ chất lượng cao.', 1, 30, 250);

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
    FOREIGN KEY (AirlineId) REFERENCES Airlines(AirlineId)
);

-- Bảng Seats
CREATE TABLE Seats (
    SeatId INT PRIMARY KEY AUTO_INCREMENT,
    FlightId INT NOT NULL,
    Status VARCHAR(50),
    SeatNumber VARCHAR(10) NOT NULL,
    SeatClass ENUM('Economy', 'VIP') NOT NULL,
    IsBooked BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (FlightId) REFERENCES Flights(FlightId)
);

-- Bảng Tickets
CREATE TABLE Tickets (
    TicketId INT PRIMARY KEY AUTO_INCREMENT,
    SeatId INT NOT NULL,
    PassengerId INT NOT NULL,
    Code VARCHAR(50) UNIQUE NOT NULL,
    Status VARCHAR(50),
    CreateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    BookingDetailId INT,
    FOREIGN KEY (SeatId) REFERENCES Seats(SeatId),
    FOREIGN KEY (PassengerId) REFERENCES Passengers(PassengerId),
    FOREIGN KEY (BookingDetailId) REFERENCES BookingDetails(BookingDetailId)
);

-- Bảng Countries
CREATE TABLE Countries (
    CountryId INT PRIMARY KEY AUTO_INCREMENT,
    CountryName VARCHAR(100) NOT NULL,
    Status TINYINT DEFAULT 1
);

INSERT INTO Countries (CountryId,CountryName)
VALUES
    (1,'Việt Nam'),
    (2,'Nhật Bản'),
    (3,'Hàn Quốc');


-- Bảng Locations
CREATE TABLE Locations (
    LocationId INT PRIMARY KEY AUTO_INCREMENT,
    LocationName VARCHAR(100) NOT NULL,
    CountryId INT NOT NULL,
    Status TINYINT DEFAULT 1,
    FOREIGN KEY (CountryId) REFERENCES Countries(CountryId)
);
INSERT INTO Locations (LocationId,LocationName, CountryId)
VALUES
    (1,'Hà Nội', 1),
    (2,'TP. Hồ Chí Minh', 1),
    (3,'Tokyo', 2),
    (4,'Osaka', 2),
    (5,'Seoul', 3),
    (6,'Busan', 3);


-- Bảng Airports
CREATE TABLE Airports (
    AirportId INT PRIMARY KEY AUTO_INCREMENT,
    AirportName VARCHAR(100) NOT NULL,
    LocationId INT NOT NULL,
    Status TINYINT DEFAULT 1,
    FOREIGN KEY (LocationId) REFERENCES Locations(LocationId)
);

INSERT INTO Airports (AirportId,AirportName, LocationId)
VALUES
    (1,'Nội Bài International Airport', 1),
    (2,'Tân Sơn Nhất International Airport', 2),
    (3,'Narita International Airport', 3),
    (4,'Kansai International Airport', 4),
    (5,'Incheon International Airport', 5),
    (6,'Gimhae International Airport', 6);


-- Chỉnh lại khóa ngoại của Flights sau khi tạo Airports
ALTER TABLE Flights
ADD FOREIGN KEY (ArrivalAirportId) REFERENCES Airports(AirportId),
ADD FOREIGN KEY (DepartureAirportId) REFERENCES Airports(AirportId);

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



