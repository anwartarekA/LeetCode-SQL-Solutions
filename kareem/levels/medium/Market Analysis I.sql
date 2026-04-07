SELECT user_id AS buyer_id , join_date, orders_in_2019 FROM Users JOIN (SELECT user_id AS buyer_id, COUNT(order_date) FILTER (WHERE order_date IS NOT NULL) AS orders_in_2019 FROM (SELECT * FROM Users LEFT OUTER JOIN (SELECT * FROM Orders WHERE order_date BETWEEN '2019-01-01' AND '2019-12-31') AS a1
ON Users.user_id = a1.buyer_id)
GROUP BY user_id , buyer_id) a2
ON
a2.buyer_id = Users.user_id;