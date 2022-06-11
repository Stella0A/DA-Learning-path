# Practicing Sql queries with Use Cases

First I created a database the data is going to live in which I called  "sql_new"

A database is an organized collection of structured information, or data, typically stored electronically in a computer system.

Create DATABASE sql_new

# Setting the Context

In this case study I will create a fictious production company and attempt to analyse their business data overtime.

# Datasets

In this case study we will need three tables consisting of;

1. productions_team 
2. orders 
3. payments 

USE sql_new;

# creating a new table productions_team and inserting values into the table

CREATE table productions
(employee_id int PRIMARY KEY,
first_name VARCHAR(20) not null,
last_name VARCHAR(20) ,
address VARCHAR(20) ,
gender CHAR(6) not null CHECK(gender= 'male' or gender ='female'),
Hire_date DATE not null))
INSERT INTO productions
VALUES(20487, 'Olajumoke','Ade', 'Lekki','Female','2020-01-01'),
      (20587, 'Olamiposi', 'Dickson', 'Lekki','Female','2020-01-09'),
      (30787, 'John', 'Malcom', 'VI','Male','2020-07-01'),
      (40987, 'Charlie', 'Simpson', 'Ogba','Male','2021-01-12'),
      (40988, 'Cain', 'Bently', 'Ikotun','Male','2020-09-08'),
      (40989, 'Cynthia', 'Bently', 'Ikotun','Female','2020-09-08'),
      (40985, 'Bimba', 'Cole', 'Ikota','Male','2019-09-08'),
      (40983, 'Jay', 'Comma', 'Abuja','Male','2021-05-15'),
      (40780, 'Des', 'Camila', 'Maitama','Female','2021-01-08'),
      (40950, 'Ifeoma', 'Katrina', 'Ikeja','Female','2020-05-08');
      
SELECT * FROM productions;
  
SELECT * FROM payments;
  
SELECT * FROM orders;
  
# creating a new table payments and inserting values into the table

CREATE table payments
(Acct_no BIGINT UNIQUE,
employee_id INT not null references productions(employee_id),
salary BIGINT not null check(salary>0),
Bank VARCHAR(15) Default 'ZenithBank',
PaymentsMethod VARCHAR(15) CHECK(PaymentsMethod= 'Cash' or paymentsMethod= 'Transfer'))
INSERT INTO payments(Acct_no,employee_id,salary,PaymentsMethod)
VALUES(20487, 250000, 'Cash'),
      (20587, 240000, 'Transfer'),
      (30787, 300000, 'Cash'),
      (40985,
      (40987, 670000, 'Transfer'),
      (40988, 500000, 'Transfer');
      
      
# creating a new table orders and inserting values into the table   

CREATE table orders
(product_id INT PRIMARY KEY,
product_name VARCHAR(20) not null,
destination VARCHAR(20) NOT NULL,
customer_id INT not null,
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
          
     
          

          
      
