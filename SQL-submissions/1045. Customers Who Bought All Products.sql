-- BEATS 96.83%

WITH deduplicated AS (
    SELECT customer_id, product_key
FROM Customer
GROUP BY customer_id, product_key
),
grouped_customers AS (
    SELECT customer_id, GROUP_CONCAT(product_key ORDER BY product_key) AS purchased_products
FROM deduplicated
GROUP BY customer_id
),
all_products AS (
    SELECT GROUP_CONCAT(product_key ORDER BY product_key) AS all_products,
    1 AS flag
    FROM Product
)
SELECT gc.customer_id
FROM grouped_customers gc
LEFT JOIN all_products ap
on gc.purchased_products = ap.all_products
WHERE ap.flag = 1
