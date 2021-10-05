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
