SELECT S.employee_id , Employees.name , S.reports_count , S.average_age FROM (SELECT reports_to AS employee_id, COUNT(reports_to) AS reports_count , ROUND(AVG(age)) AS average_age FROM Employees
GROUP BY reports_to
HAVING COUNT(reports_to) <> 0) AS S
JOIN Employees
ON Employees.employee_id = S.employee_id
ORDER BY Employees.employee_id ASC;