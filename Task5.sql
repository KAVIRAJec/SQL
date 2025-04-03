-- Subquery in WHERE Clause (NON_CORRELATED)
SELECT Name, Price, Review from Products
WHERE Price > (SELECT AVG(Price) from Products WHERE Category = 'Men\'s Clothings');

-- Subquery in the SELECT  (CORRELATED)
SELECT Name, Category, 
(SELECT AVG(Price) FROM Products WHERE Category = P.Category) as CategoryWiseAVG
FROM Products P;

SELECT Name, Price, Category FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products WHERE Products.Category = Category);