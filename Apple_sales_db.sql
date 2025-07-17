-- 1. List all products

SELECT * FROM product;

-- 2.All stores in the USA

SELECT * FROM store WHERE country = 'USA';

-- 3.Products with price above $1000

SELECT product_name, price FROM product WHERE price > 1000;

-- 4.Top 5 most expensive products

SELECT product_name, price FROM product 
ORDER BY price 
DESC LIMIT 5;

-- 5.Distinct cities with Apple stores

SELECT DISTINCT city FROM store;

-- 6.Products launched between Jan and Dec 2017

SELECT product_name, launch_date FROM product
WHERE launch_date BETWEEN '2017-01-01' AND '2017-12-31';

-- 7.Products whose names contain 'MacBook'

SELECT * FROM product WHERE product_name LIKE '%MacBook%';

-- 8.Count how many products fall under each category

SELECT category_id, COUNT(*) AS product_count
FROM product
GROUP BY category_id;

-- 9. average product price per category

SELECT category_id, AVG(price) AS avg_price
FROM product
GROUP BY category_id;

-- 10.cheapest product in each category 

SELECT category_id, MIN(price) AS min_price
FROM product
GROUP BY category_id;

-- 11.all sales before Jan 2022

SELECT * FROM sales WHERE sale_date < '2022-01-01';

-- 13.all warranty claims made in 2020

SELECT * FROM warranty
WHERE claim_date BETWEEN '2020-01-01' AND '2020-12-31';

-- 14.List of stores not in New York

SELECT * FROM store WHERE city <> 'New York';

-- 15.All products that are either iPhones or iPads

SELECT * FROM product
WHERE product_name LIKE '%iPhone%' OR product_name LIKE '%iPad%';

-- 16. Total revenue from all sales

SELECT SUM(s.quantity * p.price) AS total_revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id;

-- 17. Number of products sold per product

SELECT product_id, COUNT(*) AS total_sales
FROM sales
GROUP BY product_id;

-- 18. Total revenue per product

SELECT s.product_id, SUM(s.quantity * p.price) AS revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.product_id;

-- 19. Total revenue per category

SELECT p.category_id, SUM(s.quantity * p.price) AS category_revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.category_id;

-- 20. Count of warranty claims by repair status

SELECT repair_status, COUNT(*) AS total_claims
FROM warranty
GROUP BY repair_status;

-- 21. Total sales made by each store

SELECT store_id, COUNT(*) AS number_of_sales
FROM sales
GROUP BY store_id;

-- 22. Average product price per category

SELECT category_id, AVG(price) AS avg_price
FROM product
GROUP BY category_id;


-- 23. Highest revenue-generating store

SELECT s.store_id, SUM(s.quantity * p.price) AS total_store_revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.store_id
ORDER BY total_store_revenue DESC
LIMIT 1;

-- 24. Number of sales made in each year

SELECT YEAR(sale_date) AS sale_year, COUNT(*) AS total_sales
FROM sales
GROUP BY YEAR(sale_date);

-- 25. Total warranty claims per month

SELECT MONTH(claim_date) AS claim_month, COUNT(*) AS total_claims
FROM warranty
GROUP BY MONTH(claim_date);

-- 26. minimum, maximum, and average sale price

SELECT MIN(price) AS min_price, MAX(price) AS max_price, AVG(price) AS avg_price
FROM product;

-- 27. Revenue by product and store

SELECT s.product_id, s.store_id, SUM(s.quantity * p.price) AS revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.product_id, s.store_id;

-- 28. Top 3 products by total revenue
   
SELECT s.product_id, SUM(s.quantity * p.price) AS revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.product_id
ORDER BY revenue DESC
LIMIT 3;

-- 29. Count of stores are in each city
SELECT city, COUNT(*) AS total_stores
FROM store
GROUP BY city;

-- 30. Average warranty claims per product

