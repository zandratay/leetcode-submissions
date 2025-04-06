-- BEATS 96.10%

SELECT 
    t.id
FROM (SELECT id, temperature,
    DATE_SUB(recordDate, INTERVAL 1 DAY) AS prev_date 
    FROM Weather) AS t
LEFT JOIN Weather w
ON w.recordDate = t.prev_date
WHERE t.temperature > w.temperature
