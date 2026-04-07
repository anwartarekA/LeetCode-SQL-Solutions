select name , COALESCE(sum(Rides.distance),0) as travelled_distance from Users left outer join Rides on Users.id = Rides.user_id group by name,Users.id order by travelled_distance DESC, name ASC
