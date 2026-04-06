SELECT project_id, ROUND(AVG(Employee.experience_years)::NUMERIC , 2) AS average_years FROM Project
JOIN Employee ON Project.employee_id = Employee.employee_id
GROUP BY Project.project_id;