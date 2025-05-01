--🟢 Easy-Level Tasks (7)
--1.
SELECT
	Orders.OrderID,
	CONCAT(FirstName,'',LASTNAME) AS NAME,
	Orders.OrderDate
FROM 
	Orders
JOIN
	Customers
ON
	Orders.CustomerID=Customers.CustomerID
WHERE
	YEAR(ORDERS.OrderDate) > 2022
ORDER BY
	OrderDate;

--2.	
SELECT
	Employees.NAME AS EmployeeName,
	Departments.DepartmentName
FROM
	Employees
JOIN
	Departments
ON
	Employees.DepartmentID=Departments.DepartmentID
WHERE
	Departments.DepartmentName IN ('SALES','MARKETING')
ORDER BY
	DepartmentName;

--3.	
SELECT
	Departments.DepartmentName,
	Employees.Name as TopEmployeeName,
	Employees.Salary AS MaxSalary
FROM 
	Employees
JOIN
	Departments
ON
	Employees.DepartmentID=Departments.DepartmentID
WHERE
	Employees.Salary = (
	SELECT MAX(SALARY)
	FROM Employees 
	WHERE Employees.DepartmentID=Departments.DepartmentID
);
--4.	
SELECT
	DISTINCT Customers.CustomerID,
	CONCAT(FIRSTNAME,'',LASTNAME) AS CustomerName,
	Orders.OrderID,
	Orders.OrderDate,
	Customers.Country
FROM
	Customers
JOIN
	Orders
ON
	Customers.CustomerID=Orders.CustomerID
WHERE
	Customers.COUNTRY = 'USA' AND
	Orders.OrderDate BETWEEN '2023-01-01' AND '2023-12-31';

--5.
select * from orders; select * from customers
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COALESCE(o.TotalOrders, 0) AS TotalOrders
FROM 
    Customers c
LEFT JOIN (
    SELECT 
        CustomerID, 
        COUNT(*) AS TotalOrders
    FROM 
        Orders
    GROUP BY 
        CustomerID
) o ON c.CustomerID = o.CustomerID;


--6.
select
	Products.ProductName,
	Suppliers.SupplierName
from
	Products
join 
	Suppliers 
	on Products.SupplierID=Suppliers.SupplierID
where 
	SupplierName in ('Gadget Supplies','Clothing Mart')
order by
	SupplierName;
--7.	
select * from Customers; select * from Orders
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    o.MostRecentOrderDate,
    o.OrderID
FROM Customers c
LEFT JOIN (
    SELECT 
        CustomerID,
        MAX(OrderDate) AS MostRecentOrderDate,
		FIRST_VALUE(OrderID) OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS OrderID
    FROM Orders
    GROUP BY CustomerID
) o ON c.CustomerID = o.CustomerID;

--________________________________________
--🟠 Medium-Level Tasks (6)
--8.
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    o.OrderID,
    o.TotalAmount AS OrderTotal
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;

--9.	
SELECT 
    p.ProductName,
    s.SaleDate,
    s.SaleAmount
FROM Sales s
INNER JOIN Products p ON s.ProductID = p.ProductID
WHERE 
    YEAR(s.SaleDate) = 2022
    OR s.SaleAmount > 400;

--10.	
SELECT 
    p.ProductName,
    COALESCE(s.TotalSalesAmount, 0) AS TotalSalesAmount
FROM Products p
LEFT JOIN (
    SELECT 
        ProductID,
        SUM(SaleAmount) AS TotalSalesAmount
    FROM Sales
    GROUP BY ProductID
) s ON p.ProductID = s.ProductID;

--11.
SELECT 
    e.Name,
    d.DepartmentName,
    e.Salary
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    d.DepartmentName = 'Human Resources'
    AND e.Salary > 50000;

--12.	
SELECT 
    p.ProductName,
    s.SaleDate,
    p.StockQuantity
FROM Sales s
INNER JOIN Products p ON s.ProductID = p.ProductID
WHERE 
    YEAR(s.SaleDate) = 2023
    AND p.StockQuantity > 50;

--13.	
SELECT 
    e.Name,
    d.DepartmentName,
    e.HireDate
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    d.DepartmentName = 'Sales'
    OR e.HireDate > '2020-01-01';

--________________________________________
--🔴 Hard-Level Tasks (7)
--14.	
select Customers.FirstName,Orders.OrderID,Customers.Address,Orders.OrderDate
from Customers
join Orders on customers.customerid=orders.customerid
where customers.Country = 'usa'
and Customers.Address like '[0-9][0-9][0-9][0-9]%';

--15.	
select Products.ProductName,Products.Category,Sales.SaleAmount
from Products
join Sales
on Products.ProductID=Sales.ProductID
where Products.Category = 'electronics'
or Sales.SaleAmount > 350

--16.	

SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.Category
GROUP BY c.CategoryName;

--17.	
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.City,
    o.OrderID,
    o.TotalAmount AS Amount
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE 
    c.City = 'Los Angeles'
    AND o.TotalAmount > 300;

--18.
SELECT 
    e.Name,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    d.DepartmentName IN ('Human Resources', 'Finance')
    OR (
        LEN(REPLACE(LOWER(e.Name), 'a', '')) < LEN(e.Name) - 4
        OR LEN(REPLACE(LOWER(e.Name), 'e', '')) < LEN(e.Name) - 4
        OR LEN(REPLACE(LOWER(e.Name), 'i', '')) < LEN(e.Name) - 4
        OR LEN(REPLACE(LOWER(e.Name), 'o', '')) < LEN(e.Name) - 4
        OR LEN(REPLACE(LOWER(e.Name), 'u', '')) < LEN(e.Name) - 4
    );

--19.	
SELECT 
    p.ProductName,
    SUM(p.stockQuantity) AS QuantitySold,
    p.Price
FROM Sales s
INNER JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName, p.Price
HAVING 
    SUM(p.StockQuantity) > 100
    AND p.Price > 500;


--20.	
SELECT 
    e.Name,
    d.DepartmentName,
    e.Salary
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    d.DepartmentName IN ('Sales', 'Marketing')
    AND e.Salary > 60000;















