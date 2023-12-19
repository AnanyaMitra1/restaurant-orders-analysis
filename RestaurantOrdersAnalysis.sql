
 SHOW TABLES;

-- Display Structure of order_details Table:

DESC order_details;
-- Provides information about the columns, data types, and constraints in the order_details table.

-- Display Structure of menu_items Table:
DESC menu_items;

-- Customer Behavior Analysis

-- Identify Frequent Customers and Their Average Order Values:
SELECT
  order_id,
  COUNT(*) AS order_count,
  AVG(item_price) AS avg_order_value
FROM (
  SELECT
    od.order_id,
    mi.price AS item_price
  FROM
    order_details od
  JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
) AS subquery
GROUP BY
  order_id
ORDER BY
  order_count DESC;
  
--  Determine the Number of Orders per Customer:
SELECT
  order_id,
  COUNT(*) AS order_count
FROM
  order_details
GROUP BY
  order_id
ORDER BY
  order_count DESC;
  
-- Explanation: Counts the number of orders for each customer.

--  Find Out the Most Ordered Dishes by Customers:

SELECT
  mi.item_name,
  COUNT(*) AS order_count
FROM
  order_details od
JOIN
  menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
  mi.item_name
ORDER BY
  order_count DESC
LIMIT 5;

-- ------
-- Popular Dishes Analysis

-- Count the Number of Times Each Dish Has Been Ordered:
SELECT
  mi.item_name,
  COUNT(*) AS order_count
FROM
  order_details od
JOIN
  menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
  mi.item_name
ORDER BY
  order_count DESC;
  

-- Calculate the Revenue Contribution of Each Dish:
SELECT
  mi.item_name,
  COUNT(*) AS order_count,
  SUM(mi.price) AS total_revenue
FROM
  order_details od
JOIN
  menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
  mi.item_name
ORDER BY
  total_revenue DESC;
  
-- ------

-- Identify Trends in Dish Popularity Over Time:
SELECT
  mi.item_name,
  DATE_FORMAT(od.order_date, '%Y-%m') AS month,
  COUNT(*) AS order_count
FROM
  order_details od
JOIN
  menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
  mi.item_name, month
ORDER BY
  month, order_count DESC;
  


-- Peak Hour Analysis

-- Determine the Busiest Hours and Days Based on Order Volume:
SELECT
  HOUR(order_time) AS hour,
  DAYNAME(order_date) AS day,
  COUNT(*) AS order_count
FROM
  order_details
GROUP BY
  hour, day
ORDER BY
  order_count DESC;
  


-- Identify Any Patterns Related to Specific Cuisines or Dishes During Peak Hours:
SELECT
  mi.category,
  HOUR(od.order_time) AS hour,
  COUNT(*) AS order_count
FROM
  order_details od
JOIN
  menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
  mi.category, hour
ORDER BY
  hour, order_count DESC;
  
  -- Advanced Customer Behavior Analysis:
-- Customer Lifetime Value (CLV):
-- Calculate the CLV for each customer, considering the total revenue they've generated over time and the number of orders.


SELECT
  order_id,
  COUNT(DISTINCT order_date) AS order_frequency,
  SUM(mi.price) AS total_spent,
  COUNT(*) AS total_orders,
  SUM(mi.price) / COUNT(DISTINCT order_date) AS avg_order_value,
  SUM(mi.price) / COUNT(*) AS avg_order_value_per_order
FROM
  order_details od
JOIN
  menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
  order_id
ORDER BY
  total_spent DESC;
  
  
  -- Cohort Analysis for Customer Retention:
-- Analyzing  how cohorts of customers behave over time,
-- specifically looking at the percentage of customers who return to make additional orders.


