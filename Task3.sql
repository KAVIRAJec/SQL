-- Returns the Average price for Men's Clothings
SELECT AVG(Price) as AveragePrice from Products WHERE Category = 'Men\'s Clothings';

-- Displays the Total Count, Minimum & maximum Sold happened in each Product Category
SELECT Category, COUNT(Category) as Total_Item,
MIN(Sold_count) as Min_Sold, MAX(Sold_count) as Max_Sold 
 from Products
GROUP BY Category;

-- Count the Number of Products Sold for Each Category and 
-- Display Only Categories with Total Sales Greater Than 500
SELECT Category, SUM(Sold_count)
FROM Products
GROUP BY Category
HAVING SUM(Sold_count)>500;
