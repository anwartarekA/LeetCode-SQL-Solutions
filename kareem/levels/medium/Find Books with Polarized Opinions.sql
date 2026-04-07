WITH book AS (
SELECT * FROM reading_sessions WHERE book_id IN (SELECT book_id FROM (SELECT * FROM reading_sessions WHERE book_id IN (SELECT book_id FROM reading_sessions GROUP BY book_id HAVING COUNT(*) >= 5)) GROUP BY book_id HAVING COUNT(*) FILTER (WHERE session_rating >= 4) >= 1 AND COUNT(*) FILTER (WHERE session_rating <= 2) >= 1))

SELECT book_id , title , author , genre , pages , rating_spread , polarization_score FROM (SELECT DISTINCT  id ,rating_spread, ROUND(applied::NUMERIC / total , 2) AS polarization_score  FROM (SELECT * FROM (SELECT book_id , COUNT(*) AS applied , MAX(session_rating) - MIN(session_rating) AS rating_spread FROM book WHERE session_rating <= 2 OR session_rating >= 4 GROUP BY book_id) a1
INNER JOIN
(SELECT book_id AS id , COUNT(*) AS total FROM book GROUP BY book_id) a2
ON
a1.book_id = a2.id WHERE ROUND(applied::NUMERIC / total , 2) >= 0.6) b
INNER JOIN
book
ON
book.book_id = b.id) c
INNER JOIN
books
ON
c.id = books.book_id
ORDER BY
polarization_score DESC , title DESC;






