(SELECT store1 AS price , product_id , (SELECT 'store1' AS store)  FROM Products WHERE store1 IS NOT NULL)
UNION ALL
(SELECT store2 AS price , product_id , (SELECT 'store2' AS store) FROM Products WHERE store2 IS NOT NULL)
UNION ALL
(SELECT store3 AS price , product_id , (SELECT 'store3' AS store) FROM Products WHERE store3 IS NOT NULL)