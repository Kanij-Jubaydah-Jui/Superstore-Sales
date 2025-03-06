-- EDA-(Exploratory Data Analysis)
SELECT 
    *
FROM
    superstoresales.data;
    
-- Total Sales Record
SELECT 
    COUNT(*)
FROM
    superstoresales.data;
    
-- Total Sales, total Profit
SELECT 
    ROUND(SUM(Sales), 0) AS Total_Sales,
    ROUND(SUM(Profit), 0) AS Total_Profit
FROM
    superstoresales.data;
    
-- Unique Number of Customers
SELECT 
    COUNT(DISTINCT 'Customer Name')
FROM
    superstoresales.data;
    
-- Total Sales by Region
SELECT 
    Region, ROUND(SUM(Sales), 0) AS Total_Sales
FROM
    superstoresales.data
GROUP BY Region
ORDER BY Total_Sales DESC;
    
-- Total Profit by Product Category
SELECT 
    'Product Category', ROUND(SUM(Profit), 0) AS Total_Profit
FROM
    superstoresales.data
GROUP BY 'Product Category'
ORDER BY Total_Profit DESC;

-- Total Customer Segment Count
SELECT 
    'Customer Segment', COUNT(*) AS Customer_Count
FROM
    superstoresales.data
GROUP BY 'Customer Segment';

-- Top 5 Customers by Sales
SELECT 
    'Customer Name', ROUND(SUM(Sales), 0) AS Total_Sales
FROM
    superstoresales.data
GROUP BY 'Customer Name'
ORDER BY Total_Sales DESC
LIMIT 5;

-- Customer who made at least 5 orders
SELECT 
    'Custome Name',
    COUNT('Order ID') AS Total_Order,
    ROUND(SUM(Sales), 0) AS Total_Sales
FROM
    superstoresales.data
GROUP BY 'Custome Name'
HAVING Total_Order >= 5