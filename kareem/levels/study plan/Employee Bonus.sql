SELECT name , bonus FROM Employee
LEFT OUTER JOIN Bonus
ON Bonus.empId = Employee.empId
WHERE Bonus.bonus IS NULL OR Bonus.bonus < 1000;