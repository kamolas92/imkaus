--1. Combine Two Tables
SELECT 
	p.firstname,
	p.lastname,
	a.city,
	a.state
FROM
	person AS p
LEFT JOIN
	address AS a
ON
	p.personid=a.personid
;

--2. Employees Earning More Than Their Managers
SELECT 
	e.name
FROM
	employee AS e
LEFT JOIN
	employee AS m
ON
	e.managerid=m.id
WHERE
	e.salary>m.salary
;
--3. Duplicate Emails
SELECT
	email
FROM
	person
GROUP BY
	email
HAVING
	COUNT (*) > 1
;
--4.Delete Duplicate Emails
DELETE FROM 
	Person
WHERE id NOT IN (
    SELECT id FROM (
        SELECT MIN(id) AS id
        FROM Person
        GROUP BY email
    ) AS temp
);


--5. Find those parents who has only girls.
SELECT
	DISTINCT g.ParentName
FROM girls AS g
WHERE g.ParentName not in ( 
					SELECT DISTINCT b.parentname 
					FROM boys AS b);

--6. Total over 50 and least
SELECT 
    CustID,
    SUM(CASE WHEN Weight > 50 THEN SalesAmount ELSE 0 END) AS TotalSalesOver50,
    MIN(Weight) AS LeastWeight
FROM 
    Sales.Orders
GROUP BY 
    CustID;


--7.CARTS
SELECT 
	ISNULL(c1.item,' ')AS itemcart_1,
	ISNULL(c2.item,' ')AS itemcart_2
FROM
	cart1 AS c1
FULL JOIN 
	cart2 AS c2
ON
	c1.item=c2.item
;

--8. Customers Who Never Order
SELECT
	C.NAME
FROM
	CUSTOMERS AS C
LEFT JOIN
	ORDERS AS O
ON 
	C.ID=O.CUSTOMERID
WHERE 
	O.ID IS NULL
;

--9. Students and Examinations
SELECT 
    s.student_id,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM 
    Students s
CROSS JOIN 
    Subjects sub
LEFT JOIN 
    Examinations e 
    ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id, sub.subject_name
ORDER BY 
    s.student_id, sub.subject_name;
