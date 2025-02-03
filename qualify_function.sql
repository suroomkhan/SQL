-- Get the Most Recent Order per Customer
SELECT 
    customer_id,
    order_id,
    order_date
FROM `your_project.dataset.orders`
QUALIFY ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) = 1
