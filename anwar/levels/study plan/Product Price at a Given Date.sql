select result1.product_id , coalesce(new_price , 10) as price from ( select distinct Products.product_id from Products ) as result1
left outer join
(select inner_query.product_id , new_price from (select product_id , max(change_date) as last_date from (select product_id , new_price , change_date  from Products where change_date <= '2019-08-16'::date) as res group by product_id) as inner_query 
inner join 
Products on Products.product_id = inner_query.product_id and Products.change_date = inner_query.last_date)as result2
on result1.product_id = result2.product_id
