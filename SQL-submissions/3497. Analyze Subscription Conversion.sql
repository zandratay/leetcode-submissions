-- method 1: BEATS 72.78%

SELECT
    user_id, trial_avg_duration, paid_avg_duration
FROM
    (SELECT 
        user_id,
        ROUND(SUM(IF(activity_type = 'free_trial', activity_duration, 0)) / SUM(IF(activity_type = 'free_trial', 1, 0)), 2) AS trial_avg_duration,
        ROUND(SUM(IF(activity_type = 'paid', activity_duration, 0)) / SUM(IF(activity_type = 'paid', 1, 0)), 2) AS paid_avg_duration
    FROM UserActivity
    GROUP BY user_id) AS tbl1
WHERE paid_avg_duration IS NOT NULL AND trial_avg_duration IS NOT NULL 


-- method 2: BEATS 65%

WITH paid_users AS (
    SELECT
        DISTINCT user_id
    FROM UserActivity u1
    WHERE EXISTS (
        SELECT 1 FROM UserActivity u2
        WHERE u1.user_id = u2.user_id
        AND u2.activity_type IN ('free_trail', 'paid')
    )
)

SELECT 
    pu.user_id, 
    ROUND(SUM(IF(ua.activity_type = 'free_trial', activity_duration, 0)) / SUM(IF(ua.activity_type = 'free_trial', 1, 0)), 2) AS trial_avg_duration,
    ROUND(SUM(IF(ua.activity_type = 'paid', activity_duration, 0)) / SUM(IF(ua.activity_type = 'paid', 1, 0)), 2) AS paid_avg_duration
FROM paid_users pu
LEFT JOIN UserActivity ua
ON pu.user_id = ua.user_id
GROUP BY pu.user_id
ORDER BY pu.user_id 
