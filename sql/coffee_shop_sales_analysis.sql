USE coffee_shop;

UPDATE coffee_shop_sales
SET LineRevenue = REPLACE(REPLACE(LineRevenue, '$', ''), ',', '');
ALTER TABLE coffee_shop_sales
MODIFY COLUMN LineRevenue DECIMAL(10,2);

-- BUSIEST HOURS BY LOCATION
SELECT store_location AS location, Hour, COUNT(DISTINCT order_id) AS orders, SUM(transaction_qty) AS items_sold, SUM(LineRevenue) AS revenue 
FROM coffee_shop_sales GROUP BY location, Hour ORDER BY location, orders DESC;

-- TOP 10 PRODUCTS BY REVENUE
SELECT product_category, SUM(LineRevenue) AS revenue, SUM(transaction_qty) AS total_quantity FROM coffee_shop_sales
GROUP BY product_category ORDER BY revenue DESC LIMIT 10;

WITH per_order AS (
    SELECT 
        order_id,
        SUM(LineRevenue) AS order_revenue
    FROM coffee_shop_sales 
    GROUP BY order_id
)
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(order_revenue) AS total_revenue,
    ROUND(SUM(order_revenue) / COUNT(DISTINCT order_id), 2) AS general_avg_order_value
FROM per_order;