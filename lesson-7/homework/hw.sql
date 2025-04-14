--🟢 Easy-Level Tasks (10)
--1.	Write a query to find the minimum (MIN) price of a product in the Products table.
SELECT * FROM Products
SELECT MIN(Price) FROM Products
--2.	Write a query to find the maximum (MAX) Salary from the Employees table.
SELECT * FROM Employees
SELECT MAX(SALARY) FROM Employees
--3.	Write a query to count the number of rows in the Customers table using COUNT(*).
SELECT COUNT(*)FROM Customers;
--4.	Write a query to count the number of unique product categories (COUNT(DISTINCT Category)) from the Products table.
SELECT COUNT (DISTINCT CATEGORY) FROM Products
--5.	Write a query to find the total (SUM) sales amount for the product with id 7 in the Sales table.
SELECT SUM(SaleAmount) AS total_sales
FROM Sales
WHERE ProductID = 7;
--6.	Write a query to calculate the average (AVG) age of employees in the Employees table.
SELECT * FROM Employees
SELECT AVG(AGE) FROM Employees
--7.	Write a query that uses GROUP BY to count the number of employees in each department.
SELECT DEPARTMENTNAME, COUNT(EMPLOYEEID) FROM EMPLOYEES
GROUP BY DEPARTMENTNAME
--8.	Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
SELECT CATEGORY, MIN(PRICE), MAX(PRICE)FROM Products
GROUP BY CATEGORY

--9.	Write a query to calculate the total (SUM) sales per Customer in the Sales table.
SELECT * FROM SALES
SELECT CUSTOMERID, SUM(SALEAMOUNT)
FROM Sales
GROUP BY CustomerID

--10.	Write a query to use HAVING to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).
SELECT * FROM Employees
SELECT DepartmentName, COUNT(*)
FROM Employees
GROUP BY DepartmentName 
HAVING COUNT (*) >5

--🟠 Medium-Level Tasks (9)
--11.	Write a query to calculate the total sales and average sales for each product category from the Sales table.
SELECT productID,
    SUM(saleamount) AS total_sales,
    AVG(saleamount) AS average_sales
FROM Sales
GROUP BY productID;
--12.	Write a query that uses COUNT(columnname) to count the number of employees from the Department HR.
SELECT 
    COUNT(employeeid) AS hr_employee_count
FROM 
    Employees
WHERE 
    DepartmentName = 'HR';

--13.	Write a query that finds the highest (MAX) and lowest (MIN) Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
SELECT DepartmentName,
    MAX(Salary),  MIN(Salary)
FROM Employees
GROUP BY DepartmentName;

--14.	Write a query that uses GROUP BY to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
SELECT DEPARTMENTNAME, 
AVG(SALARY) 
FROM Employees
GROUP BY DepartmentName

--15.	Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
SELECT DEPARTMENTNAME,
AVG(SALARY), COUNT(*) EMPLOYEEID
FROM Employees
GROUP BY DepartmentName

--16.	Write a query that uses HAVING to filter product categories with an average price greater than 400.
SELECT * FROM Products
SELECT CATEGORY, avg(price)
	FROM PRODUCTS
	GROUP BY CATEGORY
	HAVING AVG(PRICE) > 400 


--17.	Write a query that calculates the total sales for each year in the Sales table, and use GROUP BY to group them.
SELECT YEAR(SaleDate), 
       SUM(SaleAmount)
FROM Sales
GROUP BY YEAR(SaleDate);

--18.	Write a query that uses COUNT to show the number of customers who placed at least 3 orders.

select customerid from Orders
group by CustomerID
having count(*) >= 3
-----------------
SELECT COUNT(*) AS CustomersWithAtLeast3Orders
FROM (
    SELECT CustomerID
    FROM Orders
    GROUP BY CustomerID
    HAVING COUNT(*) >= 3
) AS Subquery;

--19.	Write a query that applies the HAVING clause to filter out Departments with total salary expenses greater than 500,000.(DeptID is enough, if you don't have DeptName).
select departmentname, sum(salary) as totalsalary
from Employees
group by departmentname
having sum(Salary) > 500000


--🔴 Hard-Level Tasks (6)
--20.	Write a query that shows the average (AVG) sales for each product category, and then uses HAVING to filter categories with an average sales amount greater than 200.
SELECT ProductID, 
       AVG(SaleAmount) AS AverageSales
FROM Sales
GROUP BY ProductID
HAVING AVG(SaleAmount) > 200;

SELECT Category, 
       AVG(SaleAmount) AS AverageSales
FROM Sales
JOIN Products ON Sales.ProductID = Products.ProductID
GROUP BY Category
HAVING AVG(SaleAmount) > 200;


--21.	Write a query to calculate the total (SUM) sales for each Customer, then filter the results using HAVING to include only Customers with total sales over 1500.
SELECT CustomerID, 
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

--22.	Write a query to find the total (SUM) and average (AVG) salary of employees grouped by department, and use HAVING to include only departments with an average salary greater than 65000.
select DepartmentName, sum(Salary), avg(Salary)
from Employees
group by DepartmentName
having avg(Salary)> 65000
--23.	Write a query that finds the maximum (MAX) and minimum (MIN) order value for each customer, and then applies HAVING to exclude customers with an order value less than 50.
SELECT CustomerID, 
       MAX(TotalAmount) AS MaxOrderValue, 
       MIN(TotalAmount) AS MinOrderValue
FROM Orders
GROUP BY CustomerID
HAVING MIN(TotalAmount) >= 50;

--24.	Write a query that calculates the total sales (SUM) and counts distinct products sold in each month, and then applies HAVING to filter the months with more than 8 products sold.
SELECT 
    MONTH(SaleDate) AS SaleMonth,
    SUM(SaleAmount) AS TotalSales,
    COUNT(DISTINCT ProductID) AS DistinctProductsSold
FROM Sales
GROUP BY MONTH(SaleDate)
HAVING COUNT(DISTINCT ProductID) > 8;

--25.	Write a query to find the MIN and MAX order quantity per Year. From orders table. (Do some research)
SELECT 
    YEAR(OrderDate) AS OrderYear,
    MIN(Quantity) AS MinOrderQuantity,
    MAX(Quantity) AS MaxOrderQuantity
FROM Orders
GROUP BY YEAR(OrderDate);


