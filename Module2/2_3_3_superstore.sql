-- Overview (обзор ключевых метрик)

-- Total Sales
SELECT 
	SUM(sales) AS total_sales
FROM
     orders;  --2297200
	 
-- Total Profit
SELECT 
	SUM(profit) AS total_profit
FROM
     orders;   --286397
	 
-- Profit Ratio
SELECT 
	SUM(profit)/SUM(sales) AS profit_ration
FROM
     orders;    --0.12467217240315604661
	 
-- Profit per Order
SELECT 
	SUM(profit)/
	            (SELECT DISTINCT count(order_id) FROM orders)
	AS profit_per_order
FROM
     orders;   --28.6568963077846697
	 
-- Sales per Customer
SELECT 
	SUM(sales)/
	            (SELECT DISTINCT count(customer_id) FROM orders)
	AS sales_per_customer
FROM
     orders;   --229.8580008304982990
	 
-- Avg. Discount
SELECT 
	AVG(discount)
	AS avg_discount
FROM
     orders;   --0.1562
	 
-- Monthly Sales by Segment ( табличка и график)
select
  segment,
  date_trunc('month', order_date)::date as months,
  SUM(sales) as sales
from orders
group by segment, months 
order by segment, months DESC;

-- Monthly Sales by Product Category (табличка и график)
select
  category,
  date_trunc('month', order_date)::date as months,
   SUM(sales) as sales
from orders
group by category, months 
order by category, months DESC;

-- Product Dashboard (Продуктовые метрики)
-- Sales by Product Category over time (Продажи по категориям)
-- Customer Analysis

-- Sales and Profit by Customer
SELECT
	customer_id AS customer,
	SUM(sales) AS sales,
	SUM(profit) AS profit
FROM
    orders
GROUP BY
    customer
ORDER BY 
       2 DESC;

-- Customer Ranking
SELECT
	RANK() OVER(ORDER BY sales DESC) AS rank_nr,
	customer,
	 sales
FROM (
   SELECT
	customer_id AS customer,
	SUM(sales) AS sales	
FROM
    orders
GROUP BY
    customer
ORDER BY 
       2 DESC) AS s
	   ;
	
-- Sales per region
SELECT
	region AS region,
	SUM(sales) AS sales
FROM
    orders
GROUP BY region
ORDER BY 2 DESC;