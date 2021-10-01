--11. Average Interest
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) FROM WizzardDeposits
	WHERE DepositStartDate > '01/01/1985'
	GROUP BY DepositGroup, IsDepositExpired
	ORDER BY DepositGroup DESC, IsDepositExpired

--12. Rich Wizard, Poor Wizard
SELECT SUM(g.DepositAmount - w.DepositAmount) AS [Difference] FROM WizzardDeposits AS w
	JOIN WizzardDeposits AS g ON g.Id + 1 = w.Id

--13. Departments Total Salaries
SELECT DepartmentID, SUM(Salary)FROM Employees
		GROUP BY DepartmentID

--14. Employees Minimum Salaries
SELECT DepartmentID, MIN(Salary)FROM Employees
	WHERE DepartmentID IN (2, 5, 7)	
	GROUP BY DepartmentID

--15. Employees Average Salaries
SELECT * INTO NewTable FROM Employees
	WHERE Salary > 30000

DELETE FROM NewTable WHERE ManagerID = 42

UPDATE NewTable
	SET Salary += 5000
	WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary) FROM NewTable
		GROUP BY DepartmentID

--16. Employees Maximum Salaries
SELECT DepartmentID, MAX(Salary) FROM Employees
	GROUP BY DepartmentID
	HAVING MAX(Salary) > 70000 OR MAX(Salary) < 30000

--17. Employees Count Salaries
SELECT COUNT(*) FROM Employees
	WHERE ManagerID IS NULL

--18. 3rd Highest Salary
SELECT DepartmentID, EmployeeSalary FROM 
	(SELECT DepartmentID,
		MAX(Salary) AS EmployeeSalary,
		DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY MAX(Salary) DESC) AS Ranked 
		FROM Employees
		GROUP BY DepartmentID, Salary) AS K
WHERE Ranked = 3

--19. Salary Challenge
SELECT TOP(10) FirstName, LastName, DepartmentID FROM Employees AS e
	WHERE Salary > 
		(SELECT AVG(Salary) AS AVGSalary
		FROM Employees AS SubEmp
		WHERE SubEmp.DepartmentID = e.DepartmentID
		GROUP BY DepartmentID)
ORDER BY DepartmentID
		