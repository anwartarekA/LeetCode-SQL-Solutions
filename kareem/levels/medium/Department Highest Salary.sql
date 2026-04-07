SELECT Department.name AS Department, e1.name AS Employee , e1.salary AS Salary FROM Employee e1
JOIN Department
ON e1.departmentId = Department.id
WHERE e1.salary >= ALL (SELECT salary FROM Employee e2 WHERE e1.departmentId = e2.departmentId);