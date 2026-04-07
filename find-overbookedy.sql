with week_hours as (select employee_id , date_trunc('week' , meeting_date)::date as start_week , sum(duration_hours) as total_hours from meetings group by employee_id , start_week),

week_heavy as (
    select employee_id , start_week from week_hours where week_hours.total_hours > 20
),
final_employees as (
select employee_id , count(*) as meeting_heavy_weeks from week_heavy group by employee_id having count(*) >= 2) 

select employees.employee_id , employee_name, department , final_employees.meeting_heavy_weeks from final_employees join employees on final_employees.employee_id = employees.employee_id order by final_employees.meeting_heavy_weeks desc , employee_name ;
