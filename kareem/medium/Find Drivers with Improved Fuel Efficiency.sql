SELECT driver_id , driver_name , first_half_avg , second_half_avg ,efficiency_improvement  FROM (SELECT driver_id,b1.driver_name, ROUND(first_half_avg,2) AS first_half_avg , ROUND(second_half_avg , 2) AS second_half_avg , ROUND(second_half_avg::NUMERIC - first_half_avg::NUMERIC , 2) AS efficiency_improvement FROM (SELECT a.driver_id AS id , (SELECT driver_name FROM drivers WHERE drivers.driver_id = a.driver_id), AVG(distance_km / fuel_consumed) AS first_half_avg FROM (SELECT * FROM trips WHERE driver_id IN (SELECT driver_id FROM trips GROUP BY driver_id HAVING MAX(TO_CHAR(trip_date, 'MM')::INTEGER) > 6 AND MIN(TO_CHAR(trip_date , 'MM')::INTEGER) <= 6)) a WHERE TO_CHAR(trip_date, 'MM')::INTEGER <= 6 GROUP BY driver_id) b1

INNER JOIN

(SELECT a.driver_id , (SELECT driver_name FROM drivers WHERE drivers.driver_id = a.driver_id), AVG(distance_km / fuel_consumed) AS second_half_avg FROM (SELECT * FROM trips WHERE driver_id IN (SELECT driver_id FROM trips GROUP BY driver_id HAVING MAX(TO_CHAR(trip_date, 'MM')::INTEGER) > 6 AND MIN(TO_CHAR(trip_date , 'MM')::INTEGER) <= 6)) a WHERE TO_CHAR(trip_date, 'MM')::INTEGER > 6 GROUP BY driver_id) b2

ON b1.id = b2.driver_id

ORDER BY efficiency_improvement DESC, driver_name ASC) WHERE second_half_avg >= first_half_avg;