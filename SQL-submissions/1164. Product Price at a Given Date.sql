-- Beats 82.28%

WITH tmp AS (SELECT product_id, new_price
FROM
    (SELECT 
        product_id, new_price,
        ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY change_date DESC) AS entry_num
    FROM Products
    WHERE change_date <= '2019-08-16') AS temp1
WHERE entry_num = 1)

SELECT 
    DISTINCT p.product_id, 
    COALESCE(t.new_price, 10) AS price
FROM Products p
LEFT JOIN tmp t
ON p.product_id = t.product_id



-- COALESCE(MAX(CASE WHEN change_date <= '2019-08-16' THEN new_price ELSE NULL END), 10) AS price
