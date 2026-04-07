select user_id , trial_avg_duration , paid_avg_duration from ((select user_id as id , ROUND(avg(average_duration),2)as trial_avg_duration  from(select user_id , activity_type,average_duration from (select user_id , activity_type , ROUND(avg(activity_duration),2)as average_duration from(select * from (select distinct user_id as id from UserActivity where activity_type ='free_trial'
intersect
select distinct user_id from UserActivity where activity_type ='paid') as users
inner join UserActivity on users.id = UserActivity.user_id and UserActivity.activity_type='free_trial' or activity_type='paid') as res group by user_id , activity_type)as free1 where free1.activity_type = 'free_trial') as free2 group by user_id) as result1

inner join

(select user_id , ROUND(avg(average_duration),2)as paid_avg_duration  from(select user_id , activity_type,average_duration from (select user_id , activity_type , ROUND(avg(activity_duration),2)as average_duration from(select * from (select distinct user_id as id from UserActivity where activity_type ='free_trial'
intersect
select distinct user_id from UserActivity where activity_type ='paid') as users
inner join UserActivity on users.id = UserActivity.user_id and UserActivity.activity_type='free_trial' or activity_type='paid') as res group by user_id , activity_type)as free1 where free1.activity_type = 'paid') as free2 group by user_id) as result2 on result1.id = result2.user_id ) as final_result order by user_id;
