-- find 2nd highest number of orders for a customer from orders table in any given number of months
SELECT
    CUSTOMER_CODE,
    NTH_VALUE(ORDERS, 2) OVER (
        PARTITION BY CUSTOMER_CODE ORDER BY ORDERS DESC
          ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS SECOND_HIGHEST_ORDERS
FROM ORDERS
WHERE DATE_TRUNC(date_local, MONTH) IN ('2024-01-01', '2024-01-02', '2024-01-03'); -- Replace with the desired months
  
-- find the last value of orders for a customer from the orders table over any given number of months based on chronological order (e.g., the latest date or month)
SELECT
    CUSTOMER_CODE,
    LAST_VALUE(ORDERS) OVER (
        PARTITION BY CUSTOMER_CODE ORDER BY ORDER_DATE ASC -- Or use a relevant column for chronological order
          ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS LAST_ORDER
FROM ORDERS
WHERE DATE_TRUNC(date_local, MONTH) IN ('2024-01-01', '2024-01-02', '2024-01-03'); -- Replace with the desired months
