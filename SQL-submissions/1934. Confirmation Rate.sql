-- BEATS 80.06%

# Write your MySQL query statement below

WITH tbl AS (
    SELECT s.user_id,
    c.action
    FROM Signups s
    LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
)
SELECT 
    user_id,
    COALESCE(ROUND(sum(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) / COUNT(*), 2) , 0) AS confirmation_rate
FROM tbl
GROUP BY user_id