SELECT sales.product_id, COUNT(warranty.claim_id) / COUNT(DISTINCT sales.sale_id) AS avg_claims_per_product
FROM warranty
JOIN sales ON warranty.sale_id = sales.sale_id
GROUP BY sales.product_id;

-- 31. product names along with their category names

SELECT p.product_name, c.category_name
FROM product p
JOIN category c ON p.category_id = c.category_id;

-- 32.all sales with product name and category

SELECT s.sale_id, p.product_name, c.category_name, s.sale_date, s.quantity
FROM sales s
JOIN product p ON s.product_id = p.product_id
JOIN category c ON p.category_id = c.category_id;

-- 33. sales details along with store city and product price

SELECT s.sale_id, st.city, p.product_name, p.price, s.quantity, (s.quantity * p.price) AS revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
JOIN store st ON s.store_id = st.store_id;

-- 34. List all warranty claims with product name and sale date

SELECT w.claim_id, w.claim_date, p.product_name, s.sale_date
FROM warranty w
JOIN sales s ON w.sale_id = s.sale_id
JOIN product p ON s.product_id = p.product_id;

-- 35. store-wise total revenue

SELECT st.store_name, SUM(s.quantity * p.price) AS total_revenue
FROM sales s
JOIN store st ON s.store_id = st.store_id
JOIN product p ON s.product_id = p.product_id
GROUP BY st.store_name;

-- 36.  all sales where product price is above average price

SELECT s.*
FROM sales s
JOIN product p ON s.product_id = p.product_id
WHERE p.price > (SELECT AVG(price) FROM product);

-- 37. products that were never sold

SELECT p.product_id, p.product_name
FROM product p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;

-- 38. stores that had no sales

SELECT st.store_id, st.store_name
FROM store st
LEFT JOIN sales s ON st.store_id = s.store_id
WHERE s.sale_id IS NULL;

-- 39. products with more than 5 warranty claims

SELECT s.product_id, p.product_name, COUNT(w.claim_id) AS claims
FROM warranty w
JOIN sales s ON w.sale_id = s.sale_id
JOIN product p ON s.product_id = p.product_id
GROUP BY s.product_id, p.product_name
HAVING COUNT(w.claim_id) > 5;

-- 40. number of sales per product and category

SELECT p.category_id, p.product_id, COUNT(s.sale_id) AS total_sales
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.category_id, p.product_id;

-- 41. total quantity sold per month

SELECT MONTH(s.sale_date) AS sale_month, SUM(s.quantity) AS total_quantity
FROM sales s
GROUP BY MONTH(s.sale_date);

-- 42. List of the warranty claims for sales made in 2020 only

SELECT w.*
FROM warranty w
JOIN sales s ON w.sale_id = s.sale_id
WHERE YEAR(s.sale_date) = 2020;

-- 43.total revenue per category in 2022

SELECT p.category_id, SUM(s.quantity * p.price) AS revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
WHERE YEAR(s.sale_date) = 2022
GROUP BY p.category_id;

-- 44.store that  sold the most iPhones

SELECT st.store_name, SUM(s.quantity) AS total_iphones_sold
FROM sales s
JOIN product p ON s.product_id = p.product_id
JOIN store st ON s.store_id = st.store_id
WHERE p.product_name LIKE '%iPhone%'
GROUP BY st.store_name
ORDER BY total_iphones_sold DESC
LIMIT 1;

-- 45.Total Sales and Revenue by Product

SELECT 
    p.product_name,
    COUNT(s.sale_id) AS total_sales,
    SUM(s.quantity * p.price) AS total_revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 46. Revenue per Category per Month

SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS sale_month,
    c.category_name,
    SUM(s.quantity * p.price) AS monthly_revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
JOIN category c ON p.category_id = c.category_id
GROUP BY sale_month, c.category_name
ORDER BY sale_month, monthly_revenue DESC;

-- 47. Total Orders per Store

SELECT 
    st.store_name,
    COUNT(DISTINCT s.sale_id) AS total_orders
