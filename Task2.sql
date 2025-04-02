-- Select product with review 4.5
SELECT * FROM Products WHERE Review = 4.5;

-- Select & displays Products based on review in Descending order
SELECT * FROM Products ORDER BY Review desc;

-- Select product with 2 conditions
-- 1 - Review greater than 4
-- 2 - Sold_count greater than 50 or Price less than 100
SELECT * FROM Products WHERE 
Review > 4 AND (Sold_count > 50 OR Price < 100);