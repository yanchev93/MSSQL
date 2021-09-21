CREATE DATABASE HOTEL

USE HOTEL

CREATE TABLE Employees(
	[Id] INT IDENTITY PRIMARY KEY,
	[FirstName] VARCHAR(50) NOT NULL,
	[LastName] VARCHAR(50) NOT NULL,
	[Title] VARCHAR(50) NOT NULL,
	[Notes] VARCHAR(500)
)

CREATE TABLE Customers(
	[AccountNumber] INT PRIMARY KEY NOT NULL,
	[FirstName] VARCHAR(50) NOT NULL, 
	[LastName] VARCHAR(50) NOT NULL, 
	[PhoneNumber] CHAR(10) NOT NULL, 
	[EmergencyName] VARCHAR(100) NOT NULL, 
	[EmergencyNumber] CHAR(10) NOT NULL, 
	[Notes] VARCHAR(500)
)

CREATE TABLE RoomStatus(
	[RoomStatus] BIT NOT NULL, 
	[Notes] VARCHAR(500)
)

CREATE TABLE RoomTypes(
	[RoomType] VARCHAR(50) NOT NULL, 
	[Notes] VARCHAR(500)
)

CREATE TABLE BedTypes(
	[BedType] VARCHAR(50) NOT NULL, 
	[Notes] VARCHAR(500)
)

CREATE TABLE Rooms(
	[RoomNumber] INT PRIMARY KEY NOT NULL,
	[RoomType] VARCHAR(50) NOT NULL,
	[BedType] VARCHAR(50) NOT NULL, 
	[Rate] DECIMAL(2,2), 
	[RoomStatus] BIT NOT NULL, 
	[Notes] VARCHAR(500)
)

CREATE TABLE Payments(
	[Id] INT PRIMARY KEY NOT NULL, 
	[EmployeeId] INT NOT NULL, 
	[PaymentDate] DATETIME2 NOT NULL, 
	[AccountNumber] INT NOT NULL, 
	[FirstDateOccupied] DATETIME2 NOT NULL, 
	[LastDateOccupied] DATETIME2 NOT NULL, 
	[TotalDays] INT NOT NULL, 
	[AmountCharged] DECIMAL(15,2) NOT NULL, 
	[TaxRate] DECIMAL(15,2) NOT NULL, 
	[TaxAmount] DECIMAL(15,2), 
	[PaymentTotal] DECIMAL(15,2), 
	[Notes] VARCHAR(500)
)

CREATE TABLE Occupancies(
	[Id] INT PRIMARY KEY,
	[EmployeeId] INT NOT NULL,
	[DateOccupied] DATETIME2 NOT NULL,
	[AccountNumber] INT NOT NULL,
	[RoomNumber] INT NOT NULL,
	[RateApplied] DECIMAL(4,2),
	[PhoneCharge] DECIMAL(15,2),
	[Notes] VARCHAR(500)
)

INSERT INTO Employees(FirstName, LastName, Title, Notes)
	VALUES
('Teo','Teo','TTT', 'abv'),
('Teo2','Teo2','TTT2', 'abv'),
('Teo3','Teo3','TTT3', 'abv')

INSERT INTO Customers(AccountNumber,FirstName,LastName,PhoneNumber,EmergencyName,EmergencyNumber, Notes)
	VALUES
(123456,'Teo', 'Teo', '123456', 'Teo', '654321', 'abv'),
(1234567,'Teo2', 'Teo2', '1234567', 'Teo2', '6543218', 'abv'),
(1234568,'Teo3', 'Teo3', '1234568', 'Teo2', '6543217', 'abv')

INSERT INTO RoomStatus(RoomStatus, Notes)
	VALUES
(1, '123'),
(0, '123'),
(1, '123')

INSERT INTO RoomTypes(RoomType, Notes)
	VALUES
('1', '123'),
('0', '123'),
('12', '123')

INSERT INTO BedTypes(BedType, Notes)
	VALUES
('1', '123'),
('0', '123'),
('1', '123')

INSERT INTO Rooms(RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
	VALUES
(1234, '1', '1', 5.12, 0, '12345'),
(12345, '0', '1', 6.12, 1, '12345'),
(12346, '1', '1', 7.12, 0, '12345')

INSERT INTO Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
	VALUES
(1, 1, '1/1/2020', 12345, '1/1/2020', '1/2/2020', 1, 5, 1, 1, 1, 'abc'),
(2, 2, '2/1/2020', 123456, '2/1/2020', '2/2/2020', 1, 5, 1, 1, 1, 'abc'),
(3, 3, '3/1/2020', 123457, '3/1/2020', '3/2/2020', 1, 5, 1, 1, 1, 'abc')

INSERT INTO Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
	VALUES
(1, 1, '1/1/2020', 123456, 1, 1, 2, 'abv'),
(2, 2, '2/1/2020', 1234567, 1, 1, 2, 'abv'),
(3, 3, '3/1/2020', 1234568, 1, 1, 2, 'abv')