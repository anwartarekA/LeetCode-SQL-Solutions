delete from Person where id not in 
(select  MIN(id) as id FROM Person group BY email);
