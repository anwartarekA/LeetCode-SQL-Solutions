WITH S AS (
    SELECT DISTINCT Orders.order_date  FROM Products JOIN Orders ON
Products.product_id = Orders.product_id
WHERE Orders.order_date >= '2020-02-01' AND Orders.order_date <= '2020-02-29'
)


SELECT (SELECT Products.product_name FROM Products WHERE Products.product_id = Orders.product_id) , SUM(Orders.unit) AS unit FROM Orders
JOIN S ON Orders.order_date = S.order_date
GROUP BY Orders.product_id
HAVING SUM(Orders.unit) >= 100;
