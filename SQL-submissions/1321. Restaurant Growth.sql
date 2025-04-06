-- BEATS 87.77%

SELECT visited_on, amount, average_amount
FROM
    (SELECT 
        visited_on, 
        ROUND(SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS amount,
        ROUND(AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS rnk
    FROM (
        SELECT visited_on, SUM(amount) AS amount
        FROM Customer
        GROUP BY visited_on
    ) AS tmp
    ORDER BY visited_on) AS tmp2
WHERE rnk >= 7
