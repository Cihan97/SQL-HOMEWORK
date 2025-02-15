CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
CustomerName  NVARCHAR(100),
Country NVARCHAR(50)
);


CREATE TABLE Orders( 
OrderID INT PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
OrderDate DATE,
TotalAmount DECIMAL(10,2)
);

INSERT INTO Customers (CustomerID, CustomerName, Country)
VALUES 
(1, 'John Doe', 'USA'),
(2, 'Jane Smith', 'UK'),
(3, 'Carlos Hernandez', 'Spain'),
(4, 'Li Wei', 'China'),
(5, 'Hans Muller', 'Germany');


INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, '2023-01-15', 150.00),
(102, 2, '2023-01-16', 200.00),
(103, 3, '2023-01-17', 250.00),
(104, 4, '2023-01-18', 300.00),
(105, 5, '2023-01-19', 350.00),
(106, 1, '2023-01-20', 400.00),
(107, 2, '2023-01-21', 450.00),
(108, 3, '2023-01-22', 500.00),
(109, 4, '2023-01-23', 550.00),
(110, 5, '2023-01-24', 600.00);


SELECT OrderID, CustomerID, OrderDate, TotalAmount
FROM Orders
ORDER BY OrderDate DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY ; 

SELECT OrderID, CustomerID, OrderDate, TotalAmount
FROM Orders
ORDER BY OrderDate DESC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY; 


SELECT TOP 3 WITH TIES OrderID, CustomerID, OrderDate, TotalAmount
FROM Orders
ORDER BY TotalAmount DESC;