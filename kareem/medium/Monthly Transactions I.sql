SELECT TO_CHAR(TO_DATE(t1.month, 'YYYY-MM') , 'YYYY-MM') AS month , t1.country , trans_count , (CASE WHEN approved_count IS NULL THEN 0 ELSE approved_count END) AS  approved_count, trans_total_amount , (CASE WHEN approved_total_amount IS NULL THEN 0 ELSE approved_total_amount END) AS approved_total_amount FROM (SELECT EXTRACT(YEAR FROM trans_date) || '-' || EXTRACT(MONTH FROM trans_date) AS month , country, COUNT(*) AS trans_count , SUM(amount) AS trans_total_amount FROM Transactions
GROUP BY EXTRACT(YEAR FROM trans_date) || '-' || EXTRACT(MONTH FROM trans_date) , country) t1

LEFT OUTER JOIN 
(SELECT EXTRACT(YEAR FROM trans_date) || '-' || EXTRACT(MONTH FROM trans_date) AS month , country, COUNT(*) AS approved_count , SUM(amount) AS approved_total_amount FROM Transactions
GROUP BY EXTRACT(YEAR FROM trans_date) || '-' || EXTRACT(MONTH FROM trans_date) , country , state
HAVING state = 'approved') t2
ON ((t1.country = t2.country) OR (t1.country IS NULL AND t2.country IS NULL)) AND t1.month = t2.month