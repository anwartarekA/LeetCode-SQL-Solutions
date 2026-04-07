select s.product_id , first_year , s.quantity , s.price from (select * from Sales) as s
 left outer join 
(select product_id , min(year) as first_year from Sales group by product_id) as one 
on s.product_id = one.product_id and s.year = one.first_year where first_year is not null;
