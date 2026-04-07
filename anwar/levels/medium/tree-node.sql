(select id  , 'Root' as type from Tree where p_id is null)
union
select id , 'Inner' as type from (select * from Tree where p_id is not null) as P_id_not_null where id in (
    select p_id from Tree
) 
union
(select id , 'Leaf' as type from (select * from Tree where p_id is not null) as p_id_not_null_not_parent where id not in (
    select p_id from Tree where p_id is not null
));
