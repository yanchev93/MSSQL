--2 INFO ABOUT DEPARTMENTS
SELECT * FROM Departments

--3 DEPARTMENTS NAME
SELECT [Name] FROM Departments

--4 Salary for each Employee
SELECT FirstName, LastName, Salary FROM Employees

--5 Full Name each Employee
SELECT FirstName, MiddleName, LastName FROM Employees

--6 Email Address
SELECT FirstName + '.' + LastName + '@softuni.bg' AS [Full Email Address] FROM Employees

--7. Find All Different Employee’s Salaries
SELECT DISTINCT Salary FROM Employees

--8. Find all Information About Employees
SELECT * FROM Employees
	WHERE JobTitle = 'Sales Representative'

--9. Find Names of All Employees by Salary in Range
SELECT FirstName, LastName, JobTitle FROM Employees
	WHERE Salary BETWEEN 20000 AND 30000

--10. Find Names of All Employees
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name] FROM Employees
	WHERE Salary IN (25000, 14000, 12500, 23600)

--11. Find All Employees Without Manager
SELECT FirstName, LastName FROM Employees
	WHERE ManagerID IS NULL