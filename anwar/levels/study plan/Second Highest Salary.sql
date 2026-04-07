select case 
when count(salary) = 2 then min(salary)
else null
end as SecondHighestSalary
from
(select distinct salary from Employee order by salary DESC limit 2) as res
