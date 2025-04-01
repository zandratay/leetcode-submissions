-- BEATS 94.65%

WITH min_check AS (
    SELECT player_id, MIN(event_date) AS first_login_date,
    MIN(event_date) + INTERVAL 1 DAY AS next_date
    FROM Activity 
    GROUP BY player_id
),
joining AS (
    SELECT mc.*,
    a.games_played
    FROM min_check mc
    LEFT JOIN Activity a
    ON mc.player_id = a.player_id
    AND mc.next_date = a.event_date
)

SELECT 
    ROUND(SUM(CASE WHEN games_played IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS fraction
from joining
