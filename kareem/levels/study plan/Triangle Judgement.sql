WITH res AS(
    SELECT *, 'Yes' AS triangle
FROM Triangle
WHERE x + y > z AND x + z > y AND y + z > x
UNION ALL
    SELECT *, 'No' AS triangle
FROM Triangle
WHERE x + y < z OR x + z > y OR y + z > x
)

SELECT * FROM res;