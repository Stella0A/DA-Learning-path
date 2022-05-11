CREATE DATABASE dannys_diner;
USE dannys_diner;
CREATE table Sales
(customer_id VARCHAR(1),
order_date DATE,
product_id INT);

CREATE table Menu
(product_id INT references Sales(product_id),
product_name VARCHAR(15),
price INT);

CREATE table Member
(customer_id VARCHAR(1) references Sales(customer_id),
join_date DATE);

INSERT INTO sales
VALUES('A','2021-01-01','1'),
('A','2021-01-01','2'),
('A','2021-01-07','2'),
('A','2021-01-10','3'),
('A','2021-01-11','3'),
('A','2021-01-11','3'),
('B','2021-01-01','2'),
('B','2021-01-02','2'),
('B','2021-01-04','1'),
('B','2021-01-11','1'),
('B','2021-01-16','3'),
('B','2021-02-01','3'),
('C','2021-01-01','3'),
('C','2021-01-01','3'),
('C','2021-01-07','3');

INSERT INTO menu
VALUES('1','Sushi','10'),
('2','Curry','15'),
('3','Ramen','12');

INSERT INTO member
VALUES('A','2021-01-07'),
('B','2021-01-09');

SELECT * FROM sales;
SELECT * FROM menu;
SELECT * FROM member;

---What is the total amount each customer spent at the restaurant?---
SELECT sal.customer_id, SUM(men.price) AS total_spent
FROM sales sal
JOIN menu men
ON men.product_id = sal.product_id
GROUP BY sal.customer_id
ORDER BY total_spent DESC;

---How many days has each customer visited the restaurant?----
SELECT customer_id,
COUNT(DISTINCT order_date) AS visits
FROM sales
GROUP BY customer_id
ORDER BY visits DESC;

----What was the first item from the menu purchased by each customer?----
WITH ranked_products AS (
SELECT mb.customer_id,m.product_name,s.order_date,
DENSE_RANK() OVER(PARTITION BY mb.customer_id ORDER BY s.order_date) AS purchased_first
FROM menu  m
JOIN sales s
ON m.product_id=s.product_id
JOIN member mb
ON s.customer_id=mb.customer_id)
SELECT customer_id,product_name,purchased_first,order_date
FROM ranked_products
WHERE purchased_first = 1
GROUP BY customer_id,purchased_first;


--What is the most purchased item on the menu and how many times was it purchased by all customers?----
SELECT men.product_name,
COUNT(sal.product_id) AS times_purchased
FROM dannys_diner.sales sal
JOIN dannys_diner.menu men ON men.product_id = sal.product_id
GROUP BY men.product_name
ORDER BY times_purchased DESC
LIMIT 1;

-----Which item was the most popular for each customer?----
SELECT men.product_name,
COUNT(sal.product_id) AS most_popular_item
FROM dannys_diner.sales sal
JOIN dannys_diner.menu men ON men.product_id = sal.product_id
GROUP BY men.product_name
ORDER BY most_popular_item DESC
LIMIT 1;

----Which item was purchased first by the customer after they became a member?----
WITH ranked_products AS (
SELECT mb.customer_id,m.product_name,s.order_date,
DENSE_RANK() OVER(PARTITION BY mb.customer_id ORDER BY s.order_date) AS purchased_first
FROM menu  m
JOIN sales s
ON m.product_id=s.product_id
JOIN member mb
ON s.customer_id=mb.customer_id
WHERE s.order_date >= mb.join_date)
SELECT customer_id,product_name,purchased_first,order_date
FROM ranked_products
WHERE purchased_first = 1
GROUP BY customer_id,purchased_first;

----Which item was purchased just before the customer became a member?---
SELECT men.product_name,
COUNT(sal.product_id) AS times_purchased
FROM dannys_diner.sales sal
JOIN dannys_diner.menu men ON men.product_id = sal.product_id
GROUP BY men.product_name
ORDER BY times_purchased DESC
LIMIT 1;

-----Which item was the most popular for each customer?----
SELECT men.product_name,
COUNT(sal.product_id) AS most_popular_item
FROM dannys_diner.sales sal
JOIN dannys_diner.menu men ON men.product_id = sal.product_id
GROUP BY men.product_name
ORDER BY most_popular_item DESC
LIMIT 1;

