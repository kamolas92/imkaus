create database homework10
--🟢 Easy-Level Tasks (10)
--1.	Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
--🔁 Expected Output: EmployeeName, Salary, DepartmentName
SELECT
	Employees.Name,
	Employees.Salary,
	Departments.DepartmentName
FROM 
	Employees
INNER JOIN
	Departments
ON
	Departments.DepartmentID=Employees.DepartmentID
WHERE 
	Employees.Salary > 50000;

--2.	Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
--🔁 Expected Output: FirstName, LastName, OrderDate
SELECT 
	Customers.FirstName,
	Customers.LastName,
	Orders.OrderDate
FROM
	Customers
INNER JOIN
	Orders
ON
	Customers.CustomerID=Orders.CustomerID
WHERE
	YEAR(Orders.OrderDate) = 2023;

--3.	Using the Employees and Departments tables, write a query to show all employees along with their department names.Include employees who do not belong to any department.
--🔁 Expected Output: EmployeeName, DepartmentName
--(Hint: Use a LEFT OUTER JOIN)
SELECT
	Employees.Name AS EmployeeName,
	Departments.DepartmentName
FROM
	Employees
LEFT JOIN
	Departments
ON
	Employees.DepartmentID=Departments.DepartmentID;

--4.	Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
--🔁 Expected Output: SupplierName, ProductName
SELECT
	Suppliers.SupplierName,
	Suppliers.SupplierID,
	Products.ProductName,
	Products.SupplierID
FROM
	Products
LEFT JOIN
	Suppliers
ON
	Products.SupplierID=Suppliers.SupplierID;

--5.	Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
--🔁 Expected Output: OrderID, OrderDate, PaymentDate, Amount
SELECT
	Orders.OrderID,
	Orders.OrderDate,
	Payments.PaymentDate,
	Payments.Amount
FROM
	Orders
FULL JOIN
	Payments
ON	
	Orders.OrderID=Payments.OrderID;

--6.	Using the Employees table, write a query to show each employee's name along with the name of their manager.
--🔁 Expected Output: EmployeeName, ManagerName
SELECT
	E.Name AS EmployeeName,
	M.Name AS ManagersName
FROM
	Employees AS E
LEFT JOIN
	Employees AS M
ON
	E.ManagerID=M.EmployeeID;
		
--7.	Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
--🔁 Expected Output: StudentName, CourseName
SELECT
	Students.Name AS StudentName,
	Courses.CourseName,
	Enrollments.EnrollmentID
FROM 
	Students
JOIN
	Enrollments ON 	Enrollments.StudentID=Students.StudentID
JOIN
	Courses ON Enrollments.CourseID=Courses.CourseID
WHERE
	Courses.CourseName = 'MATH 101';

--8.	Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
--🔁 Expected Output: FirstName, LastName, Quantity
SELECT
	Customers.FirstName,
	Customers.LastName,
	Orders.Quantity
FROM
	Customers
JOIN
	Orders
ON
	Customers.CustomerID=Orders.CustomerID
WHERE
	Orders.Quantity > 3;

--9.	Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
--🔁 Expected Output: EmployeeName, DepartmentName
SELECT
	Employees.Name,
	Departments.DepartmentName
FROM
	Employees
JOIN
	Departments
ON
	Employees.DepartmentID=Departments.DepartmentID
WHERE
	Departments.DepartmentName= 'Human Resources';
--________________________________________
--🟠 Medium-Level Tasks (9)
--10.	Using the Employees and Departments tables, write a query to return department names that have more than 10 employees.
--🔁 Expected Output: DepartmentName, EmployeeCount
SELECT 
	Departments.DepartmentName,
	COUNT(Employees.EmployeeID) AS EmployeeCount
FROM 
	Employees
INNER JOIN 
	Departments
ON
	Departments.DepartmentID = Employees.DepartmentID
GROUP BY
	Departments.DepartmentName
HAVING 
	COUNT(Employees.EmployeeID) > 10;

--11.	Using the Products and Sales tables, write a query to find products that have never been sold.
--🔁 Expected Output: ProductID, ProductName
SELECT
	Products.ProductID,
	Products.ProductName
FROM
	Products
LEFT JOIN
	Sales
ON
	Products.ProductID=Sales.ProductID
WHERE
	Sales.ProductID IS NULL;
--12.	Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
--🔁 Expected Output: FirstName, LastName, TotalOrders
SELECT
	Customers.FirstName,
	Customers.LastName,
	Orders.Quantity
FROM	
	Customers
INNER JOIN
	Orders
ON
	Customers.CustomerID=Orders.CustomerID;

--13.	Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
--🔁 Expected Output: EmployeeName, DepartmentName
SELECT
	Employees.EmployeeID,
	Employees.Name,
	Departments.DepartmentName
FROM
	Employees
JOIN
	Departments
ON
	Employees.DepartmentID = Departments.DepartmentID;

--14.	Using the Employees table, write a query to find pairs of employees who report to the same manager.
--🔁 Expected Output: Employee1, Employee2, ManagerID
SELECT
	E1.EmployeeID,
	E1.Name,
	E2.EmployeeID,
	E2.Name
FROM 
	Employees AS E1
JOIN 
	Employees AS E2
ON
	E1.ManagerID=E2.ManagerID
