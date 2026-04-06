SELECT * FROM Products
WHERE description ~ '(?<![A-Za-z0-9])SN[0-9]{4}-[0-9]{4}(?![0-9A-Za-z])'
ORDER BY product_id ASC;