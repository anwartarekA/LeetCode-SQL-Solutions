WITH views AS (SELECT * FROM (SELECT * FROM (SELECT review_id ,employee_id ,review_date,rating , ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_id DESC) FROM (SELECT * FROM performance_reviews WHERE employee_id IN (SELECT employee_id FROM performance_reviews GROUP BY employee_id HAVING COUNT(*) >= 3))) WHERE row_number IN (1,2,3)))
,
selec AS (
    SELECT * FROM (SELECT * FROM views) a1
INNER JOIN
(SELECT review_id AS review , employee_id AS id , review_date AS date, rating AS r, row_number AS row FROM views) a2
ON a1.employee_id = a2.id
INNER JOIN
(SELECT review_id AS review_3 , employee_id AS id_3 , review_date AS date_3, rating AS r_3, row_number AS row_3 FROM views) a3
ON a1.employee_id = a3.id_3

WHERE a1.row_number = 1 AND a2.row = 2 AND a3.row_3 = 3 AND a1.rating > a2.r AND a2.r > a3.r_3
)

SELECT employee_id , name , improvement_score FROM (SELECT employee_id AS i , MAX(rating) - MIN(rating) AS improvement_score FROM (SELECT review_id , employee_id,review_date,  rating, row_number FROM selec
UNION ALL
SELECT review AS review_id  , id AS employee_id,date AS review_date, r AS rating, row AS row_number FROM selec
UNION ALL
SELECT review_3 AS review_id  , id_3 AS employee_id,date_3 AS review_date, r_3 AS rating, row_3 AS row_number FROM selec

) GROUP BY employee_id) c
INNER JOIN
employees
ON employees.employee_id = c.i
ORDER BY improvement_score DESC, name ASC;