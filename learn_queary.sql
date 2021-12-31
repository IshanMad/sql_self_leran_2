
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
--EXERCISE
--return all the fk_order_items_products
SELECT * FROM products;
--RETURN ALL THER PRODUCTS NAME ,UNIT PRICE ,NEW PRICE (UNIT PRICE *1.1)
SELECT name,unit_price,unit_price * 1.1 AS new_price FROM products;
--WHERE CALUES IN SQL
SELECT * FROM customers WHERE points > 3000;
--select all customers in the vergina
SELECT * FROM customers WHERE state = "VA";
--select all customer igrone the vargina Sate using not equal operater
SELECT * FROM customers WHERE state != "VA";
--select some customers using thier birth_date
SELECT * FROM customers WHERE birth_date > '1990-01-01';
--get the oders placed this year 
SELECT * FROM ORDERS WHERE order_date >= '2019-01-01';

--AND,OR AND NOT OPERATORS 
--AND
SELECT * FROM ORDERS WHERE order_date >= '2019-01-01' AND points > 1000;
--OR
SELECT * FROM customers WHERE order_date >= '2019-01-01' OR points > 1000;
--AGIAN USING AND
SELECT * FROM customers WHERE birth_date > '1990-01-01' OR points > 1000 AND state = "VA";

SELECT * FROM customers WHERE birth_date > '1990-01-01' OR points > 1000 AND state = "VA";

--NOT OPERATOR
SELECT * FROM customers WHERE NOT (birth_date > '1990-01-01' OR points > 1000);
--above query same result without NOT operator
SELECT * FROM customers WHERE birth_date <= '1990-01-01' AND points <= 1000;
--from the order items table,get the items for order #6 where the total price grater than 30 
SELECT * FROM order_items WHERE order_id = 6 AND unit_price * quantity >30;
-- repalce OR operater query by using in operater
SELECT * FROM customerS WHERE state ='VA' OR state ='GA' OR state ='FL'; 
--repalece by using
SELECT * FROM customers WHERE state IN('VA','GA','FL');
--NOT IN Operater
SELECT * FROM customers WHERE state NOT IN('VA','GA','FL');
--return products with quantity in stock equal to 49,38,72
SELECT * FROM products WHERE quantity_in_stock IN ('49','38','72');
--between operater 
SELECT * FROM customers WHERE points >= 1000 AND points <= 3000; -- repalce this queary by using between operater
SELECT * FROM customers WHERE points BETWEEN  1000 AND 3000;
--Return Customers born between 1/1/1990 and 1/1/2000
SELECT * FROM customers WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';
--THE LIKE OPERATER 
--retive rows mathed specific pattern
SELECT * FROM customers WHERE last_name LIKE 'b%';
-- % used to check any number of CHARACTERs
-- _ used check single character 
--get the customers whose addresses contain TRAIL OR Avenue
SELECT * FROM customers WHERE address LIKE '%trail%' OR  address LIKE '%avenue%';
--phone number end in 9
SELECT * FROM customers WHERE phone  LIKE '%9';
--the REGXP OPERATOR
SELECT * FROM customers WHERE last_name REGEXP'field';
--exersise
--get the customers whose
    --first names are ELKA OR AMBUR
SELECT *FROM customers WHERE first_name REGEXP 'elka|ambur';
    --LAST NAMES END WITH ey or on
SELECT * FROM customers WHERE   last_name  REGEXP 'ey$|on$';
    --LAST NAMES START WITH MY OR CONTAINS SE
SELECT * FROM customers WHERE   last_name  REGEXP '^ey|on';
    --LAST NAME CONTAIN b FOLLOWED BY r OR U
SELECT * FROM customers WHERE last_name REGEXP 'br|bu';
--THE IS NULL OPERATOR 
SELECT * FROM customers WHERE phone IS NULL;
--is not null 
SELECT * FROM customers WHERE phone IS NOT NULL;
--exersise
--GET THE ORDERS THAT ARE NOT SHIPPED
SELECT * FROM orders WHERE shipper_id IS NULL;
--THE ORDER BY CALUES
SELECT * FROM customers ORDER BY first_name,state DESC;
SELECT first_name,last_name FROM customers ORDER BY birth_date,state DESC;
--EXERSICE
SELECT *,quantity*unit_price AS total_price FROM order_items WHERE order_id = 2 ORDER BY total_price DESC;
--THE LIMIT CLAUSE
SELECT * FROM customers LIMIT 3;
--LIMIT WITH OFFESET 
SELECT * FROM customers limit 6,3; --this is use full to pagination;
--EXERSISE 
--get the top 3 loyal customers 
SELECT * FROM customers ORDER BY points DESC LIMIT 3;

