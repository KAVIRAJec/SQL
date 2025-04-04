CREATE TABLE EC_Customers (
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(30) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Contact VARCHAR(20),
    CreatedAt TIMESTAMP DEFAULT current_timestamp
);

CREATE TABLE EC_Products (
	ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(30) NOT NULL,
    Price FLOAT NOT NULL,
    Category VARCHAR(20),
    Review FLOAT DEFAULT 0,
    StockQuantity INT NOT NULL CHECK (StockQuantity >= 0)
);

CREATE TABLE EC_Orders (
	OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate TIMESTAMP DEFAULT current_timestamp,
    Status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    TotalAmount FLOAT NOT NULL CHECK (TotalAmount > 0),
    FOREIGN KEY (CustomerID) REFERENCES EC_Customers(CustomerID) ON DELETE CASCADE
);

CREATE TABLE EC_OrderDetails (
	OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    SubTotal FLOAT NOT NULL CHECK (SubTotal > 0),
    FOREIGN KEY (OrderID) REFERENCES EC_Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES EC_Products(ProductID) ON DELETE CASCADE
);

-- INDEXING
CREATE INDEX idx_customer_email ON EC_Customers(Email);
CREATE INDEX idx_order_customer ON EC_Orders(CustomerID);
CREATE INDEX idx_orderdetails_product ON EC_OrderDetails(ProductID);

-- Triggers to update stock & update totalAmount
DELIMITER $$
CREATE TRIGGER update_stock_totalAmount
AFTER INSERT ON EC_OrderDetails
FOR EACH ROW
BEGIN
	UPDATE EC_Products
    SET StockQuantity = StockQuantity - NEW.Quantity
    WHERE ProductID = NEW.ProductID;

    UPDATE EC_Orders
    SET TotalAmount = (
		SELECT SUM(SubTotal) FROM EC_OrderDetails WHERE OrderID = NEW.OrderID
    )
    WHERE OrderID = NEW.OrderID;
END $$
DELIMITER ;

-- INSERT DATA
INSERT INTO EC_Customers (Name, Email, Contact) VALUES 
('Alice', 'alice@example.com', '+91 98653253'),
('Bob', 'bob@example.com', '+62 98653253');
INSERT INTO EC_Products (Name, Price, Category, Review, StockQuantity) VALUES 
('Laptop', 800, 'Electronics', 4.2, 10),
('Jeans', 20, 'Men\'s Clothings', 4.5, 100),
('Keyboard', 50,'Accessories', 4.0, 50);

-- Stored Procedures to place order
DELIMITER $$ 
CREATE PROCEDURE PlaceOrder ( p_customer_id INT, p_product_id INT, p_quantity INT) 
BEGIN 
	DECLARE order_id INT;
    DECLARE product_price FLOAT;
    DECLARE subtotal FLOAT;
    DECLARE available_stock INT;
    DECLARE error_occurred INT DEFAULT 0;
    
    -- To catch error
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION  
    BEGIN  
        SET error_occurred = 1;
        ROLLBACK;  -- Undo all changes if any error occurs
        SIGNAL SQLSTATE '45000'  
        SET MESSAGE_TEXT = 'An error occurred. Order could not be placed.';
    END;  
    
    -- Start transaction
    START TRANSACTION;
    
    -- Check Stock
    SELECT StockQuantity INTO available_stock FROM EC_Products WHERE ProductID = p_product_id;
    
    IF available_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough stock available';
    END IF;
    
    -- GET PRODUCT PRICE
    SELECT Price INTO product_price FROM EC_Products
    WHERE ProductID = p_product_id;
    
    SET subtotal = p_quantity * product_price;
        
    -- Create order
    INSERT INTO EC_Orders (CustomerID, TotalAmount)
    VALUES (p_customer_id, subtotal);
    
    -- Get OrderID
    SET order_id = LAST_INSERT_ID();
    -- Create OrderDetails
    INSERT INTO EC_OrderDetails (OrderID, ProductID, Quantity, SubTotal)
    VALUES (order_id, p_product_id, p_quantity, subtotal);
    
    IF error_occurred = 0 THEN
        COMMIT;
    END IF;
    -- THEN Trigger updated EC_Products.StockQuantity
    -- THEN Trigger updated EC_Orders.TotalAmount
END $$
DELIMITER ;

CALL PlaceOrder(1, 1, 1);

-- VIEWS
CREATE VIEW OrderSummary AS
SELECT o.OrderID, c.Name AS customer_name, p.Name as ProductName, d.Quantity, o.OrderDate, o.TotalAmount, o.Status
FROM EC_Orders o
JOIN EC_Customers c ON o.CustomerID = c.CustomerID
JOIN EC_OrderDetails d ON o.OrderID = d.OrderID
JOIN EC_Products p ON d.ProductID = p.ProductID;