-- BEATS 88.64%

SELECT 
    id,
    CASE WHEN id = (SELECT MAX(id) FROM Seat) AND id % 2 = 1 THEN student
        WHEN id % 2 = 1 THEN LEAD(student) OVER (ORDER BY id)
        WHEN id % 2 = 0 THEN LAG(student) OVER (ORDER BY id)
    END AS student
FROM Seat
