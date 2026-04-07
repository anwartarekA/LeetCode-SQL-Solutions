WITH compination AS(
SELECT MovieRating.user_id ,  MovieRating.movie_id , rating , created_at , name FROM MovieRating
JOIN
Users
ON Users.user_id = MovieRating.user_id
JOIN
Movies
ON Movies.movie_id = MovieRating.movie_id
)

(SELECT name AS results FROM (SELECT user_id FROM (SELECT user_id , COUNT(rating) FROM compination GROUP BY user_id) WHERE count IN (SELECT MAX(count) FROM (SELECT user_id , COUNT(rating) FROM compination GROUP BY user_id))) b1
JOIN Users
ON Users.user_id = b1.user_id
ORDER BY name
LIMIT 1)
UNION ALL
(SELECT title AS results FROM (SELECT * FROM (SELECT movie_id , AVG(rating) FROM compination WHERE TO_CHAR(created_at , 'YYYY-MM') = '2020-02' GROUP BY movie_id) WHERE avg IN (SELECT MAX(avg) FROM (SELECT movie_id , AVG(rating) FROM compination WHERE TO_CHAR(created_at , 'YYYY-MM') = '2020-02' GROUP BY movie_id))) a1
JOIN Movies
ON movies.movie_id = a1.movie_id
ORDER BY title
LIMIT 1);