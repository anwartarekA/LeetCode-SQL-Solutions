(select employee_id , max(department_id) as department_id from Employee group by employee_id having count(*) = 1 order by employee_id)
union
(select employee_id , department_id from Employee where primary_flag='Y' order by employee_id)
