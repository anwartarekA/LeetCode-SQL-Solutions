SELECT ROUND((COUNT(*)::NUMERIC / (SELECT COUNT(DISTINCT customer_id) FROM Delivery)) * 100 , 2) AS immediate_percentage FROM (SELECT a1.customer_id , a1.order_date , customer_pref_delivery_date  FROM (SELECT customer_id , MIN(order_date) AS order_date FROM Delivery
GROUP BY customer_id) a1
JOIN

(SELECT customer_id , customer_pref_delivery_date , order_date FROM Delivery) a2
ON
a1.customer_id = a2.customer_id
AND
a1.order_date = a2.order_date) WHERE order_date = customer_pref_delivery_date;