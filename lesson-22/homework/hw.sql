select * from sales_data
--Compute Running Total Sales per Customer
SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS running_total_sales
FROM
    sales_data
ORDER BY
    customer_id,
    order_date;

--Count the Number of Orders per Product Category
SELECT
    product_category,
    COUNT(*) AS order_count
FROM
    sales_data
GROUP BY
    product_category
ORDER BY
    order_count DESC;

--Find the Maximum Total Amount per Product Category
SELECT
    product_category,
    MAX(total_amount) AS max_total_amount
FROM
    sales_data
GROUP BY
    product_category
ORDER BY
    product_category;

--Find the Minimum Price of Products per Product Category
SELECT
    product_category,
    MIN(unit_price) AS min_unit_price
FROM
    sales_data
GROUP BY
    product_category
ORDER BY
    product_category;

--Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
WITH DailySales AS (
    SELECT
        order_date,
        SUM(total_amount) AS total_sales
    FROM
        sales_data
    GROUP BY
        order_date
)
SELECT
    order_date,
    total_sales,
    AVG(total_sales) OVER (
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg_3day
FROM
    DailySales
ORDER BY
    order_date;

--Find the Total Sales per Region
SELECT
    region,
    SUM(total_amount) AS total_sales
FROM
    sales_data
GROUP BY
    region
ORDER BY
    total_sales DESC;

--Compute the Rank of Customers Based on Their Total Purchase Amount
SELECT
    customer_id,
    customer_name,
    SUM(total_amount) AS total_purchase,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS purchase_rank
FROM
    sales_data
GROUP BY
    customer_id,
    customer_name
ORDER BY
    purchase_rank;

--Calculate the Difference Between Current and Previous Sale Amount per Customer
SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS diff_from_previous_sale
FROM
    sales_data
ORDER BY
    customer_id,
    order_date;

--Find the Top 3 Most Expensive Products in Each Category
SELECT
    product_category,
    product_name,
    unit_price
FROM (
    SELECT
        product_category,
        product_name,
        unit_price,
        ROW_NUMBER() OVER (
            PARTITION BY product_category
            ORDER BY unit_price DESC
        ) AS rn
    FROM
        sales_data
) AS ranked_products
WHERE
    rn <= 3
ORDER BY
    product_category,
    unit_price DESC;

--Compute the Cumulative Sum of Sales Per Region by Order Date
SELECT
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY region
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_sales
FROM
    sales_data
ORDER BY
    region,
    order_date;
--Compute Cumulative Revenue per Product Category
	SELECT
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_revenue
FROM
    sales_data
ORDER BY
    product_category,
    order_date;

--Here you need to find out the sum of previous values. Please go through the sample input and expected output.
SELECT
    ID,
    SUM(ID) OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM
    table
ORDER BY
    ID;
--Sum of Previous Values to Current Value
SELECT
    Value,
    SUM(Value) OVER (ORDER BY Value ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM
    OneColumn
ORDER BY
    Value;

--Generate row numbers for the given data. The condition is that the first row number for every partition should be odd number.For more details please check the sample input and expected output.
SELECT
    Id,
    Vals,
    (ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) * 2) - 1 AS OddRowNum
FROM
    Row_Nums
ORDER BY
    Id, OddRowNum;
--Find customers who have purchased items from more than one product_category
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT product_category) AS category_count
FROM
    sales_data
GROUP BY
    customer_id,
    customer_name
HAVING
    COUNT(DISTINCT product_category) > 1;

--Find Customers with Above-Average Spending in Their Region
WITH CustomerRegionSpending AS (
    SELECT
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS total_spent
    FROM
        sales_data
    GROUP BY
        customer_id,
        customer_name,
        region
),
RegionAverageSpending AS (
    SELECT
        region,
        AVG(total_spent) AS avg_spent
    FROM
        CustomerRegionSpending
    GROUP BY
        region
)

SELECT
    crs.customer_id,
    crs.customer_name,
    crs.region,
    crs.total_spent
FROM
    CustomerRegionSpending crs
JOIN
    RegionAverageSpending ras ON crs.region = ras.region
WHERE
    crs.total_spent > ras.avg_spent
ORDER BY
    crs.region,
    crs.total_spent DESC;

--Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank.
SELECT
    customer_id,
    customer_name,
    region,
    total_spent,
    RANK() OVER (PARTITION BY region ORDER BY total_spent DESC) AS spending_rank
FROM (
    SELECT
        customer_id,
        customer_name,
        region,
        SUM(total_amount) AS total_spent
    FROM
        sales_data
    GROUP BY
        customer_id,
        customer_name,
        region
) AS customer_totals
ORDER BY
    region,
    spending_rank;

--Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.
SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_sales
FROM
    sales_data
ORDER BY
    customer_id,
    order_date;

--Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
WITH MonthlySales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(total_amount) AS total_sales
    FROM
        sales_data
    GROUP BY
        DATE_TRUNC('month', order_date)
),
SalesWithPrev AS (
    SELECT
        month,
        total_sales,
        LAG(total_sales) OVER (ORDER BY month) AS prev_month_sales
    FROM
        MonthlySales
)
SELECT
    month,
    total_sales,
    prev_month_sales,
    CASE
        WHEN prev_month_sales IS NULL THEN NULL
        WHEN prev_month_sales = 0 THEN NULL
        ELSE ROUND(((total_sales - prev_month_sales) / prev_month_sales) * 100, 2)
    END AS growth_rate_percent
FROM
    SalesWithPrev
ORDER BY
    month;

--Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)
WITH CustomerTotals AS (
    SELECT
        customer_id,
        customer_name,
        SUM(total_amount) AS total_spent
    FROM sales_data
    GROUP BY customer_id, customer_name
),
LastOrderAmounts AS (
    SELECT
        customer_id,
        total_amount AS last_order_amount
    FROM (
        SELECT
            customer_id,
            total_amount,
            ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
        FROM sales_data
    ) t
    WHERE rn = 1
)
SELECT
    ct.customer_id,
    ct.customer_name,
    ct.total_spent,
    lo.last_order_amount
FROM
    CustomerTotals ct
JOIN
    LastOrderAmounts lo ON ct.customer_id = lo.customer_id
WHERE
    ct.total_spent > lo.last_order_amount;

