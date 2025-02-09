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
