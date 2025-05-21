1.
CREATE PROCEDURE sp_GetEmployeeBonuses
AS
BEGIN
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(101),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * db.BonusPercentage / 100 AS BonusAmount
    FROM 
        Employees e
    JOIN 
        DepartmentBonus db ON e.Department = db.Department;

    SELECT * FROM #EmployeeBonus;
END;

2.
CREATE PROCEDURE sp_UpdateDepartmentSalary
    @DepartmentName NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    -- Step 1: Update the salaries
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercent / 100)
    WHERE Department = @DepartmentName;

    -- Step 2: Return updated employees from that department
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        Department,
        Salary
    FROM 
        Employees
    WHERE 
        Department = @DepartmentName;
END;

3.
MERGE Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

WHEN MATCHED AND 
    (target.ProductName <> source.ProductName OR target.Price <> source.Price)
THEN UPDATE SET
    target.ProductName = source.ProductName,
    target.Price = source.Price

WHEN NOT MATCHED BY TARGET
THEN INSERT (ProductID, ProductName, Price)
     VALUES (source.ProductID, source.ProductName, source.Price)

WHEN NOT MATCHED BY SOURCE
THEN DELETE;

4.
SELECT 
    t1.id,
    CASE 
        WHEN t1.p_id IS NULL THEN 'Root'
        WHEN t1.id NOT IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS NodeType
FROM Tree t1;

5.
SELECT 
    s.user_id,
    ROUND(
        COALESCE(
            SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) * 1.0 /
            NULLIF(COUNT(c.action), 0), 
        0), 
    2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id;

6.
SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
-------------------
SELECT *
FROM employees
WHERE salary = (
    SELECT MIN(salary) 
    FROM employees
);

7.
CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    -- Prevent extra result sets
    SET NOCOUNT ON;

    SELECT
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
EXEC GetProductSalesSummary @ProductID = 1;

