SELECT Q1.query_name , quality , ROUND( (COALESCE(Q2.c::DECIMAL , 0) / Q1.C::DECIMAL) * 100 ,2) AS poor_query_percentage  FROM (SELECT query_name , ROUND(AVG(rating::NUMERIC / position::NUMERIC) , 2) AS quality  , COUNT(*) AS C FROM Queries
GROUP BY query_name) AS Q1

LEFT JOIN (SELECT query_name , COUNT(rating) AS c FROM Queries WHERE rating < 3 GROUP BY query_name) AS Q2

ON Q1.query_name = Q2.query_name;