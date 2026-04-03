select project_id , (sum(experience_years)::NUMERIC / count(*)::NUMERIC)::NUMERIC(10,2) as average_years from Project join Employee on Project.employee_id = Employee.employee_id group by project_id; 
