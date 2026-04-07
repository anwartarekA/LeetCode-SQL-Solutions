SELECT Employees.name , EmployeeUNI.unique_id FROM Employees
LEFT OUTER JOIN EmployeeUNI
ON Employees.id = EmployeeUNI.id;