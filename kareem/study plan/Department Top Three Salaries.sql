SELECT Department.name AS Department , d.name AS Employee , salary AS Salary FROM (SELECT * FROM Employee
WHERE Employee.salary in (SELECT DISTINCT salary FROM Employee e WHERE e.departmentId = Employee.departmentId ORDER BY salary DESC LIMIT 3)) d
JOIN Department
ON Department.id = d.departmentId;