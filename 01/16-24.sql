--16.Create SoftUni Database 

--Towns (Id, Name)
--Addresses (Id, AddressText, TownId)
--Departments (Id, Name)
--Employees (Id, FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)


--PersonID int FOREIGN KEY REFERENCES Persons(PersonID) - HOW TO ADD FOREIGN KEY

CREATE TABLE Towns (Id INT IDENTITY PRIMARY KEY, [Name] NVARCHAR(50) NOT NULL)

CREATE TABLE Addresses (Id INT IDENTITY PRIMARY KEY, AddressText NVARCHAR(50)  NOT NULL,
						TownId INT FOREIGN KEY REFERENCES Towns(Id))

CREATE TABLE Departments (Id INT IDENTITY PRIMARY KEY, [Name] NVARCHAR(50)  NOT NULL)

CREATE TABLE Employees(
	Id INT IDENTITY PRIMARY KEY, 
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50),
	LastName NVARCHAR(50)  NOT NULL,
	JobTitle NVARCHAR(50)  NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES DEpartments(Id),
	HireDate DATETIME2  NOT NULL,
	Salary INT  NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)

--18.Basic Insert

INSERT INTO [Towns] ([Name])
VALUES 
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO [Departments] ([Name])
VALUES 
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

INSERT INTO [Employees] ([FirstName],[MiddleName],[LastName],[JobTitle],
[DepartmentId],[HireDate],[Salary])
VALUES 
('Petar' , 'P' , 'Petrov', 'Senior Engineer',1,'2004/02/03',4000.00),
('Maria' , 'P' , 'Ivanova', 'Quality Assurance',5,'2016/08/08',525.00),
('Georgi' , 'T' , 'Ivanov', 'Sales',2,'2007/09/10',3000.00),
('Peter' , 'P' , 'Pan', '.Marketing',3,'2016/11/11',599.88)

--19 BASIC SELECT

SELECT * FROM Towns

SELECT * FROM Departments

SELECT * FROM Employees

--20 SELECT AND ORDER

SELECT * FROM Towns
	ORDER BY [Name] ASC

SELECT * FROM Departments
	ORDER BY [Name] ASC

SELECT * FROM Employees
	ORDER BY [Salary] DESC

--21 BASIC SELECT SOME FIELDS

SELECT [Name] FROM Towns
	ORDER BY [Name] ASC

SELECT [Name] FROM Departments
	ORDER BY [Name] ASC

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
	ORDER BY [Salary] DESC


UPDATE [Employees]
SET
Salary *= 1.10

SELECT Salary FROM Employees

UPDATE [HOTEL]
SET
TaxRate /= 0.97

SELECT TaxRate FROM Payments

DELETE FROM Occupancies


	