--INNER JOIN
SELECT order_id , first_name,last_name FROM orders JOIN customers on orders.customer_id = customers.customer_id;
--USING ALIAS
SELECT order_id , first_name, last_name,o.customer_id FROM orders  o JOIN customers  c on o.customer_id = c.customer_id;
SELECT * FROM order_items o JOIN products p ON o.product_id = p.product_id;
--SELF JOIN 
SELECT * FROM employees e JOIN employees m ON e.reports_to = m.employee_id;
SELECT e.employee_id,e.first_name, m.first_name AS manager_name FROM employees e JOIN employees m ON e.reports_to = m.employee_id;

--JOIN three tables
SELECT o.order_id,o.order_date,c.first_name,c.last_name,os.name AS status 
FROM orders o JOIN customers c ON o.customer_id = c.customer_id 
JOIN order_statuses os ON o.status = os.order_status_id;

--EXERCISE
SELECT * FROM payments p JOIN clients c ON p.client_id = c.client_id;
SELECT * FROM payments p JOIN clients c ON p.client_id = c.client_id JOIN payment_methods pm ON p.payment_method = pm.payment_method_id;
SELECT p.date,p.invoice_id,p.amount,c.name,pm.name FROM payments p JOIN clients c ON p.client_id = c.client_id JOIN payment_methods pm ON p.payment_method = pm.payment_method_id;

--COMPUND JOIN CONDITIONS
SELECT * FROM order_items oi JOIN order_item_notes oin ON oi.order_id = oin.order_id AND oi.product_id = oin.product_id;
--IMPLICIT JOIN SYNATX
--NORMAL QUERY
SELECT * FROM orders o JOIN customers c ON o.customer_id = c.customer_id;
--same query using implicit 
SELECT * FROM orders o,customers c WHERE o.customer_id = c.customer_id;

--outer join 
    --right join
SELECT c.customer_id,c.first_name,o.order_id FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id ORDER BY c.customer_id;
 --left join c
 SELECT c.customer_id,c.first_name,o.order_id FROM customers c RIGHT JOIN orders o ON c.customer_id = o.customer_id ORDER BY c.customer_id;
 --outer join betwee multiple table
 SELECT 
    c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
RIGHT JOIN orders o
            ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
            ON o.shipper_id = sh.shipper_id
        ORDER BY c.customer_id;    

SELECT o.order_id, o.order_date, c.first_name AS customer, sh.name AS shipper, os.name AS status FROM orders o JOIN customers c ON o.customer_id = c.customer_id LEFT JOIN shippers sh ON o.shipper_id = sh.shipper_id JOIN order_statuses os ON o.status = os.order_status_id;

--self outer joins
SELECT e.employee_id,e.first_name,m.first_name AS manager FROM employees e LEFT JOIN employees m ON e.reports_to = m.employee_id;
--THE USING CALUES  using ke world only used colum name extarcly same
SELECT o.order_id,c.first_name FROM orders o JOIN customer c USING(customer_id) JOIN shippers sh USING (shipper_id);
--EXERCISES 
SELECT p.date,c.name AS client,p.amount,pm.name AS payment_method FROM
        payments p JOIN clients c USING (client_id) JOIN payment_methods
        pm ON p.payment_method = pm.payment_method_id;
--NATURAL JOINS(database engine automatically find joins this may be danguroes)
SELECT o.order_id, c.first_name FROM orders o NATURAL JOIN customers c ;    
--CROSS JOINS    
SELECT c.first_name AS customer,p.name AS product FROM customers c CROSS JOIN  products p ORDER BY c,first_name;
--unicons(combine two queries using union)
SELECT order_id,order_date,'Active' AS status FROM orders WHERE order_date >= '2019-01-01' 
UNION SELECT 
order_id,order_date,'Archived' AS status FROM orders WHERE order_date < '2019-01-01';
--EXERCISES
SELECT customer_id,first_name,points, 'Bronze' FROM customers WHERE points < 2000 
UNION
SELECT customer_id,first_name,points, 'Silver' FROM customers WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id,first_name,points, 'Golg' FROM customers WHERE points >  3000 ORDER BY first_name;
--COLUM ATTRIBUTES




