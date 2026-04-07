select name from Employee join (select managerId from Employee group by managerId  having count(*) >= 5 and managerId is not null) as res on Employee.id = res.managerId;
