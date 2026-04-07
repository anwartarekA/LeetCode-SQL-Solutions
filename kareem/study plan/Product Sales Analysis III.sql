SELECT Sales.product_id , s.first_year , Sales.quantity , Sales.price FROM Sales
JOIN (SELECT product_id , MIN(year) AS first_year FROM Sales
GROUP BY product_id) s
ON Sales.product_id = s.product_id
AND Sales.year = s.first_year;