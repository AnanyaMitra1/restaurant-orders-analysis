# Restaurant Orders Analysis

## Introduction

This section provides an overview of the analysis conducted on the "Restaurant Orders" database. The database consists of two main tables: `order_details` and `menu_items`. 
Below are the details of the tables and the analysis performed.

# Restaurant Orders Database - Table Details

## `order_details` Table

| Column           | Description                         |
|------------------|-------------------------------------|
| order_details_id | Unique identifier for order details |
| order_id         | Unique identifier for the order     |
| order_date       | Date of the order                   |
| order_time       | Time of the order                   |
| item_id          | Unique identifier for the item      |

**Primary Key:** order_details_id

## `menu_items` Table

| Column          | Description                           |
|-----------------|---------------------------------------|
| menu_item_id    | Unique identifier for menu items       |
| item_name       | Name of the menu item                  |
| category        | Category to which the item belongs     |
| price           | Price of the menu item                 |

**Primary Key:** menu_item_id

## Analysis

The analysis on the restaurant orders data includes the following key aspects:

### 1. Basic Analysis

- Explored the structure of the database.
- Identified key tables, relationships, and primary/foreign keys.

### 2. Customer Behavior Analysis

- Analyzed frequent customers and their average order values.
- Determined the number of orders per customer.
- Identified the most ordered dishes by customers.

### 3. Popular Dishes Analysis

- Counted the number of times each dish has been ordered.
- Calculated the revenue contribution of each dish.
- Identified trends in dish popularity over time.

### 4. Peak Hour Analysis

- Analyzed peak hours and days based on order volume.
- Identified patterns related to specific cuisines or dishes during peak hours.

### 5. Advanced Analysis

- Conducted Customer Lifetime Value (CLV) analysis.
- Explored cohort analysis for customer retention.
- Analyzed dish affinity and identified pairs of dishes often ordered together.
- Explored peak hour trends by cuisine category.
- Calculated the average order value by dish category.
- Calculated a diversity index for each customer, measuring how evenly they distribute their orders across different dish categories.
- Calculated the average time between consecutive orders for each customer.

These analyses provide valuable insights into customer behavior, popular dishes, peak hours, and more, offering opportunities for optimization and business strategies.

*Thank you for exploring the Restaurant Orders Analysis!*

