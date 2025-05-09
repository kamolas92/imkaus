--Easy Tasks
--Create a numbers table using a recursive query from 1 to 1000.
;WITH NUMBCTE AS (
	SELECT 1 AS N
	UNION ALL
	SELECT N + 1
	FROM NUMBCTE
	WHERE N < 1000
)
INSERT INTO NUMBERS (ID)
SELECT N
FROM NUMBCTE
OPTION (MAXRECURSION 1000);

--Write a query to find the total sales per employee using a derived table.(Sales, Employees)
SELECT
	CONCAT(FirstName,' ',LastName) as EmployeeName,
	sales_sum.totalsales
FROM Employees as e
JOIN (
	SELECT EmployeeID, 
		SUM(SalesAmount) as totalsales
	FROM Sales as s 
	GROUP BY EmployeeID
	) AS sales_sum
ON e.EmployeeID = sales_sum.employeeID;

--Create a CTE to find the average salary of employees.(Employees)
;WITH AverageSalary AS (
	SELECT AVG(SALARY) AS AVGSaLaRY
	FROM EMPLOYEES
	)
SELECT * FROM AverageSalary;

--Write a query using a derived table to find the highest sales for each product.(Sales, Products)
SELECT
	p.productid,
	p.productname,
	highsales.maxsales
FROM products as p
JOIN (
	SELECT s.productid,
		MAX(salesamount) as maxsales
	FROM sales as s
	GROUP BY productid
	) AS highsales
ON p.productid = highsales.productid;

--Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
;WITH Numbercte as (
	select 1 as n
	union all
	select n * 2
	from Numbercte
	where n * 2 < 1000000
	)
select * from Numbercte;

--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
;WITH salescte as (
	SELECT employeeID,count(*) as salestotal
	FROM sales 
	GROUP BY employeeid
	)
SELECT 
	e.employeeid,
	CONCAT(firstname,' ',lastname) as Name,
	s.salestotal
FROM salescte as s
JOIN employees as e
ON s.employeeid = e.employeeid
WHERE s.salestotal > 5;

--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
;WITH PRODUCTSCTE AS (
	SELECT PRODUCTID,
		SUM(SALESAMOUNT) AS ALLPRODUCTS
		FROM SALES	
		GROUP BY PRODUCTID
		)
SELECT P.PRODUCTID,P.PRODUCTNAME,P1.ALLPRODUCTS
FROM PRODUCTSCTE AS P1
JOIN PRODUCTS AS P
ON P1.PRODUCTID = P.PRODUCTID
WHERE P1.ALLPRODUCTS > 500;

--Create a CTE to find employees with salaries above the average salary.(Employees)
;WITH AverageSalary AS (
	SELECT AVG(SALARY) AS AVGSaLaRY
	FROM EMPLOYEES
	)
SELECT E.EMPLOYEEID, CONCAT(FIRSTNAME,' ',LASTNAME)AS EMPLOYE_NAME, E.SALARY
FROM EMPLOYEES AS E
CROSS JOIN AverageSalary AS AVG
WHERE E.SALARY > AVG.AVGSaLaRY;

--Medium Tasks
--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
select * from Employees;select * from sales
SELECT TOP 5
	E.EMPLOYEEID,
	CONCAT(FIRSTNAME,' ',LASTNAME) AS EMPLOYEENAME,
	TORDERS.ORDERCOUNT
FROM Employees AS E
INNER JOIN (
			SELECT EMPLOYEEID,
				COUNT(SALESID) AS ORDERCOUNT
			FROM SALES 
			GROUP BY EmployeeID
			) TORDERS
			ON E.EmployeeID = TORDERS.EmployeeID
ORDER BY TORDERS.ORDERCOUNT DESC, E.EmployeeID;

--Write a query using a derived table to find the sales per product category.(Sales, Products)
SELECT
	PR.CategoryID,
	SUM(S.TOTALSALES) AS CATEGORYSALES
FROM 
	PRODUCTS AS PR
JOIN (
	SELECT PRODUCTID,
		SUM(SalesAmount) AS TOTALSALES			
	FROM SALES 
	GROUP BY ProductID
	) S  ON S.ProductID=PR.ProductID
GROUP BY PR.CategoryID
ORDER BY PR.CategoryID;

--Write a script to return the factorial of each value next to it.(Numbers1)
;WITH cte AS (
  SELECT 1 num, 1 AS factorial
  UNION all
  SELECT (num+1),(num+1) * factorial FROM cte
  WHERE num+1<10)
SELECT * FROM cte 
WHERE num in ( SELECT number FROM Numbers1);

