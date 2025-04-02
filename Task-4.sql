-- CREATE TABLE IF NOT EXISTS Customers (
-- 	CustomerID INT AUTO_INCREMENT PRIMARY KEY,
--     Name VARCHAR(20),
--     UserName VARCHAR(20),
--     Email VARCHAR(40),
--     PhoneNumber VARCHAR(15)
-- );

-- CREATE TABLE IF NOT EXISTS Orders (
-- 	OrderID INT AUTO_INCREMENT PRIMARY KEY,
--     CustomerID INT,
--     OrderDate DATE,
--     DeliveryStatus bool,
--     TotalAmount FLOAT,
--     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
-- );

-- INSERT INTO Customers (Name, UserName, Email, PhoneNumber) 
-- VALUES 
-- ('John Doe', 'johndoe', 'john.doe@email.com', '555-1234'),
-- ('Jane Smith', 'janesmith', 'jane.smith@email.com', '555-5678'),
-- ('Alice Johnson', 'alicejohnson', 'alice.johnson@email.com', '555-8765'),
-- ('Bob Williams', 'bobwilliams', 'bob.williams@email.com', '555-4321'),
-- ('Charlie Brown', 'charliebrown', 'charlie.brown@email.com', '555-6789'),
-- ('Emily Davis', 'emilydavis', 'emily.davis@email.com', '555-2468'),
-- ('David Wilson', 'davidwilson', 'david.wilson@email.com', '555-1357'),
-- ('Sophia Miller', 'sophiamiller', 'sophia.miller@email.com', '555-1122'),
-- ('William Taylor', 'williamtaylor', 'william.taylor@email.com', '555-3344'),
-- ('Olivia Moore', 'oliviamoore', 'olivia.moore@email.com', '555-5566');

-- INSERT INTO Orders (CustomerID, OrderDate, DeliveryStatus, TotalAmount)
-- VALUES
-- (1, '2025-03-15', TRUE, 150.75),
-- (2, '2025-03-17', FALSE, 89.50),
-- (3, '2025-03-20', TRUE, 210.00),
-- (4, '2025-03-22', TRUE, 320.45),
-- (5, '2025-03-25', FALSE, 75.90),
-- (6, '2025-03-27', TRUE, 50.00),
-- (7, '2025-03-29', TRUE, 185.60),
-- (8, '2025-03-30', FALSE, 99.99),
-- (9, '2025-04-01', TRUE, 450.00),
-- (10, '2025-04-02', FALSE, 120.10);

-- INNER JOINS
-- SELECT Customers.Name, Customers.PhoneNumber, Orders.OrderDate, Orders.DeliveryStatus, Orders.TotalAmount
-- FROM Customers INNER JOIN Orders 
-- ON Customers.CustomerID = Orders.CustomerID

-- LEFT JOINS
-- INSERT INTO Customers (Name, UserName, Email, PhoneNumber) 
-- VALUES 
-- ('Left_Test', 'johndoe', 'john.doe@email.com', '555-1234');

-- SELECT Customers.Name, Customers.PhoneNumber, Orders.OrderDate, Orders.DeliveryStatus, Orders.TotalAmount
-- FROM Customers LEFT JOIN Orders 
-- ON Customers.CustomerID = Orders.CustomerID

-- RIGHT JOINS
-- INSERT INTO Orders (CustomerID, OrderDate, DeliveryStatus, TotalAmount)
-- VALUES
-- (100, '2025-03-15', TRUE, 9999);

-- SELECT Customers.Name, Customers.PhoneNumber, Orders.OrderDate, Orders.DeliveryStatus, Orders.TotalAmount
-- FROM Customers RIGHT JOIN Orders 
-- ON Customers.CustomerID = Orders.CustomerID

-- FULL OUTER JOINS
-- SELECT Customers.Name, Customers.PhoneNumber, Orders.OrderDate, Orders.DeliveryStatus, Orders.TotalAmount
-- FROM Customers FULL OUTER JOIN Orders 
-- ON Customers.CustomerID = Orders.CustomerID