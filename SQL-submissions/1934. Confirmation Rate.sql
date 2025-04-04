-- BEATS 95.59%


WITH joined AS (
    SELECT s.user_id, c.time_stamp, c.action
    FROM Signups s
    LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
)

SELECT 
    user_id,
    ROUND(COALESCE(SUM(IF(action = 'confirmed', 1, 0)) / COUNT(*), 0), 2) AS confirmation_rate
FROM joined
GROUP BY user_id
