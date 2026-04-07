SELECT * FROM (SELECT user_id , (SELECT plan_name FROM subscription_events WHERE event_id = max) AS current_plan ,(SELECT monthly_amount FROM subscription_events WHERE event_id = max) AS current_monthly_amount, max_historical_amount, days_as_subscriber  FROM (SELECT user_id , MAX(monthly_amount) AS max_historical_amount , MAX(event_date) - MIN(event_date) AS days_as_subscriber FROM subscription_events
GROUP BY user_id
HAVING
MAX(event_date) FILTER (WHERE event_type <> 'cancel') IS NOT NULL
AND
MAX(event_date) - MIN(event_date) >= 60
AND
STRING_AGG(event_type , ',') like '%downgrade%'
) a1
INNER JOIN
(SELECT user_id AS id , MAX(event_id) FROM subscription_events GROUP BY user_id) a2
ON a1.user_id = a2.id)
WHERE (current_monthly_amount / max_historical_amount) * 100 < 50 AND (current_monthly_amount / max_historical_amount) * 100 > 0
ORDER BY days_as_subscriber DESC , user_id ASC;
