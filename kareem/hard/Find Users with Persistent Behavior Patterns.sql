WITH users AS (SELECT * FROM (SELECT user_id , action , COUNT(*), MAX(action_date) - MIN(action_date) + 1 AS streak_length ,MAX(action_date) AS end_date, MIN(action_date) AS start_date  FROM activity GROUP BY user_id, action) WHERE count >= 5 AND streak_length >= 5)

SELECT user_id , action , streak_length , start_date , end_date FROM (SELECT user_id AS id , MAX(count) FROM users GROUP BY user_id) a1
INNER JOIN
users
ON
users.user_id = a1.id AND users.count = a1.max
ORDER BY streak_length DESC , user_id ASC;