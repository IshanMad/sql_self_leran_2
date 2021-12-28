
--SELECT DATA BASE
USE self_learn2;
--retrive the  all colums in CUSTOMER table
SELECT * FROM customers;
--use where caluse to filter data by customer id
SELECT * FROM customers WHERE customer_id = 1;

-- select with order by
SELECT * FROM customers ORDER BY first_name

--get specific colums using select caluse
SELECT first_name,last_name FROM customers;

--Arithmatics Expression
SELECT first_name,last_name,points,points + 10 AS bonus FROM customers;
--More example
SELECT 
	first_name,
    last_name,points,
    points * 10 + 100 AS 
	bonus 
 FROM customers;
--select specific colum
SELECT state FROM customers;
--remove duplicate values by using DISTINCT
SELECT DISTINCT state FROM customers;

