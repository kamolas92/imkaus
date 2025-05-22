--homework21--
--Write a query to assign a row number to each sale based on the SaleDate.
select saleid,saledate,
		ROW_NUMBER() over(order by saledate desc) as rn
from productsales;

--Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.
select productname,
	sum(quantity) as totalquantity,
	dense_rank() over(order by sum(quantity) desc) as drnk
from productsales
group by productname;

--Write a query to identify the top sale for each customer based on the SaleAmount.
;with cte as (
select customerid,saleamount,
dense_rank() over(partition by customerid order by saleamount desc) as drnk
from productsales) 
select * from cte
where cte.drnk=1;

--Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.
select 
	*,
	isnull(lead(saleamount) over (order by saledate),0) as nextsalea
from productsales;

--Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.
select *,
	isnull(lag(saleamount) over(order by saledate),0) as prvsale
from productsales;
	
--Write a query to identify sales amounts that are greater than the previous sale's amount
;with cteprvs as (
SELECT 
    SaleID,
    SaleDate,
    saleAmount AS CurrentAmount,
    LAG(saleAmount) OVER (ORDER BY SaleDate) AS PreviousAmount
FROM productsales) 
select * from cteprvs
WHERE cteprvs.CurrentAmount > cteprvs.PreviousAmount;

--Write a query to calculate the difference in sale amount from the previous sale for every product
SELECT 
    SaleID,
    SaleDate,
    saleAmount AS CurrentAmount,
    isnull(LAG(saleAmount) OVER (partition BY productname order by SaleDate),0) AS PreviousAmount,
	isnull(saleamount - LAG(saleAmount) OVER (partition BY productname order by SaleDate),0) as amountdiff
FROM productsales;

--Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
SELECT 
    SaleID,
    SaleDate,
    saleAmount AS CurrentAmount,
    Lead(saleAmount) OVER (partition BY productname order by SaleDate) AS PreviousAmount,
	saleamount / Lead(saleAmount) OVER (partition BY productname order by SaleDate) * 100 - 100 as amountdiff
	FROM productsales;

--Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
select * from productsales
SELECT 
    productname,
	saleid,
	saledate,
    saleAmount AS CurrentAmount,
    lag(saleAmount) OVER (PARTITION BY Productname ORDER BY SaleDate) AS PreviousAmount,
    saleamount/ lag(saleAmount) OVER (PARTITION BY Productname ORDER BY SaleDate)
    AS AmountRatio
FROM productSales;

--Write a query to calculate the difference in sale amount from the very first sale of that product.
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DifferenceFromFirstSale
FROM 
    ProductSales
ORDER BY
    ProductName, SaleDate;

--Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).
WITH SalesWithPrev AS (
    SELECT
        SaleID,
        ProductName,
        SaleDate,
        SaleAmount,
        LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSaleAmount
    FROM
        ProductSales
)
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    PrevSaleAmount
FROM
    SalesWithPrev
WHERE
    SaleAmount > PrevSaleAmount
ORDER BY
    ProductName, SaleDate;


--Write a query to calculate a "closing balance"(running total) for sales amounts which adds the current sale amount to a running total of previous sales.
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS ClosingBalance
FROM
    ProductSales
ORDER BY
    ProductName, SaleDate;

--Write a query to calculate the moving average of sales amounts over the last 3 sales.
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER (
        PARTITION BY ProductName 
        ORDER BY SaleDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg_Last3Sales
FROM
    ProductSales
ORDER BY
    ProductName, SaleDate;

--Write a query to show the difference between each sale amount and the average sale amount.
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvgSale
FROM
    ProductSales
ORDER BY
    SaleDate;

--Find Employees Who Have the Same Salary Rank
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM
    Employees1
ORDER BY
    SalaryRank, Salary DESC;

--Identify the Top 2 Highest Salaries in Each Department
WITH RankedSalaries AS (
    SELECT
        EmployeeID,
        Name,
        Department,
        Salary,
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RowNum
    FROM
        Employees1
)
SELECT
    EmployeeID,
    Name,
    Department,
    Salary
FROM
    RankedSalaries
WHERE
    RowNum <= 2
ORDER BY
    Department, Salary DESC;

--Find the Lowest-Paid Employee in Each Department
WITH RankedSalaries AS (
    SELECT
        EmployeeID,
        Name,
        Department,
        Salary,
        RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS RankNum
    FROM
        Employees1
)
SELECT
    EmployeeID,
    Name,
    Department,
    Salary
FROM
    RankedSalaries
WHERE
    RankNum = 1
ORDER BY
    Department;

--Calculate the Running Total of Salaries in Each Department
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    HireDate,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS UNBOUNDED PRECEDING) AS RunningTotalSalary
FROM
    Employees1
ORDER BY
    Department, HireDate;

--Find the Total Salary of Each Department Without GROUP BY
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalSalaryByDepartment
FROM
    Employees1
ORDER BY
    Department, EmployeeID;

--Calculate the Average Salary in Each Department Without GROUP BY
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgSalaryByDepartment
FROM
    Employees1
ORDER BY
    Department, EmployeeID;

--Find the Difference Between an Employee’s Salary and Their Department’s Average
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM
    Employees1
ORDER BY
    Department, EmployeeID;

--Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        PARTITION BY Department
        ORDER BY EmployeeID
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary_3Employees
FROM
    Employees1
ORDER BY
    Department, EmployeeID;

--Find the Sum of Salaries for the Last 3 Hired Employees
WITH RankedEmployees AS (
    SELECT
        EmployeeID,
        Name,
        Department,
        Salary,
        HireDate,
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY HireDate DESC) AS HireRank
    FROM Employees1
)
SELECT
    Department,
    SUM(Salary) AS SumLast3HiredSalaries
FROM
    RankedEmployees
WHERE
    HireRank <= 3
GROUP BY
    Department
ORDER BY
    Department;
