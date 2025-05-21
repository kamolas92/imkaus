--HOMEWORK18--
--1. 
SELECT * FROM #monthlysales 
SELECT 
	s.ProductID,
	p.productname,
	SUM(s.quantity) AS totalquantity,
	SUM(s.quantity*p.price) AS totalrevenue
INTO #monthlysales
FROM sales AS s
JOIN products AS p
ON p.ProductID=s.ProductID
WHERE s.SaleDate <= DATEFROMPARTS(year(getdate()),month(getdate()),1) and s.SaleDate > DATEADD(month,1,datefromparts(year(getdate()),month(getdate()),1))
GROUP BY s.ProductID,p.ProductName;

--2.
CREATE VIEW vw_productsalessummary
AS
SELECT p.ProductID,p.ProductName,sum(s.Quantity) as totalquantitysold
FROM products as p
JOIN sales as s
ON p.ProductID=s.ProductID
GROUP by P.ProductID, p.ProductName,p.Category;
SELECT * FROM vw_productsalessummary

--3.
CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
DECLARE @totalrevenue decimal(10,2)

SELECT @totalrevenue = sum(s.quantity*p.price) 
FROM sales as s
JOIN Products as p on p.ProductID=s.ProductID
WHERE s.productid=@productid
RETURNS isnull(@totalrevenue,0)
END;
SELECT dbo.fn_GetTotalRevenueForProduct(1) AS RevenueForProduct1;

--4.
CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
SELECT p.ProductName, 
ISNULL(sum(s.quantity*p.price),0) as totalrevenue,
ISNULL(sum(s.quantity),0) as totalquantity
FROM sales as s
LEFT join products as p
ON s.ProductID=p.ProductID
WHERE p.category=@Category
GROUP by p.ProductName
)
SELECT * FROM dbo.fn_GetSalesByCategory('Electronics');

--5.
CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    IF @Number < 2
        RETURN 'No';

    DECLARE @i INT = 2;

    WHILE @i * @i <= @Number
    BEGIN
        IF (@Number % @i) = 0
            RETURN 'No';
        SET @i = @i + 1;
    END

    RETURN 'Yes';
END;
SELECT dbo.fn_IsPrime(7);  -- Yes
SELECT dbo.fn_IsPrime(10); -- No

--6.
CREATE FUNCTION fn_GetNumbersBetween (@Start INT, @End INT)
RETURNS TABLE
AS
RETURN
(
    WITH NumbersCTE AS (
        SELECT @Start AS Number
        WHERE @Start <= @End

        UNION ALL

        SELECT Number + 1
        FROM NumbersCTE
        WHERE Number + 1 <= @End
    )
    SELECT Number FROM NumbersCTE
);
SELECT * FROM dbo.fn_GetNumbersBetween(5, 10);

7.
CREATE FUNCTION dbo.getNthHighestSalary(@n INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;

    SELECT @result = (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        OFFSET @n - 1 ROWS FETCH NEXT 1 ROW ONLY
    );

    RETURN @result;
END;
SELECT * from dbo.getNthHighestSalary(2) AS [getNthHighestSalary(2)];
CREATE FUNCTION dbo.getNthHighestSalary(@n INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;

    WITH RankedSalaries AS (
        SELECT salary,
               ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
        FROM (SELECT DISTINCT salary FROM Employee) AS distinct_salaries
    )
    SELECT @result = salary
    FROM RankedSalaries
    WHERE rn = @n;

    RETURN @result;
END;

--8.
WITH AllFriends AS (
    -- List each friendship twice: once for requester, once for accepter
    SELECT requester_id AS user_id, accepter_id AS friend_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS user_id, requester_id AS friend_id
    FROM RequestAccepted
),
FriendCounts AS (
    SELECT user_id, COUNT(DISTINCT friend_id) AS num_friends
    FROM AllFriends
    GROUP BY user_id
)
SELECT TOP 1 user_id AS id, num_friends AS num
FROM FriendCounts
ORDER BY num_friends DESC;

--9.
CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    ISNULL(SUM(o.amount), 0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.name;
SELECT * FROM vw_CustomerOrderSummary;


--10.
SELECT rownumber,
(SELECT MAX(testcase)
FROM gaps AS g2
WHERE g2.rownumber<=g1.rownumber) AS result
FROM gaps AS g1;


