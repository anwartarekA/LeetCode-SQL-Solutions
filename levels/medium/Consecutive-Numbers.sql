select distinct l1.num as ConsecutiveNums from Logs l1 where num = 
(
    select num from Logs l2 where l2.num = l1.num and l2.id = l1.id + 1 and l2.num = (
        select num from Logs l3 where l3.num = l2.num and l3.id = l2.id + 1
    )
)
