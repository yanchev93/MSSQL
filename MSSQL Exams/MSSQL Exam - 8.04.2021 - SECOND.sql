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

--08. Birthday Report
SELECT u.Username, c.[Name] FROM Users AS u
	JOIN Reports AS r ON r.UserId = u.Id
	JOIN Categories AS c ON c.Id = r.CategoryId
	WHERE DAY(u.Birthdate) = DAY(r.Opendate)
	ORDER BY u.Username, c.[Name]

--09. User per Employee
SELECT  e.FirstName + ' ' + e.LastName AS FullName,
		COUNT(u.Username) AS UserCount FROM Employees AS e
	LEFT JOIN Reports AS r ON r.EmployeeId = e.Id
	LEFT JOIN Users AS u ON u.Id = r.UserId
	GROUP BY e.FirstName, e.LastName, e.Id
	ORDER BY UserCount DESC, FullName

--10. Full Info
SELECT  ISNULL(e.FirstName + ' ' + e.LastName, 'None') AS Employee,
		ISNULL(d.[Name], 'None') AS Department,
		ISNULL(c.[Name], 'None') AS Category,
		ISNULL(r.[Description], 'None') AS [Description],
		ISNULL(convert(varchar, OpenDate, 104), 'None') AS OpenDate,
		ISNULL(s.[Label], 'None') AS [Status],
		ISNULL(u.[Name], 'None') as [User]
		FROM Reports AS r
	LEFT JOIN Employees AS e ON e.Id = r.EmployeeId
	LEFT JOIN Departments AS d ON d.Id = e.DepartmentId
	LEFT JOIN Categories AS c ON c.Id = r.CategoryId
	LEFT JOIN [Status] AS s ON s.Id = R.StatusId
	LEFT JOIN Users AS u ON u.Id = r.UserId
	ORDER BY e.FirstName DESC, e.LastName DESC,
			 d.[Name], c.[Name], r.[Description],
			 r.OpenDate, s.[Label], u.[Name]

--11. Hours to Complete
GO
CREATE FUNCTION udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT
AS
BEGIN
	DECLARE @result INT;

	IF @StartDate IS NULL
	BEGIN
		RETURN 0
	END

	ELSE IF @EndDate IS NULL
	BEGIN
		RETURN 0
	END

	SET @result = DATEDIFF(HOUR, @StartDate, @EndDate)

	RETURN @result
END

GO

SELECT dbo.udf_HoursToComplete(OpenDate, CloseDate) AS TotalHours
   FROM Reports

--12. Assign Employee
GO

CREATE PROC usp_AssignEmployeeToReport(@EmployeeId INT, @ReportId INT)
AS
IF(NOT EXISTS(SELECT * FROM Reports AS r
	JOIN Employees AS e ON e.Id = @EmployeeId
	JOIN Categories AS c ON c.Id = r.CategoryId
	WHERE r.Id = @ReportId AND e.DepartmentId = c.DepartmentId))
THROW 60000, 'Employee doesn''t belong to the appropriate department!', 1;


UPDATE Reports
SET EmployeeId = @EmployeeId
WHERE Id = @ReportId

EXEC usp_AssignEmployeeToReport 30, 1



