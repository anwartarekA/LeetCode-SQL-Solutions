SELECT Employee.name AS Employee
FROM Employee
JOIN (SELECT * FROM Employee) AS manager
ON Employee.managerId = manager.id
WHERE Employee.salary > manager.salary;