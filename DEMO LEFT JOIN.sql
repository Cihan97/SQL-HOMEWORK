--Orders without a sales representative
--Purpose; List all orders that do not have a sales representative assigned.
--Tables: Sales.SalesOrderHeader, Sales.SalesPerson

SELECT 
soh.SalesOrderID,
soh.Orderdate,
soh.TotalDue,
sp.BusinessEntityID AS SalesPersonID,
sp.SalesQuota

FROM 
Sales.SalesOrderHeader soh

LEFT JOIN 
Sales.SalesPerson sp ON soh.SalesPersonID = SP.BusinessEntityID

WHERE sp.BusinessEntityID IS NULL ; 


