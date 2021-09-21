--12. Find All Employees with Salary More Than
SELECT FirstName, LastName, Salary FROM Employees
	WHERE Salary > 50000
	ORDER BY Salary DESC

--13. Find 5 Best Paid Employees
SELECT TOP(5) FirstName, LastName FROM Employees
	ORDER BY Salary DESC

--14. Find All Employees Except Marketing
SELECT FirstName, LastName FROM Employees
	WHERE DepartmentID != 4

--15. Sort Employees Table
SELECT * FROM Employees
	ORDER BY Salary DESC, FirstName, LastName DESC, MiddleName

--16. Create View Employees with Salaries
--Partitioned view as defined on Server1  
CREATE VIEW V_EmployeesSalaries AS  
	SELECT FirstName, LastName, Salary
	FROM Employees

--17. Create View Employees with Job Titles
CREATE VIEW V_EmployeeNameJobTitle AS
	SELECT FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName AS [Full Name], JobTitle 
	FROM Employees

--18. Distinct Job Titles
SELECT DISTINCT JobTitle FROM Employees

--19. Find First 10 Started Projects
SELECT TOP(10) * FROM Projects
	ORDER BY StartDate, [Name]

--20. Last 7 Hired Employees
SELECT TOP(7) FirstName, LastName, HireDate From Employees
	ORDER BY HireDate DESC

--21. Increase Salaries
UPDATE Employees
	SET Salary *= 1.12
	WHERE DepartmentID IN (1, 2, 4, 11)

SELECT Salary FROM Employees

USE [Geography]
--22. All Mountain Peaks
SELECT DISTINCT PeakName FROM Peaks

--23. Biggest Countries by Population
SELECT TOP(30) CountryName, [Population] FROM Countries
	WHERE ContinentCode = 'EU'
	ORDER BY [Population] DESC, CountryName

--24. Countries and Currency (Euro / Not Euro)
SELECT CountryName, CountryCode,
	CASE 
		 WHEN CurrencyCode = 'EUR' THEN 'Euro'
		 ELSE 'Not Euro'
	END AS [Currency]
FROM Countries
	ORDER BY CountryName

--25. All Diablo Characters
SELECT [Name] FROM [Characters]
	ORDER BY [Name]
