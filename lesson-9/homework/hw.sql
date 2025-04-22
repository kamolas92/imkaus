--🟢 Easy (10 puzzles)
--1.	Using Products, Suppliers table List all combinations of product names and supplier names.
SELECT
	Products.ProductName, 
	Suppliers.SupplierName
FROM
	PRODUCTS 
CROSS JOIN 
	SUPPLIERS;

--2.	Using Departments, Employees table Get all combinations of departments and employees.
SELECT *
FROM	
	Departments
CROSS JOIN
	Employees;

--3.	Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
SELECT 
	Suppliers.SupplierName,
	Products.ProductName
FROM 
	Products
INNER JOIN
	Suppliers
ON
	Products.SupplierID = Suppliers.SupplierID;

--4.	Using Orders, Customers table List customer names and their orders ID.
SELECT 
	Customers.CustomerID, Orders.OrderID
FROM
	Customers
INNER JOIN
	Orders
	ON
	  Customers.CustomerID = Orders.CustomerID;

--5.	Using Courses, Students table Get all combinations of students and courses.
SELECT 
	Courses.CourseName,
	Students.Name
FROM
	Courses
CROSS JOIN
	Students;

--6.	Using Products, Orders table Get product names and orders where product IDs match.
SELECT
	Products.ProductName,
	Orders.OrderID
FROM
	Products
INNER JOIN
	Orders
ON 
	Products.ProductID = Orders.ProductID;

--7.	Using Departments, Employees table List employees whose DepartmentID matches the department.
SELECT
	Employees.Name,
	Departments.DepartmentName
FROM
	Employees
INNER JOIN
	Departments
ON 
	Departments.DepartmentID = Employees.DepartmentID;

--8.	Using Students, Enrollments table List student names and their enrolled course IDs.
SELECT
	Students.Name,
	Enrollments.CourseID
FROM
	Students
INNER JOIN
	Enrollments
ON
	Students.StudentID = Enrollments.StudentID;

--9.	Using Payments, Orders table List all orders that have matching payments.
SELECT
	Payments.PaymentID,
	Orders.OrderID
FROM
	Payments
INNER JOIN
	Orders
ON 
	Payments.OrderID = Orders.OrderID;

--10.	Using Orders, Products table Show orders where product price is more than 100.
SELECT 
	Products.Price,
	Orders.OrderID,
	Products.ProductName
FROM
	Products
INNER JOIN
	Orders
ON 
	Products.ProductID = Orders.ProductID
WHERE 
	Products.Price > 100;
----------------------------------------------------------------------------------------
--🟡 Medium (10 puzzles)
--11.	Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
SELECT
	Employees.Name,
	Departments.DepartmentName
FROM 
	Employees
INNER JOIN
	Departments
ON 
	Employees.DepartmentID != Departments.DepartmentID
ORDER BY
	Employees.NAME,
	Departments.DepartmentName;

--12.	Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
SELECT
	Orders.OrderID,
	Products.ProductName,
	Orders.Quantity AS Orderedquantity,
	Products.StockQuantity
FROM
	Orders
INNER JOIN
	Products
ON
	Orders.ProductID = Products.ProductID
WHERE
	Orders.Quantity >= Products.StockQuantity;

--13.	Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
SELECT
	 CONCAT(FIRSTNAME,' ', LASTNAME) AS NAME,
	 Sales.ProductID,
	 Sales.SaleAmount
FROM 
	Customers
INNER JOIN
	Sales
ON
	Sales.CustomerID = Customers.CustomerID 
WHERE
	Sales.SaleAmount >= 500;

--14.	Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
SELECT 
	Students.Name,
	Courses.CourseName,
	Enrollments.EnrollmentID
FROM
	Enrollments
JOIN 
	Students
ON 
	Enrollments.ENROLLMENTID = STUDENTS.StudentID
JOIN
	Courses
ON
	EnrollmENTS.EnrollmentID = Courses.CourseID
 ORDER BY
	Students.Name, Courses.CourseName,Enrollments.EnrollmentID;

--15.	Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
SELECT
	Products.ProductName,
	Suppliers.SupplierName
