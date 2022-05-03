CREATE DATABASE sql_new;
USE sql_new;
CREATE table productions
(employee_id int PRIMARY KEY,
first_name VARCHAR(20) not null,
last_name VARCHAR(20) ,
address VARCHAR(20) ,
gender CHAR(6) not null CHECK(gender= 'male' or gender ='female'),
Hire_date DATE not null);

CREATE table payments
(Acct_no BIGINT UNIQUE,
employee_id INT not null references productions(employee_id),
salary BIGINT not null check(salary>0),
Bank VARCHAR(15) Default 'ZenithBank',
PaymentsMethod VARCHAR(15) CHECK(PaymentsMethod= 'Cash' or paymentsMethod= 'Transfer'));
INSERT INTO payments(Acct_no,employee_id,salary,PaymentsMethod)
VALUES(20487, 1, 250000, 'Cash'),
      (20587, 2, 240000, 'Transfer'),
	  (30787, 3, 300000, 'Cash'),
      (40987, 4, 670000, 'Transfer'),
      (40988, 5, 500000, 'Transfer');
      
    
      CREATE table orders
      (product_id INT PRIMARY KEY,
      product_name VARCHAR(20) not null,
      destination VARCHAR(20) NOT NULL,
      customer_id INT not null references orders(customer_id),
      paymentsMethod VARCHAR(15) not null references orders(paymentsMethod));
   INSERT INTO orders(product_id,product_name,destination,customer_id,paymentsMethod)
    VALUES(10121, 'Fruits', 'Lagos', 1, 'Transfer'),
          (10122, 'Vegetables', 'Lagos', 2, 'Cash'),
          (10123, 'Cereals', 'Ilorin', 3, 'Transfer'),
          (10124, 'Stockfish', 'Akure', 1, 'Transfer'),
          (10125, 'Meat', 'AkwaIbom', 1, 'Transfer'),
          (10126, 'Nuts', 'Poland', 2, 'Cash'),
          (10127, 'Soups', 'Abeokuta', 4, 'Transfer'),
          (10128, 'Beverages', 'Kano', 5, 'Transfer'),
          (10129, 'Water', 'Ondo', 4, 'Cash'),
          (10130, 'Yam', 'Abuja', 1, 'Transfer');
      

     SELECT first_name,gender, Hire_date,salary
      FROM productions p
      JOIN payments pm
          ON p.employee_id=pm.employee_id;
          
     SELECT *
      FROM orders o
      JOIN o.paymentsMethod pm
          ON o.product_id=pm.customer_id;
          
SELECT CONCAT(employee_id, ' ','is paid via',' ', PaymentsMethod, ' ','into this',' ',Bank as description from payments);

SELECT CONCAT('sql',' ', 'is',' ','fun')   
          
      