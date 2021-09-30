--11. Average Interest
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) FROM WizzardDeposits
	WHERE DepositStartDate > '01/01/1985'
	GROUP BY DepositGroup, IsDepositExpired
	ORDER BY DepositGroup DESC, IsDepositExpired

--12. Rich Wizard, Poor Wizard
SELECT SUM(g.DepositAmount - w.DepositAmount) AS [Difference] FROM WizzardDeposits AS w
	JOIN WizzardDeposits AS g ON g.Id + 1 = w.Id

--13. Departments Total Salaries
