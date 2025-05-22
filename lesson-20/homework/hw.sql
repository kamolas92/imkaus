--1. Find customers who purchased at least one item in March 2024 using EXISTS
SELECT DISTINCT S.customername
FROM #sales as S
WHERE EXISTS (
SELECT 1
FROM #sales as sa
WHERE sa.customername = s.customername
AND sa.saledate>='2024-03-01'
AND sa.saledate<'2024-04-01'
);

--2. Find the product with the highest total sales revenue using a subquery.
SELECT product, sum(quantity*price) as totalrevenue
FROM #sales 
GROUP by product
HAVING sum(quantity*price) = (
SELECT max(totalrev)
FROM( 
SELECT product,sum(quantity*price) as totalrev
FROM #sales
GROUP by product
) AS revenueperproduct
);

--3. Find the second highest sale amount using a subquery
SELECT MAX(QUANTITY*PRICE)AS SECONDHIGHESTSALE
FROM #SALES
WHERE QUANTITY*PRICE < (
SELECT MAX(QUANTITY*PRICE)
FROM #SALES);

--4. Find the total quantity of products sold per month using a subquery
 SELECT DISTINCT
 MONTH(SALEDATE) AS SALEMONTH,
 ( SELECT SUM(QUANTITY)
 FROM #SALES AS S2
 WHERE MONTH(S2.SALEDATE) = MONTH(S1.SALEDATE)
 ) AS TOTALQUANTITY
 FROM #SALES AS S1;

--5. Find customers who bought same products as another customer using EXISTS
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.Product = s1.Product
      AND s2.CustomerName = s1.CustomerName
);

--6. Return how many fruits does each person have in individual fruit level
SELECT 
    Name,
    COUNT(CASE WHEN Fruit = 'Apple' THEN 1 END) AS Apple,
    COUNT(CASE WHEN Fruit = 'Orange' THEN 1 END) AS Orange,
    COUNT(CASE WHEN Fruit = 'Banana' THEN 1 END) AS Banana
FROM Fruits
GROUP BY Name
ORDER BY Name;

--7.
WITH RecursiveFamily AS (
    -- Base case: direct parent-child relationship
    SELECT ParentId AS PID, ChildID AS CHID
    FROM Family

    UNION ALL

    -- Recursive case: find indirect descendants
    SELECT rf.PID, f.ChildID
    FROM RecursiveFamily rf
    JOIN Family f ON rf.CHID = f.ParentId
)
SELECT PID, CHID
FROM RecursiveFamily
ORDER BY PID, CHID;

--8.
SELECT * FROM #ORDERS
SELECT CustomerID, OrderID, DeliveryState, Amount
FROM #Orders o1
WHERE DeliveryState = 'TX'
  AND EXISTS (
    SELECT 1
    FROM #Orders o2
    WHERE o2.CustomerID = o1.CustomerID
      AND o2.DeliveryState = 'CA'
  );
--9.
UPDATE #residents
SET fullname = LTRIM(RTRIM(SUBSTRING(
    address,
    CHARINDEX('name=', address) + 5,
    CHARINDEX(' ', address + ' ', CHARINDEX('name=', address) + 5) - (CHARINDEX('name=', address) + 5)
)))
WHERE (fullname IS NULL OR fullname = '')
  AND CHARINDEX('name=', address) > 0;

  --10.
-- Route 1: Tashkent -> Samarkand -> Khorezm
SELECT 
    'Tashkent - Samarkand - Khorezm' AS Route,
    r1.Cost + r2.Cost AS Cost
FROM #Routes r1
JOIN #Routes r2 ON r1.ArrivalCity = r2.DepartureCity
WHERE r1.DepartureCity = 'Tashkent' 
  AND r1.ArrivalCity = 'Samarkand'
  AND r2.ArrivalCity = 'Khorezm'

UNION ALL

-- Route 2: Tashkent -> Jizzakh -> Samarkand -> Bukhoro -> Khorezm
SELECT
    'Tashkent - Jizzakh - Samarkand - Bukhoro - Khorezm' AS Route,
    r1.Cost + r2.Cost + r3.Cost + r4.Cost AS Cost
FROM #Routes r1
JOIN #Routes r2 ON r1.ArrivalCity = r2.DepartureCity
JOIN #Routes r3 ON r2.ArrivalCity = r3.DepartureCity
JOIN #Routes r4 ON r3.ArrivalCity = r4.DepartureCity
WHERE r1.DepartureCity = 'Tashkent' 
  AND r1.ArrivalCity = 'Jizzakh'
  AND r2.ArrivalCity = 'Samarkand'
  AND r3.ArrivalCity = 'Bukhoro'
  AND r4.ArrivalCity = 'Khorezm';

  --11.
SELECT
    ID,
    Vals,
    CASE WHEN Vals = 'Product' THEN
        ROW_NUMBER() OVER (ORDER BY ID)
    END AS ProductRank
FROM #RankingPuzzle
ORDER BY ID;

--12.

SELECT EmployeeID, EmployeeName, Department, SalesAmount
FROM #EmployeeSales es
WHERE SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = es.Department
)
ORDER BY Department, SalesAmount DESC;

--13.
SELECT DISTINCT es1.EmployeeID, es1.EmployeeName, es1.Department, es1.SalesAmount, es1.SalesMonth, es1.SalesYear
FROM #EmployeeSales es1
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales es2
    WHERE es2.SalesMonth = es1.SalesMonth
      AND es2.SalesYear = es1.SalesYear
    GROUP BY es2.SalesMonth, es2.SalesYear
    HAVING es1.SalesAmount = MAX(es2.SalesAmount)
);

--14.
-- Find employees who made sales in every month of 2024
SELECT DISTINCT es.EmployeeID, es.EmployeeName
FROM #EmployeeSales es
WHERE NOT EXISTS (
    -- Check if there's any month from 1 to 12 where this employee did NOT make a sale
    SELECT 1
    FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12)) AS Months(MonthNum)
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales es2
        WHERE es2.EmployeeID = es.EmployeeID
          AND es2.SalesYear = 2024
          AND es2.SalesMonth = Months.MonthNum
    )
)
AND es.SalesYear = 2024;

--15.
SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);
--16.
SELECT Name, Stock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);
--17.
SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');
--18.
SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);
--19.
SELECT ProductID, Name, Category, Price
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);
--20.
SELECT ProductID, Name, Category, Price, Stock
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);


--21.
SELECT p.Name
FROM Products p
JOIN (
    SELECT ProductID, SUM(Quantity) AS TotalQuantity
    FROM Orders
    GROUP BY ProductID
) o ON p.ProductID = o.ProductID
WHERE o.TotalQuantity > (
    SELECT AVG(TotalQuantity)
    FROM (
        SELECT SUM(Quantity) AS TotalQuantity
        FROM Orders
        GROUP BY ProductID
    ) AS sub
);

--22.
SELECT ProductID, Name, Category, Price, Stock
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);


--23.
WITH ProductTotals AS (
    SELECT p.ProductID, p.Name, SUM(o.Quantity) AS TotalQuantity
    FROM Products p
    JOIN Orders o ON p.ProductID = o.ProductID
    GROUP BY p.ProductID, p.Name
)
SELECT ProductID, Name, TotalQuantity
FROM ProductTotals
WHERE TotalQuantity = (SELECT MAX(TotalQuantity) FROM ProductTotals);


