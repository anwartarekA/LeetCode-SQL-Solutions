select user_id , plan_name as current_plan , monthly_amount as current_monthly_amount , max_revenue as max_historical_amount , days_as_subscriber from (select user_id , event_date , event_type , plan_name , monthly_amount , max_revenue, percent , min_date , days_as_subscriber from 
(select user_id , event_date , event_type , plan_name , monthly_amount , max_revenue, percent , min_date, (event_date - min_date) as days_as_subscriber
 from (select user_id , event_date , event_type , plan_name , monthly_amount , max_revenue , ROUND((monthly_amount::numeric / max_revenue) * 100,2) as percent , min_date 
 from 
 (select user_id as id , max(event_date) as max_date , max(event_id) as max_id , min(event_date) as min_date, max(monthly_amount) as max_revenue 
  from subscription_events group by id ) as one 
  inner join subscription_events on one.id = subscription_events.user_id and one.max_date = subscription_events.event_date where event_type <> 'cancel' and event_id = max_id ) as two where percent < 50) as three where days_as_subscriber >= 60) as four join 
(select user_id as id , event_type as e_t from subscription_events group by id , e_t having count(event_type) >=1 and min(event_type) = 'downgrade') as downgrade on four.user_id = downgrade.id order by days_as_subscriber DESC , user_id;
