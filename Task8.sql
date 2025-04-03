-- CTE(Common Table Expressions) to get Product which price > 100
WITH OrderedProduct AS (
	SELECT P.Name as ProductName, P.Price, O.OrderID, O.DeliveryStatus
    FROM Products P INNER JOIN Orders O
    ON P.ProductID = O.ProductID
)

SELECT * FROM OrderedProduct WHERE OrderedProduct.Price > 100;

-- Multiple CTE
WITH OrderedProduct AS (
	SELECT P.Name as ProductName, P.Price, P.Category, O.OrderID, O.DeliveryStatus
    FROM Products P INNER JOIN Orders O
    ON P.ProductID = O.ProductID
),
	 UserDetails AS (
	SELECT C.Name, C.UserName, C.PhoneNumber, O.OrderID
    FROM Customers C INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
)
SELECT U.Name, U.UserName, U.PhoneNumber, O.ProductName, O.Price, O.Category, O.OrderID, O.DeliveryStatus
FROM UserDetails U INNER JOIN OrderedProduct O
ON U.OrderID = O.OrderID
WHERE O.DeliveryStatus = 0;

-- Recursive CTE to Show all Date in Order(OrderDate)
WITH RECURSIVE CustomOrder(dt) AS (
	SELECT MIN(OrderDate) as FirstDate FROM Orders
    UNION ALL
    SELECT dt + INTERVAL 1 DAY
    FROM CustomOrder
    WHERE dt < (SELECT MAX(OrderDate) FROM Orders)
)
SELECT * 
FROM CustomOrder CO LEFT JOIN Orders O
ON CO.dt = O.OrderDate;

-- Recursive CTE product belongs to a category, and categories can have subcategories.
WITH RECURSIVE CustomerHierarchy AS (
	-- Base Level - Customer
    SELECT C.CustomerID, C.Name as CustomerName, NULL as OrderID, NULL AS ProductID, 1 as Level
    FROM Customers C
    
    UNION ALL
    
    SELECT C.CustomerID, C.Name as CustomerName, O.OrderID, NULL as ProductID, 2 as Level
    FROM Orders O INNER JOIN Customers C
    ON O.CustomerID = C.CustomerID
    
    UNION ALL
	
    SELECT C.CustomerID, C.Name as CustomerName, O.OrderID, P.ProductID, 3 as Level
    FROM Orders O
    INNER JOIN Customers C ON O.CustomerID = C.CustomerID
    INNER JOIN Products P ON O.ProductID = P.ProductID
)
SELECT CustomerName, OrderID, ProductID, Level FROM CustomerHierarchy
ORDER BY CustomerID, Level, OrderID, ProductID;