WITH a AS (SELECT sale_id , product_id AS id , sale_date , quantity , price ,(CASE WHEN TO_char(sale_date,'MM')::INTEGER IN (12 , 1, 2) THEN 'Winter' WHEN TO_char(sale_date,'MM')::INTEGER IN (3,4,5) THEN 'Spring' WHEN TO_char(sale_date,'MM')::INTEGER IN (6,7,8) THEN 'Summer' ELSE 'Fall' END) AS season FROM Sales)

SELECT season , category,total_quantity , total_revenue FROM (SELECT category , season , total_quantity , total_revenue, ROW_NUMBER() OVER (PARTITION BY season ORDER BY total_quantity DESC , total_revenue DESC , category ASC  ) FROM (SELECT category , season , SUM(quantity) AS total_quantity , SUM(price * quantity) AS total_revenue FROM a
INNER JOIN Products
ON Products.product_id = a.id
GROUP BY season , category)) WHERE row_number = 1
ORDER BY season ASC;