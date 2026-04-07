select ROUND((count(first_player_login.player_id)::numeric / (select count(distinct player_id)from Activity)) , 2) as fraction from (select player_id , min(event_date) as first_login from Activity group by player_id) as first_player_login where first_login - (
    select event_date from Activity where Activity.event_date = first_player_login.first_login + 1 and Activity.player_id = first_player_login.player_id
) = -1
