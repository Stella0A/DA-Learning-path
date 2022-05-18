'''
I got this dataset from Kaggle where I wanted to understand 
the customers purchasing habit and what items are mostly purchased including the days and months the items are purchased.
I used SQL queries to analyze this dataset:
'''
First I created a database schema 'groceries_project' that will house all the different tables in the dataset,
then I imported the dataset in csv(comma seperated values) to mysql workbench using the import wizard.

CREATE DATABASE groceries_project
Import data csv into the database

USE groceries_project;

Here I write queries to count all the items in the groceries_list
SELECT COUNT(distinct itemDescription)
FROM groceries_dataset2;


Here I want to know the total orders made per date on the groceries list
SELECT 
    Date, itemDescription,
    COUNT( itemDescription) AS Total_orders
FROM
    groceries_dataset2
GROUP BY itemDescription
ORDER BY 2 DESC;


---- most purchased item and how any times it was purchased by all customers-------
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
WITH cte_dataset AS (
SELECT MONTH(Date) AS Month,Date,COUNT(itemDescription) AS sales,itemDescription
FROM groceries_dataset2
WHERE itemDescription IS NOT NULL
GROUP BY date
ORDER BY 3 ASC
LIMIT 10
)
SELECT *
FROM cte_dataset;


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


