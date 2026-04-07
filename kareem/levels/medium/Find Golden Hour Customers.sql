WITH orders AS (SELECT * FROM (SELECT * FROM (SELECT id , ROUND((applied::NUMERIC / total),2) * 100 AS peak_hour_percentage FROM (SELECT customer_id AS id, COUNT(*) AS total FROM restaurant_orders GROUP BY customer_id HAVING COUNT(*) >= 3) a1
INNER JOIN
(SELECT customer_id , COUNT(*) AS applied FROM restaurant_orders WHERE (STRING_TO_ARRAY(order_timestamp::TEXT , ' '))[2]::TIME BETWEEN '11:00'::TIME AND '14:00'::TIME OR (STRING_TO_ARRAY(order_timestamp::TEXT , ' '))[2]::TIME BETWEEN '18:00'::TIME AND '21:00'::TIME  GROUP BY customer_id) a2
ON
a1.id = a2.customer_id) WHERE  peak_hour_percentage >= 60) c1
INNER JOIN
restaurant_orders
ON
restaurant_orders.customer_id = c1.id)

SELECT DISTINCT customer_id , total_orders , peak_hour_percentage , average_rating FROM (SELECT customer_id AS id ,total_orders,average_rating  FROM (SELECT * FROM (SELECT customer_id , COUNT(*) AS applied , ROUND(AVG(order_rating) , 2) AS average_rating FROM orders WHERE order_rating IS NOT NULL GROUP BY customer_id)  WHERE average_rating >= 4) b1
INNER JOIN
(SELECT customer_id AS id , COUNT(*) AS total_orders FROM orders GROUP BY customer_id) b2
ON
b1.customer_id = b2.id
WHERE applied::NUMERIC / total_orders >= 0.5) d1
INNER JOIN

(SELECT customer_id , peak_hour_percentage FROM orders) d2
ON
d1.id = d2.customer_id
ORDER BY
average_rating DESC , customer_id DESC;