WITH CustomerCohort AS (
  SELECT
    od.order_id,
    MIN(od.order_date) AS first_order_date
  FROM
    order_details od
  GROUP BY
    od.order_id
)
SELECT
  EXTRACT(YEAR FROM first_order_date) AS cohort_year,
  EXTRACT(MONTH FROM first_order_date) AS cohort_month,
  COUNT(DISTINCT od.order_id) AS customers_in_cohort,
  COUNT(DISTINCT CASE WHEN od.order_date >= DATE_ADD(first_order_date, INTERVAL 1 MONTH) THEN od.order_id END) AS retained_customers
FROM
  CustomerCohort
JOIN
  order_details od ON CustomerCohort.order_id = od.order_id
GROUP BY
  cohort_year, cohort_month
ORDER BY
  cohort_year, cohort_month;

  -- Advanced Popular Dishes Analysis:
-- Dish Affinity Analysis:
-- Identifying  pairs of dishes that are often ordered together,
-- indicating potential recommendations or bundles.


WITH DishPairs AS (
  SELECT
    od1.item_id AS dish1,
    od2.item_id AS dish2,
    COUNT(*) AS order_count
  FROM
    order_details od1
  JOIN
    order_details od2 ON od1.order_id = od2.order_id AND od1.item_id < od2.item_id
  GROUP BY
    dish1, dish2
  ORDER BY
    order_count DESC
)
SELECT
  d1.item_name AS dish1,
  d2.item_name AS dish2,
  dp.order_count
FROM
  DishPairs dp
JOIN
  menu_items d1 ON dp.dish1 = d1.menu_item_id
JOIN
  menu_items d2 ON dp.dish2 = d2.menu_item_id
ORDER BY
  dp.order_count DESC
LIMIT 10;


-- Advanced Peak Hour Analysis:
-- Peak Hour Trends by Cuisine Category:
-- Exploring peak hours not just globally but for specific cuisine categories, helping understand when certain types of dishes are more popular.


SELECT
  mi.category,
  HOUR(od.order_time) AS peak_hour,
  COUNT(*) AS order_count
FROM
  order_details od
JOIN
  menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
  mi.category, peak_hour
ORDER BY
  mi.category, peak_hour, order_count DESC;
  
  -- Advanced Dish Analysis:
-- Average Order Value by Dish Category:

-- Calculating the average order value for each dish category, helping identify high-value categories.


SELECT
  mi.category,
  AVG(mi.price) AS avg_order_value
FROM
  order_details od
JOIN
  menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY
  mi.category
ORDER BY
  avg_order_value DESC;
  
  -- Dish Diversity Index:
-- Calculate a diversity index for each customer, measuring how evenly they distribute their orders across different dish categories.

WITH CustomerDishCategories AS (
  SELECT
    order_id,
    COUNT(DISTINCT mi.category) AS distinct_categories
  FROM
    order_details od
  JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
  GROUP BY
    order_id
)
SELECT
  AVG(distinct_categories) AS avg_diversity_index
FROM
  CustomerDishCategories;
  
  -- Advanced Time Analysis:
-- Time Between Orders:
-- Calculating the average time between consecutive orders for each customer.


WITH TimeBetweenOrders AS (
  SELECT
    order_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY order_id ORDER BY order_date) AS previous_order_date
  FROM
    order_details
)
SELECT
  AVG(DATEDIFF(order_date, previous_order_date)) AS avg_time_between_orders
FROM
  TimeBetweenOrders
WHERE
  previous_order_date IS NOT NULL;
  
  
-- Advanced Customer Segmentation:
-- RFM (Recency, Frequency, Monetary) Analysis:
-- Segmentation of  customers based on recency of their last order, frequency of orders, and monetary value spent.

WITH CustomerRFM AS (
  SELECT
    order_id,
    MAX(order_date) AS last_order_date,
    COUNT(DISTINCT order_date) AS order_frequency,
    SUM(mi.price) AS total_spent
  FROM
    order_details od
  JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
  GROUP BY
    order_id
)
SELECT
  order_id,
  DATEDIFF(CURDATE(), last_order_date) AS recency,
  order_frequency AS frequency,
  total_spent AS monetary
FROM
  CustomerRFM;
