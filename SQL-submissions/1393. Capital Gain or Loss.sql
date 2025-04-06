-- BEATS 94.68%

SELECT 
    stock_name,
    SUM(IF(operation = 'Buy', -1*price, price)) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name
