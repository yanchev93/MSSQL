--01. Find Names of All Employees by First Name
SELECT FirstName, LastName FROM Employees
	WHERE LEFT(FirstName, 2) = 'Sa'

--02. Find Names of All Employees by Last Name
SELECT FirstName, LastName FROM Employees
	WHERE LastName LIKE '%ei%'

--03. Find First Names of All Employess
SELECT FirstName FROM Employees
	WHERE YEAR(HireDate) BETWEEN '1995' AND '2005' AND DepartmentID IN(3,10)

--04. Find All Employees Except Engineers
SELECT FirstName, LastName FROM Employees
	WHERE JobTitle NOT LIKE '%engineer%'

--05. Find Towns with Name Length
SELECT [Name] FROM Towns
	WHERE LEN([Name]) = 5 OR LEN([Name]) = 6
	ORDER BY [Name]

--06. Find Towns Starting With
SELECT TownID, [Name] FROM TOWNS
	WHERE [Name] LIKE '[MKBE]%'
	ORDER BY [Name]

--07. Find Towns Not Starting With
SELECT TownID, [Name] FROM TOWNS
	WHERE [Name] NOT LIKE '[RBD]%'
	ORDER BY [Name]

--08. Create View Employees Hired After
CREATE VIEW V_EmployeesHiredAfter2000 AS
	SELECT FirstName, LastName FROM Employees
		WHERE YEAR(HireDate) > '2000'

--09. Length of Last Name
SELECT FirstName, LastName from Employees
	WHERE LEN(LastName) = 5
