 --1.
SELECT * 
FROM
	employees
WHERE 
	salary =(
		SELECT MIN(salary) FROM employees
		);
--2. 
SELECT *
FROM
	products
WHERE 
	price > (
		SELECT AVG(price) FROM products
		);
--3.
SELECT * FROM employees AS e
WHERE  exists
	(SELECT *
	FROM departments AS d 
	WHERE e.department_id=d.id and  d.department_name = 'sales'
	);


--4.
SELECT *
FROM customers AS c
WHERE not exists 
	(SELECT * 
	FROM orders AS o
	WHERE c.customer_id=o.customer_id
	);

--5. 
SELECT * FROM products AS p
WHERE p.price = (SELECT MAX(p1.price)
					FROM products AS p1 
					WHERE p.category_id=p1.category_id
					);

--6.
SELECT *
FROM 
	employees as e
JOIN 
	departments as d
ON
	E.id = d.id
WHERE e.salary > 
	(SELECT AVG(E1.salary) FROM employees as e1 WHERE e.department_id =e1.department_id
	);
 
--7. 
 SELECT *
FROM 
	employees AS E
WHERE salary >= 
	(SELECT avg(salary)
		FROM employees
		WHERE department_id = E.department_id
		);

--8. 
SELECT *
FROM 
	GRADES AS G
JOIN 
	STUDENTS AS S
ON 
	g.student_id=s.student_id
WHERE g.GRADE = (
	SELECT MAX(g1.GRADE)FROM GRADEs as g1 where g1.course_id=g.course_id
	);

--9. 
SELECT 
	*
FROM
	PRODUCTS AS P
WHERE 3 = (
	SELECT COUNT(PRICE) 
	FROM PRODUCTS AS P1 
	WHERE P.PRICE<=P1.PRICE AND
	P.CATEGORY_ID=P1.CATEGORY_ID
	);

--10.
SELECT *
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary) FROM employees
)
AND e.salary < (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e.department_id = e2.department_id
);


