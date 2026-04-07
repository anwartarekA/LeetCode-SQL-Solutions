SELECT A.sell_date , COUNT(sell_date) AS num_sold , STRING_AGG(product , ',' ORDER BY product ASC) AS products
FROM (SELECT DISTINCT sell_date , product FROM Activities) AS A
GROUP BY sell_date
ORDER BY sell_date;