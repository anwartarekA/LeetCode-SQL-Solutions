SELECT category , (CASE WHEN c1.c IS NULL THEN 0
    ELSE COUNT(*) END ) AS accounts_count FROM (SELECT (CASE WHEN income < 20000 THEN 'Low Salary'
    WHEN income >= 20000 AND income <= 50000 THEN 'Average Salary'
    ELSE 'High Salary' END ) AS c FROM Accounts) c1

RIGHT OUTER JOIN

((SELECT 'Low Salary' AS category)
UNION
(SELECT 'Average Salary' AS category)
UNION
(SELECT 'High Salary' AS category)) c2
ON c1.c = c2.category
GROUP BY category , c
