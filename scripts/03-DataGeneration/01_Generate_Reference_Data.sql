/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 01_Generate_Reference_Data.sql
Purpose : Generate reference/master data.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

----------------------------------------------------------
-- Countries: 30 rows
----------------------------------------------------------

INSERT INTO dbo.Countries (CountryCode, CountryName, Region)
VALUES
('US','United States','North America'),
('CA','Canada','North America'),
('MX','Mexico','North America'),
('CO','Colombia','South America'),
('BR','Brazil','South America'),
('AR','Argentina','South America'),
('CL','Chile','South America'),
('PE','Peru','South America'),
('EC','Ecuador','South America'),
('UY','Uruguay','South America'),
('GB','United Kingdom','Europe'),
('ES','Spain','Europe'),
('FR','France','Europe'),
('DE','Germany','Europe'),
('IT','Italy','Europe'),
('NL','Netherlands','Europe'),
('PT','Portugal','Europe'),
('SE','Sweden','Europe'),
('NO','Norway','Europe'),
('DK','Denmark','Europe'),
('JP','Japan','Asia'),
('KR','South Korea','Asia'),
('CN','China','Asia'),
('IN','India','Asia'),
('SG','Singapore','Asia'),
('AU','Australia','Oceania'),
('NZ','New Zealand','Oceania'),
('ZA','South Africa','Africa'),
('AE','United Arab Emirates','Middle East'),
('SA','Saudi Arabia','Middle East');
GO

----------------------------------------------------------
-- Categories: 25 rows
----------------------------------------------------------

DECLARE @i INT = 1;

WHILE @i <= 25
BEGIN
    INSERT INTO dbo.Categories (CategoryName, Description)
    VALUES (
        CONCAT('Category ', FORMAT(@i, '00')),
        CONCAT('Retail product category ', FORMAT(@i, '00'))
    );

    SET @i += 1;
END;
GO

----------------------------------------------------------
-- Warehouses: 40 rows
----------------------------------------------------------

DECLARE @i INT = 1;

WHILE @i <= 40
BEGIN
    INSERT INTO dbo.Warehouses
    (
        WarehouseCode,
        WarehouseName,
        CountryID,
        City
    )
    VALUES
    (
        CONCAT('WH-', FORMAT(@i, '000')),
        CONCAT('Warehouse ', FORMAT(@i, '000')),
        ((@i - 1) % 30) + 1,
        CONCAT('City ', FORMAT(@i, '000'))
    );

    SET @i += 1;
END;
GO

----------------------------------------------------------
-- Suppliers: 500 rows
----------------------------------------------------------

DECLARE @i INT = 1;

WHILE @i <= 500
BEGIN
    INSERT INTO dbo.Suppliers
    (
        SupplierCode,
        SupplierName,
        CountryID,
        ContactEmail,
        Phone
    )
    VALUES
    (
        CONCAT('SUP-', FORMAT(@i, '000000')),
        CONCAT('Supplier ', FORMAT(@i, '000000')),
        ((@i - 1) % 30) + 1,
        CONCAT('supplier', @i, '@example.com'),
        CONCAT('+1-555-', FORMAT(@i, '000000'))
    );

    SET @i += 1;
END;
GO

----------------------------------------------------------
-- Products: 50,000 rows
----------------------------------------------------------

WITH Numbers AS
(
    SELECT TOP (50000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO dbo.Products
(
    ProductCode,
    ProductName,
    CategoryID,
    UnitPrice,
    StandardCost,
    CurrentStock,
    ReorderLevel
)
SELECT
    CONCAT('PRD-', FORMAT(n, '000000')),
    CONCAT('Product ', FORMAT(n, '000000')),
    ((n - 1) % 25) + 1,
    CAST((10 + (n % 500)) AS DECIMAL(18,2)),
    CAST((5 + (n % 250)) AS DECIMAL(18,2)),
    n % 1000,
    50
FROM Numbers;
GO

----------------------------------------------------------
-- Validation
----------------------------------------------------------

SELECT 'Countries' AS TableName, COUNT(*) AS TotalRows FROM dbo.Countries
UNION ALL
SELECT 'Categories', COUNT(*) FROM dbo.Categories
UNION ALL
SELECT 'Warehouses', COUNT(*) FROM dbo.Warehouses
UNION ALL
SELECT 'Suppliers', COUNT(*) FROM dbo.Suppliers
UNION ALL
SELECT 'Products', COUNT(*) FROM dbo.Products;
GO