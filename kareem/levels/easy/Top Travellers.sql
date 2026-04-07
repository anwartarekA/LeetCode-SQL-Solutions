(SELECT name , SUM(distance) AS travelled_distance
FROM Users
JOIN Rides
ON Users.id = Rides.user_id
GROUP BY (name , user_id))

UNION ALL

(SELECT name , 0 AS travelled_distance
FROM Users
LEFT JOIN Rides
ON Users.id = Rides.user_id
WHERE distance IS NULL)

ORDER BY travelled_distance DESC , name ASC;