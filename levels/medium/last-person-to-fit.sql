select person_name from (SELECT q1.person_id , q1.person_name,
       SUM(q2.weight) AS weight
FROM Queue q1
JOIN Queue q2
  ON q2.turn <= q1.turn
GROUP BY q1.person_id ,q1.person_name having SUM(q2.weight) <= 1000 order by weight DESC limit 1 ) as res
