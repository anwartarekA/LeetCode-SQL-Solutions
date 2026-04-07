select name as Employee from Employee e where e.salary > (
 select salary from Employee where id = e.managerId
);