FROM sales s
JOIN store st ON s.store_id = st.store_id
GROUP BY st.store_name
ORDER BY total_orders DESC;

-- 48.Top 3 Cities by Revenue

SELECT 
    st.city,
    SUM(s.quantity * p.price) AS city_revenue
FROM sales s
JOIN store st ON s.store_id = st.store_id
JOIN product p ON s.product_id = p.product_id
GROUP BY st.city
ORDER BY city_revenue DESC
LIMIT 3;

-- 49.Monthly Growth in Revenue (with LAG)

SELECT 
    sale_month,
    total_revenue,
    total_revenue - LAG(total_revenue) OVER (ORDER BY sale_month) AS revenue_growth
FROM (
    SELECT 
        DATE_FORMAT(s.sale_date, '%Y-%m') AS sale_month,
        SUM(s.quantity * p.price) AS total_revenue
    FROM sales s
    JOIN product p ON s.product_id = p.product_id
    GROUP BY sale_month
) AS monthly_data;

-- 50. Warranty Claim Rate per Product

SELECT 
    p.product_name,
    COUNT(w.claim_id) AS total_claims,
    COUNT(s.sale_id) AS total_sales,
    ROUND(COUNT(w.claim_id) / COUNT(s.sale_id), 2) AS claim_rate
FROM product p
JOIN sales s ON p.product_id = s.product_id
LEFT JOIN warranty w ON s.sale_id = w.sale_id
GROUP BY p.product_name
ORDER BY claim_rate DESC;

-- 51.Category-wise Product Count

SELECT 
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM category c
LEFT JOIN product p ON c.category_id = p.category_id
GROUP BY c.category_name;

-- 52.Average Revenue per Order

SELECT 
    ROUND(AVG(s.quantity * p.price), 2) AS avg_order_value
FROM sales s
JOIN product p ON s.product_id = p.product_id;

-- 53.Top 3 Products with Highest Warranty Claims

SELECT 
    p.product_name,
    COUNT(w.claim_id) AS warranty_count
FROM warranty w
JOIN sales s ON w.sale_id = s.sale_id
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY warranty_count DESC
LIMIT 3;

-- 54.Products Never Sold

SELECT 
    p.product_name
FROM product p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;

-- 55.Store-wise Sales Distribution by Category

SELECT 
    st.store_name,
    c.category_name,
    SUM(s.quantity * p.price) AS category_sales
FROM sales s
JOIN product p ON s.product_id = p.product_id
JOIN category c ON p.category_id = c.category_id
JOIN store st ON s.store_id = st.store_id
GROUP BY st.store_name, c.category_name
ORDER BY st.store_name, category_sales DESC;

-- 56.Day with Maximum Sales

SELECT 
    s.sale_date,
    SUM(s.quantity * p.price) AS total_sales
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.sale_date
ORDER BY total_sales DESC
LIMIT 1;

-- 57. Warranty Claims per Month

SELECT 
    DATE_FORMAT(w.claim_date, '%Y-%m') AS claim_month,
    COUNT(*) AS total_claims
FROM warranty w
GROUP BY claim_month
ORDER BY claim_month;

-- 58.Products Sold in Multiple Stores

SELECT 
    p.product_name,
    COUNT(DISTINCT s.store_id) AS store_count
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING store_count > 1;

-- 59.Category with Lowest Average Price

SELECT 
    c.category_name,
    ROUND(AVG(p.price), 2) AS avg_price
FROM category c
JOIN product p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY avg_price ASC
LIMIT 1;

-- 60.Revenue Contribution Percentage by Product

SELECT 
    p.product_name,
    ROUND(SUM(s.quantity * p.price) / 
          (SELECT SUM(quantity * price) FROM sales s JOIN product p ON s.product_id = p.product_id) * 100, 2) 
    AS revenue_pct
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue_pct DESC;

-- 61.Rank Products by Revenue

SELECT 
    p.product_name,
    SUM(s.quantity * p.price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(s.quantity * p.price) DESC) AS revenue_rank
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- 62.Running Total of Revenue by Month

SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS sale_month,
    SUM(s.quantity * p.price) AS monthly_revenue,
    SUM(SUM(s.quantity * p.price)) OVER (ORDER BY DATE_FORMAT(s.sale_date, '%Y-%m')) AS running_total
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY sale_month;

-- Monthly Warranty Rate

WITH sales_monthly AS (
    SELECT 
        DATE_FORMAT(s.sale_date, '%Y-%m') AS month,
        COUNT(s.sale_id) AS total_sales
    FROM sales s
    GROUP BY month
),
claims_monthly AS (
    SELECT 
        DATE_FORMAT(w.claim_date, '%Y-%m') AS month,
        COUNT(w.claim_id) AS total_claims
    FROM warranty w
    GROUP BY month
)
SELECT 
    s.month,
    s.total_sales,
    IFNULL(c.total_claims, 0) AS total_claims,
    ROUND(IFNULL(c.total_claims, 0) / s.total_sales, 2) AS claim_rate
FROM sales_monthly s
LEFT JOIN claims_monthly c ON s.month = c.month;

-- 64.NTILE Quartiles of Products by Revenue

SELECT 
    product_name,
    total_revenue,
    NTILE(4) OVER (ORDER BY total_revenue DESC) AS revenue_quartile
FROM (
    SELECT 
        p.product_name,
        SUM(s.quantity * p.price) AS total_revenue
    FROM sales s
    JOIN product p ON s.product_id = p.product_id
    GROUP BY p.product_name
) AS product_revenue;

-- 65.Monthly Average Order Value

SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS sale_month,
    ROUND(SUM(s.quantity * p.price) / COUNT(DISTINCT s.sale_id), 2) AS avg_order_value
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY sale_month;

-- 66.Last Sale Date per Product

SELECT 
    p.product_name,
    MAX(s.sale_date) AS last_sold_on
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- 67.Product Sales Contribution per Category

SELECT 
    c.category_name,
    p.product_name,
    ROUND(SUM(s.quantity * p.price), 2) AS product_revenue,
    ROUND(SUM(s.quantity * p.price) / SUM(SUM(s.quantity * p.price)) OVER (PARTITION BY c.category_name) * 100, 2) AS pct_within_category
FROM sales s
JOIN product p ON s.product_id = p.product_id
JOIN category c ON p.category_id = c.category_id
GROUP BY c.category_name, p.product_name
ORDER BY c.category_name, pct_within_category DESC;

-- 68. Store Revenue Percentile

SELECT 
    store_name,
    total_revenue,
    ROUND(PERCENT_RANK() OVER (ORDER BY total_revenue) * 100, 2) AS revenue_percentile_pct
FROM (
    SELECT 
        st.store_name,
        SUM(s.quantity * p.price) AS total_revenue
    FROM sales s
    JOIN product p ON s.product_id = p.product_id
    JOIN store st ON s.store_id = st.store_id
    GROUP BY st.store_name
) AS revenue_data;



-- 69.Revenue Contribution % by Product

SELECT 
    p.product_name,
    ROUND(SUM(s.quantity * p.price), 2) AS product_revenue,
    ROUND(
        SUM(s.quantity * p.price) * 100 / 
        (SELECT SUM(s2.quantity * p2.price)
         FROM sales s2
         JOIN product p2 ON s2.product_id = p2.product_id),
        2
    ) AS revenue_percentage
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue_percentage DESC;

-- 70. Most Sold Product in Each Category

SELECT 
    category_name,
    product_name,
    total_sales
FROM (
    SELECT 
        c.category_name,
        p.product_name,
        COUNT(s.sale_id) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY c.category_name 
            ORDER BY COUNT(s.sale_id) DESC
        ) AS rn
    FROM sales s
    JOIN product p ON s.product_id = p.product_id
    JOIN category c ON p.category_id = c.category_id
    GROUP BY c.category_name, p.product_name
) AS ranked_products
WHERE rn = 1;

