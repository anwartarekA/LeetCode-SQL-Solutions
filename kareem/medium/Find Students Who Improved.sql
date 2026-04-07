SELECT student_id ,subject , first_score ,latest_score  FROM (SELECT student_id , subject , score AS latest_score ,exam_date FROM (SELECT student_id AS id, subject AS s, MAX(exam_date) AS max_date FROM Scores GROUP BY student_id , subject HAVING COUNT(*) >= 2) c1
INNER JOIN
Scores
ON
Scores.student_id = c1.id AND Scores.subject = c1.s AND Scores.exam_date = c1.max_date) d1
INNER JOIN
(SELECT student_id AS id, subject AS s , score AS first_score ,exam_date FROM (SELECT student_id AS id, subject AS s, MIN(exam_date) AS min_date FROM Scores GROUP BY student_id , subject HAVING COUNT(*) >= 2) c2
INNER JOIN
Scores
ON
Scores.student_id = c2.id AND Scores.subject = c2.s AND Scores.exam_date = c2.min_date) d2
ON
d1.student_id = d2.id
AND
d1.subject = d2.s
AND
d1.latest_score > d2.first_score
ORDER BY
student_id , subject ASC;