SELECT name FROM Employee
WHERE id IN (SELECT managerId FROM (SELECT managerId , COUNT(*) AS num FROM Employee
GROUP BY managerId) WHERE num >= 5); 