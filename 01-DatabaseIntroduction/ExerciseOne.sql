CREATE DATABASE Minions

USE Minions

CREATE TABLE Minions
(
	Id INT PRIMARY KEY,
	[Name] VARCHAR(50),
	Age INT
)

CREATE TABLE Towns
(
	Id INT PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
)

ALTER TABLE Minions
	ADD TownId INT

ALTER TABLE Minions
	ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)

ALTER TABLE [Minions]
	ADD CONSTRAINT [FK_MinionsTownId] FOREIGN KEY (TownId) References Towns(Id)

ALTER TABLE Minions
	ALTER COLUMN Age INT NULL

INSERT INTO Towns(Id, [Name])
	VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions(Id, [Name], Age, TownId)
	VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

DELETE FROM Minions

SELECT * FROM Minions

DROP DATABASE Minions

CREATE TABLE People(
	Id INT IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX) CHECK(DATALENGTH(Picture) <= 2 * 1024 * 1024),
	Height DECIMAL(3, 2),
	[Weight] DECIMAL(5, 2),
	Gender CHAR CHECK(Gender = 'm' OR Gender = 'f') NOT NULL,
	Birthdate DATETIME2 NOT NULL,
	Biography NVARCHAR(MAX)
)

INSERT INTO People([Name], Height, [Weight], Gender, Birthdate) VALUES
('Pesho', 12, 2.22, 'm', '1.5.2006'),
('Peesho', 122, 2.22, 'f', '1.6.2006'),
('qwerty', 232, 1.12, 'f', '1.4.2006'),
('qwesarty', 12, 22.12, 'f', '1.3.2006'),
('qwewqrty', 22, 23.12, 'm', '1.2.2006')

SELECT * FROM People

CREATE DATABASE Users

CREATE TABLE Users(
	[Id] BIGINT IDENTITY(1,1) PRIMARY KEY,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY(MAX) CHECK(DATALENGTH([ProfilePicture]) <= 900000),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT
)

INSERT INTO Users
	([Username], [Password], ProfilePicture, LastLoginTime, IsDeleted)
	VALUES
('PESHO1', '123456', 234, '1/15/2021', 1),
('PESHO2', '123256', 224, '2/15/2021', 1),
('PESHO3', '124356', 134, '3/15/2021', 0),
('PESHO4', '123346', 124, '4/15/2021', 1),
('PESHO5', '12222', 235, '5/15/2021', 0)

ALTER TABLE [Users]
	DROP CONSTRAINT [PK__Users__3214EC07FB0C7A35]

ALTER TABLE [Users]
	ADD CONSTRAINT PK_IdUsers PRIMARY KEY (Id, [Username])

ALTER TABLE [Users]
	ADD CONSTRAINT CH_PassAtLeast5Symbols CHECK(LEN([Password]) > 5)

ALTER TABLE [Users]
	ADD CONSTRAINT CH_LastDefaultTime DEFAULT GETDATE() FOR [LastLoginTime]

ALTER TABLE [Users]
	DROP CONSTRAINT PK_IdUsers

ALTER TABLE [Users]
	ADD CONSTRAINT PK_Id PRIMARY KEY (Id)

ALTER TABLE [Users]
	ADD CONSTRAINT CH_UsernameAtLeast3Symbols CHECK(LEN(Username) >= 3)

-- Problem 13.	Movies Database
CREATE DATABASE Movies;

USE Movies;

CREATE TABLE Directors(
	Id INT IDENTITY PRIMARY KEY,
	DirectorName VARCHAR(80) NOT NULL,
	Notes VARCHAR(500)
);

INSERT INTO Directors (DirectorName, Notes) 
	VALUES
('Tom1', 'No notes yet'),
('Tom2', 'No notes yet'),
('Tom3', 'No notes yet'),
('Tom4', 'No notes yet'),
('Tom5', 'No notes yet');

SELECT * FROM Directors

CREATE TABLE Genres(
	Id INT IDENTITY PRIMARY KEY,
	GenreName VARCHAR(80) NOT NULL,
	Notes VARCHAR(500)
);

INSERT INTO Genres (GenreName, Notes) 
	VALUES
('Action', 'No notes yet'),
('Anime', 'No notes yet'),
('Cartoon', 'No notes yet'),
('Drama', 'No notes yet'),
('Biographic', 'No notes yet');

CREATE TABLE Categories(
	Id INT IDENTITY PRIMARY KEY,
	CategoryName VARCHAR(80) NOT NULL,
	Notes VARCHAR(500)
);

INSERT INTO Categories (CategoryName, Notes) 
	VALUES
('Wow', 'No notes yet'),
('TV Show', 'No notes yet'),
('NetFlix', 'No notes yet'),
('AmazonPrime', 'No notes yet'),
('Kids TV', 'No notes yet');

SELECT * FROM Genres

CREATE TABLE Movies(
	Id INT IDENTITY PRIMARY KEY,
	Title VARCHAR(80) NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
	CopyrightYear INT NOT NULL,
	[Length] TIME NOT NULL,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Rating DECIMAL(2,1),
	Notes VARCHAR(1000)
)

