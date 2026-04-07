SELECT  borrowing_records.book_id, library_books.title, library_books.author, library_books.genre, library_books.publication_year, COUNT(borrowing_records.book_id) AS current_borrowers FROM 
borrowing_records
JOIN library_books
ON borrowing_records.book_id = library_books.book_id
WHERE borrowing_records.return_date IS NULL
GROUP BY borrowing_records.book_id, total_copies, library_books.title ,  library_books.author, library_books.genre, library_books.publication_year
HAVING COUNT(borrowing_records.book_id) - library_books.total_copies = 0
ORDER BY current_borrowers DESC, library_books.title ASC;