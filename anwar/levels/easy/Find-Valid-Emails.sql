select user_id , email from Users where email ~ '^[0-9a-zA-Z_]+[@][a-z]+\.com$' order by user_id ASC;
