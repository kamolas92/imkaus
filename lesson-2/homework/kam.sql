--DDL & DML HOMEWORK LESSON 2
--Basic-Level Tasks (10)
--1.Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
CREATE DATABASE HOMEWORKLESSON2
CREATE TABLE Employees
SELECT * FROM Employees
CREATE TABLE Employees(
EMPID INT,
NAME VARCHAR(50),
SALARY DECIMAL (10,2)
);
--2.Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
INSERT INTO Employees (EMPID,NAME,SALARY) VALUES (100,'IMRON',450000);
INSERT INTO Employees (EMPID,NAME,SALARY) VALUES (101,'KAMRON',450000);
INSERT INTO Employees (EMPID,NAME,SALARY) VALUES (102,'USMON',450000);
--3.Update the Salary of an employee where EmpID = 1.
UPDATE Employees SET SALARY=460000 WHERE EMPID=100;
--4.Delete a record from the Employees table where EmpID = 2.
DELETE FROM Employees WHERE EMPID=101;
--5.Demonstrate the difference between DELETE, TRUNCATE, and DROP commands on a test table.
DROP TABLE Employees;
TRUNCATE TABLE Employees;
DELETE FROM EMPLOYEES WHERE EMPID=100;
SELECT * FROM Employees;
--6.Modify the Name column in the Employees table to VARCHAR(100).
ALTER TABLE EMPLOYEES ALTER COLUMN NAME VARCHAR (100);
--7.Add a new column Department (VARCHAR(50)) to the Employees table.
ALTER TABLE EMPLOYEES ADD DEPARTMENT VARCHAR (50);
--8.Change the data type of the Salary column to FLOAT.
ALTER TABLE EMPLOYEES ALTER COLUMN SALARY FLOAT;
--9.Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
CREATE TABLE Departments (DepartmentID INT, DeprtmentName VARCHAR(50));
SELECT * FROM Departments
--10.Remove all records from the Employees table without deleting its structure.
TRUNCATE TABLE Employees;
SELECT * FROM Employees;
---------------------------------
--Intermediate-Level Tasks (6)
--11.Insert five records into the Departments table using INSERT INTO SELECT from an existing table.
INSERT INTO Departments (DepartmentID,DeprtmentName) 
SELECT EmpID,NAME
FROM Employees
WHERE EmpID >3;
SELECT*FROM Departments
--12.Update the Department of all employees where Salary > 5000 to 'Management'.
UPDATE Employees 
Set Department = 'Management' 
where salary > 5000;
SELECT * FROM Employees;
--13.Write a query that removes all employees but keeps the table structure intact.
TRUNCATE table Employees;
DELETE FROM Employees;
--14.Drop the Department column from the Employees table.
ALTER TABLE EMPLOYEES DROP COLUMN DEPARTMENT;
SELECT * FROM Employees;
--15.Rename the Employees table to StaffMembers using SQL commands.
EXEC SP_RENAME 'EMPLOYEES', 'STAFFMEMBERS'
SELECT * FROM STAFFMEMBERS
--16.Write a query to completely remove the Departments table from the database.
DROP TABLE Departments
DROP TABLE IF EXISTS DEPARTMENTS
-------------------------------------------------------------------------------------
--Advanced-Level Tasks (9)
--17.Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE PRODUCTS(
ProductID int,
PRODUCTNAME VARCHAR(30),
CATEGORY VARCHAR(20),
PRICE DECIMAL(10,2),
WEIGHkg INT
);
SELECT* FROM PRODUCTS
--18.Add a CHECK constraint to ensure Price is always greater than 0.
ALTER TABLE PRODUCTS
ADD CONSTRAINT chk_price_positive CHECK (Price > 0);
--19.Modify the table to add a StockQuantity column with a DEFAULT value of 50.
ALTER TABLE PRODUCTS DROP COLUMN STOCKQUANTITY
ALTER TABLE PRODUCTS ADD STOCKQUANTITY INT DEFAULT 50
--ATLER TABLE PRODUCTS ADD STOCKQUANTITY INT(50)???
--20.Rename Category to ProductCategory
EXEC SP_RENAME 'PRODUCTS.CATEGORY', 'PRODUCTCATEGORY','COLUMN'
SELECT* FROM PRODUCTS
--21.Insert 5 records into the Products table using standard INSERT INTO queries.
INSERT INTO PRODUCTS (ProductID,PRODUCTNAME,PRODUCTCATEGORY,PRICE,Weigh,STOCKQUANTITY) VALUES 
(1,'APPLE','FRUITS',35000,22,200),
(2,'WATERMELON','FRUITS',5000,200,1500),
(3,'TOMATO','VEGETABLES',50000,100,2300),
(4,'PUMPKIN','VEGETABLES',5000,100,200),
(5,'GRAPE','FRUITS',100000,22,500);
--22.Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
SELECT * INTO Products_Backup
FROM Products;
SELECT* FROM PRODUCTS
SELECT*FROM Products_Backup
--23.Rename the Products table to Inventory.
EXEC SP_RENAME 'PRODUCTS','INVENTORY'
SELECT*FROM INVENTORY
--24.Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
ALTER TABLE Inventory 
ALTER COLUMN Price FLOAT;
--25.Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5.
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5);
