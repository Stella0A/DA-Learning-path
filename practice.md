# Introduction

I have been learning and practising sql on my path to being a seasoned Data Analyst so I decided to create a fictious company with small size data to practice a little on all I have learnt so far.

# Setting the Context

First I created a database that is going to house the data tables which I called "sql_new". In this case study using a fictious company that I created, I will attempt to analyse their data answering five business questions.

A database is an organized collection of structured information, or data, typically stored electronically in a computer system.

      Create DATABASE sql_new
# Datasets
      1. customer 
      2. orders 
      3. payments 
# Creating data tables and inserting values into the table
After creating the database that will house the tables, I created the tables with the various data types and inserted my data.

Database data types refer to the format of data storage that can hold a distinct type or range of values.Some common data types include integers, floating point numbers, characters, strings, and arrays.E.g Dates follow the DATE structure, short numbers like 14, 20, 200 follow the INT(integers) data type while larger numbers like phone numbers follow the BIGINT type. Read more on data types here https://teachcomputerscience.com/database-data-types/.

#customers

      CREATE table customers
      (customer_id int PRIMARY KEY,
      first_name VARCHAR(20) not null,
      last_name VARCHAR(20) not null,
      address VARCHAR(20) ,
      gender CHAR(6) not null CHECK(gender= 'male' or gender ='female');
      INSERT INTO customers(customer_id,first_name,last_name,address,gender,order_date)
      VALUES(20487, 'Olajumoke','Ade', 'Lekki','Female'),
            (20587, 'Olamiposi', 'Dickson', 'Lekki','Female'),
            (30787, 'John', 'Malcom', 'VI','Male'),
            (40987, 'Charlie', 'Simpson', 'Ogba','Male'),
            (40988, 'Cain', 'Bently', 'Ikotun','Male','2020-09-08'),
            (40989, 'Cynthia', 'Bently', 'Ikotun','Female'),
            (40985, 'Bimba', 'Cole', 'Ikota','Male'),
            (40983, 'Jay', 'Comma', 'Abuja','Male'),
            (40780, 'Des', 'Camila', 'Maitama','Female'),
            (40950, 'Ifeoma', 'Katrina', 'Ikeja','Female');
 
# orders

      CREATE table orders
      (product_id VARCHAR PRIMARY KEY,
      product_name VARCHAR(20) not null,
      customer_id INT not null,
      paymentsMethod VARCHAR(15) not null);
      INSERT INTO orders(product_id,product_name,customer_id,paymentsMethod)
      VALUES('A', 'Fruits',20487 , 'Transfer'),
            ('B', 'Vegetables',30787, 'Cash'),
            ('C', 'Cereals', 40987, 'Transfer'),
            ('D', 'Stockfish', 40989, 'Transfer'),
            ('E', 'Meat', 40985, 'Transfer'),
            ('F', 'Nuts', 40780', 'Cash'),
            ('G', 'Nuts', 40950, 'Transfer'),
            ('H', 'Beverages', 40988, 'Transfer'),
            ('A', 'Fruits', 40983 'Cash'),
            ('H', 'Beverages', 20587, 'Transfer');
            
# payments

     CREATE table payments
      (Acct_no VARCHAR,
      price BIGINT not null check(price > 0),
      Bank VARCHAR(15) Default 'ZenithBank',
      PaymentsMethod VARCHAR(15) CHECK(PaymentsMethod= 'Cash' or paymentsMethod= 'Transfer'));
      INSERT INTO payments(Acct_no,price,PaymentsMethod)
      VALUES('A',250, 'Cash'),
            ('A',240, 'Transfer'),
            ('B',300, 'Cash'),
            ('C',400, 'Cash'),
            ('D',670, 'Transfer'),
            ('E',500, 'Transfer');
      
            
 # Runing the queries
      
      SELECT * FROM customers;
      
      
      
customer_id | first_name | last_name | address | gender | 
----------- | :--------: | :-------: | :-----: | ----:  |
20487       | Olajumoke  | Ade       | Lekki   | Female | 
20587       | Olamiposi	 | Dickson   | Lekki   | Female | 
30787	      | John       | Malcom    | VI      | Male   | 
40780       | Des	       | Camila    | Maitama | Female | 
40950	      | Ifeoma     | Katrina   | Ikeja   | Female | 
40983 	| Jay	       | Comma     | Abuja   | Male   | 
40985	      | Bimba      | Cole      | Ikota   | Male   | 
40987	      | Charlie    | Simpson   | Ogba    | Male   | 
40988	      | Cain       | Bently    | Ikotun  | Male   | 
40989 	| Cynthia    | Bently    | Ikotun  | Female | 

   
      SELECT * FROM orders;
      
 product_id | product_name|	customer_id | paymentsMethod | order_date |
 ---------- | :--------:  | :----------: | :------------: | ----------: |
A	      | Fruits	  |  20487	     | Transfer	    | 2020-01-01  |
B	      | Vegetables  | 30787	     |  Cash	    | 2020-01-09  |
C	      |  Cereals	  | 40987	     |  Transfer	    |2020-07-01   |
D	      |Stockfish	  |  40989	     | Transfer	    |2021-01-12   |
E	      |Meat	        |  40985	     | Transfer	    |2020-09-08   |
F	      |Nuts	        | 40780	     |  Cash	    |2019-09-08   |
G	      | Nuts	  | 40950	     | Transfer	    |2021-05-15   |
H	      | Beverages	  | 40988        | Transfer	    |2021-01-08   |
A	      | Fruits	  | 40983	     | Cash           |2020-05-08   |
H	      | Beverages	  |20587	     | Transfer	    |2021-01-08   |
      
      
      SELECT * FROM payments;
      
Acct_no | price | Bank       | PaymentsMethod |
------- | :----:| :--------: | ------------:  | 
A       | 250   |	ZenithBank | Cash           |
A	  | 240   | ZenithBank | Transfer       |
B	  | 300   |	ZenithBank |	Cash      |
C	  | 400   | ZenithBank |   Cash         |
D       | 670   |	ZenithBank | Transfer       |
E	  | 500   |	ZenithBank |  Transfer      |

# Business questions 
   1. What payments method was mostly used?
   2. What is the most purchased item on the menu and how many times was it purchased by all customers?
   3. What is the total items and amount spent for person?
   4. What was the first item from the menu purchased by each customer?
   5. 
      SELECT first_name,gender, Hire_date,salary
      FROM productions p
      JOIN payments pm
      ON p.employee_id=pm.employee_id;
      
  
      
          
     
          

          
      
