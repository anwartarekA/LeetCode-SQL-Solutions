WITH recom AS (
    SELECT user_id , product_id , quantity , id , product , (product_id::varchar || ',' ||  product::varchar) AS pair   FROM (SELECT * FROM ProductPurchases) a1
    JOIN (SELECT user_id AS id , product_id AS product FROM ProductPurchases) a2
    ON a1.user_id = a2.id
    AND
    a1.product_id <> a2.product
    AND
    a1.product_id < a2.product
    ORDER BY user_id
)

SELECT product1_id , product2_id , product1_category,category AS product2_category , customer_count FROM (SELECT product1_id , product2_id , category AS product1_category , count AS customer_count FROM (SELECT (STRING_TO_ARRAY(pair , ','))[1]::INTEGER AS product1_id , (STRING_TO_ARRAY(pair , ','))[2]::INTEGER AS product2_id, count(pair) FROM recom GROUP BY pair HAVING COUNT(*) >= 3) b
JOIN ProductInfo
ON ProductInfo.product_id = b.product1_id) c
JOIN ProductInfo
ON
ProductInfo.product_id = c.product2_id
ORDER BY customer_count DESC, product1_id ASC , product2_id ASC;