--Start 03:30 PM
--01. DDL
CREATE DATABASE [Service]

USE [Service]

CREATE TABLE Users(
	[Id] INT PRIMARY KEY IDENTITY,
	[Username]	NVARCHAR(30) UNIQUE NOT NULL,
	[Password]	NVARCHAR(50) NOT NULL,
	[Name] NVARCHAR(50),
	[Birthdate] DATETIME2,
	[Age] INT CHECK(Age >= 14 AND Age <= 110),
	[Email] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Status](
	[Id] INT PRIMARY KEY IDENTITY,
	[Label]	NVARCHAR(30) NOT NULL
)

CREATE TABLE Departments(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	DepartmentId INT REFERENCES Departments(Id) NOT NULL
)

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(25),
	LastName NVARCHAR(25),
	Birthdate DATETIME2,
	Age INT CHECK(Age >= 18 AND Age <= 110),
	DepartmentId INT REFERENCES Departments(Id) NOT NULL
)

CREATE TABLE Reports(
	[Id] INT PRIMARY KEY IDENTITY,
	CategoryId INT REFERENCES Categories(Id) NOT NULL,
	StatusId INT REFERENCES [Status](Id) NOT NULL,
	OpenDate DATETIME2 NOT NULL,
	CloseDate DATETIME2,
	[Description] NVARCHAR(200) NOT NULL,
	UserId INT REFERENCES Users(Id) NOT NULL,
	EmployeeId INT REFERENCES Employees(Id)
)

--02. Insert
GO
INSERT INTO Employees(FirstName, LastName, Birthdate, DepartmentId) VALUES
('Marlo',	'O''Malley', 1958-9-21, 1),
('Niki',	'Stanaghan', 1969-11-26, 4),
('Ayrton',	'Senna', 1960-03-21, 9),
('Ronnie',	'Peterson', 1944-02-14, 9),
('Giovanna', 'Amati', 1959-07-20, 5)

INSERT INTO Reports(CategoryId, StatusId, OpenDate, CloseDate, Description, UserId, EmployeeId)		VALUES
(1,	1,	2017-04-13,	NULL,'Stuck Road on Str.133',	6,	2),
(6,	3,	2015-09-05,	2015-12-06,'Charity trail running',	3,	5),
(14, 2,	2015-09-07,	NULL, 'Falling bricks on Str.58',	5,	2),
(4,	3,	2017-07-03,	2017-07-06	,'Cut off streetlight on Str.11',	1,	1)

--03. Update
GO
UPDATE Reports
SET CloseDate = GETDATE() 
	WHERE CloseDate = NULL

UPDATE Reports
SET CloseDate = GETDATE()
WHERE CloseDate IS NULL

--04. Delete
DELETE Reports
WHERE StatusId = 4
