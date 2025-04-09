-- BEATS 93.04%

SELECT 
    person_name
FROM
    (SELECT 
        person_id, person_name, 
        SUM(weight) OVER (ORDER BY turn) AS cum_weight
    FROM Queue
    ORDER BY turn) t
WHERE cum_weight <= 1000
ORDER BY cum_weight DESC
LIMIT 1
