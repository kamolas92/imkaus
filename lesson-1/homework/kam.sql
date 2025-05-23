--LESSON1 HOMEWORK
--Lesson 1: Introduction to SQL Server and SSMS
--EASY
--1.Define the following terms: data, database, relational database, and table.
--DATA is information that we can see numbers,texts,graphs, facts, information can be measurment and observations. 
--Data is the raw information or facts of all these factories that are mentioned above.
--DATA is known from a word DATUM which means is single piece of information that can be any name in consideration.
--DATABASE is a systematic collection of Data. DATABASES make management easy, one set of Software Program Provides access of Data to all the Users.
--Database operates large amount of information by storing, retrieving  and managing Data. Many dinamic website on the WWW. which are held through Databases.
--Relational Database has been around for almost 50 years that is uses tables by providing the structure of realting two or more tables together by describing through particular entity  or relationships. Benefits are consistency, stored procedures and locking with concurency.
--Table is a collection of related Data in an organized manner from rows and columns. an organized arrangement of data and infro in the tabular form containing rows and columns by making it easy to understand and compare data.

--2.List five key features of SQL Server.
--High Availability & Disaster Recovery (HADR), Security & Compliance, Performance Optimization, Scalability & Flexibility, Business Intelligence & Analytics.

--3.What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
--SQL Server provides two main authentication modes for connecting to the database: Windows Authentication Mode and SQL Server Authentication Mode
 
 --Medium
 --4.Create a new database in SSMS named SchoolDB.
CREATE DATABASE SchoolDB

--5.Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
CREATE TABLE Students(
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT
);
SELECT * FROM Students

--6.Describe the differences between SQL Server, SSMS, and SQL.
--SQL SERVER is like a library where all data is stored. Relational Database management system developed by Microsoft. The Server that manages and stores data.
--SSMS (SQLServerManagementSystem) is the librarian that helps you interact with the database easily. this is the tool that we interact with and connect to SQL server.
--SQL is structured query language is a programming language for sorting and processing database in relational database. SQL is the language you use to ask the librarian for books which are queries in sql to retrieve or modify data.

--HARD
--7.Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
--SQL COMMANDS are instructions, which is used to communicate with database. it is also used to perform, specific tasks, functions and queries of data.
-- DQL is used to fetch data from Database and only uses command SELECT.
--DML is uses commands INSERT,UPDATE,DELETE. these commands are used to modify the database, it is responsible for all form of changes in Database. this command is not auto committed which means it cannot permanently save all the changes in Database.
--DDL uses commmands as CREATE,DROP,ALTER,TRUNCATE,RENAME. Changes the structure of the table like creating table.. all the commmands of DDL are auto committed that are permanently saves all the changes in the system.
--DCL commands are used to grant and take back authority from any database users. uses commands as GRANT, REVOKE.
--TCL commmands can only use with DML commmands as INSERT,DELETE,UPDATE only. operations are automatically committed in the DATABASE. commands are COMMIT,ROLLBACK,SAVEPOINT.

--8. Write a query to insert three records into the Students table.
INSERT INTO Students (StudentID,Name,Age) VALUES (100,'Imron',22), (101,'Kamron',24), (102,'Usmon',26);
SELECT* FROM Students

--9. Create a backup of your SchoolDB database and restore it. (write its steps to submit)
BACKUP DATABASE SchoolDB TO DISK = 'C:\BACKUP\SCHOOLDB.BAK';
SELECT @@SERVERNAME
SELECT @@SERVICENAME
RESTORE DATABASE SchoolDB FROM DISK = 'C:\Backup\SchoolDB.bak';
