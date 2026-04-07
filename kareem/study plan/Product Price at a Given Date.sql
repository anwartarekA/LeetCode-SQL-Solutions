SELECT product_id , (CASE WHEN new_price IS NULL THEN 10 ELSE new_price END) AS price FROM (SELECT a1.product_id , max , new_price FROM (SELECT DISTINCT product_id , max FROM (SELECT p1.product_id , max FROM Products p1
LEFT OUTER JOIN
(SELECT product_id , MAX(change_date) FROM Products
WHERE change_date <= '2019-08-16'
GROUP BY product_id) p2
ON p1.product_id = p2.product_id)) a1
LEFT OUTER JOIN Products
ON Products.product_id = a1.product_id
AND Products.change_date = a1.max);
