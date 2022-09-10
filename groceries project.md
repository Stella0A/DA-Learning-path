# GROCERIES EXPLORATORY DATA ANALYSIS PROJECT
# Context

I got this groceries_dataset from Kaggle where I wanted to understand the customers purchasing habit; the items mostly purchased including the days and time of month the items are purchased.

This is quite important because it helps the stakeholders to understand what influences consumers' buying decisions. By understanding how consumers decide on a product, they can fill in the gap in the market and identify the products that are needed and the products that are obsolete.

# Tools Used
Microsoft Excel

MYSQL

# Datasets
The datasets was gotten from kaggle and it comprises of 3 columns with the description(Member_number, Date, itemDescription) with 38777 rows.

# Solution

Upon download of the dataset from kaggle, I noticed the Date wasn't in MYSQL date format. MySQL retrieves and displays DATE values in  ' YYYY-MM-DD ' format but the groceries_dataset was in the excel date format so I changed the format by using the Format cells option.

Then I imported the changed dataset in csv(comma seperated values) into MYSQL workbench using the import wizard and created a database schema 'groceries_project' that will house the table.

    CREATE DATABASE groceries_project
    USE groceries_project;

# Business Questions

# Total number of items on the groceries_list
    SELECT COUNT(distinct itemDescription)
    FROM groceries_dataset2;

# Total orders made per date on the groceries list
    SELECT 
        Date, itemDescription,
        COUNT( itemDescription) AS Total_orders
    FROM
        groceries_dataset2
    GROUP BY itemDescription
    ORDER BY 2 DESC;


# Most purchased item and how any times it was purchased by all customers
    SELECT itemDescription,COUNT(Member_number) AS mostpurchaseditem
    FROM groceries_dataset2
    GROUP BY itemDescription
    ORDER BY mostpurchaseditem DESC
    LIMIT 1;

# Number of times each customer purchased an item
    SELECT DISTINCT Member_number,COUNT(Date) AS Totalitemsbought
    FROM groceries_dataset2
    GROUP BY Member_number
    ORDER BY 2 DESC;

# Ten most purchased items
    SELECT itemDescription,COUNT(itemDescription) AS Mostpurchaseditem
    FROM groceries_dataset2
    GROUP BY itemDescription
    ORDER BY 2 DESC
    LIMIT 10;

# Ten least purchased items
    SELECT itemDescription,COUNT(itemDescription) AS Leastpurchaseditem
    FROM groceries_dataset2
    WHERE itemDescription IS NOT NULL
    GROUP BY itemDescription
    ORDER BY 2 ASC
    LIMIT 10;


# Dates the highest sales were made
    SELECT date,itemDescription,COUNT(itemDescription) AS Highestsales
    FROM groceries_dataset2
    GROUP BY date
    ORDER BY 3 DESC
    LIMIT 10;


# Dates the lowest sales were made
    SELECT date,itemDescription,COUNT(itemDescription) AS Low_sales
    FROM groceries_dataset2
    WHERE itemDescription IS NOT NULL
    GROUP BY date
    ORDER BY 3 ASC
    LIMIT 10;


# Filtering the Month out of the date to find out the Month item sells the most
    SELECT MONTH(Date) AS Month,date,itemDescription,COUNT(itemDescription) AS sales
    FROM groceries_dataset2
    WHERE itemDescription IS NOT NULL
    GROUP BY date
    ORDER BY 4 DESC
    LIMIT 10;

# Filtering the Month out of the date to find out the Month item sells the least
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


# Filtering the Days out of the date to find out the Days the items sells most
    SELECT DAY(Date) AS Day,MONTH(Date) AS Month,Date,
    itemDescription,
    COUNT(itemDescription) AS sales
    FROM groceries_dataset2
    WHERE itemDescription IS NOT NULL
    GROUP BY date
    ORDER BY 5 DESC
    LIMIT 10;


# Filtering the Days out of the date to find out the Days the items sells least
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


