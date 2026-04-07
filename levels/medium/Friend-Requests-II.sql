select id , sum(num)as num from (select accepter_id as id ,count(*) as num from RequestAccepted group by accepter_id
union all
select requester_id as id,count(*) as num from RequestAccepted group by requester_id ) as res group by id order by num DESC limit 1;
