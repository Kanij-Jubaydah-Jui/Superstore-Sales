-- Exploring the Data & Cleaning
SELECT 
    *
FROM
    superstoresales.data;
    
SELECT 
    'Order Date'
FROM
    superstoresales.data
LIMIT 10;
 
SELECT 
    'Order Date',
    STR_TO_DATE('Order Date', '%y/%m/%d') AS FORMATTED_DATE
FROM
    superstoresales.data;

SET SQL_SAFE_UPDATES = 0;

UPDATE superstoresales.data 
SET 
    OrderDate = STR_TO_DATE('Order Date', '%y/%m/%d');
SELECT 
    *
FROM
    superstoresales.data
LIMIT 10;
    
SELECT 
    'Ship Date'
FROM
    superstoresales.data
LIMIT 10;
 
SELECT 
    'Ship Date',
    STR_TO_DATE('Ship Date', '%y/%m/%d') AS FORMATTED_date
FROM
    superstoresales.data;

SET SQL_SAFE_UPDATES = 0;

UPDATE superstoresales.data 
SET 
    ShipDate = STR_TO_DATE('Ship Date', '%y/%m/%d');
SELECT 
    *
FROM
    superstoresales.data
LIMIT 10;