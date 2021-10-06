--01. Employees with Salary Above 35000
CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
	SELECT FirstName, LastName FROM Employees
		WHERE Salary > 35000

EXEC usp_GetEmployeesSalaryAbove35000

--02. Employees with Salary Above Number
GO
CREATE PROC usp_GetEmployeesSalaryAboveNumber(@salary DECIMAL(18,4))
AS
	SELECT FirstName, LastName FROM Employees
		WHERE Salary >= @salary

EXEC usp_GetEmployeesSalaryAboveNumber 48100

GO

--03. Town Names Starting With
CREATE PROC usp_GetTownsStartingWith (@town VARCHAR(100))
AS
SELECT [Name] FROM Towns
	WHERE [Name] LIKE @town + '%'

EXEC usp_GetTownsStartingWith 'b'

--04. Employees from Town
GO
CREATE PROC usp_GetEmployeesFromTown (@townName VARCHAR(100))
AS
SELECT FirstName, LastName FROM Employees AS e
	JOIN Addresses AS a ON a.AddressID = e.AddressID
	JOIN Towns AS t  ON t.TownID = a.TownID
	WHERE t.[Name] = @townName

EXEC usp_GetEmployeesFromTown 'Sofia'

--05. Salary Level Function
GO
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @result VARCHAR(10)
	IF(@salary < 30000)
	BEGIN
		SET @result = 'Low'
	END
	ELSE IF(@salary <= 30000 OR @salary < 50000)
	BEGIN
		SET @result = 'Average'
	END
	ELSE
		SET @result = 'High'


		RETURN @result;
END

--06. Employees by Salary Level
GO
CREATE PROC usp_EmployeesBySalaryLevel (@param VARCHAR(10))
AS
	SELECT FirstName, LastName FROM Employees
		WHERE dbo.ufn_GetSalaryLevel(Salary) = @param

--07. Define Function
GO
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX))
RETURNS BIT
BEGIN
		DECLARE @result BIT
		DECLARE @counter INT 
		SET @counter = LEN(@word)
	WHILE @counter > 0
	BEGIN
		DECLARE @letter CHAR(1) = SUBSTRING(@word, @counter, 1)
		IF CHARINDEX(@letter, @setOfLetters) <= 0
		BEGIN
			SET @result = 0
			RETURN @result
		END

		SET @counter -=1;
	END

	SET @result = 1
	RETURN @result
END

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')

--08. Delete Employees and Departments
CREATE PROC usp_DeleteEmployeesFromDepartment (@departmentId INT) 
AS
ALTER TABLE Departments
ALTER COLUMN ManagerID INT NULL

DELETE FROM EmployeesProjects
WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

UPDATE Employees
	SET ManagerID = NULL
	WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

UPDATE Departments
	SET ManagerID = NULL
	WHERE DepartmentID = @departmentId

DELETE FROM Employees
	WHERE DepartmentID = @departmentId

DELETE FROM Departments
	WHERE DepartmentID = @departmentId

SELECT COUNT(*) FROM Employees WHERE DepartmentID = @departmentId
GO

--09. Find Full Name
SELECT * FROM AccountHolders

SELECT * FROM Accounts

CREATE PROCEDURE usp_GetHoldersFullName
AS
SELECT FirstName + ' ' + LastName from AccountHolders

EXEC usp_GetHoldersFullName