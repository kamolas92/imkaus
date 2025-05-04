--Easy Tasks
--1.	You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
SELECT 
	CONCAT(employee_id, '-',first_name,space(1),last_name) as Output
FROM 
	employees
WHERE
	employee_id = 100;

--2.	Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
UPDATE Employees
SET PHONE_NUMBER =  REPLACE(PHONE_NUMBER,'124','999')
WHERE PHONE_NUMBER LIKE '%124%'

--3.	That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. 
--Give each column an appropriate label. Sort the results by the employees' first names.(Employees)
SELECT 
    FIRST_NAME AS [First Name],
    LEN(FIRST_NAME) AS [Name Length]
FROM 
    Employees
WHERE 
    LEFT(FIRST_NAME, 1) IN ('A', 'J', 'M')
ORDER BY 
    FIRST_NAME;

--4.	Write an SQL query to find the total salary for each manager ID.(Employees table)
SELECT 
    CAST(MANAGER_ID AS VARCHAR) AS [Manager ID],
    SUM(Salary) AS [Total Salary]
FROM 
    Employees
GROUP BY 
    MANAGER_ID;

--5.	Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
SELECT 
    Year1,
    CAST(
        CASE 
            WHEN Max1 >= Max2 AND Max1 >= Max3 THEN Max1
            WHEN Max2 >= Max1 AND Max2 >= Max3 THEN Max2
            ELSE Max3
        END AS VARCHAR
    ) AS HighestValue
FROM 
    TestMax;

--6.	Find me odd numbered movies and description is not boring.(cinema)
SELECT 
    *
FROM 
    Cinema
WHERE 
    ID % 2 = 1 
    AND LOWER(Description) <> 'boring' 
	AND TRIM(LOWER(Description)) <> 'boring';

--7.	You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)
SELECT 
    *
FROM 
    SingleOrder
ORDER BY 
    CASE 
        WHEN Id = 0 THEN 'ZZZ' 
        ELSE CAST(Id AS VARCHAR) 
    END;

--8.	Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person)
SELECT 
    COALESCE(CAST(id AS VARCHAR), CAST(ssn AS VARCHAR), CAST(passportid AS VARCHAR)) AS FirstNonNullValue
FROM 
    Person;

--9.	Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date, rounded to two decimal places).(Employees)
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    CAST(ROUND(DATEDIFF(CURRENT_DATE, HIRE_DATE) / 365.0, 2) AS VARCHAR) AS YearsOfService
FROM 
    Employees
WHERE 
    DATEDIFF(CURRENT_DATE,HIRE_DATE) / 365.0 > 10
    AND DATEDIFF(CURRENT_DATE,HIRE_DATE) / 365.0 < 15;

--10.	Find the employees who have a salary greater than the average salary of their respective department.(Employees)
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    DEPARTMENT_ID,
    Salary,
    CAST(Salary AS VARCHAR) AS SalaryAsString
FROM 
    Employees E
WHERE 
    Salary > (
        SELECT AVG(Salary)
        FROM Employees
        WHERE DEPARTMENT_ID = E.DEPARTMENT_ID
    );

--Medium Tasks
--1.Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
SELECT
  FullName,
  LEFT(FullName, CHARINDEX(' ', FullName) - 1) AS FirstName,

  CASE
    WHEN LEN(FullName) - LEN(REPLACE(FullName, ' ', '')) >= 2 THEN
      SUBSTRING(
        FullName,
        CHARINDEX(' ', FullName) + 1,
        CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1
      )
    ELSE NULL
  END AS MiddleName,

  RIGHT(
    FullName,
    CHARINDEX(' ', REVERSE(FullName)) - 1
  ) AS LastName

FROM Students;

--2.For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)
SELECT *
FROM Orders
WHERE DeliveryState = 'TX'
  AND CustomerID IN (
      SELECT DISTINCT CustomerID
      FROM Orders
      WHERE DeliveryState = 'CA'
  );
--3.Write an SQL statement that can group concatenate the following values.(DMLTable)
SELECT STRING_AGG(String, ', ') AS ConcatenatedValues
FROM DMLTable;

--4.Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
SELECT FIRST_NAME,LAST_NAME
FROM Employees
WHERE LEN(LOWER(FIRST_NAME + LAST_NAME))  - LEN(REPLACE(LOWER(FIRST_NAME + LAST_NAME), 'a', '')) >= 3;

