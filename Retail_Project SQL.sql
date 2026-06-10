CREATE DATABASE retail_project;

USE retail_project;

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
InvoiceNo INT,
StockCode VARCHAR(50),
Description VARCHAR(255),
Quantity INT,
InvoiceDate DATETIME,
UnitPrice DECIMAL(10,2),
CustomerID VARCHAR(50),
Country VARCHAR(100),
Discount DECIMAL(5,2),
PaymentMethod VARCHAR(50),
ShippingCost DECIMAL(10,2),
Category VARCHAR(100),
SalesChannel VARCHAR(50),
ReturnStatus VARCHAR(50),
ShipmentProvider VARCHAR(100),
WarehouseLocation VARCHAR(100),
OrderPriority VARCHAR(20),
TotalCost DECIMAL(10,2),
Revenue DECIMAL(10,2),
TotalSales DECIMAL(10,2),
Day VARCHAR(20),
Month VARCHAR(20)
);
SHOW TABLES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_data.csv'
INTO TABLE retail_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select count(*)
from retail_sales;

-- 1 Total Orders
SELECT COUNT(*) AS total_orders FROM retail_sales;

-- 2 Total Sales
SELECT SUM(TotalSales) AS total_sales FROM retail_sales;

-- 3 Total Revenue
SELECT SUM(Revenue) AS total_revenue FROM retail_sales;

-- 4 Total Cost
SELECT SUM(TotalCost) AS total_cost FROM retail_sales;

-- 5 Average Order Value
SELECT AVG(TotalSales) AS avg_order_value FROM retail_sales;

-- 6 Sales by Country
SELECT Country,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY Country
ORDER BY sales DESC;

-- 7 Sales by Category
SELECT Category,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY Category
ORDER BY sales DESC;

-- 8 Sales by Month
SELECT Month,SUM(TotalSales) AS monthly_sales
FROM retail_sales
GROUP BY Month
ORDER BY monthly_sales DESC;

-- 9 Sales by Day
SELECT Day,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY Day
ORDER BY sales DESC;

-- 10 Sales by Payment Method
SELECT PaymentMethod,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY PaymentMethod
ORDER BY sales DESC;

-- 11 Sales by Sales Channel
SELECT SalesChannel,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY SalesChannel;

-- 12 Orders by Warehouse
SELECT WarehouseLocation,COUNT(*) AS orders
FROM retail_sales
GROUP BY WarehouseLocation
ORDER BY orders DESC;

-- 13 Orders by Priority
SELECT OrderPriority,COUNT(*) AS orders
FROM retail_sales
GROUP BY OrderPriority
ORDER BY orders DESC;

-- 14 Returns Analysis
SELECT ReturnStatus,COUNT(*) AS return_count
FROM retail_sales
GROUP BY ReturnStatus;

-- 15 Sales by Shipping Provider
SELECT ShipmentProvider,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY ShipmentProvider
ORDER BY sales DESC;

-- 16 Top 10 Products by Sales
SELECT Description,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY Description
ORDER BY sales DESC
LIMIT 10;

-- 17 Lowest 10 Products
SELECT Description,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY Description
ORDER BY sales ASC
LIMIT 10;

-- 18 Top Countries by Revenue
SELECT Country,SUM(Revenue) AS revenue
FROM retail_sales
GROUP BY Country
ORDER BY revenue DESC
LIMIT 5;

-- 19 Average Discount by Category
SELECT Category,AVG(Discount) AS avg_discount
FROM retail_sales
GROUP BY Category
ORDER BY avg_discount DESC;

-- 20 Quantity Sold by Category
SELECT Category,SUM(Quantity) AS total_quantity
FROM retail_sales
GROUP BY Category
ORDER BY total_quantity DESC;

-- 21 Rank Products by Sales
SELECT Description,
SUM(TotalSales) AS sales,
RANK() OVER (ORDER BY SUM(TotalSales) DESC) AS sales_rank
FROM retail_sales
GROUP BY Description;

-- 22 Rank Countries by Sales
SELECT Country,
SUM(TotalSales) AS sales,
RANK() OVER (ORDER BY SUM(TotalSales) DESC) AS country_rank
FROM retail_sales
GROUP BY Country;

