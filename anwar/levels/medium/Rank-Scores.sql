select score, rank from (select id , score , dense_rank() over(order by score DESC) as rank from Scores ) as scores 
