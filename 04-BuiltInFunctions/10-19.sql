--10. Rank Employees by Salary
SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (PARTITION by Salary ORDER BY EmployeeID) AS [Rank] FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
	ORDER BY Salary DESC

--11. Find All Employees with Rank 2**
SELECT * FROM
	(SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (PARTITION by Salary ORDER BY EmployeeID) AS [Rank] FROM Employees
		WHERE Salary BETWEEN 10000 AND 50000) AS TableRank
		WHERE [Rank] = 2
	ORDER BY Salary DESC

--12. Countries Holding 'A'
SELECT CountryName, IsoCode FROM Countries
	WHERE CountryName LIKE '%A%A%A%'
	ORDER BY IsoCode

--13. Mix of Peak and River Names
SELECT PeakName, RiverName,
	   LOWER(CONCAT(PeakName, SUBSTRING(RiverName, 2, LEN(RiverName)))) AS Mix
FROM Peaks, Rivers
	WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
	ORDER BY Mix

--14. Games From 2011 and 2012 Year
SELECT TOP(50) [Name], CONVERT(varchar,[Start],23) as [Start] FROM Games
	WHERE YEAR([Start]) BETWEEN '2011' AND '2012'
	ORDER BY [Start], [Name]

--15. User Email Providers
SELECT Username, SUBSTRING(Email, CHARINDEX('@',Email,1) + 1, LEN(Email)) AS [Email Provider] FROM Users
	ORDER BY [Email Provider], Username

--16. Get Users with IPAddress Like Pattern
SELECT Username, IpAddress FROM Users
	WHERE IpAddress LIKE '___.1%.%.___'
	ORDER BY Username

--17. Show All Games with Duration
SELECT [Name] AS Game,  
CASE 
	WHEN DATEPART(HOUR, [Start]) >= 0 AND DATEPART(HOUR, [Start]) < 12 THEN 'Morning'
	WHEN DATEPART(HOUR, [Start]) >= 12 AND DATEPART(HOUR, [Start]) < 18 THEN 'Afternoon'
	ELSE 'Evening'
END AS [Part of the Day],
CASE 
	WHEN Duration <= 3 THEN 'Extra Short'
	WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
	WHEN Duration > 6 THEN 'Long'
	ELSE 'Extra Long'
END AS Duration FROM Games
	ORDER BY Game, Duration

SELECT [Name] AS Game, DATEPART(HOUR, [Start]) AS PartOfTheDay, Duration FROM Games
	ORDER BY Game, Duration

--18. Orders Table

SELECT 
	ProductName,
	OrderDate,
	DATEADD(DAY, 3, OrderDate) AS [Pay Due],
	DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
	FROM Orders