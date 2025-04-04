-- BEATS 99.76%

SELECT DISTINCT
    num AS ConsecutiveNums
FROM
    (SELECT 
        num,
        LAG(NUM, 1) OVER (ORDER BY id) AS prev_num,
        LEAD(NUM, 1) OVER (ORDER BY id) AS next_num
    FROM Logs) AS joined
WHERE num = prev_num AND num = next_num 
