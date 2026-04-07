SELECT id , SUM(count) AS num FROM ((SELECT accepter_id AS id , COUNT(*) FROM
RequestAccepted
GROUP BY accepter_id)
UNION ALL
(SELECT requester_id AS id , COUNT(*) FROM
RequestAccepted
GROUP BY requester_id))
GROUP BY id
ORDER BY num DESC
LIMIT 1;