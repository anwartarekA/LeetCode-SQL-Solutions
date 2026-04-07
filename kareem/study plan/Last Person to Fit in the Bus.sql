WITH ordered AS(
    SELECT * FROM Queue ORDER BY turn ASC
)

SELECT person_name FROM Queue WHERE turn = (SELECT turn FROM (SELECT o.turn  FROM ordered o WHERE (SELECT SUM(weight) FROM ordered WHERE ordered.turn <= o.turn) <= 1000) ORDER BY turn DESC LIMIT 1);