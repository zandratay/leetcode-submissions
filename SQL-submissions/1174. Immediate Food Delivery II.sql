-- BEATS 85.6%

# Write your MySQL query statement below

WITH first_order AS (
    SELECT customer_id, MIN(order_date) AS first_order_date
FROM Delivery
GROUP BY customer_id),
joining AS (
    SELECT fo.customer_id, fo.first_order_date,
    d.customer_pref_delivery_date, d.delivery_id
    FROM Delivery d
    LEFT JOIN first_order fo
    ON fo.customer_id = d.customer_id 
    AND fo.first_order_date = d.order_date
)

SELECT 
    ROUND(100 * SUM(CASE WHEN customer_id IS NOT NULL AND first_order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / SUM(CASE WHEN customer_id IS NOT NULL THEN 1 ELSE 0 END), 2) AS immediate_percentage
FROM joining
