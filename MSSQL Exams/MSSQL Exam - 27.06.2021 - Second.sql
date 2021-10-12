--05. Mechanic Assignments
SELECT FirstName + ' ' + LastName, j.[Status], j.IssueDate FROM Mechanics AS m
	JOIN Jobs AS j ON j.MechanicId = m.MechanicId
	ORDER BY m.MechanicId, J.IssueDate, J.JobId

SELECT  * FROM Jobs

--06. Current Clients
SELECT c.FirstName + ' ' + c.LastName, DATEDIFF(day, j.IssueDate, '2017-04-24') AS [Days going], j.[Status] FROM Clients AS c
	JOIN Jobs AS j ON j.ClientId = c.ClientId
	WHERE j.[Status] = 'In Progress' OR j.[Status] = 'Pending'
	ORDER BY [Days going] DESC, c.ClientId

select	DATEDIFF(day, '2017-04-06', '2017-04-24')

SELECT * FROM Clients

--07. Mechanic Performance
SELECT  m.FirstName + ' ' + m.LastName AS Mechanic,
		AVG(DATEDIFF(day, j.IssueDate, j.FinishDate)) AS [Average Days]
		FROM Mechanics AS m
	JOIN Jobs AS j ON j.MechanicId = m.MechanicId
	GROUP BY m.FirstName, m.LastName, m.MechanicId

--08. Available Mechanics
SELECT FirstName + ' ' + LastName FROM Mechanics
WHERE MechanicId NOT IN(
		SELECT MechanicId FROM Jobs
			WHERE [Status] = 'In Progress'
			GROUP BY MechanicId)

--09. Past Expenses
SELECT J.JobId, ISNULL(SUM(P.Price * OP.Quantity), 0) AS TOTAL FROM Jobs AS J
	LEFT JOIN Orders AS O ON O.JobId = J.JobId
	LEFT JOIN OrderParts AS OP ON OP.OrderId = O.OrderId
	LEFT JOIN Parts AS P ON P.PartId = OP.PartId
	WHERE J.[Status] = 'Finished'
	GROUP BY J.JobId
	ORDER BY TOTAL DESC, J.JobId

--10. Missing Parts
SELECT P.PartId, P.[Description], PN.Quantity, P.StockQty, IIF(O.Delivered = 0, OP.Quantity, 0)
	FROM Parts AS P
	LEFT JOIN PartsNeeded AS PN ON PN.PartId = P.PartId
	LEFT JOIN OrderParts AS OP ON OP.PartId = P.PartId
	LEFT JOIN JOBS AS J ON J.JobId = PN.JobId
	LEFT JOIN Orders AS O ON O.OrderId = OP.OrderId
	WHERE J.[Status] != 'Finished'
	AND (P.StockQty +  IIF(O.Delivered = 0, OP.Quantity, 0))< PN.Quantity
	ORDER BY PartId
