SELECT day , COUNT(active_users) AS active_users FROM (SELECT activity_date AS day , COUNT(DISTINCT activity_date) AS active_users FROM
Activity
WHERE activity_date >= '2019-06-28' AND  activity_date <= '2019-07-27'
GROUP BY (user_id ,  activity_date))
GROUP BY day;