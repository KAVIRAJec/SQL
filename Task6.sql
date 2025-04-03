-- Date Difference
SELECT C.Name, datediff(CURDATE(),OrderDate) as ToBeDeliveredIn from Orders O
INNER JOIN Customers C
ON C.CustomerID = O.CustomerID where O.DeliveryStatus = 0;

-- Date ADD / SUB
SELECT C.Name, DATE_ADD(CURDATE(), Interval 1 week) as ToBeDeliveredIn from Orders O
INNER JOIN Customers C
ON C.CustomerID = O.CustomerID;

-- Custom query filter on date (give discount 10% for 1month new product)
SELECT Name, 
IF(DATEDIFF(CURDATE(),CreatedAt) < 30,Price * 0.9, Price) as DiscountPrice, Category
 FROM Products;

-- select order created between 2 dates
SELECT Name, Price, Category FROM Products 
WHERE CreatedAt BETWEEN '2025-01-01' AND CURDATE();

-- Date Format
-- SELECT Name, Price, date_format(CreatedAt, '%Y/%m %W') from Products;
SELECT Name, Price, date_format(CreatedAt, '%T') from Products; -- Date format, not in DateTime 

