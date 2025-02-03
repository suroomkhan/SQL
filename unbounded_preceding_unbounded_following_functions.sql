-- Key Points 
-- ✅ UNBOUNDED PRECEDING → Includes all previous rows in a partition.
-- ✅ UNBOUNDED FOLLOWING → Includes all future rows in a partition.
-- ✅ Used in window functions to calculate running totals, rolling averages, or max/min values.

-- 1. Running Total of Sales Using UNBOUNDED PRECEDING
SELECT 
    order_id,
    customer_id,
    order_date,
    order_amount,
    SUM(order_amount) OVER (PARTITION BY customer_id ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM `your_project.dataset.orders`;

-- 2. Compute Total Sales Per Customer Using UNBOUNDED FOLLOWING
SELECT 
    order_id,
    customer_id,
    order_date,
    order_amount,
    SUM(order_amount) OVER (PARTITION BY customer_id ORDER BY order_date ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS future_total
FROM `your_project.dataset.orders`;

-- 3. Find the Maximum Order Amount in Each Customer's History
SELECT 
    order_id,
    customer_id,
    order_date,
    order_amount,
    MAX(order_amount) OVER (PARTITION BY customer_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_order_amount
FROM `your_project.dataset.orders`;

