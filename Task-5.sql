-- Subquery in WHERE Clause (NON_CORRELATED)
SELECT Name, Price, Review from Products
WHERE Price > (SELECT AVG(Price) from Products WHERE Category = 'Men\'s Clothings');

-- Subquery in the SELECT  (CORRELATED)
SELECT Name, Category, (SELECT AVG(Price) FROM Products WHERE Category = P.Category) as CategoryWiseAVG
FROM Products P;