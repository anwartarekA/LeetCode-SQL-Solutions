WITH Signs AS(
    SELECT Signups.user_id , Confirmations.action FROM Signups
    LEFT OUTER JOIN Confirmations
    ON Signups.user_id = Confirmations.user_id
)
SELECT user_id , MAX(c) AS confirmation_rate FROM (SELECT a1.user_id , (CASE WHEN action = 'confirmed' THEN ROUND(num::NUMERIC / count , 2) ELSE 0 END) AS c FROM ((SELECT Signs.user_id , action , COUNT(action) AS num FROM Signs
GROUP BY Signs.user_id , action) a1
JOIN (SELECT user_id , COUNT(user_id) FROM Signs GROUP BY  user_id) a2
ON a1.user_id = a2.user_id)) GROUP BY user_id;