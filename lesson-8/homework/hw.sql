--lesson08
--Easy-Level Tasks
--1.	Using Products table, find the total number of products available in each category.
SELECT 
    Category, COUNT(*) AS TotalProducts
FROM 
    Products
GROUP BY 
    Category;

--2.	Using Products table, get the average price of products in the 'Electronics' category.
SELECT
	AVG(PRICE) AS AVGPRICE
FROM	
	Products
WHERE
	Category = 'ELECTRONICS';

--3.	Using Customers table, list all customers from cities that start with 'L'.
SELECT 
	FirstName,LastName, City 
FROM 
	Customers
where 
	City like 'L%';

--4.	Using Products table, get all product names that end with 'er'.
SELECT
	ProductName
FROM
	Products
WHERE 
	ProductName LIKE '%ER';

--5.	Using Customers table, list all customers from countries ending in 'A'.
SELECT 
	FirstName,LastName,Country
FROM	
	CUSTOMERS
WHERE
	COUNTRY LIKE '%A';

--6.	Using Products table, show the highest price among all products.
SELECT 
	MAX(PRICE) as highestprice
FROM
	Products;

--7.	Using Products table, use IIF to label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
SELECT 
    ProductName,
    StockQuantity,
    IIF( StockQuantity < 30, 'Low Stock', 'Sufficient') AS StockStatus
FROM 
    Products;

--8.	Using Customers table, find the total number of customers in each country.
SELECT
	Country,
	COUNT (*) AS TOTALCUSTOMERS
FROM 
	Customers
GROUP BY 
	Country;

--9.	Using Orders table, find the minimum and maximum quantity ordered.
SELECT 
	MIN(Quantity) AS MINORDERS,
	MAX(Quantity) AS MAXORDERS
FROM
	Orders;

--________________________________________

--Medium-Level Tasks
--10.	Using Orders and Invoices tables, list customer IDs who placed orders in 2023 (using EXCEPT) to find those who did not have invoices.
SELECT 
	DISTINCT CustomerID
FROM
	Orders
WHERE
	YEAR(OrderDate) = 2023

EXCEPT

SELECT
	DISTINCT CustomerID
FROM 
	Invoices;
--This means all customer IDs have invoices.

--11.	Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
SELECT 
	ProductName
FROM 
	Products
UNION ALL
SELECT
	ProductName 
FROM
	Products_Discounted;

--12.	Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
SELECT
	ProductName
FROM
	Products
UNION
SELECT 
	ProductName
FROM
	Products_Discounted;

--13.	Using Orders table, find the average order amount by year.
SELECT
	YEAR(ORDERDATE) AS ORDERYEAR,
	AVG(TOTALAMOUNT) AS AVGORDERAMOUNT
FROM 
	ORDERS
GROUP BY
	YEAR(ORDERDATE)
ORDER BY
	(ORDERYEAR);
	
--14.	Using Products table, use CASE to group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
SELECT
	PRODUCTNAME,
	PRICE,
CASE
	WHEN PRICE < 100 THEN 'LOW'
	WHEN PRICE BETWEEN 100 AND 500 THEN 'MID'
	WHEN PRICE > 500 THEN 'HIGH'
END AS PRICEGROUP
FROM Products;

--15.	Using Customers table, list all unique cities where customers live, sorted alphabetically.
SELECT
	DISTINCT CITY
FROM 
	Customers
ORDER BY 
	City;

--16.	Using Sales table, find total sales per product Id.
SELECT 
    ProductID,
    SUM(SaleAmount) AS TotalSales
FROM 
    Sales
GROUP BY 
    ProductID;

--17.	Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
SELECT 
	ProductName
FROM
	Products
WHERE
	ProductName LIKE '%OO%';

--18.	Using Products and Products_Discounted tables, compare product IDs using INTERSECT.
SELECT 
	ProductID
FROM
	Products
INTERSECT 
SELECT 
	PRODUCTID 
FROM 
	PRODUCTS_DISCOUNTED;
--________________________________________
--Hard-Level Tasks
--19.	Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
SELECT TOP 3 CustomerID, 
       SUM(TotalAmount) AS TotalSpent
FROM
	Invoices
GROUP BY 
	CustomerID
ORDER BY 
	TotalSpent DESC;

--20.	Find product ID and productname that are present in Products but not in Products_Discounted.
SELECT 
	PRODUCTID,
	PRODUCTNAME
FROM 
	Products
EXCEPT
SELECT
	PRODUCTID,
	PRODUCTNAME
FROM 
	PRODUCTS_DISCOUNTED;
--21.	Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
SELECT
	p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM
	Products p
JOIN
	Sales s ON p.ProductID = s.ProductID
GROUP BY 
	p.ProductName;
--22.	Using Orders table, find top 5 products (by ProductID) with the highest order quantities.
SELECT
	TOP 5 ProductID, 
       SUM(Quantity) AS TotalOrdered
FROM
	Orders
GROUP BY
	ProductID
ORDER BY 
	TotalOrdered DESC;
