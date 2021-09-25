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
