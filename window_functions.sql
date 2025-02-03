-- Advanced SQL Script for Customer Order Analysis
-- Author: Suroom Khan
-- Date: 03 Feb 2025
-- Description: This script analyzes customer orders using window functions, CTEs, and advanced SQL techniques.

-- Step 1: Create a CTE to calculate running totals and rank orders for each customer
WITH customer_order_analysis AS (
    SELECT
        customer_id,
        order_id,
        order_date,
        total_amount,
        -- Calculate running total of orders for each customer
        SUM(total_amount) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_total,
        -- Rank orders by total_amount for each customer
        RANK() OVER (
            PARTITION BY customer_id
            ORDER BY total_amount DESC
        ) AS order_rank
    FROM
        orders
)

-- Step 2: Analyze top customers and their orders
SELECT
    customer_id,
    order_id,
    order_date,
    total_amount,
    running_total,
    order_rank,
    -- Identify top customers based on total spending
    CASE
        WHEN running_total >= 500 THEN 'Top Customer'
        ELSE 'Regular Customer'
    END AS customer_segment
FROM
    customer_order_analysis
ORDER BY
    customer_id,
    order_date;
