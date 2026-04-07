select activity_date as day , count(DISTINCT user_id) as active_users from Activity group by activity_date  having '2019-07-27'::DATE - activity_date < 30 and '2019-07-27'::DATE >=  activity_date;
