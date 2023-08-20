# Pizza_Sales_Insight_PowerBI
## Pizza Sales Insight Analysis using SQL, DAX, PowerQuery
* This project aims to analyze the sales data of a pizza chain and provide insights on key performance indicators, trends, and best sellers. The data source is a table named pizza_sales, which contains the following columns:

* order_id: a unique identifier for each order
* order_date: the date and time when the order was placed
* pizza_name: the name of the pizza ordered
* pizza_category: the category of the pizza, such as veggie, meat, or cheese
* pizza_size: the size of the pizza, such as small, medium, or large
* quantity: the number of pizzas ordered
* unit_price: the price per pizza
* total_price: the total price of the order
* The project uses SQL and DAX queries to perform various calculations and aggregations on the data. The results are presented in charts and tables using Power BI.

## Key Performance Indicators (KPIs)
### The following KPIs are calculated using SQL and DAX queries:

### Total Revenue: the sum of total_price for all orders
* SQL: select SUM(total_price) as total_revenue from pizza_sales
* DAX: Total Revenue = SUM(pizza_sales[total_price])
### Average Order Value: the average of total_price per order
* SQL: select SUM(total_price) / count(distinct order_id) as avg_orders_value from pizza_sales
* DAX: Average Order Value = AVERAGEX(VALUES(pizza_sales[order_id]), pizza_sales[total_price])
### Total Pizza Sold: the sum of quantity for all orders
* SQL: select sum(quantity) as Total_pizza_sold from pizza_sales
* DAX: Total Pizza Sold = SUM(pizza_sales[quantity])
### Total Orders Placed: the count of distinct order_id
* SQL: select COUNT(distinct order_id) as total_orders from pizza_sales
* DAX: Total Orders Placed = DISTINCTCOUNT(pizza_sales[order_id])
### Average Pizzas per Order: the average of quantity per order
* SQL: select CAST(CAST(sum(quantity) AS Decimal(10,2)) / CAST(COUNT(distinct order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) as avg_pizza_per_order from pizza_sales
* DAX: Average Pizzas per Order = AVERAGEX(VALUES(pizza_sales[order_id]), pizza_sales[quantity])
## Charts Requirements
###  The following charts are created using SQL and DAX queries:

### Daily Trend for Total Orders: a line chart that shows the number of orders placed by each day of the week
* SQL: SELECT DATENAME(DW, order_date) as week_day, COUNT(distinct order_id) as daily_order from pizza_sales GROUP BY DATENAME(DW, order_date)
* DAX: Daily Trend for Total Orders = GROUPBY(pizza_sales, FORMAT(pizza_sales[order_date], "dddd"), "Daily Order", DISTINCTCOUNT(pizza_sales[order_id]))
### Monthly Trend for Total Orders: a column chart that shows the number of orders placed by each month in descending order
* SQL: SELECT DATENAME(MONTH, order_date) as Month_name, COUNT(distinct order_id) as Total_orders from pizza_sales GROUP BY DATENAME(MONTH, order_date) ORDER BY Total_orders DESC
* DAX: Monthly Trend for Total Orders = GROUPBY(pizza_sales, FORMAT(pizza_sales[order_date], "MMMM"), "Total Orders", DISTINCTCOUNT(pizza_sales[order_id]))
### Percentage of Sales by Pizza Category: a pie chart that shows the percentage of total revenue by each pizza category
* SQL: SELECT pizza_category,SUM(total_price)*100/ (SELECT SUM(total_price) from pizza_sales) as sale_percentage from pizza_sales GROUP BY pizza_category
* DAX: Percentage of Sales by Pizza Category = GROUPBY(pizza_sales, pizza_sales[pizza_category], "Sale Percentage", SUM(pizza_sales[total_price]) / CALCULATE(SUM(pizza_sales[total_price]), ALL(pizza_sales)))
### Sales for January: a bar chart that shows the total revenue and percentage of total revenue by each pizza category for January only
* SQL: SELECT pizza_category,SUM(total_price) as total_Sales, SUM(total_price)*100/ (SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date)=1) as sale_percentage from pizza_sales WHERE MONTH(order_date)=1 GROUP BY pizza_category
* DAX: Sales for January = FILTER(GROUPBY(pizza_sales, pizza_sales[pizza_category], "Total Sales", SUM(pizza_sales[total_price]), "Sale Percentage", SUM(pizza_sales[total_price]) / CALCULATE(SUM(pizza_sales[total_price]), ALL(pizza_sales))), MONTH(pizza_sales[order_date]) = 1)
### Percentage of Sales by Pizza Size: a donut chart that shows the percentage of total revenue by each pizza size
* SQL: SELECT pizza_size,SUM(total_price) as total_Sales, SUM(total_price)*100/ (SELECT SUM(total_price) from pizza_sales) as sale_percentage from pizza_sales GROUP BY pizza_size
* DAX: Percentage of Sales by Pizza Size = GROUPBY(pizza_sales, pizza_sales[pizza_size], "Total Sales", SUM(pizza_sales[total_price]), "Sale Percentage", SUM(pizza_sales[total_price]) / CALCULATE(SUM(pizza_sales[total_price]), ALL(pizza_sales)))
### Top 5 Best Sellers by Revenue: a table that shows the top 5 pizza names and their total revenue in descending order
* SQL: SELECT TOP 5 pizza_name, sum(total_price) AS total_revenue from pizza_sales GROUP BY pizza_name ORDER BY total_revenue DESC
* DAX: Top 5 Best Sellers by Revenue = TOPN(5, GROUPBY(pizza_sales, pizza_sales[pizza_name], "Total Revenue", SUM(pizza_sales[total_price])), [Total Revenue], DESC)
### Bottom/Worst 5 Best Sellers by Revenue: a table that shows the bottom 5 pizza names and their total revenue in ascending order
* SQL: SELECT TOP 5 pizza_name, sum(total_price) AS total_revenue from pizza_sales GROUP BY pizza_name ORDER BY total_revenue ASC
* DAX: Bottom/Worst 5 Best Sellers by Revenue = TOPN(5, GROUPBY(pizza_sales, pizza_sales[pizza_name], "Total Revenue", SUM(pizza_sales[total_price])), [Total Revenue], ASC)
### Top 5 Best Sellers by Quantity: a table that shows the top 5 pizza names and their total quantity sold in descending order
* SQL: SELECT TOP 5 pizza_name, sum(quantity) AS total_quantity from pizza_sales GROUP BY pizza_name ORDER BY total_quantity DESC
* DAX: Top 5 Best Sellers by Quantity = TOPN(5, GROUPBY(pizza_sales, pizza_sales[pizza_name], "Total Quantity", SUM(pizza_sales[quantity])), [Total Quantity], DESC)
### Bottom/Worst 5 Best Sellers by Quantity: a table that shows the bottom 5 pizza names and their total quantity sold in ascending order
* SQL: SELECT TOP 5 pizza_name, sum(quantity) AS total_quantity from pizza_sales GROUP BY pizza_name ORDER BY total_quantity ASC
* DAX: Bottom/Worst 5 Best Sellers by Quantity = TOPN(5, GROUPBY(pizza_sales, pizza_sales[pizza_name], "Total Quantity", SUM(pizza_sales[quantity])), [Total Quantity], ASC)
### Top 5 Best Sellers by Order: a table that shows the top 5 pizza names and their total number of orders placed in descending order
* SQL: SELECT TOP 5 pizza_name, count(distinct order_id ) AS total_orders from pizza_sales GROUP BY pizza_name ORDER BY total_orders DESC
* DAX: Top 5 Best Sellers by Order = TOPN(5, GROUPBY(pizza_sales, pizza_sales[pizza_name], "Total Orders", DISTINCTCOUNT(pizza_sales[order_id])), [Total Orders], DESC)
### Bottom/Worst 5 Best Sellers by Order: a table that shows the bottom 5 pizza names and their total number of orders placed in ascending order
* SQL: SELECT TOP 5 pizza_name, count(distinct order_id ) AS total_orders from pizza_sales GROUP BY pizza_name ORDER BY total_orders ASC
* DAX: Bottom/Worst 5 Best Sellers by Order = TOPN(5, GROUPBY(pizza_sales, pizza_sales[pizza_name], "Total Orders", DISTINCTCOUNT(pizza_sales[order_id])), [Total Orders], ASC)
  
