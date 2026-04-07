SELECT Weather.id  FROM Weather
WHERE Weather.temperature > (
    SELECT w.temperature FROM
     (SELECT * FROM Weather) w
    WHERE w.recordDate = Weather.recordDate - 1)