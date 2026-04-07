select ROUND((min(customers)::numeric/max(customers)::numeric )*100,2) as immediate_percentage from (select count(customer_id) as customers from (select customer_id,min(order_date) as order_date from Delivery d group by customer_id having min(order_date) = (
    select customer_pref_delivery_date from Delivery where d.customer_id = Delivery.customer_id and order_date = (select min(order_date) from Delivery where d.customer_id = Delivery.customer_id)
) ) as res
union 
select count(distinct customer_id) as customers from Delivery)as result 
