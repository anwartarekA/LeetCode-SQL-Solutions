WITH Meets AS (SELECT employee_id, meetings.meeting_date,meetings.meeting_id ,  (SELECT SUM(duration_hours) FROM meetings m WHERE meetings.meeting_date+'6d'::INTERVAL >= m.meeting_date AND meetings.employee_id = m.employee_id AND meetings.meeting_id <= m.meeting_id GROUP BY m.employee_id) FROM meetings)
-- SELECT employee_id , MIN(meeting_date) AS meeting_date FROM Meets GROUP BY employee_id

,B AS (SELECT * FROM (SELECT * FROM Meets WHERE sum > 20) m1
INNER JOIN (SELECT employee_id AS ID ,meeting_date AS MD, sum AS s FROM Meets WHERE sum > 20) m2
ON m1.employee_id = m2.ID AND m1.meeting_date - m2.MD > 6)


SELECT employee_id ,employee_name ,department ,  meeting_heavy_weeks FROM (SELECT ei , COUNT(*) AS meeting_heavy_weeks FROM (SELECT employee_id AS ei , meeting_date , sum AS meeting_heavy_weeks FROM B
UNION ALL
SELECT id AS employee_id , md AS meeting_date, s AS meeting_heavy_weeks FROM B)
GROUP BY ei) e
INNER JOIN employees ON employees.employee_id = e.ei
ORDER BY meeting_heavy_weeks DESC, employee_name ASC;
