select * from (
select s1.id , min(s2.id) as id , max(s2.student) filter(where s2.id > s1.id) from Seat s1
join Seat s2
on s2.id = s1.id + 1 or s2.id = s1.id group by s1.id
union all
select s1.id , max(s2.id) as id , max(s2.student) filter(where s2.id = s1.id) from Seat s1
join Seat s2
on s2.id = s1.id + 1 or s2.id = s1.id group by s1.id
 )as res
