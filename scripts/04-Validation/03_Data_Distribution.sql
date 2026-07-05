/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 03_Data_Distribution.sql
Purpose : Analyze data distribution across key business columns.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

------------------------------------------------------------
-- Customers by Country
------------------------------------------------------------
SELECT
    co.CountryName,
    co.Region,
    COUNT_BIG(*) AS TotalCustomers
FROM dbo.Customers c
INNER JOIN dbo.Countries co
    ON c.CountryID = co.CountryID
GROUP BY
    co.CountryName,
    co.Region
ORDER BY
    TotalCustomers DESC;
GO

------------------------------------------------------------
-- Orders by Status
------------------------------------------------------------
SELECT
    OrderStatus,
    COUNT_BIG(*) AS TotalOrders
FROM dbo.Orders
GROUP BY OrderStatus
ORDER BY TotalOrders DESC;
GO

------------------------------------------------------------
-- Orders by Sales Channel
------------------------------------------------------------
SELECT
    SalesChannel,
    COUNT_BIG(*) AS TotalOrders
FROM dbo.Orders
GROUP BY SalesChannel
ORDER BY TotalOrders DESC;
GO

------------------------------------------------------------
-- Orders by Year
------------------------------------------------------------
SELECT
    YEAR(OrderDate) AS OrderYear,
    COUNT_BIG(*) AS TotalOrders
FROM dbo.Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
GO

------------------------------------------------------------
-- Products by Category
------------------------------------------------------------
SELECT
    c.CategoryName,
    COUNT_BIG(*) AS TotalProducts
FROM dbo.Products p
INNER JOIN dbo.Categories c
    ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalProducts DESC;
GO

------------------------------------------------------------
-- Payments by Status
------------------------------------------------------------
SELECT
    PaymentStatus,
    COUNT_BIG(*) AS TotalPayments
FROM dbo.Payments
GROUP BY PaymentStatus
ORDER BY TotalPayments DESC;
GO

------------------------------------------------------------
-- Shipments by Status
------------------------------------------------------------
SELECT
    ShipmentStatus,
    COUNT_BIG(*) AS TotalShipments
FROM dbo.Shipments
GROUP BY ShipmentStatus
ORDER BY TotalShipments DESC;
GO

------------------------------------------------------------
-- Inventory by Warehouse
------------------------------------------------------------
SELECT
    w.WarehouseName,
    COUNT_BIG(*) AS InventoryRows,
    SUM(i.QuantityOnHand) AS TotalQuantityOnHand,
    SUM(i.QuantityReserved) AS TotalQuantityReserved
FROM dbo.Inventory i
INNER JOIN dbo.Warehouses w
    ON i.WarehouseID = w.WarehouseID
GROUP BY w.WarehouseName
ORDER BY InventoryRows DESC;
GO