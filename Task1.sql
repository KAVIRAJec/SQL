-- Create a Table named Products
CREATE TABLE IF NOT EXISTS Products (
	ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(20),
    Description VARCHAR(100),
    Price FLOAT,
    Category VARCHAR(20),
    Review FLOAT,
    Sold_count INT,
    CreatedAt DATE
);

-- Insert values into the table
INSERT INTO Products ( Name, Description, Price, Category, Review, Sold_count, CreatedAt) 
VALUES 
( 'Shirt', 'This is a brand new shirt', 400,"Men's Clothings", 320, 44, curdate()),
( 'Pant', 'This is a brand new Pant', 540,"Men's Clothings", 52, 54, curdate()),
( 'Shoe', 'This is a brand new Shoe', 350.2,"Women's Clothings", 46, 10, DATE(now())),
( 'Tshirt', 'This is a brand new Tshirt', 150.7,"Women's Clothings", 385, 79, DATE(NOW())),
( 'Jean', 'This is a brand new Jean', 802,"Men's Clothings", 672, 37, curdate());

-- Select all data in the table
SELECT * from Products;
