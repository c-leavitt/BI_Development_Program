# Update column names to remove spaces
ALTER TABLE sales
CHANGE COLUMN `Area Code` Area_Code INT,
CHANGE COLUMN `Market Size` Market_Size TEXT,
CHANGE COLUMN `Budget Profit` Budget_Profit DOUBLE,
CHANGE COLUMN `Budget COGS` Budegt_COGS DOUBLE,
CHANGE COLUMN `Budget Margin` Budget_Margin DOUBLE,
CHANGE COLUMN `Budget Sales` Budget_Sales DOUBLE,
CHANGE COLUMN `Product Type` Product_Type TEXT,
CHANGE COLUMN `Total Expenses` Total_Expenses DOUBLE;

# Updating Date column to DATE format
UPDATE sales
SET Date = STR_TO_DATE(Date, '%m/%d/%y %H:%i:%s');

# Question 1
# What were the top 3 average highest profit by product?
SELECT
Product,
ROUND(AVG(Profit),2) as Avg_Profit
FROM sales
GROUP BY Product
HAVING Avg_Profit
ORDER BY Avg_Profit DESC
LIMIT 5;


# Question 2
# What is the lowest 3 sellng products for each state?
WITH RankedSales AS (
	SELECT
		State,
        Product,
        SUM(Sales) AS Total_Sold,
        ROW_NUMBER() OVER (PARTITION BY State ORDER BY SUM(Sales) ASC) AS rnk
	FROM Sales
    GROUP BY State, Product
)
SELECT State, Product, Total_Sold
FROM RankedSales
WHERE rnk <= 3
ORDER BY State, rnk;

# Question 3
# Do products sold in the smaller markets have a higher margin than products sold in the major markets?
SELECT
Market_Size,
Market,
ROUND(AVG(Margin),2) as Avg_Margin
FROM sales
GROUP BY Market_Size, Market
ORDER BY Avg_Margin DESC;

# Question 4
# What are the marketing costs by Market and State?
SELECT 
State,
Market,
SUM(Marketing) as Total_Marketing
FROM sales
GROUP BY State,Market
ORDER BY Total_Marketing DESC;