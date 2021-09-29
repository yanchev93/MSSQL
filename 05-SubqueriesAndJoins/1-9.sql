--01. Employee Address
SELECT TOP(5) EmployeeId, JobTitle, e.AddressID, a.AddressText FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	ORDER BY e.AddressID

--02. Addresses with Towns
SELECT TOP(50) e.FirstName, e.LastName, t.Name, a.AddressText
	FROM Employees AS e
		JOIN Addresses AS a ON a.AddressID = e.AddressID
		JOIN Towns AS t ON t.TownID = a.TownID
		ORDER BY e.FirstName, e.LastName

--03. Sales Employees
SELECT e.EmployeeID, e.FirstName, e.LastName, d.[Name] FROM Employees AS e
	JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
	WHERE d.DepartmentID = 3
	ORDER BY e.EmployeeID

--04. Employee Departments
SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.[Name] FROM Employees AS e
	JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
	WHERE Salary > 15000
	ORDER BY d.DepartmentID

--05. Employees Without Projects
SELECT * FROM EmployeesProjects AS ea
	JOIN Projects AS a ON a.ProjectID = ea.ProjectID

SELECT TOP(3) e.EmployeeID, e.FirstName FROM Employees AS e
	LEFT JOIN EmployeesProjects AS ea ON e.EmployeeID = ea.EmployeeID
	LEFT JOIN Projects AS p ON p.ProjectID = ea.ProjectID
	WHERE ea.EmployeeID IS NULL
	ORDER BY e.EmployeeID

--06. Employees Hired After
SELECT e.FirstName, e.LastName, e.HireDate, d.[Name] FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	WHERE d.[Name] = 'Sales' OR d.[Name] = 'Finance' AND e.HireDate > '1.1.1999'
	ORDER BY e.HireDate

--07. Employees With Project
SELECT TOP(5) e.EmployeeID, e.FirstName, p.[Name] FROM Employees AS e
	JOIN EmployeesProjects AS ea ON ea.EmployeeID = e.EmployeeID
	JOIN Projects AS p ON p.ProjectID = ea.ProjectID
	WHERE p.StartDate > '08.13.2002' AND p.EndDate IS NULL
	ORDER BY e.EmployeeID

--08. Employee 24
SELECT e.EmployeeID, e.FirstName,
	CASE
		WHEN YEAR(p.StartDate) >= 2005 THEN NULL
		ELSE p.[Name]
	END AS ProjectName
FROM Employees AS e
	JOIN EmployeesProjects AS ea ON ea.EmployeeID = e.EmployeeID
	JOIN Projects AS p ON p.ProjectID = ea.ProjectID
	WHERE e.EmployeeID = 24

--09. Employee Manager
SELECT emp.EmployeeID, emp.FirstName, emp.ManagerID, mng.FirstName FROM Employees AS emp
	JOIN Employees AS mng ON mng.EmployeeID = emp.ManagerID
	WHERE emp.ManagerID = 3 OR emp.ManagerID = 7
	ORDER BY emp.EmployeeID
	
SELECT * FROM Departments