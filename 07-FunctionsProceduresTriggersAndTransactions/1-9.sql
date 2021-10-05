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
RETURNS @result
(
	DECLARE @result VARCHAR(10)
)