-- 23 Running Total Sales by Month
SELECT Month,
SUM(TotalSales) AS monthly_sales,
SUM(SUM(TotalSales)) OVER(ORDER BY Month) AS running_total
FROM retail_sales
GROUP BY Month;

-- 24 Highest Order
SELECT *
FROM retail_sales
ORDER BY TotalSales DESC
LIMIT 1;

-- 25 Shipping Cost by Provider
SELECT ShipmentProvider,
SUM(ShippingCost) AS total_shipping_cost
FROM retail_sales
GROUP BY ShipmentProvider
ORDER BY total_shipping_cost DESC;

-- 26 Sales Contribution by Country
SELECT Country,
SUM(TotalSales) AS sales,
ROUND(SUM(TotalSales)*100/(SELECT SUM(TotalSales) FROM retail_sales),2) AS percentage
FROM retail_sales
GROUP BY Country
ORDER BY sales DESC;

-- 27 Category Contribution
SELECT Category,
SUM(TotalSales) AS sales,
ROUND(SUM(TotalSales)*100/(SELECT SUM(TotalSales) FROM retail_sales),2) AS percentage
FROM retail_sales
GROUP BY Category
ORDER BY sales DESC;

-- 28 Most Used Payment Method
SELECT PaymentMethod,
COUNT(*) AS usage_count
FROM retail_sales
GROUP BY PaymentMethod
ORDER BY usage_count DESC;

-- 29 Top Shipping Providers by Orders
SELECT ShipmentProvider,
COUNT(*) AS total_orders
FROM retail_sales
GROUP BY ShipmentProvider
ORDER BY total_orders DESC
LIMIT 5;

-- 30 Highest Revenue Product
SELECT Description,
SUM(Revenue) AS revenue
FROM retail_sales
GROUP BY Description
ORDER BY revenue DESC
LIMIT 1;

-- 31 CTE Top Countries
WITH country_sales AS (
SELECT Country,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY Country
)
SELECT *
FROM country_sales
ORDER BY sales DESC
LIMIT 5;

-- 32 CTE Category Sales
WITH category_sales AS (
SELECT Category,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY Category
)
SELECT *
FROM category_sales
ORDER BY sales DESC;

-- 33 CTE Monthly Sales
WITH monthly_sales AS (
SELECT Month,SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY Month
)
SELECT *
FROM monthly_sales
ORDER BY sales DESC;

-- 34 Products Above Average Sales
SELECT Description,
SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY Description
HAVING SUM(TotalSales) >
(
SELECT AVG(product_sales)
FROM
(
SELECT SUM(TotalSales) AS product_sales
FROM retail_sales
GROUP BY Description
) AS avg_table
);

-- 35 Countries Above Average Sales
SELECT Country,
SUM(TotalSales) AS sales
FROM retail_sales
GROUP BY Country
HAVING SUM(TotalSales) >
(
SELECT AVG(country_sales)
FROM
(
SELECT SUM(TotalSales) AS country_sales
FROM retail_sales
GROUP BY Country
) AS avg_table
);

-- 36 ROW_NUMBER Example
SELECT Description,
SUM(TotalSales) AS sales,
ROW_NUMBER() OVER (ORDER BY SUM(TotalSales) DESC) AS row_num
FROM retail_sales
GROUP BY Description;

-- 37 DENSE_RANK Example
SELECT Country,
SUM(TotalSales) AS sales,
DENSE_RANK() OVER (ORDER BY SUM(TotalSales) DESC) AS dense_rk
FROM retail_sales
GROUP BY Country;

-- 38 Partition by Category
SELECT Category,
Description,
SUM(TotalSales) AS sales,
RANK() OVER(PARTITION BY Category ORDER BY SUM(TotalSales) DESC) AS category_rank
FROM retail_sales
GROUP BY Category,Description;

-- 39 Partition by Country
SELECT Country,
Description,
SUM(TotalSales) AS sales,
ROW_NUMBER() OVER(PARTITION BY Country ORDER BY SUM(TotalSales) DESC) AS product_rank
FROM retail_sales
GROUP BY Country,Description;

-- 40 Monthly Revenue Rank
SELECT Month,
SUM(Revenue) AS revenue,
RANK() OVER (ORDER BY SUM(Revenue) DESC) AS revenue_rank
FROM retail_sales
GROUP BY Month;
