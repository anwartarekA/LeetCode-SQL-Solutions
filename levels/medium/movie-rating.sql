select min(name) as results from (select user_id , movie_count from (select user_id , count(movie_id) as movie_count from MovieRating group by user_id ) where movie_count = (
    select max(movie_count) from (select user_id , count(movie_id) as movie_count from MovieRating group by user_id) as sub2
) )as persons
inner join Users on persons.user_id = Users.user_id

union all

select min(title) as results from (select movie_id from (select movie_id , avg(rating) as average_rating from (select * from MovieRating where created_at between'2020-02-01'::Date and '2020-02-29'::Date) group by movie_id) as two where average_rating = (
    select max(average_rating) from (
        select movie_id , avg(rating) as average_rating from (select * from         MovieRating where created_at between'2020-02-01'::Date and '2020-02-29'::Date) group by movie_id
    ) as inner_sub
))as mov inner join Movies on mov.movie_id = Movies.movie_id
