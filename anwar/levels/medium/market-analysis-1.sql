select distinct Users.user_id as buyer_id , join_date , count(res.buyer_id) as orders_in_2019 from Users
left outer join 
(select buyer_id , item_id from Orders where to_char(order_date , 'YYYY') = '2019') as res 
 on Users.user_id = res.buyer_id 
left outer join Items on res.item_id = Items.item_id group by Users.user_id  , join_date
