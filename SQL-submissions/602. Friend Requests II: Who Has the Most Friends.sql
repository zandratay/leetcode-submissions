-- BEATS 83.99%

SELECT 
    id, 
    COUNT(id) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted 
    UNION ALL 
    SELECT accepter_id FROM RequestAccepted) AS t1
GROUP BY id
ORDER BY COUNT(id) DESC
LIMIT 1

