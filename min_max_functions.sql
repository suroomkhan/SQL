-- Get the product with the highest and lowest sales
SELECT 
    product_id,
    MIN(order_amount) AS min_sales,
    MAX(order_amount) AS max_sales
FROM `your_project.dataset.orders`
GROUP BY product_id;