--This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
;WITH SplitCTE AS (
    SELECT
        Id,
        SUBSTRING(String, 1, 1) AS Character,
        1 AS Position,
        String
    FROM Example AS E
    WHERE LEN(String) >= 1
    UNION ALL
    SELECT
        Id,
        SUBSTRING(String, Position + 1, 1),
        Position + 1,
        String
    FROM SplitCTE 
    WHERE Position + 1 <= LEN(String)
) 
SELECT Id, Position, Character
FROM SplitCTE
ORDER BY Id, Position
OPTION (MAXRECURSION 0); 

--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
WITH MonthlySales AS (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS YearMonth,
        SUM(SalesAmount) AS MonthlySales
    FROM Sales
    WHERE SaleDate IS NOT NULL
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
SalesWithDifference AS (
    SELECT 
        YearMonth,
        MonthlySales,
        MonthlySales - LAG(MonthlySales) OVER (ORDER BY YearMonth) AS SalesDifference
    FROM MonthlySales
)
SELECT *
FROM SalesWithDifference
ORDER BY YearMonth;

--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
SELECT 
    E.EmployeeID,
    E.FirstName,
    Q.Year,
    Q.Quarter,
    Q.TotalSales
FROM Employees E
JOIN (
    SELECT 
        EmployeeID,
        YEAR(SaleDate) AS Year,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
    HAVING SUM(SalesAmount) > 45000
) AS Q ON E.EmployeeID = Q.EmployeeID
ORDER BY E.EmployeeID, Q.Year, Q.Quarter;


--Difficult Tasks
--This script uses recursion to calculate Fibonacci numbers
;WITH cte as (
  SELECT 0 as first_num, 1 as second_num 
  UNION all
  SELECT second_num,first_num + second_num FROM cte
  WHERE first_num < 100)
SELECT first_num FROM cte;

--Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT *
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND LEN(REPLACE(vals, LEFT(Vals, 1), '')) = 0;

--Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
DECLARE @n INT = 5;
WITH NumberSequence AS (
    SELECT 1 AS Num, CAST('1' AS VARCHAR(MAX)) AS Sequence
    UNION ALL
    SELECT Num + 1,
           Sequence + CAST(Num + 1 AS VARCHAR)
    FROM NumberSequence
    WHERE Num + 1 <= @n
)
SELECT Sequence
FROM NumberSequence
ORDER BY Num
OPTION (MAXRECURSION 0);

--Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
SELECT 
    E.EmployeeID,
    E.FirstName,
    S.TotalSales
FROM Employees E
JOIN (
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) AS S ON E.EmployeeID = S.EmployeeID
WHERE S.TotalSales = (
    SELECT MAX(TotalSales)
    FROM (
        SELECT 
            EmployeeID,
            SUM(SalesAmount) AS TotalSales
        FROM Sales
        WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY EmployeeID
    ) AS SalesSummary
);

--Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
;WITH ExtractParts AS (
    SELECT 
        Pawan_slug_name,
        LEFT(Pawan_slug_name, CHARINDEX('-', Pawan_slug_name)) AS Prefix,
        RIGHT(Pawan_slug_name, LEN(Pawan_slug_name) - CHARINDEX('-', Pawan_slug_name)) AS NumberPart
    FROM RemoveDuplicateIntsFromNames
    WHERE CHARINDEX('-', Pawan_slug_name) > 0
),
SplitDigits AS (
    SELECT 
        e.Pawan_slug_name,
        e.Prefix,
        Digit = SUBSTRING(e.NumberPart, v.number, 1)
    FROM ExtractParts e
    JOIN master.dbo.spt_values v ON v.type = 'P' AND v.number BETWEEN 1 AND LEN(e.NumberPart)
),
FilteredDigits AS (
    SELECT 
        Pawan_slug_name,
        Prefix,
        Digit
    FROM (
        SELECT 
            Pawan_slug_name,
            Prefix,
            Digit,
            ROW_NUMBER() OVER (PARTITION BY Pawan_slug_name, Digit ORDER BY Digit) AS rn,
            COUNT(*) OVER (PARTITION BY Pawan_slug_name) AS digit_count
        FROM SplitDigits
    ) AS x
    WHERE rn = 1 AND digit_count > 1
),
Recombined AS (
    SELECT 
        Pawan_slug_name,
        Prefix + STRING_AGG(Digit, '') AS Cleaned_slug_name
    FROM FilteredDigits
    GROUP BY Pawan_slug_name, Prefix
)
SELECT 
    r.Pawan_slug_name,
    COALESCE(c.Cleaned_slug_name, 
             CASE 
                 WHEN LEN(RIGHT(r.Pawan_slug_name, LEN(r.Pawan_slug_name) - CHARINDEX('-', r.Pawan_slug_name))) = 1 
                 THEN LEFT(r.Pawan_slug_name, CHARINDEX('-', r.Pawan_slug_name)) 
                 ELSE r.Pawan_slug_name 
             END) AS FinalResult
FROM RemoveDuplicateIntsFromNames r
LEFT JOIN Recombined c ON r.Pawan_slug_name = c.Pawan_slug_name;
