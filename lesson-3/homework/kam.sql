--Easy-Level Tasks (10)
--1.Define and explain the purpose of BULK INSERT in SQL Server.
--The Bulk insert statement allows you to import a data file into a table or view in SQL Server. this commmand helps you to extract from other file into Sql database and work on it.
--it is very helpful to work with large tables. he target table must exist beforehand.File access requires the SQL Server instance to have read permission on the file.Proper formatting of the source file is crucial to avoid errors.

--2.List four file formats that can be imported into SQL Server.
--There are several file formats that used to import into SQL server, but common file formats are Comma Seperated Value(CSV) file(Plain text file where values are separated by commas)., Plain Text (TXT), XML (eXtensible Markup Language) which: Hierarchical data format, widely used in web services and configuration, JSON (JavaScript Object Notation), Excel files(.xls,.xlsx) Microsoft Excel spreadsheet files.

--3.Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
CREATE DATABASE PRODUCTS
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price Decimal(10,2)
);
SELECT * FROM Products
--4.Insert three records into the Products table using INSERT INTO.
Insert into Products (ProductID,ProductName,Price) Values (100,'Laptop',3500),(101,'Mobile',350),(102,'TV',400)
SELECT * FROM Products
--5.Explain the difference between NULL and NOT NULL with examples.
--In SQL, NULL represents a missing, unknown, or undefined value in a database column. Its not the same as 0, an empty string (''), or zero-length — it literally means "no value."
--WHere NOT NULL means ensures  that a column cannot have NULL(no value). it is a constraint that ensures that a table or field or column has a value.

--6.Add a UNIQUE constraint to the ProductName column in the Products table.
Alter TABLE Products add constraint ProductName UNIQUE (ProductName)
--7.Write a comment in a SQL query explaining its purpose.
-- In SQL, two dashes (--) are used to write a single-line comment. Everything after the dashes on that line is ignored by SQL Server (or any SQL engine)..these two dashes explain in SQL query that it is not a command by comment to explain or define any other commands. this is for codes to make easier to understand. make notes for yourself or other developers.

--8.Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
CREATE TABLE CATEGORIES (CATEGORYID INT PRIMARY KEY, CATEGORYNAME VARCHAR(100) UNIQUE)
SELECT * FROM CATEGORIES
--9.Explain the purpose of the IDENTITY column in SQL Server.
--In SQL Server, the IDENTITY property is used to create a column that automatically generates numeric values, often used for primary keys.
--The main purpose of the IDENTITY column is to:Auto-generate unique values for each row.Avoid manual input of IDs (like customer IDs, order numbers, etc.).Simplify creation of primary keys.

-- Medium-Level Tasks (10)
--10.Use BULK INSERT to import data from a text file into the Products table.
BULK INSERT PRODUCTS
FROM 'C:\Users\isfan\Documents\Kamola Data Analytics school\SQL\SQL.HOMEWORK\HOMEWORK3.txt'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
SELECT * FROM PRODUCTS

--11.Create a FOREIGN KEY in the Products table that references the Categories table.
ALTER TABLE Products
ADD CONSTRAINT fk_category
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

--12.Explain the differences between PRIMARY KEY and UNIQUE KEY with examples.
--The primary key uniquely identifies each record in the table.
--The unique key serves as a unique identifier for records when a primary key is absent.
--The primary key cannot store NULL values. The unique key can store a null value, but only one 
--NULL value is allowed. Unique keys can consist of multiple columns. Unique keys are also called alternate keys. Unique keys are an alternative to the primary key of the relation. In SQL, the unique keys have a UNIQUE constraint assigned to them in order to prevent duplicates (a duplicate entry is not valid in a unique column).
--Driver's licenses are examples of primary keys, as they can officially identify each user as a licensed driver and their street address in the Department of Motor Vehicles' database. Student ID. Students are routinely given a unique ID known as a student ID.

--13.Add a CHECK constraint to the Products table ensuring Price > 0.
ALTER TABLE Products
ADD CONSTRAINT chk_price_positive
CHECK (Price > 0);
--14.Modify the Products table to add a column Stock (INT, NOT NULL).
ALTER TABLE Products
ADD Stock INT DEFAULT 0 NOT NULL;

--15.Use the ISNULL function to replace NULL values in a column with a default value.
ISNULL(column_name, default_value)
SELECT 
    ProductID,
    ProductName,
    ISNULL(Stock, 0) AS Stock
FROM Products;

--16.Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
--A FOREIGN KEY is a constraint in SQL Server that ensures referential integrity between two tables by creating a relationship between a column in one table and the primary key (or unique key) of another.
-- Purpose of FOREIGN KEY:
--Enforces data consistency: Ensures that the value in the child table exists in the parent table.
--Prevents orphan records: You can’t insert a value in the child table that doesn’t exist in the parent table.
--Maintains relationships: Helps define how tables are logically related.


-- Hard-Level Tasks (10)

--17.Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Age INT,
    CONSTRAINT chk_age_min CHECK (Age >= 18)
);
SELECT * FROM Customers

--18.Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE ProductsS (
    ProductID INT IDENTITY(100, 10) PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);
SELECT * FROM ProductsS

--19.Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    CONSTRAINT pk_orderdetails PRIMARY KEY (OrderID, ProductID)
);
SELECT * FROM OrderDetails

--20.Explain with examples the use of COALESCE and ISNULL functions for handling NULL values.


--21.Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,            
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,        
    HireDate DATE
);
SELECT * FROM Employees

--22.Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    CONSTRAINT fk_customer
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
SELECT * FROM Orders
