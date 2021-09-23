CREATE DATABASE Tests
USE Tests

--01. One-To-One Relationship

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

--02. One-To-Many Relationship
CREATE TABLE Manufacturers(
	ManufacturerID INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL,
	EstablishedOn DATETIME NOT NULL
)

CREATE TABLE Models(
	ModelID INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL,
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers(ManufacturerID, [Name], EstablishedOn)
	VALUES
(1, 'BMW', 07/03/1916),
(2, 'Tesla', 01/01/2003),
(3, 'Lada', 01/05/1966)

INSERT INTO Models(ModelID, [Name], ManufacturerID)
	VALUES
(101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3)

--03. Many-To-Many Relationship
CREATE TABLE Students(
	StudentID INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Exams(
	ExamID INT PRIMARY KEY,
	[Name] NVARCHAR(50)
)

CREATE TABLE StudentsExams(
	StudentID INT,
	ExamID INT

	CONSTRAINT PK_Students_Exams PRIMARY KEY (StudentID, ExamID),
	CONSTRAINT FK_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
	CONSTRAINT FK_Exams FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
)


INSERT INTO Students(StudentID, [Name])
	VALUES
(1, 'Mila'),
(2, 'Toni'),
(3, 'Ron')

INSERT INTO Exams(ExamID, [Name])
	VALUES
(101, 'SpringMVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g')

INSERT INTO StudentsExams(StudentID, ExamID)
	VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103)

--04. Self-Referencing
CREATE TABLE Teachers(
	TeacherID INT PRIMARY KEY IDENTITY(101,1),
	[Name] NVARCHAR(50) NOT NULL,
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

--05. Online Store Database
CREATE TABLE ItemTypes(
	ItemTypeID INT PRIMARY KEY,
	[Name] NVARCHAR(50)
)

CREATE TABLE Items(
	ItemID INT PRIMARY KEY,
	[Name] NVARCHAR(50),
	ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
)


CREATE TABLE Cities(
	CityID INT PRIMARY KEY,
	[Name] VARCHAR(50)
)

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50),
	Birthday DATETIME,
	CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY,
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)

CREATE TABLE OrderItems(
	OrderID INT,
	ItemID INT 

	CONSTRAINT PK_Order_Item_ID PRIMARY KEY (OrderID, ItemID),
	CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	CONSTRAINT FK_ItemID FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
)

--06. University Database
CREATE TABLE Subjects( 
	SubjectID INT PRIMARY KEY IDENTITY,
	SubjectName VARCHAR(50) NOT NULL
)


CREATE TABLE Majors( 
	MajorID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Students( 
	StudentID INT PRIMARY KEY IDENTITY,
	StudentNumber VARCHAR(10),
	StudentName VARCHAR(50) NOT NULL,
	MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
)

CREATE TABLE Payments( 
	PaymentID INT PRIMARY KEY IDENTITY,
	PaymentDate DATETIME NOT NULL,
	PaymentAmount DECIMAL(15,2) NOT NULL,
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
)

CREATE TABLE Agenda( 
	StudentID INT,
	SubjectID INT

	CONSTRAINT PK_Subject_Student_ID PRIMARY KEY(SubjectID, StudentID)
	CONSTRAINT FK_StudentID FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
	CONSTRAINT FK_SubjectID FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
)
