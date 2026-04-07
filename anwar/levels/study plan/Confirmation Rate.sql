select Signups.user_id ,round(count(action) filter(where action='confirmed'),2)::numeric as confirmation_rate from Signups left outer join Confirmations on Signups.user_id = Confirmations.user_id group by Signups.user_id having round(count(action) filter(where action='confirmed'),2)::numeric = 0

union

select Signups.user_id ,round((count(action) filter(where action='confirmed')::numeric/count(action)),2)::numeric as confirmation_rate from Signups left outer join Confirmations on Signups.user_id = Confirmations.user_id group by Signups.user_id having round(count(action) filter(where action='confirmed'),2)::numeric <> 0
