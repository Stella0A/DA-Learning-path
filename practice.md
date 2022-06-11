# Practicing Sql queries with Use Cases

First I created a database that is going to house the data which I called  "sql_new"

A database is an organized collection of structured information, or data, typically stored electronically in a computer system.

      Create DATABASE sql_new

# Setting the Context

In this case study I will create a fictious company and attempt to analyse their business data using three tables;

      1. customer 
      2. orders 
      3. payments 

# Creating a new table customer and inserting values into the table

      CREATE table customers
      (customer_id int PRIMARY KEY,
      first_name VARCHAR(20) not null,
      last_name VARCHAR(20) not null,
      address VARCHAR(20) ,
      gender CHAR(6) not null CHECK(gender= 'male' or gender ='female'),
      order_date DATE not null);
      INSERT INTO customers
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
 
# Creating a new table orders and inserting values into the table   

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
            
# Creating a new table payments and inserting values into the table

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
    

      SELECT * FROM payments;
     
  
      SELECT * FROM orders;
      
      
      
      SELECT first_name,gender, Hire_date,salary
      FROM productions p
      JOIN payments pm
      ON p.employee_id=pm.employee_id;
      
  
      
          
     
          

          
      
