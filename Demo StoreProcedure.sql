CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(15)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),  -- Fixed typo here
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1, 1) PRIMARY KEY,  -- Added IDENTITY
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    OrderDate DATE
);

-----------------------

-- Insert sample data
INSERT INTO Customer (CustomerID, CustomerName, Email, Phone)
VALUES (1, 'David', 'david@example.com', '555-1234');

INSERT INTO Product (ProductID, ProductName, Price)
VALUES (1, 'Laptop', 1500.00),
       (2, 'Mouse', 50.00);

INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate)
VALUES (1, 1, 1, '2024-10-01'),
       (2, 1, 2, '2024-10-15');

-------------------

-- Stored Procedures

CREATE PROCEDURE GetAllCustomers
AS
BEGIN
    SELECT CustomerID, CustomerName, Email, Phone
    FROM Customer;
END;

CREATE PROCEDURE GetProductById
    @ProductID INT
AS
BEGIN
    SELECT ProductID, ProductName, Price
    FROM Product
    WHERE ProductID = @ProductID;
END;

CREATE PROCEDURE GetOrdersByCustomerId
    @CustomerID INT
AS
BEGIN
    SELECT o.OrderID, o.OrderDate, p.ProductName, p.Price
    FROM Orders o
    JOIN Product p ON o.ProductID = p.ProductID
    WHERE o.CustomerID = @CustomerID;
END;

CREATE PROCEDURE AddNewOrder
    @CustomerID INT,
    @ProductID INT,
    @OrderDate DATE
AS
BEGIN
    INSERT INTO Orders (CustomerID, ProductID, OrderDate)
    VALUES (@CustomerID, @ProductID, @OrderDate);
END;

-- Test the procedure
EXEC AddNewOrder @CustomerID = 1, @ProductID = 2, @OrderDate = '2024-10-29';

-------------------

-- Check current table structure
EXEC sp_help 'Orders';

-- Steps to fix the `OrderID` issue

-- 1) Copy existing table data to a temporary table
SELECT * INTO TempOrders FROM Orders;

-- 2) Drop the existing `Orders` table
DROP TABLE Orders;

-- 3) Create new `Orders` table with auto-increment `OrderID`
CREATE TABLE Orders (
    OrderID INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    OrderDate DATE
);

-- 4) Insert data from the temporary table into the new `Orders` table
INSERT INTO Orders (CustomerID, ProductID, OrderDate)
SELECT CustomerID, ProductID, OrderDate FROM TempOrders;

-- 5) Drop the temporary table
DROP TABLE TempOrders;

-- 6) Test the procedure
EXEC AddNewOrder @CustomerID = 1, @ProductID = 2, @OrderDate = '2024-10-29';

-- Get orders for a specific customer
EXEC GetOrdersByCustomerId @CustomerID = 1;

-- Get product by ID
EXEC GetProductById @ProductID = 1;
