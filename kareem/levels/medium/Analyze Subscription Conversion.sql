SELECT user_id , MAX(trial_avg_duration) AS trial_avg_duration , MAX(paid_avg_duration) AS paid_avg_duration FROM (SELECT user_id , ROUND((CASE WHEN activity_type = 'free_trial' THEN SUM(activity_duration) END) / COUNT(activity_type)::NUMERIC , 2) AS trial_avg_duration , ROUND((CASE WHEN activity_type = 'paid' THEN SUM(activity_duration) END) / COUNT(activity_type)::NUMERIC ,2)AS paid_avg_duration FROM UserActivity WHERE user_id IN (SELECT DISTINCT user_id FROM UserActivity WHERE activity_type = 'paid')
GROUP BY user_id , activity_type
ORDER BY user_id)
GROUP BY user_id