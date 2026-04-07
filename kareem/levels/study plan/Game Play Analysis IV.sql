SELECT ROUND(count::NUMERIC / (SELECT COUNT(*) FROM ((SELECT player_id FROM Activity GROUP BY player_id))) , 2) AS fraction FROM (SELECT COUNT(*) FROM (SELECT DISTINCT a1.player_id FROM (SELECT * FROM Activity ORDER BY event_date ASC) a1
JOIN (SELECT * FROM Activity ORDER BY event_date ASC) a2
ON
a1.player_id = a2.player_id 
AND
a1.event_date - a2.event_date = -1
AND a1.event_date  = (SELECT MIN(event_date) FROM Activity WHERE player_id = a1.player_id GROUP BY player_id)
))