--5.The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
select * from Employees
SELECT 
    d.DEPARTMENT_ID,
    COUNT(e.EMPLOYEE_ID) AS TotalEmployees,
    COUNT(CASE 
              WHEN DATEDIFF(YEAR, e.HIRE_DATE, GETDATE()) > 3 
              THEN 1 
         END) AS EmployeesOver3Years,
    CAST(COUNT(CASE 
                  WHEN DATEDIFF(YEAR, e.HIRE_DATE, GETDATE()) > 3 
                  THEN 1 
             END) * 100.0 / COUNT(e.EMPLOYEE_ID) AS DECIMAL(5,2)) AS PercentageOver3Years
FROM 
    Employees e
JOIN 
   Employees d ON e.Department_ID = d.Department_ID
GROUP BY 
    d.DEPARTMENT_ID;

--6.Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
select * from Personal
select
WITH personal AS (
    SELECT
        SpacemanID,
        JobDescription,
        MissionCount,
        ROW_NUMBER() OVER (PARTITION BY JobDescription ORDER BY StartDate ASC) AS MostExperiencedRank,
        ROW_NUMBER() OVER (PARTITION BY JobDescription ORDER BY StartDate DESC) AS LeastExperiencedRank
    FROM Personal
)
SELECT
    JobDescription,
    MAX(CASE WHEN MostExperiencedRank = 1 THEN SpacemanID END) AS MostExperiencedSpaceman,
    MAX(CASE WHEN LeastExperiencedRank = 1 THEN SpacemanID END) AS LeastExperiencedSpaceman
FROM Personal
GROUP BY JobDescription;

--Difficult Tasks
--1.
DECLARE @input NVARCHAR(100) = 'tf56sd#%OqH';
WITH Numbers AS (
    SELECT TOP (LEN('tf56sd#%OqH'))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects 
),
Chars AS (
    SELECT
        SUBSTRING('tf56sd#%OqH', n, 1) AS Char,
        n
    FROM Numbers
)
SELECT
    STRING_AGG(CASE WHEN Char LIKE '[A-Z]' THEN Char END, '') AS UppercaseLetters,
    STRING_AGG(CASE WHEN Char LIKE '[a-z]' THEN Char END, '') AS LowercaseLetters,
    STRING_AGG(CASE WHEN Char LIKE '[0-9]' THEN Char END, '') AS Numbers
FROM Chars;

--2.
Select
    StudentID,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeSum
FROM Students;

--3.
SELECT SUM(CASE 
                WHEN Equation LIKE '%+%' THEN 
                    CAST(SUBSTRING(Equation, 1, CHARINDEX('+', Equation) - 1) AS INT) + 
                    CAST(SUBSTRING(Equation, CHARINDEX('+', Equation) + 1, LEN(Equation)) AS INT)
                WHEN Equation LIKE '%-%' THEN 
                    CAST(SUBSTRING(Equation, 1, CHARINDEX('-', Equation) - 1) AS INT) - 
                    CAST(SUBSTRING(Equation, CHARINDEX('-', Equation) + 1, LEN(Equation)) AS INT)
                WHEN Equation LIKE '%*%' THEN 
                    CAST(SUBSTRING(Equation, 1, CHARINDEX('*', Equation) - 1) AS INT) * 
                    CAST(SUBSTRING(Equation, CHARINDEX('*', Equation) + 1, LEN(Equation)) AS INT)
                WHEN Equation LIKE '%/%' THEN 
                    CAST(SUBSTRING(Equation, 1, CHARINDEX('/', Equation) - 1) AS INT) / 
                    CAST(SUBSTRING(Equation, CHARINDEX('/', Equation) + 1, LEN(Equation)) AS INT)
                ELSE 0
            END) AS TotalSum
FROM Equations;


--4.
SELECT 
    s1.StudentName,
    s1.Birthday
FROM 
    Student s1
JOIN 
    (
        SELECT Birthday
        FROM Student
        GROUP BY Birthday
        HAVING COUNT(*) > 1
    ) s2 ON s1.Birthday = s2.Birthday
ORDER BY s1.Birthday, s1.StudentName;
--5.
SELECT 
    CASE
        WHEN PlayerA < PlayerB THEN PlayerA + '-' + PlayerB
        ELSE PlayerB + '-' + PlayerA
    END AS PlayerPair,
    SUM(Score) AS TotalScore
FROM 
    PlayerScores
GROUP BY 
    CASE
        WHEN PlayerA < PlayerB THEN PlayerA + '-' + PlayerB
        ELSE PlayerB + '-' + PlayerA
    END
ORDER BY PlayerPair;
