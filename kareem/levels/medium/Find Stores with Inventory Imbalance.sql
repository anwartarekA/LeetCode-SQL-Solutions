-- WITH s1 AS (
--     SELECT stores.store_id , MAX(price) , MIN(price) FROM stores
-- INNER JOIN inventory
-- ON inventory.store_id = stores.store_id
-- GROUP BY stores.store_id
-- HAVING COUNT(*) >= 3
-- ),
-- s2 AS (
--     SELECT inventory.store_id AS id , store_name, location, inventory_id, product_name, quantity, price  FROM stores
-- INNER JOIN inventory
-- ON inventory.store_id = stores.store_id
-- ),
-- b1 AS (SELECT id , max , min , quantity , price , ROW_NUMBER() OVER (PARTITION BY id ORDER BY id ASC) FROM (SELECT store_id AS id , max , min FROM s1) a1
-- INNER JOIN
-- (SELECT store_id,quantity, price FROM inventory) a2
-- ON (a1.id = a2.store_id
-- AND a1.max = a2.price) OR
-- (a1.id = a2.store_id AND a1.min = a2.price)),
-- c AS
-- (SELECT id AS i , row_number AS number , price AS p FROM b1),
-- j AS (SELECT id , quantity , (SELECT quantity AS q FROM c WHERE b1.row_number - c.number = -1 AND c.i = b1.id) , ROW_NUMBER() OVER (PARTITION BY id ORDER BY id ASC) FROM  b1)

-- SELECT store_id ,store_name , location , most_exp_product , cheapest_product , imbalance_ratio  FROM(SELECT id AS store_id , ROUND(quantity / q::NUMERIC , 2) AS imbalance_ratio FROM (SELECT id , quantity FROM j WHERE row_number = 2) val1
-- INNER JOIN
-- (SELECT id AS d , q FROM j WHERE row_number = 1) val2
-- ON val1.id = val2.d WHERE q < quantity) g1

-- INNER JOIN
-- (SELECT id AS i2 , store_name, location, product_name AS most_exp_product FROM (SELECT id AS i , MAX(price) FROM s2 GROUP BY id) e1
-- INNER JOIN s2 ON e1.i = s2.id AND e1.max = s2.price) g2

-- ON g1.store_id = g2.i2

-- INNER JOIN
-- (SELECT id AS i3, product_name AS cheapest_product FROM (SELECT id AS i , min(price) FROM s2 GROUP BY id) e1
-- INNER JOIN s2 ON e1.i = s2.id AND e1.min = s2.price) g3

-- ON g1.store_id = g3.i3
-- WHERE store_id IN

-- (SELECT store_id FROM inventory GROUP BY store_id HAVING COUNT(*) >= 3)
-- ORDER BY imbalance_ratio DESC , store_name ASC






-- SELECT store_id,store_name ,location,most_exp_product,cheapest_product,imbalance_ratio   FROM (SELECT store_id AS id , ROUND(q2::NUMERIC / q1 , 2) AS imbalance_ratio , q1 , q2  , (SELECT product_name  AS most_exp_product FROM inventory WHERE q1 = quantity AND inventory.store_id = store_id), (SELECT product_name  AS cheapest_product FROM inventory WHERE q2 = quantity AND inventory.store_id = store_id) FROM (SELECT a1.store_id, (SELECT inventory.quantity AS q1 FROM inventory WHERE a1.store_id = inventory.store_id AND a1.max = inventory.price) , (SELECT inventory.quantity AS q2 FROM inventory WHERE a1.store_id = inventory.store_id AND a1.min = inventory.price) FROM (SELECT stores.store_id , MAX(price) , MIN(price) FROM  stores
-- INNER JOIN inventory
-- ON stores.store_id = inventory.store_id
-- GROUP BY stores.store_id
-- HAVING COUNT(*) >= 3) a1) WHERE q1 < q2) g1
-- INNER JOIN
-- stores
-- ON stores.store_id = g1.id
-- ORDER BY imbalance_ratio DESC , store_name ASC;

SELECT store_id ,store_name, location ,most_exp_product ,cheapest_product,imbalance_ratio FROM  (SELECT id , most_exp_product ,cheapest_product ,imbalance_ratio  FROM (SELECT store_id AS id, ROUND(q2::NUMERIC / q1 , 2) AS imbalance_ratio , q1 , q2 min , max , (SELECT product_name  AS most_exp_product FROM inventory WHERE q1 = quantity AND inventory.store_id = store_id AND max = inventory.price), (SELECT product_name  AS cheapest_product FROM inventory WHERE q2 = quantity AND inventory.store_id = store_id AND min = inventory.price)  FROM (SELECT min , max, a1.store_id, (SELECT inventory.quantity AS q1 FROM inventory WHERE a1.store_id = inventory.store_id AND a1.max = inventory.price) , (SELECT inventory.quantity AS q2  FROM inventory WHERE a1.store_id = inventory.store_id AND a1.min = inventory.price) FROM (SELECT stores.store_id , MAX(price) , MIN(price) FROM  stores
INNER JOIN inventory 
ON stores.store_id = inventory.store_id
GROUP BY stores.store_id
HAVING COUNT(*) >= 3) a1) WHERE q1 < q2)) c1
INNER JOIN
stores
ON c1.id = stores.store_id
ORDER BY imbalance_ratio DESC , store_name ASC;







