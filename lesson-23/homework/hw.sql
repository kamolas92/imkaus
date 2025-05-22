--Puzzle 1:
select * from dates
select 
	*, 
	right('0'+cast(month(dt) as varchar(2)),2) as monthprefixedwithzero
from dates;
--Puzzle 2:
;with summaxcte as
	(select 
		id,
		rid,
		max(vals) as maxval
	from mytabel
	group by id,rid
)
select 
	(select count(distinct id) from mytabel) as distinctids,
	rid,
	(select sum(maxval)from summaxcte) as totalmaxvals
from
	summaxcte
group by
	rid;

--3.
select *
from TestFixLengths 
where len(vals)>=6 and len(vals)<=10;

--4.
select * from TestMaximum
select t.id,t.item,t.vals
from testmaximum as t
join (
select id, max(vals)as maxval
from testmaximum
group by id) as maxvals
on t.id=maxvals.id and t.vals=maxvals.maxval
order by t.id

--Puzzle 5:
SELECT
    Id,
    SUM(MaxVals) AS SumOfMaxVals
FROM
(
    SELECT
        Id,
        DetailedNumber,
        MAX(Vals) AS MaxVals
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS MaxPerDetail
GROUP BY Id
ORDER BY Id;

--6.
SELECT
  Id,
  a,
  b,
  CASE 
    WHEN a - b = 0 THEN ''
    ELSE cast(a - b as varchar(20))
  END AS Output
FROM TheZeroPuzzle;

--7.
select * from sales

SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;

--8.
SELECT AVG(UnitPrice) AS AverageUnitPrice
FROM Sales;

--9.
SELECT COUNT(*) AS TotalSalesTransactions
FROM Sales;

--10.
select max (quantitysold) as highestunitsold
from sales

--11.
SELECT 
    Category,
    SUM(QuantitySold) AS TotalProductsSold
FROM Sales
GROUP BY Category;

--12.
SELECT
    Region,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region;

--13.
SELECT TOP 1
    Product,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;

--14.
SELECT
    SaleID,
    SaleDate,
    Product,
    QuantitySold,
    UnitPrice,
    QuantitySold * UnitPrice AS Revenue,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS RunningTotalRevenue
FROM Sales
ORDER BY SaleDate;

--15.
SELECT
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    SUM(QuantitySold * UnitPrice) * 100.0 / (SELECT SUM(QuantitySold * UnitPrice) FROM Sales) AS RevenuePercentage
FROM Sales
GROUP BY Category;

select * from customers
--17.
SELECT 
    s.SaleID,
    s.Product,
    s.QuantitySold,
    s.UnitPrice,
    s.SaleDate,
    s.Region,
    c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;

--18.
SELECT *
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.CustomerID IS NULL;

--19.
SELECT 
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName;

--20.
SELECT TOP 1 
    c.CustomerName,
    SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;

--21.
SELECT 
    c.CustomerName,
    SUM(s.QuantitySold) AS TotalUnitsSold
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName;


--22. 
SELECT DISTINCT p.ProductName
FROM Products p
JOIN Sales s ON p.ProductName = s.Product;

--23.
SELECT TOP 1 *
FROM Products
ORDER BY SellingPrice DESC;

--24.
SELECT *
FROM Products p
WHERE SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products
    WHERE Category = p.Category
);
