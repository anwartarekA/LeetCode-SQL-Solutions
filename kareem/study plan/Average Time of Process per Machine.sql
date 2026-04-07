SELECT machine_id , ROUND(SUM(total) , 3) AS processing_time FROM (SELECT machine_id , (CASE WHEN activity_type = 'start' THEN SUM(-timestamp)::NUMERIC / COUNT(*)
ELSE SUM(timestamp)::NUMERIC / COUNT(*) END) AS total FROM
Activity
GROUP BY machine_id , activity_type)
GROUP BY machine_id;