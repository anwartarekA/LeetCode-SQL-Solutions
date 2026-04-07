select q.query_name , q.quality , p.poor_query_percentage from (select query_name , ROUND(sum(rating::numeric / position::numeric)/count(*),2) as quality from Queries group by query_name) q 
inner join 
(select query_name , ROUND(((count(rating) filter(where rating < 3) )::numeric/count(*)::numeric) * 100,2) as poor_query_percentage from Queries group by query_name) p
on q.query_name = p.query_name;
