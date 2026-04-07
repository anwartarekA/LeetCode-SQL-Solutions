WITH tests AS (SELECT * FROM covid_tests WHERE patient_id IN (SELECT patient_id FROM covid_tests GROUP BY patient_id HAVING COUNT(*) FILTER (WHERE result = 'Positive') >= 1 AND COUNT(*) FILTER (WHERE result = 'Negative') >= 1)),
about AS (
SELECT * FROM (SELECT patient_id AS id, MIN(test_date) AS first_date FROM tests WHERE result = 'Positive' GROUP BY patient_id) a
INNER JOIN
tests
ON
tests.patient_id = a.id
AND
tests.test_date > a.first_date
AND
tests.result = 'Negative')

SELECT patient_id , patient_name , age , recovery_time FROM (SELECT patient_id AS id , (negative_date - first_date) AS recovery_time FROM (SELECT patient_id AS i , MIN(test_date) AS negative_date FROM about GROUP BY id , patient_id , result) b
INNER JOIN about
ON
about.patient_id = b.i
AND
about.test_date = b.negative_date) c
INNER JOIN
patients
ON
patients.patient_id = c.id
ORDER BY
recovery_time ASC , patient_name ASC;
