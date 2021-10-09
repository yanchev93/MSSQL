--05. Unassigned Reports
SELECT [Description], convert(varchar, OpenDate, 105) FROM Reports
	WHERE EmployeeId IS NULL
	ORDER BY OpenDate, [Description]

--06. Reports & Categories
SELECT r.[Description], c.[Name] FROM Reports AS r
	JOIN Categories AS c ON c.Id = r.CategoryId
	WHERE CategoryId IS NOT NULL
	ORDER BY [Description], c.[Name]

--07. Most Reported Category
SELECT TOP(5) c.Name, COUNT(*) AS CategoryName FROM Reports AS r
	JOIN Categories AS c ON c.Id = r.CategoryId	
	GROUP BY r.CategoryId, c.Name
	ORDER BY CategoryName DESC, c.Name