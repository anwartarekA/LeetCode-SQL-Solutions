select result1.customer_id ,result1.total_orders , result1.peak_hour_percentage, result3.average_order_rating as average_rating from (select res1.customer_id , orders_number as total_orders , ROUND((order_peak_num::numeric / all_order_timestamp::numeric) * 100 , 0) as peak_hour_percentage from (select customer_id , count(order_id) as orders_number , count(order_timestamp) as all_order_timestamp from restaurant_orders group by customer_id having count(order_id) >=3)as res1
inner join
(select customer_id , count(order_timestamp) as order_peak_num from restaurant_orders where order_timestamp::time between '11:00' and '14:00' or  order_timestamp::time between '18:00' and '21:00' group by customer_id ) as res2 on res1.customer_id = res2.customer_id where ROUND((order_peak_num::numeric / all_order_timestamp::numeric) * 100 , 2) >= 60 )as result1

inner join 

(select result2.customer_id , average_order_rating from (select * from (select customer_id as id , count(*) as total_count from restaurant_orders group by id ) as one 
inner join
(select customer_id , ROUND(avg(order_rating::numeric) , 2) as average_order_rating , count(order_rating) as order_rating_count from restaurant_orders group by customer_id) as two on one.id = two.customer_id ) as result2 
where ROUND(average_order_rating , 2) >= 4 and ROUND((order_rating_count::numeric/total_count::numeric)*100,2) >= 50)as result3 on result1.customer_id = result3.customer_id order by average_rating DESC , result1.customer_id DESC;
