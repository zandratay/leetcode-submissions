- BEATS 80.64%

SELECT
    id,
    CASE 
        WHEN p_id IS NULL THEN 'Root'
        WHEN p_id IN (SELECT id FROM Tree) AND id IN (SELECT p_id FROM Tree) THEN 'Inner'
    ELSE 'Leaf' END AS type
FROM Tree