----Which item was purchased first by the customer after they became a member?----
WITH ranked_products AS (
SELECT mb.customer_id,m.product_name,s.order_date,
DENSE_RANK() OVER(PARTITION BY mb.customer_id ORDER BY s.order_date) AS purchased_first
FROM menu  m
JOIN sales s
ON m.product_id=s.product_id
JOIN member mb
ON s.customer_id=mb.customer_id
WHERE s.order_date >= mb.join_date)
SELECT customer_id,product_name,purchased_first,order_date
FROM ranked_products
WHERE purchased_first = 1
GROUP BY customer_id,purchased_first;

----Which item was purchased just before the customer became a member?----
WITH ranked_products AS (
SELECT mb.customer_id,m.product_name,s.order_date,
DENSE_RANK() OVER(PARTITION BY mb.customer_id ORDER BY s.order_date) AS purchased_first
FROM menu  m
JOIN sales s
ON m.product_id=s.product_id
JOIN member mb
ON s.customer_id=mb.customer_id
WHERE s.order_date < mb.join_date)
SELECT customer_id,product_name,purchased_first,order_date
FROM ranked_products
WHERE purchased_first = 1
GROUP BY customer_id,purchased_first;

---What is the total items and amount spent for each member before they became a member?----
WITH overalltotal_payments AS (
SELECT mb.customer_id,m.product_name,m.price
FROM menu  m
JOIN sales s
ON m.product_id=s.product_id
JOIN member mb
ON s.customer_id=mb.customer_id
WHERE s.order_date < mb.join_date)
SELECT customer_id,COUNT(product_name) AS total_items,SUM(price) as Amount_spent
FROM overalltotal_payments
GROUP BY customer_id
ORDER BY Amount_spent;

If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
WITH points_per_purchase AS(
SELECT sal.customer_id,men.product_name,men.price,
    CASE
WHEN men.product_name = 'sushi' THEN 2
	ELSE 1
END AS multiplier,(men.price * 10) AS points
FROM dannys_diner.sales sal
JOIN dannys_diner.menu men ON men.product_id = sal.product_id)
SELECT customer_id,SUM((points * multiplier)) AS total_points
FROM points_per_purchase
GROUP BY customer_id
ORDER BY customer_id;

---In the first week after a customer joins the program (including their join date) they earn 2x points on all items,
 not just sushi - how many points do customer A and B have at the end of January?----
WITH points_per_purchase AS(
SELECT sal.customer_id,mem.join_date,Month(mem.join_date) AS month,
    CASE
WHEN sal.order_date >= mem.join_date THEN 2
	ELSE 1
END AS points
FROM dannys_diner.sales sal
JOIN dannys_diner.member mem ON mem.customer_id = sal.customer_id)
SELECT customer_id,SUM(points) AS total_points
FROM points_per_purchase
WHERE month = 1
GROUP BY customer_id
ORDER BY customer_id;

---create a table adding the customer_id,order_date,product_name,price,and add a column to show customers who are members---
SELECT sal.customer_id,sal.order_date,men.product_name,men.price,
CASE
WHEN sal.order_date >= mem.join_date THEN 'Y'
ELSE 'N'
END AS member
FROM sales sal
LEFT JOIN member mem ON mem.customer_id = sal.customer_id
JOIN menu men ON men.product_id = sal.product_id
ORDER BY customer_id,order_date,product_name;

---create a table adding the customer_id,order_date,product_name,price,and add a column to show 
ranking values for the records when customers are not yet part of the loyalty program-----
With customers_list AS (
SELECT sal.customer_id,sal.order_date,men.product_name,men.price,
CASE
WHEN sal.order_date >= mem.join_date THEN 'Y'
ELSE 'N'
END AS member
FROM sales sal
LEFT JOIN member mem ON mem.customer_id = sal.customer_id
JOIN menu men ON men.product_id = sal.product_id)
SELECT *,
CASE
WHEN member = 'N' THEN 'Null'
ELSE ROW_NUMBER() OVER (ORDER BY customer_id) 
END AS ranking
FROM customers_list
ORDER BY customer_id,order_date,product_name

