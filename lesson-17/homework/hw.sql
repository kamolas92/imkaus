--Lesson-17: Practice
--1. 
select
	r.region,
	d.distributor,
	isnull(rs.sales,0) as sales
from (
	select distinct region 
	from #regionsales
	) as r
cross join (
	select distinct distributor
	from #regionsales
	) as d
left join 
	#regionsales as rs
	on rs.region=r.region 
	and rs.distributor = d.distributor
order by  d.distributor;

--2. Find managers with at least five direct reports
select e.name
from employee as e
where e.id in (
	select managerid
	from employee
	where managerid is not null
	group by managerid
	having count (*) >= 5
	);

--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
select 
	p.product_name,
	sum(o.unit) as total_units
from 
	orders as o
join 
	products as p
on
	o.product_id=p.product_id
where 
	o.order_date between '2020-02-01' and '2020-02-29'
group by
	o.product_id,p.product_name
having
	sum(o.unit) >=100;

--4. Write an SQL statement that returns the vendor from which each customer has placed the most orders
;WITH VendorOrderCount AS (
    SELECT CustomerID, Vendor, COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY CustomerID, Vendor
),
RankedVendors AS (
    SELECT CustomerID, Vendor, OrderCount,
           RANK() OVER (PARTITION BY CustomerID ORDER BY OrderCount DESC) AS rank
    FROM VendorOrderCount
)
SELECT CustomerID, Vendor
FROM RankedVendors
WHERE rank = 1;

--5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'

DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;
IF @Check_Prime <= 1
    SET @IsPrime = 0;
ELSE
BEGIN
    WHILE @i * @i <= @Check_Prime
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';


--6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.

WITH DeviceStats AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SignalCount
    FROM Device
    GROUP BY Device_id, Locations
),
MostSignals AS (
    SELECT 
        Device_id,
        MAX(SignalCount) AS MaxSignal
    FROM DeviceStats
    GROUP BY Device_id
)
SELECT 
    d.Device_id,
    COUNT(d.Locations) AS Number_of_Locations,
    MAX(CASE WHEN ds.SignalCount = ms.MaxSignal THEN ds.Locations END) AS Most_Signals_Location,
    SUM(ds.SignalCount) AS Total_Signals
FROM DeviceStats ds
JOIN MostSignals ms ON ds.Device_id = ms.Device_id
JOIN (
    SELECT DISTINCT Device_id, Locations FROM Device
) d ON ds.Device_id = d.Device_id AND ds.Locations = d.Locations
GROUP BY d.Device_id;

--7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output
SELECT EmpID, EmpName, Salary
FROM Employee e
WHERE Salary >= (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);

--8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
WITH WinningTickets AS (
    SELECT Ticket_ID, COUNT(DISTINCT t.Number) AS MatchingNumbers
    FROM Tickets t
    JOIN WinningNumbers wn ON t.Number = wn.Number
    GROUP BY Ticket_ID
),
TotalWinnings AS (
    SELECT Ticket_ID,
           CASE 
               WHEN MatchingNumbers = (SELECT COUNT(*) FROM WinningNumbers) THEN 100
               WHEN MatchingNumbers > 0 THEN 10
               ELSE 0
           END AS Winnings
    FROM WinningTickets
)
SELECT SUM(Winnings) AS TotalWinnings
FROM TotalWinnings;

--9. The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.
;WITH UserSpending AS (
    SELECT 
        User_id,
        Spend_date,
        MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS UsedMobile,
        MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS UsedDesktop,
        SUM(Amount) AS TotalAmount
    FROM Spending
    GROUP BY User_id, Spend_date
),
ClassifiedSpending AS (
    SELECT 
        Spend_date,
        CASE 
            WHEN UsedMobile = 1 AND UsedDesktop = 1 THEN 'Both'
            WHEN UsedMobile = 1 THEN 'Mobile'
            WHEN UsedDesktop = 1 THEN 'Desktop'
        END AS Platform,
        TotalAmount
    FROM UserSpending
)
SELECT 
    Spend_date,
    Platform,
    COUNT(*) AS Total_users,
    SUM(TotalAmount) AS Total_Amount
FROM ClassifiedSpending
GROUP BY Spend_date, Platform
ORDER BY Spend_date, 
         CASE 
             WHEN Platform = 'Mobile' THEN 1
             WHEN Platform = 'Desktop' THEN 2
             WHEN Platform = 'Both' THEN 3
         END;

--10. Write an SQL Statement to de-group the following data.
;WITH  DeGrouped AS (
    SELECT Product, 1 AS Quantity, 1 AS RowNum
    FROM Grouped
    UNION ALL
    SELECT g.Product, 1, dg.RowNum + 1
    FROM Grouped g
    JOIN DeGrouped dg ON g.Product = dg.Product
    WHERE dg.RowNum < g.Quantity
)
SELECT Product, Quantity
FROM DeGrouped
ORDER BY Product, RowNum;

