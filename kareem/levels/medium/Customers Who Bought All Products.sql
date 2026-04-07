SELECT customer_id FROM (SELECT customer_id , product_key FROM Customer GROUP BY customer_id , product_key)
GROUP BY customer_id
HAVING COUNT(*) = (SELECT COUNT(*) FROM Product);