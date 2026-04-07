select contest_id,ROUND((count(*)::numeric/(select count(user_id) from Users)::numeric)*100::numeric , 2)  as percentage from Register group by contest_id order by percentage DESC , contest_id ASC;
