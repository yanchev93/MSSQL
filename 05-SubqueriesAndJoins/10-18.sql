--10. Employees Summary
SELECT TOP(50) e.EmployeeID, e.FirstName + ' ' + e.LastName AS EmployeeName,
			m.FirstName + ' ' + m.LastName AS ManagerName, d.Name FROM Employees AS e
	JOIN Employees AS m ON m.EmployeeID = e.ManagerID
	JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
	ORDER BY e.EmployeeID

--11. Min Average Salary
SELECT TOP(1) AVG(e.Salary) AS MinAVGSalary FROM Employees AS e
	JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
	GROUP BY e.DepartmentID
	ORDER BY MiNAVGSalary ASC

--12. Highest Peaks in Bulgaria

SELECT * FROM Peaks

SELECT * FROM Mountains

SELECT mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation FROM MountainsCountries AS mc
	JOIN Mountains AS m ON m.Id = mc.MountainId
	JOIN Peaks AS p ON p.MountainId = m.Id
		WHERE mc.CountryCode = 'BG' and  p.Elevation > 2835
		ORDER BY p.Elevation DESC

--13. Count Mountain Ranges
SELECT mc.CountryCode, COUNT(m.MountainRange) FROM MountainsCountries AS mc
	JOIN Mountains AS m ON m.Id = mc.MountainId
	WHERE mc.CountryCode IN ('US', 'RU', 'BG')
	GROUP BY mc.CountryCode

--14. Countries With or Without Rivers
SELECT TOP(5) c.CountryName, r.RiverName FROM Countries AS c
	LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
	LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
	WHERE ContinentCode = 'AF'
	ORDER BY c.CountryName

--15. Continents and Currencies
SELECT ContinentCode, CurrencyCode, CurrencyUsage FROM (
	SELECT ContinentCode,CurrencyCode, COUNT(CurrencyCode) AS CurrencyUsage,
	DENSE_RANK() OVER (PARTITION BY ContinentCode ORDER BY COUNT(CurrencyCode) DESC) AS Ranked FROM Countries
	GROUP BY ContinentCode, CurrencyCode) AS k
	WHERE Ranked = 1 AND CurrencyUsage > 1
	ORDER BY ContinentCode

--16. Countries Without any Mountains
SELECT COUNT(c.CountryCode) FROM Countries AS c
	LEFT JOIN MountainsCountries AS MC ON mc.CountryCode = c.CountryCode
	WHERE MountainId IS NULL
	GROUP BY MountainId

--17. Countries Without any Mountains
SELECT TOP(5) 
	CountryName, Elevation, [Length] FROM (
	SELECT c.CountryName, p.Elevation, r.[Length],
	DENSE_RANK() OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS RankedPeaks,
	DENSE_RANK() OVER (PARTITION BY c.CountryName ORDER BY r.[Length] DESC) AS RankedRivers
	FROM Countries AS c
		JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
		JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
		JOIN Peaks AS p ON p.MountainId = mc.MountainId
		JOIN Rivers AS r ON r.Id = cr.RiverId) AS k
		WHERE RankedPeaks = 1 AND RankedRivers = 1
	ORDER BY Elevation DESC, [Length] DESC, CountryName



SELECT * FROM Peaks