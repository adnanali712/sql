create database sql_projecr1

use sql_projecr1;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantiy VARCHAR(15),
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

SELECT count(*) FROM retail_sales

select * from retail_sales
where 
transactions_id is null
OR
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
OR
age is null
OR
category is null
OR
quantiy is null
OR
price_per_unit is null
OR
cogs is null
OR
total_sale is null;
--DELETE--

DELETE FROM retail_sales
WHERE 
    (
        sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL
    )
    AND transactions_id > 0;
    
    
-- DATA EXPLORATION
-- HOW MANY SALES WE HAVE ?
SELECT COUNT(*) AS TOTAL_SALE FROM retail_sales

-- count of customer ?
SELECT COUNT(DISTINCT customer_id) AS TOTAL_SALE  FROM retail_sales

-- category 

SELECT DISTINCT category FROM retail_sales

--  DATA ANALYSIS 

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:




SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy > 1
  AND MONTH(sale_date) = 11;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) AS NET_sales
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
    AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    gender,
    category,
    COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY 
    gender,
    category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    AVG(total_sale) AS avg_monthly_sale
FROM retail_sales
GROUP BY 
    YEAR(sale_date),
    MONTH(sale_date);
    
WITH monthly_sales AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(total_sale) AS total_monthly_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY 
        YEAR(sale_date),
        MONTH(sale_date)
)

SELECT *
FROM monthly_sales
WHERE rnk = 1;
