CREATE TABLE Customer (
CustomerID INT PRIMARY KEY,
CustomerName NVARCHAR(100),
Email NVARCHAR(100),
Phone NVARCHAR(15)
);


CREATE TABLE Product (
ProductID INT PRIMARY KEY,
ProdutName NVARCHAR(100),
Price DECIMAL(10,2)
);


CREATE TABLE Orders (
OrderID INT  PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
OrderDate DATE
);
-----------------------

INSERT INTO Customer (CustomerID, CustomerName, Email, Phone)
VALUES (1, 'David', 'david@example.com', '555-1234');


INSERT INTO Product (ProductID, ProductName, Price)
VALUES (1, 'Laptop', '1500.00'),
       (2, 'Mouse', '50.00');

INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate)
VALUES ( 1, 1, 1, '2024-10-01'),
       (2, 1, 2,  '2024-10-15');

-------------------

CREATE PROCEDURE GetAllCustomers
AS
BEGIN
    SELECT CustomerID, CustomerName, Email, Phone
	FROM Customer;
	END


----
CREATE PROCEDURE GetProductById
    @ProductID INT
AS
BEGIN
    SELECT ProductID, ProductName, Price
    FROM Product
    WHERE ProductID = @ProductID;
END
--------------------------------------------------
CREATE PROCEDURE  GetOrdersByCustomerId
@CustomerID INT
AS
BEGIN
SELECT o.OrderID, o.OrderDate, p.ProductName, p.Price
FROM  Orders O 
JOIN Product p ON o.ProductID = p.ProductID
WHERE o.CustomerID = @CustomerID;
END
----------------------------------------------------------
CREATE PROCEDURE AddNewOrder
@CustomerID INT,
@ProductID INT,
@OrderDate DATE
AS 

BEGIN

INSERT INTO  Orders (CustomerID, ProductID, OrderDate)
VALUES (@CustomerID, @ProductID, @OrderDate);

END;

EXEC AddNewOrder @CustomerID = 1, @ProductID = 2, @OrderDate = '2024-10-29';
----(OrderId sutunu NULL deger almadigi icin ve otamatik artan IDENTITY olarak tanimlanmadigi icin hata veriyor)--------

--- Mevcut tablonun kontrol edilmesi-- 
EXEC sp_help 'Orders'

--Mevcut tablonun guncellenmesi---

1)--Mevcut tabloyu gecici bir tabloya tasinmasi--
SELECT * INTO TempOrders FROM Orders;

2)--Mevcut tablonun silinmesi--
DROP TABLE Orders;

3)--Yeni Orders Tablosunun olusturulmasi--

CREATE TABLE Orders (
OrderID INT IDENTITY(1,1) PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
OrderDate DATE
);

4)-- Gecici tablo verilerini yeni tabloya tasi--

INSERT INTO Orders (CustomerID, ProductID, OrderDate)
SELECT CustomerID, ProductID, OrderDate FROM TempOrders;

5)-- Gecici tabloyu sil--
DROP TABLE TempOrders;


6-- Procedure kullan--
EXEC AddNewOrder @CustomerID = 1, @ProductID = 2, @OrderDate = '2024-10-29';



--Belirli musterinin siparislerini getiren procedure 
EXEC GetOrdersByCustomerId @CustomerID = 1;


--Belirli urunu ID ile getirme--
EXEC GetProductById @ProductID = 1;
