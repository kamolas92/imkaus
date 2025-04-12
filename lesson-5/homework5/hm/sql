--Easy-Level Tasks
--1.Write a query that uses an alias to rename the ProductName column as Name in the Products table.
SELECT ProductName AS Name
FROM Products;

--2.Write a query that uses an alias to rename the Customers table as Client for easier reference.
SELECT *
FROM Customers AS Client;

--3.Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
SELECT ProductName
FROM Products

UNION

SELECT ProductName
FROM Products_Discounted;

--4.Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.
SELECT ProductName
FROM Products

INTERSECT

SELECT ProductName
FROM Products_Discounted;

--5.Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.
SELECT DISTINCT CustomerName, Country
FROM Customers;

--6.Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
SELECT ProductName, Price,
       CASE 
           WHEN Price > 1000 THEN 'High'
           ELSE 'Low'
       END AS PriceCategory
FROM Products;

--7.Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
SELECT ProductName, StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS InStockOver100
FROM Products_Discounted;

--Medium-Level Tasks
--8.Use UNION to combine results from two queries that select ProductName from Products and ProductName from OutOfStock tables.
SELECT ProductName
FROM Products

UNION

SELECT ProductName
FROM OutOfStock;

--9.Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
SELECT ProductName
FROM Products

EXCEPT

SELECT ProductName
FROM Products_Discounted;

--10.Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
SELECT ProductName, Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;

--11.Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.
SELECT *
FROM Employees
WHERE Age < 25
   OR Salary > 60000;

--12.Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5
UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR'
   OR EmployeeID = 5;

--Hard-Level Tasks
--13.Use INTERSECT to show products that are common between Products and Products_Discounted tables.
SELECT ProductName
FROM Products

INTERSECT

SELECT ProductName
FROM Products_Discounted;

--14.Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)
SELECT SaleAmount,
       CASE 
           WHEN SaleAmount > 500 THEN 'Top Tier'
           WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
           ELSE 'Low Tier'
       END AS SalesTier
FROM Sales;

--15.Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Invoices table.
SELECT CustomerID
FROM Orders

EXCEPT

SELECT CustomerID
FROM Invoices;

--16.Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. Use orders table. Result set should show customerid, quantity and discount percentage. The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%
SELECT CustomerID, Quantity,
       CASE 
           WHEN Quantity = 1 THEN 3
           WHEN Quantity BETWEEN 2 AND 3 THEN 5
           ELSE 7
       END AS DiscountPercentage
FROM Orders;
