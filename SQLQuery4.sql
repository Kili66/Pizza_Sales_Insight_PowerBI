select * from pizza_sales

SELECT TOP 5 pizza_name, count(distinct order_id ) AS total_orders from pizza_sales
GROUP BY pizza_name
ORDER BY total_orders 


