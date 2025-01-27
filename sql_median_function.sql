-- How to find median of orders for each customer from orders table 
SELECT 
  PERCENTILE_DISC(orders, 0.5) OVER(PARTITION BY customer_code) AS median_orders
FROM `orders`
