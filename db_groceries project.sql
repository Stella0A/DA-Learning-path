-----GROCERIES EXPLORATORY DATA ANALYSIS PROJECT-----
CREATE DATABASE groceries_project
Import data csv into the database

USE groceries_project;

----------the total number of each item purchased on the list---------
SELECT 
    itemDescription,
    COUNT(Member_number) AS Total
FROM
    groceries_dataset2
GROUP BY itemDescription
ORDER BY 2 DESC;

---- most purchased item and how any times it was purchased by all customers----
SELECT itemDescription,COUNT(Member_number) AS mostpurchaseditem
FROM groceries_dataset2
GROUP BY itemDescription
ORDER BY mostpurchaseditem DESC
LIMIT 1;

-----number of times each customer purchased an item-------
SELECT DISTINCT Member_number,COUNT(Date) AS Totalitemsbought
FROM groceries_dataset2
GROUP BY Member_number
ORDER BY 2 DESC;

--------Ten most purchased items--------------
SELECT itemDescription,COUNT(itemDescription) AS Mostpurchaseditem
FROM groceries_dataset2
GROUP BY itemDescription
ORDER BY 2 DESC
LIMIT 10

------Ten least purchased items------
SELECT itemDescription,COUNT(itemDescription) AS Leastpurchaseditem
FROM groceries_dataset2
WHERE itemDescription IS NOT NULL
GROUP BY itemDescription
ORDER BY 2 ASC
LIMIT 10;

----------dates the highest sales were made--------
SELECT date,itemDescription,COUNT(itemDescription) AS Highestsales
FROM groceries_dataset2
GROUP BY date
ORDER BY 3 DESC
LIMIT 10;


----------dates the lowest sales were made--------
SELECT date,itemDescription,COUNT(itemDescription) AS Highestsales
FROM groceries_dataset2
WHERE itemDescription IS NOT NULL
GROUP BY date
ORDER BY 3 ASC
LIMIT 10;

------filtering the Month out of the date to find out the Month item sells the most-------
SELECT MONTH(Date) AS Month,date,itemDescription,COUNT(itemDescription) AS sales
FROM groceries_dataset2
WHERE itemDescription IS NOT NULL
GROUP BY date
ORDER BY 4 DESC
LIMIT 10;

------filtering the Month out of the date to find out the Month item sells the least-------
WITH cte_practice AS (
SELECT MONTH(Date) AS Month,Date,COUNT(itemDescription) AS sales,itemDescription
FROM groceries_dataset2
WHERE itemDescription IS NOT NULL
GROUP BY date
ORDER BY 3 ASC
LIMIT 10
)
SELECT *
FROM cte_practice

------filtering the Days out of the date to find out the Days the items sells most-------
SELECT DAY(Date) AS Day,MONTH(Date) AS Month,Date,
itemDescription,
COUNT(itemDescription) AS sales
FROM groceries_dataset2
WHERE itemDescription IS NOT NULL
GROUP BY date
ORDER BY 5 DESC
LIMIT 10;

------filtering the Days out of the date to find out the Days the items sells least-------
SELECT DAY(Date) AS Day,MONTH(Date) AS Month,Date,
itemDescription,
COUNT(itemDescription) AS sales
FROM groceries_dataset2
WHERE itemDescription IS NOT NULL
GROUP BY date
ORDER BY 5 ASC
LIMIT 10;

SELECT DAY(Date) AS Day,MONTH(Date) AS Month,Date,
itemDescription,
COUNT(itemDescription) AS sales
FROM groceries_dataset2
WHERE itemDescription IS NOT NULL
GROUP BY date
ORDER BY 5 ASC
LIMIT 10;

SELECT Date,Member_number,itemDescription,
COUNT(itemDescription) OVER (PARTITION BY Member_number) AS Salescount
FROM groceries_dataset2
ORDER BY Member_number;

SELECT DATE_PART(Month,Date) as Month,
DATE_PART(Year,Date) as Year,
DATE_PART(Day,Date) as Day
FROM groceries_dataset2
