select Department.name as Department , res.name as Employee, res.salary as Salary from (select * from Employee as e where e.salary = (
    select max(salary) from Employee where Employee.departmentId=e.departmentId 
)) as res inner join Department on res.departmentId = Department.id
