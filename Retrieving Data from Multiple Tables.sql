--Retrieving Data from Multiple Tables

--Combining the results of 2 Queries
--List the part number,book title and publishing date of all books in the titles table
--List the part number,book title and publishing date of all books in the Obsolete_titles table
SELECT partnum, bktitle, pubdate
FROM Titles

SELECT partnum, bktitle, pubdate
FROM Obsolete_Titles

--Create a combined book list by using Union operator , Union use to not show the duplicate but in this case 
--there will be one duplicate because the pubdate for that book is different in each table
SELECT partnum, bktitle, pubdate
FROM Titles
UNION
SELECT partnum, bktitle, pubdate
FROM Obsolete_Titles

--Eliminate the Pubdate column, to get rid of the duplicate row
SELECT partnum, bktitle
FROM Titles
UNION
SELECT partnum, bktitle
FROM Obsolete_Titles

--Use the Union All operator tp show all combined row , including duplicates
SELECT partnum, bktitle
FROM Titles
UNION ALL
SELECT partnum, bktitle
FROM Obsolete_Titles


--Comparing Results of 2 Queries
--Retrieve any records in the titles table that are also in the obsolete_titles table
--Use Intersect
SELECT partnum, bktitle
FROM Titles
INTERSECT
SELECT partnum, bktitle
FROM Obsolete_Titles


--Retrieve any records in the titles table that are not included in the obsolete_titles table
--Use Except
SELECT partnum, bktitle
FROM Titles
EXCEPT
SELECT partnum, bktitle
FROM Obsolete_Titles

--Retrieve Data by Performing an Inner Join
--Want to know the order number,the sate date, the quantity sold and the name of the sales representative
--Sort the output in descending order by the quantity sold
SELECT ordnum, sldate, qty, repid
FROM Sales

SELECT repid, fname, lname
FROM Slspers

--Enter an Inner Join query to retrieve a list of sales along with the sales representatives' names
--Add an Inner Join clause to join data from the Slspers table to Sales table
--Add the Order By clause to sort the output in alphabetical order by sales representative name
SELECT ordnum, sldate, qty, Sales.repid, fname, lname
FROM Sales
INNER JOIN Slspers ON Sales.repid = Slspers.repid
ORDER BY qty DESC

--Retrieve Data by Performing an Outer Join
--Display all coluns in the Titles and Sales tables
SELECT *
FROM Titles

SELECT *
FROM Sales


--Use the EXCEPT operator to show only the values that exist in one table but not in the other
SELECT partnum
FROM Titles
EXCEPT
SELECT partnum
FROM Sales

--Write the Outer Join query, joining on partnum
SELECT bktitle, qty
FROM Titles LEFT OUTER JOIN Sales
ON Titles.partnum = Sales.partnum

--Use the sum function to aggregate the qty values 
--Use group by clause to summarize results for each book title
SELECT bktitle, SUM(qty) AS total_qty
FROM Titles LEFT OUTER JOIN Sales
ON Titles.partnum = Sales.partnum
GROUP BY bktitle

--Retrieve Data from a single table using a Self Join
--you can join table to itself to show the name of each costumer, 
--with anothe column showing the name of the customer who refeered them
SELECT *
FROM Potential_Customers


SELECT *
FROM Potential_Customers AS custlist
INNER JOIN Potential_Customers AS referredlist
ON custlist.referredby = referredlist.custnum

--show specific columns from each side of the join
SELECT custlist.custname, referredlist.custname AS referred_by
FROM Potential_Customers AS custlist
INNER JOIN Potential_Customers AS referredlist
ON custlist.referredby = referredlist.custnum 
