select user_id , upper(name::varchar(1)) || lower(substr(name , 2  )) as name  from Users order by user_id;
