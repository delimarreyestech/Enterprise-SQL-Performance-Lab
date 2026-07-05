/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 02_Foreign_Key_Validation.sql
Purpose : Validate referential integrity between related tables.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

DECLARE @FKValidation TABLE
(
    ValidationName NVARCHAR(200),
    OrphanRows BIGINT,
    Status NVARCHAR(20)
);

INSERT INTO @FKValidation
SELECT
    'Customers without valid Country',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Customers c
LEFT JOIN dbo.Countries co
    ON c.CountryID = co.CountryID
WHERE co.CountryID IS NULL

UNION ALL

SELECT
    'Products without valid Category',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Products p
LEFT JOIN dbo.Categories c
    ON p.CategoryID = c.CategoryID
WHERE c.CategoryID IS NULL

UNION ALL

SELECT
    'Orders without valid Customer',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Orders o
LEFT JOIN dbo.Customers c
    ON o.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL

UNION ALL

SELECT
    'OrderDetails without valid Order',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.OrderDetails od
LEFT JOIN dbo.Orders o
    ON od.OrderID = o.OrderID
WHERE o.OrderID IS NULL

UNION ALL

SELECT
    'OrderDetails without valid Product',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.OrderDetails od
LEFT JOIN dbo.Products p
    ON od.ProductID = p.ProductID
WHERE p.ProductID IS NULL

UNION ALL

SELECT
    'Payments without valid Order',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Payments p
LEFT JOIN dbo.Orders o
    ON p.OrderID = o.OrderID
WHERE o.OrderID IS NULL

UNION ALL

SELECT
    'Shipments without valid Order',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Shipments s
LEFT JOIN dbo.Orders o
    ON s.OrderID = o.OrderID
WHERE o.OrderID IS NULL

UNION ALL

SELECT
    'Warehouses without valid Country',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Warehouses w
LEFT JOIN dbo.Countries c
    ON w.CountryID = c.CountryID
WHERE c.CountryID IS NULL

UNION ALL

SELECT
    'Inventory without valid Warehouse',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Inventory i
LEFT JOIN dbo.Warehouses w
    ON i.WarehouseID = w.WarehouseID
WHERE w.WarehouseID IS NULL

UNION ALL

SELECT
    'Inventory without valid Product',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Inventory i
LEFT JOIN dbo.Products p
    ON i.ProductID = p.ProductID
WHERE p.ProductID IS NULL

UNION ALL

SELECT
    'Suppliers without valid Country',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Suppliers s
LEFT JOIN dbo.Countries c
    ON s.CountryID = c.CountryID
WHERE c.CountryID IS NULL

UNION ALL

SELECT
    'ProductSuppliers without valid Product',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.ProductSuppliers ps
LEFT JOIN dbo.Products p
    ON ps.ProductID = p.ProductID
WHERE p.ProductID IS NULL

UNION ALL

SELECT
    'ProductSuppliers without valid Supplier',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.ProductSuppliers ps
LEFT JOIN dbo.Suppliers s
    ON ps.SupplierID = s.SupplierID
WHERE s.SupplierID IS NULL;

SELECT *
FROM @FKValidation
ORDER BY ValidationName;
GO