WHERE
	E1.EmployeeID<E2.EmployeeID;

--15.	Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
--🔁 Expected Output: OrderID, OrderDate, FirstName, LastName
SELECT 
	o.OrderID, 
	o.OrderDate,
	c.FirstName, 
	c.LastName
FROM 
	Orders o
JOIN 
	Customers c 
ON
	o.CustomerID = c.CustomerID
WHERE 
	YEAR(o.OrderDate) = 2022;

--16.	Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
--🔁 Expected Output: EmployeeName, Salary, DepartmentName
SELECT
	e.EmployeeID, 
		e.Name, 
		e.Salary,
		d.DepartmentName
FROM
	Employees AS e
JOIN 
	Departments AS d
ON 
	e.DepartmentID = d.DepartmentID
WHERE
	d.DepartmentName = 'Sales'
  AND 
	e.Salary > 60000;

--17.	Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
--🔁 Expected Output: OrderID, OrderDate, PaymentDate, Amount
SELECT
	Orders.OrderID,
	Orders.OrderDate,
	Payments.PaymentDate,
	Payments.Amount
FROM
	Orders
INNER JOIN
	Payments
ON 
	Orders.OrderID=Payments.OrderID;

--18.	Using the Products and Orders tables, write a query to find products that were never ordered.
--🔁 Expected Output: ProductID, ProductName
SELECT
	Products.ProductID, 
	Products.ProductName
FROM
	Products 
LEFT JOIN
	Orders  
ON
	Products.ProductID = Orders.ProductID
WHERE 
	Orders.ProductID IS NULL;

--________________________________________
--🔴 Hard-Level Tasks (9)
--19.	Using the Employees table, write a query to find employees whose salary is greater than the average salary of all employees.
--🔁 Expected Output: EmployeeName, Salary
SELECT
	Employees.Name,
	Employees.Salary
FROM
	Employees
WHERE
		Salary > (
	SELECT AVG(SALARY)
	FROM Employees
	);
--20.	Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
--🔁 Expected Output: OrderID, OrderDate
SELECT * FROM Orders
SELECT 
	Orders.OrderID,
	Orders.OrderDate,
	Payments.OrderID
FROM
	Orders
LEFT JOIN
	Payments
ON 
	Orders.OrderID=Payments.OrderID
WHERE 
	Orders.OrderDate < '2020-01-01'
AND
	Payments.OrderID IS NULL;

--21.	Using the Products and Categories tables, write a query to return products that do not have a matching category.
--🔁 Expected Output: ProductID, ProductName
SELECT
	Products.ProductID,
	Categories.CategoryName
FROM
	Products
LEFT JOIN
	Categories
ON
	Products.ProductID = Categories.CategoryID
WHERE
	Categories.CategoryID IS NULL;
	
--22.	Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
--🔁 Expected Output: Employee1, Employee2, ManagerID, Salary
SELECT
	e.EmployeeID, 
	e.Name,
	e.Salary,
	e.ManagerID
FROM Employees e
WHERE e.Salary > 60000
  AND e.ManagerID IS NOT NULL
  AND e.ManagerID IN (
      SELECT ManagerID
      FROM Employees
      WHERE Salary > 60000
      GROUP BY ManagerID
      HAVING COUNT(*) > 1
  );
	
--23.	Using the Employees and Departments tables, write a query to return employees who work in departments whose name starts with the letter 'M'.
--🔁 Expected Output: EmployeeName, DepartmentName
SELECT * FROM Employees; SELECT * FROM Departments;
SELECT
	Employees.Name,
	Departments.DepartmentName
FROM
	Employees
INNER JOIN
	Departments
ON
	Employees.DepartmentID=Departments.DepartmentID
WHERE
	Employees.Name LIKE 'M%';

--24.	Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
--🔁 Expected Output: SaleID, ProductName, SaleAmount
SELECT
	Sales.SaleID,
	Products.ProductID,
	Sales.SaleAmount
FROM
	Products
JOIN
	Sales
ON	
	Products.ProductID=Sales.ProductID
WHERE
	SALES.SALEAMOUNT > 500;

--25.	Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
--🔁 Expected Output: StudentID, StudentName
SELECT
	Students.Name AS StudentName,
	Courses.CourseName,
	Enrollments.EnrollmentID
FROM 
	Students
JOIN
	Enrollments ON 	Enrollments.StudentID=Students.StudentID
JOIN
	Courses ON Enrollments.CourseID=Courses.CourseID
WHERE
	Courses.CourseName != 'MATH 101';

--26.	Using the Orders and Payments tables, write a query to return orders that are missing payment details.
--🔁 Expected Output: OrderID, OrderDate, PaymentID
SELECT
	Orders.OrderID,
	Orders.OrderDate,
	Payments.PaymentID
FROM
	Orders
LEFT JOIN
	PAYMENTS
ON
	Orders.OrderID=Payments.OrderID
WHERE
	Payments.PaymentID IS NULL;

--27.	Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
--🔁 Expected Output: ProductID, ProductName, CategoryName
SELECT 
	Products.ProductID,
	Products.ProductName,
	Categories.CategoryName
FROM
	Products
INNER JOIN
	Categories
ON
	Products.ProductID=Categories.CategoryID
WHERE
	Categories.CategoryName IN('Electronics','Furniture');
