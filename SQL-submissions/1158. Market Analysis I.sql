-- BEATS 83.30%

SELECT 
    u.user_id AS buyer_id, u.join_date,
    COALESCE(o.orders_in_2019, 0) AS orders_in_2019
FROM Users u
LEFT JOIN (
    SELECT buyer_id, COUNT(DISTINCT order_id) AS orders_in_2019
    FROM Orders
    WHERE YEAR(order_date) = 2019
    GROUP BY buyer_id
) o
ON u.user_id = o.buyer_id
