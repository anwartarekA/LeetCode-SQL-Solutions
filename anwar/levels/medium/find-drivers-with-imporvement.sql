select drivers.driver_id , driver_name , round(first_half_avg,2) as first_half_avg , round(second_half_avg , 2) as second_half_avg , round(efficiency_improvement,2) as efficiency_improvement from(select res3.driver_id ,res3.average as second_half_avg , res4.average as first_half_avg,(res3.average - res4.average)as efficiency_improvement  from (select driver_id , average , year from (select driver_id , avg(fuel_efficiency)as average , max(year) as year from (select * from (select trip_id , driver_id , trip_date , distance_km , fuel_consumed ,(distance_km::numeric / fuel_consumed) as fuel_efficiency , month::int , year from (select trip_id , driver_id , trip_date , distance_km , fuel_consumed, to_char(trip_date , 'MM') as month ,year from (select * from 
 (select trip_id id, to_char(trip_date,'YYYY') as year from trips) as years
     join trips on
     years.id = trips.trip_id) as one ) as half_one where month::int >= 1 and month::int <= 6 ) as first_half) as first_avg group by driver_id ) as res1) as res4

join

(select driver_id , average , year from (select driver_id , avg(fuel_efficiency)as average , max(year) as year from (select * from (select trip_id , driver_id , trip_date , distance_km , fuel_consumed ,(distance_km::numeric / fuel_consumed) as fuel_efficiency , month::int , year from (select trip_id , driver_id , trip_date , distance_km , fuel_consumed, to_char(trip_date , 'MM') as month ,year from (select * from 
 (select trip_id id, to_char(trip_date,'YYYY') as year from trips) as years
     join trips on
     years.id = trips.trip_id) as two ) as half_two where month::int >= 7 and month::int <= 12 ) as second_half) as second_avg group by driver_id) as res2 ) as res3 on res4.driver_id = res3.driver_id and res4.year = res3.year ) final1 join drivers on final1.driver_id = drivers.driver_id where efficiency_improvement > 0 order by efficiency_improvement desc , driver_name;
