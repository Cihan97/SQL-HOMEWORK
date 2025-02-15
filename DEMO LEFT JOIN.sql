--Satis temsilcisi olamyan siparisler
--Amac ; Satis temsilcisi atanmamis tum siparisleri listelemek. 
-- Tablolar : Sales.SalesOrderHeader, Sales.SalesPerson

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


--WHERE sp.BusinessEntityID IS NULL komutu, sadece atis temsilcisi olmayan siparislerin filtrelenmesini saglar. 