FROM 
	Products
INNER JOIN
	Suppliers 
ON	
	Suppliers.SupplierID = Products.SupplierID
WHERE 
	SupplierName LIKE '%Tech%'

--16.	Using Orders, Payments table Show orders where payment amount is less than total amount.
SELECT 
	Orders.OrderID,
	Orders.TotalAmount,
	Payments.OrderID,
	Payments.PaymentID,
	Payments.Amount
FROM
	Orders
INNER JOIN
	Payments
ON 
	Orders.OrderID = Payments.OrderID
WHERE
	Payments.Amount < Orders.TotalAmount
ORDER BY
	Orders.OrderID;
--17.	Using Employees table List employee names with salaries greater than their manager’s salary.
SELECT 
    E.Name AS EmployeeName,
    M.Name AS ManagerName,
    E.Salary AS EmployeeSalary,
    M.Salary AS ManagerSalary
FROM 
    Employees AS E
JOIN 
    Employees AS M
ON
	E.ManagerID = M.EmployeeID
WHERE 
    E.Salary > M.Salary
ORDER BY 
    E.Name;

--18.	Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
SELECT 
	Products.*
FROM 
	Products
JOIN
	Categories
ON
	Products.Category = Categories.CategoryID
WHERE 
	CategoryName IN ('ELECTRONICS','FURNITURE');

--19.	Using Sales, Customers table Show all sales from customers who are from 'USA'.
SELECT 
	Sales.SaleID,
	CONCAT(FIRSTNAME,'',LASTNAME)AS NAME,
	Customers.Country
FROM
	Sales
INNER JOIN
	Customers
ON
	Sales.CustomerID = Customers.CustomerID
WHERE 
	Customers.Country = 'USA';

--20.	Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
SELECT *
FROM 
	Orders
INNER JOIN 
	Customers
ON 
	Orders.CustomerID = Customers.CustomerID
WHERE
	Customers.Country = 'GERMANY' AND 
	Orders.OrderID > 100;
-----------------------------------------
--🔴 Hard (5 puzzles)
--21.	Using Employees table List all pairs of employees from different departments.
SELECT E1.EmployeeID AS Employee1_ID, E1.Name AS Employee1_Name,
       E2.EmployeeID AS Employee2_ID, E2.Name AS Employee2_Name
FROM
	Employees AS E1
JOIN 
	Employees AS E2
ON 
	E1.DepartmentID != E2.DepartmentID
ORDER BY
	E1.EmployeeID, E2.EmployeeID;


--22.	Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
SELECT
	P.PaymentID,
	P.OrderID,
	O.Quantity, 
	PR.Price,
	P.Amount AS PaidAmount, 
	O.Quantity * PR.Price AS ExpectedAmount
FROM Payments AS P
JOIN Orders AS O ON P.OrderID = O.OrderID
JOIN Products AS PR ON O.ProductID = PR.ProductID
WHERE P.Amount != (O.Quantity * PR.Price);
SELECT * FROM Products

--23.	Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
SELECT 
	S.StudentID, S.Name
FROM 
	Students AS S
LEFT JOIN 
	Enrollments AS E
ON 
	S.StudentID = E.StudentID
WHERE
	E.EnrollmentID IS NULL;


--24.	Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
SELECT
	E1.EmployeeID, E1.Name AS ManagerName, 
	E1.Salary AS ManagerSalary,
	E2.EmployeeID, E2.Name AS EmployeeName, 
	E2.Salary AS EmployeeSalary
FROM 
	Employees AS E1
JOIN 
	Employees AS E2 
ON
	E1.EmployeeID = E2.ManagerID
WHERE 
	E1.Salary <= E2.Salary;


--25.	Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
SELECT
	C.CustomerID,
	C.FirstName,
	C.LastName,
	O.OrderID,
	P.PaymentID
FROM
	Customers AS C
JOIN 
	Orders AS O
ON
	C.CustomerID = O.CustomerID
LEFT JOIN
	Payments AS P
ON 
	O.OrderID = P.OrderID
WHERE 
	P.PaymentID IS NULL;
