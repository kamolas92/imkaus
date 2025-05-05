--Easy Tasks
--Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
SELECT 
  LTRIM(RTRIM(LEFT(Name, CHARINDEX(',', Name) - 1))) AS Name,
  LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
FROM TestMultipleColumns;

--Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
SELECT *
FROM TestPercent
WHERE Strs LIKE '%\%%' ESCAPE '\';

--In this puzzle you will have to split a string based on dot(.).(Splitter)
SELECT 
  LEFT(Vals, CHARINDEX('.', Vals) - 1) AS Part1,
  SUBSTRING(
    Vals,
    CHARINDEX('.', Vals) + 1,
    CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1) - CHARINDEX('.', Vals) - 1
  ) AS Part2,
  RIGHT(Vals, 
    LEN(Vals) - CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1)
  ) AS Part3
FROM Splitter;

--Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
SELECT 
  REPLACE(
    REPLACE(
      REPLACE(
        REPLACE(
          REPLACE(
            REPLACE(
              REPLACE(
                REPLACE(
                  REPLACE(
                    REPLACE('1234ABC123456XYZ1234567890ADS', '0', 'X'),
                  '1', 'X'),
                '2', 'X'),
              '3', 'X'),
            '4', 'X'),
          '5', 'X'),
        '6', 'X'),
      '7', 'X'),
    '8', 'X'),
  '9', 'X') AS ReplacedValue;

--Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
SELECT * 
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

--Write a SQL query to count the spaces present in the string.(CountSpaces)
SELECT LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

--write a SQL query that finds out employees who earn more than their managers.(Employee)
SELECT *
FROM Employee e
JOIN Employee m ON e.ManagerID = m.id
WHERE e.Salary > m.Salary;
--Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
SELECT 
    Employee_ID, 
    First_Name, 
    Last_Name, 
    Hire_Date, 
    DATEDIFF(YEAR, Hire_Date, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, Hire_Date, GETDATE()) > 10
  or DATEDIFF(YEAR, Hire_Date, GETDATE()) < 15;

--Medium Tasks
--Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
SELECT
    LEFT(Value, PATINDEX('%[0-9]%', Value + '0') - 1) AS CharacterValues,
    RIGHT(Value, LEN(Value) - PATINDEX('%[0-9]%', Value + '0') + 1) AS IntegerValues
FROM (SELECT 'rtcfvty34redt' AS Value) AS Example;

--write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
SELECT w1.ID, w1.recordDate, w1.Temperature
FROM weather w1
JOIN weather w2 
    ON w1.recordDate = DATEADD(DAY, 1, w2.recordDate)  
WHERE w1.Temperature > w2.Temperature;  

--Write an SQL query that reports the first login date for each player.(Activity)
SELECT Player_ID, MIN(event_date) AS FirstLoginDate
 FROM Activity
GROUP BY Player_ID;

--Your task is to return the third item from that list.(fruits)
SELECT fruit
FROM (VALUES 
    ('apple'),
    ('banana'),
    ('orange'),
    ('grape')
) AS fruits(fruit)
ORDER BY fruit
OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY;

--Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
CREATE TABLE CharacterTable (
    Character VARCHAR(1)
);
DECLARE @String VARCHAR(100) = 'sdgfhsdgfhs@121313131';
DECLARE @Length INT = LEN(@String);
DECLARE @Counter INT = 1;

WHILE @Counter <= @Length
BEGIN
    INSERT INTO CharacterTable (Character)
    VALUES (SUBSTRING(@String, @Counter, 1));
    
    SET @Counter = @Counter + 1;
END;

--You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
SELECT 
    p1.id,
    CASE 
        WHEN p1.code = 0 THEN p2.code
        ELSE p1.code
    END AS code
FROM p1
JOIN p2 ON p1.id = p2.id;

--Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:

SELECT 
    Employee_ID,
    Hire_Date,
    CASE
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) BETWEEN 1 AND 4 THEN 'Mid-Tier'
        WHEN DATEDIFF(YEAR, Hire_Date, GETDATE()) >= 5 THEN 'Veteran'
    END AS EmploymentStage
FROM Employees;

--Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
SELECT 
    Vals,
    LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'X') - 1) AS StartingInteger
FROM GetIntegers
WHERE PATINDEX('%[0-9]%', Vals) = 1;

--Difficult Tasks
--In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
SELECT
    Id,
    CONCAT(
        SUBSTRING(Vals, 2, 1), 
        SUBSTRING(Vals, 1, 1), 
        SUBSTRING(Vals, 3, LEN(Vals) - 2) 
    ) AS SwappedVals
FROM MultipleVals;


--Write a SQL query that reports the device that is first logged in for each player.(Activity)
SELECT player_id, device_id
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date ASC) AS rn
    FROM Activity
) AS ranked
WHERE rn = 1;

--You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
WITH DailySales AS (
    -- Step 1: Summarize sales per day for each area, week, and year
    SELECT
        Area,
        FinancialYear,
        FinancialWeek,
        DayName,
        DayOfWeek,
        SUM(ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0)) AS DailyTotal
    FROM WeekPercentagePuzzle
    GROUP BY Area, FinancialYear, FinancialWeek, DayName, DayOfWeek
),
WeeklyTotal AS (
    -- Step 2: Calculate total sales for each week and area
    SELECT
        Area,
        FinancialYear,
        FinancialWeek,
        SUM(DailyTotal) AS WeeklyTotal
    FROM DailySales
    GROUP BY Area, FinancialYear, FinancialWeek
)
-- Step 3: Calculate the daily sales percentage based on the weekly total
SELECT
    d.Area,
    d.FinancialYear,
    d.FinancialWeek,
    d.DayName,
    d.DayOfWeek,
    d.DailyTotal,
    w.WeeklyTotal,
    ROUND(CAST(d.DailyTotal AS FLOAT) / NULLIF(w.WeeklyTotal, 0) * 100, 2) AS DailyPercentage
FROM DailySales d
JOIN WeeklyTotal w
    ON d.Area = w.Area
    AND d.FinancialYear = w.FinancialYear
    AND d.FinancialWeek = w.FinancialWeek
ORDER BY d.Area, d.FinancialYear, d.FinancialWeek, d.DayOfWeek;
