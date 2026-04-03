select employee_id , case 
when name::varchar(1) <> 'M' and employee_id % 2 <> 0 then salary
else 0
end as bonus
from Employees order by employee_id;
