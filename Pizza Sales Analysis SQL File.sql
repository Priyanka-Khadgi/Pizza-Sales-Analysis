
-- Viewing dataset
SELECT * FROM pizza_sales

-- -------------------------------------------KPIs---------------------------------------------
-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;


-- Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value
FROM pizza_sales;


-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales;


-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;


-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;


-- ------------------------------------------- Trend Analysis ---------------------------------------------


-- Daily Trend for Orders
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);


-- Monthly Trend for Orders
SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC;


-- ------------------------------------------- Performance Analysis ---------------------------------------------


-- % of Sales by Pizza Category
SELECT pizza_category AS Pizza_Category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,  
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage_Sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Percentage_Sales DESC;


-- % of Sales by Pizza Size (Order Contribution per Pizza size)
SELECT pizza_size AS Pizza_Size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,  
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_Sales DESC;


-- Total Pizzas Sold by Pizza Category
SELECT pizza_category AS Pizza_Category, SUM(quantity) as Total_Quantity_Sold, ROUND (SUM (Total_price),2) AS Total_revenue
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- ------------------------------------------- Best / Worst Sellers ---------------------------------------------


-- Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name AS Pizza_Name, 
CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;


-- Bottom 5 Pizzas by Revenue
SELECT TOP 5 pizza_name AS Pizza_Name, 
CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue;


-- Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name AS Pizza_Name, 
CAST(SUM(quantity) AS DECIMAL(10,2)) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;


-- Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name AS Pizza_Name, 
CAST(SUM(quantity) AS DECIMAL(10,2)) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity;


-- Top 5 Pizzas by Orders
SELECT TOP 5 pizza_name AS Pizza_Name, 
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;


-- Bottom 5 Pizzas by Orders
SELECT TOP 5 pizza_name AS Pizza_Name, 
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders;


-- ------------------------------------------- Summary ---------------------------------------------


--Summary
SELECT COUNT (order_id) AS Total_Orders, COUNT (DISTINCT pizza_name) AS Number_of_pizza_types, 
		SUM (quantity) AS Total_Quantity_Sold, ROUND (SUM (total_price),2) AS Total_revenue,ROUND (AVG (total_price),2) AS Average_revenue
FROM pizza_sales


-- ------------------------------------------- Details ---------------------------------------------


--Orders per Pizza  
SELECT pizza_name, COUNT (order_id) AS Number_of_Orders,
SUM (quantity) AS Number_of_Pizzas, ROUND (SUM (total_price),2) AS Total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC




