-- Displaying the Top sold product using ROW_NUMBER
SELECT ProductID, Name, Price, Category, Sold_count,
ROW_NUMBER() OVER(ORDER BY Sold_count desc) AS SalesPopularity
from Products;

-- Displaying the Top sold Product under each category
SELECT Name, Price, Category, Sold_count,
ROW_NUMBER() OVER(partition by Category ORDER BY Sold_count desc) AS RowNumber,
RANK() OVER(partition by Category ORDER BY Sold_count desc) AS RankFunc,
DENSE_RANK() OVER(partition by Category ORDER BY Sold_count desc) AS DenseRank
from Products;

-- Displaying the Top sold Product under each category & also show their nearby product name
SELECT Name, Price, Category, Sold_count,
LEAD(Name) OVER(partition by Category ORDER BY Sold_count desc) AS NextSold,
LAG(Name) OVER(partition by Category ORDER BY Sold_count desc) AS PrevSold
from Products;

-- Select customers who spend more money
SELECT C.Name as CustomerName, C.UserName, C.PhoneNumber, O.TotalAmount,
RANK() OVER(ORDER BY O.TotalAmount DESC) as AmountRank
FROM Customers C INNER JOIN Orders O
ON C.CustomerID = O.CustomerID;

-- Select Total amount sold in each category
SELECT Name, Category, Price, Sold_count,
    SUM(Price * Sold_count) OVER (PARTITION BY Category) AS category_sales
FROM Products;