INSERT INTO [Movies] ([Title],[DirectorId],[CopyrightYear],[Length],[GenreId],[CategoryId],
[Rating])
VALUES
('FILM1', 1, 1994, '1:45:00', 5, 1, 9.2),
('FILM5', 2, 1994, '1:40:00', 1, 2, 7.5),
('FILM4', 3, 1995, '1:55:00', 3, 3, 7.9),
('FILM3', 4, 1914, '1:00:00', 4, 4, 0.9),
('FILM2', 5, 1994, '1:12:00', 2, 5, 7.9)

-- 	Problem 14.	Car Rental Database

CREATE DATABASE CarRental

USE CarRental

CREATE TABLE Categories(
	[Id] INT IDENTITY PRIMARY KEY,
	[CategoryName] VARCHAR(50) NOT NULL,
	[DailyRate] DECIMAL(4,2) NOT NULL,
	[WeeklyRate] DECIMAL(4,2) NOT NULL,
	[MonthlyRate] DECIMAL(4,2) NOT NULL,
	[WeekendRate] DECIMAL(4,2) NOT NULL
)

CREATE TABLE Cars(
	[Id] INT IDENTITY PRIMARY KEY,
	[PlateNumber] INT NOT NULL,
	[Manufacturer] VARCHAR(50) NOT NULL,
	[Model] VARCHAR(50) NOT NULL,
	[CarYear] INT NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES Categories(Id),
	[Doors] INT CHECK(DOORS >= 3) NOT NULL,
	[Picture] VARCHAR(MAX),
	[Condition] VARCHAR(20),
	[Available] BIT NOT NULL,
)

CREATE TABLE Employees(
	[Id] INT IDENTITY PRIMARY KEY,
	[FirstName] VARCHAR(50) NOT NULL,
	[LastName] VARCHAR(50) NOT NULL,
	[Title] VARCHAR(150) NOT NULL,
	[Notes] VARCHAR(500)
)

CREATE TABLE Customers(
	[Id] INT IDENTITY PRIMARY KEY, 
	[DriverLicenceNumber] VARCHAR(10), 
	[FullName] VARCHAR(50) NOT NULL, 
	[Address] VARCHAR(100) NOT NULL, 
	[City] VARCHAR(50) NOT NULL, 
	[ZIPCode] VARCHAR(50) NOT NULL, 
	[Notes] VARCHAR(500)
)

CREATE TABLE RentalOrders(
	[Id] INT IDENTITY PRIMARY KEY, 
	[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id), 
	[CustomerId] INT FOREIGN KEY REFERENCES Customers(Id), 
	[CarId] INT FOREIGN KEY REFERENCES Cars(Id), 
	[TankLevel] INT NOT NULL, 
	[KilometrageStart] INT NOT NULL, 
	[KilometrageEnd] INT NOT NULL, 
	[TotalKilometrage] AS [KilometrageStart] - [KilometrageEnd], 
	[StartDate] DATETIME NOT NULL, 
	[EndDate] DATETIME NOT NULL, 
	[TotalDays] AS DATEDIFF(Day,[StartDate],[EndDate]), 
	[RateApplied] DECIMAL (5,2) NOT NULL, 
	[TaxRate] DECIMAL (7,2) NOT NULL, 
	[OrderStatus] VARCHAR(20) NOT NULL, 
	[Notes] VARCHAR(500)
)

INSERT INTO [Categories]([CategoryName], [DailyRate], [WeeklyRate], [MonthlyRate], [WeekendRate])
	VALUES
('Coupe', 12.1, 2.2, 3.3, 4.4),
('Moupe', 13.1, 3.2, 2.3, 5.4),
('Foupe', 11.1, 4.2, 1.3, 6.4)
			   
INSERT INTO [Cars]
([PlateNumber], [Manufacturer], [Model], [CarYear], [CategoryId], [Doors],
[Picture], [Condition], [Available])
VALUES
(1234, 'MANUF1', 'MODEL1', 2000, 1, 3, 'ASDASD', 'NEW', 0),
(1224, 'MANUF3', 'MODEL2', 2300, 2, 5, 'SDASD', 'USED', 1),
(1214, 'MANUF2', 'MODEL3', 2100, 3, 5, 'ADASD', 'NEW', 1)

INSERT INTO [Employees]([FirstName],[LastName],[Title])
VALUES 
('AAAA','GGGG','SELLER'),
('BBBB','DDDD','MANAGER'),
('VVVV','EEEE','SELLER')

INSERT INTO [Customers]([DriverLicenceNumber],[FullName],[Address],[City],[ZIPCode])
VALUES 
('10035','JOHN DOE','IVAN SHISHMAN 3','PORTLAND', '7070'),
('20544','PUPESH MORKOVCHIK','IVAN SHISHMAN 3','PORTLAND', '7070'),
('13035','DINQ BRAAAT','IVAN SHISHMAN 3','PORTLAND', '7070')

INSERT INTO [RentalOrders]([EmployeeId],[CustomerId],[CarId],[TankLevel]
,[KilometrageStart],[KilometrageEnd],[StartDate],[EndDate],[RateApplied],[TaxRate],
[OrderStatus])
VALUES 
(1,1,1,7,600,900,'2020-07-02','2020-07-04',69.00,20.00,'TRUE'),
(2,2,2,7,600,900,'2020-07-02','2020-07-04',89.00,20.00,'FALSE'),
(3,3,3,7,600,900,'2020-07-02','2020-07-04',99.00,20.00,'TRUE')
