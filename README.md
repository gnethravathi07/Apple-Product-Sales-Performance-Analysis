# 📱 Apple Product Sales Performance Analysis

## 📊 Project Overview
This project showcases **advanced SQL querying techniques** through the analysis of Apple Inc. retail sales data. The dataset contains information about **products, stores, sales transactions, and warranty claims** from various Apple retail locations. It includes solutions to **real-world business problems** by leveraging SQL to analyze and extract insights from large-scale datasets.

---

## 🗃️ Database Schema

### `stores`
- `store_id`, `store_name`, `city`, `country`

### `category`
- `category_id`, `category_name`

### `products`
- `product_id`, `product_name`, `category_id`, `launch_date`, `price`

### `sales`
- `sale_id`, `sale_date`, `store_id`, `product_id`, `quantity`

### `warranty`
- `claim_id`, `claim_date`, `sale_id`, `repair_status`

---

## 🛠️ SQL Features Covered
- ✅ Table creation and schema design with constraints  
- ✅ Data insertion and relationship setup (PKs and FKs)  
- ✅ Basic to advanced `JOIN`s  
- ✅ Filtering and aggregations (`WHERE`, `GROUP BY`, `HAVING`)  
- ✅ Window functions: `RANK()`, `ROW_NUMBER()`, `NTILE()`, `PERCENT_RANK()`  
- ✅ Date formatting and month-based grouping  
- ✅ Subqueries and Common Table Expressions (CTEs)  
- ✅ Percentage calculations, running totals, and comparisons 

## 🎯 SQL Question Bank (70 Questions)

### 🟢 Easy Level (1–20)
 1. Count of stores per country  
 2. Total quantity sold per store  
 3. Count of sales in December 2023  
 4. Stores with no warranty claims  
 5. Percentage of claims marked 'Warranty Void'  
 6. Store with highest units sold in last year  
 7. Count of unique products sold last year  
 8. Average price by category  
 9. Warranty claims in 2020  
 10. Best-selling day per store  
 11. Products launched after 2017 with claims  
 12. Warranty claims by repair status  
 13. Products never sold but under warranty  
 14. Total revenue by store by year  
 15. Products with > 1000 total units sold  
 16. Highest revenue day per city  
 17. Category-wise average quantity sold  
 18. Daily average sales per store  
 19. Top 3 best-selling products per year  
 20. Sales by quarter and year  

---

### 🟡 Moderate Level (21–50)
 21. Products with warranty > 30 days after sale  
 22. Sales grouped by weekday  
 23. Revenue per store per product  
 24. Days with no sales  
 25. Percentage of revenue by category  
 26. Monthly sales trend line data  
 27. Percentage growth in revenue per year  
 28. Store with lowest warranty % rate  
 29. Most popular product per region  
 30. Products with declining sales 3 months in a row  
 31. Median sale quantity per product  
 32. Warranty claims per store per month  
 33. Store revenue rank per year  
 34. Top 5 categories by revenue in 2023  
 35. Product contribution to total revenue  
 36. First and last sale date per product  
 37. Days between launch and first sale  
 38. Revenue variance per product (monthly)  
 39. Ratio of sales to claims per product  
 40. Warranty claims by product line  
 41. Year with highest claim count  
 42. Average time to warranty claim per store  
 43. Most common warranty status per product  
 44. Sales frequency per weekday  
 45. Warranty rate for each store  
 46. Best store by average daily revenue  
 47. Top 3 launch years by total product sales  
 48. Revenue per store per product category  
 49. Percentage of products claimed under warranty  
 50. Products launched but never sold  

---

### 🔴 Advanced Level (51–70)
 51. City with highest revenue in 2022  
 52. Store-category combination with lowest sales  
 53. Products sold >50 times but 0 claims  
 54. Stores with consistent growth YoY  
 55. Months with no warranty claims  
 56. Peak sales day for each category  
 57. Warranty claim percentage by product  
 58. Products with >10% claim rate  
 59. Sales-to-claim ratio over time  
 60. Least selling product by country and year  
 61. Warranty claims filed within 180 days of sale  
 62. Claims for products launched in last 2 years  
 63. Months with >5,000 sales in last 3 years (USA)  
 64. Category with most warranty claims (last 2 yrs)  
 65. Percentage chance of claim after purchase (by country)  
 66. Year-over-year growth rate for stores  
 67. Correlation: price vs warranty claims (5 yrs)  
 68. Store with highest % of 'Paid Repaired' claims  
 69. Monthly running total of sales by store (4 years)  
 70. Store-wise year-by-year sales vs warranty trend  

---

## 🔍 Project Focus Areas

- **Complex Joins and Aggregations**: Mastering multi-table joins and grouping.  
- **Window Functions**: Running totals, rankings, time-based comparisons.  
- **Time-Series Analysis**: Product and store performance over time.  
- **Correlation Logic**: Exploring relationships between price and repair behavior.  
- **Business Insight**: Mimicking real-life reporting and decision-support with SQL.

## ✅ Sample Queries

 1. 🔢 Total Revenue by Product
```sql
SELECT 
    p.product_name,
    SUM(s.quantity * p.price) AS total_revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name;



### 2. 📊 Revenue Contribution %

```sql
SELECT 
    p.product_name,
    ROUND(SUM(s.quantity * p.price), 2) AS product_revenue,
    ROUND(SUM(s.quantity * p.price) * 100 / 
          (SELECT SUM(s2.quantity * p2.price)
           FROM sales s2
           JOIN product p2 ON s2.product_id = p2.product_id), 2) AS revenue_pct
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name;


🧠 Outcome
By the end of this SQL analysis:

* Key business performance metrics are uncovered

* Revenue and sales trends are analyzed per product, store, and category

* High-warranty products are identified for quality improvement

