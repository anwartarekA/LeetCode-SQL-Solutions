WITH totalCount AS (
    SELECT user_id, COUNT(user_id) FROM reactions GROUP BY user_id
)

SELECT * FROM (SELECT reactions.user_id , reaction AS dominant_reaction, ROUND(COUNT(reaction)::NUMERIC / (SELECT count FROM totalCount WHERE totalCount.user_id = reactions.user_id) , 2) AS reaction_ratio FROM reactions GROUP BY user_id , reaction HAVING COUNT(*) >= 4) WHERE reaction_ratio >= 0.6 ORDER BY reaction_ratio DESC , user_id ASC;