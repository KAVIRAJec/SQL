-- To get Total count & amount sold in specific date range (Stored Procedure)
DELIMITER $$
CREATE PROCEDURE GetSalesDetails(startDate Date, endDate Date)
BEGIN
	SELECT COUNT(*) as TotalCount, SUM(TotalAmount) as TotalPrice
    FROM Orders O
    WHERE O.OrderDate BETWEEN startDate AND endDate;
END $$
DELIMITER ;

-- To call the Stored Procedure
CALL GetSalesDetails('2025-01-01', '2025-03-31');

-- To provide discount for particular prices (User defined Function)
DELIMITER $$
CREATE FUNCTION ApplyDiscount(totalAmount FLOAT) RETURNS FLOAT
DETERMINISTIC
BEGIN 
	DECLARE Discount FLOAT;
    IF TotalAmount > 500 THEN SET Discount = TotalAmount * 0.80; -- 20% Discount
    ELSEIF TotalAmount > 300 THEN SET Discount = TotalAmount * 0.90; -- 10% Discount
    ELSE SET Discount = TotalAmount;
    END IF;
    RETURN Discount;
END $$
DELIMITER ;

-- SELECT ApplyDiscount(280);

-- Using Query
SELECT OrderID, CustomerID, TotalAmount, ApplyDiscount(TotalAmount) as DiscountAmount
FROM Orders;
