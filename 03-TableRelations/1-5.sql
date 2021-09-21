CREATE DATABASE Tests
USE Tests

CREATE TABLE Passports(
	PassportID INT PRIMARY KEY,
	PasportNumber NVARCHAR(50) NOT NULL
)

CREATE TABLE Persons(
	PersonID INT PRIMARY KEY,
	FirstName nvarchar(50) NOT NULL,
	Salary DECIMAL(15,2) NOT NULL,
	PassportID INT FOREIGN KEY REFERENCES Passports(PassportID)
)

INSERT INTO Passports(PassportID, PasportNumber)
	VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2')

INSERT INTO Persons(PersonID, FirstName, Salary,PassportID)
	VALUES
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 103),
(3, 'Yana', 60200.00, 101)
