

/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 06_Data_Quality_Check.sql
Purpose : Validate basic data quality rules across core tables.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

DECLARE @DataQuality TABLE
(
    CheckName NVARCHAR(200),
    IssueCount BIGINT,
    Status NVARCHAR(20)
);

INSERT INTO @DataQuality
SELECT
    'Customers with missing email',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Customers
WHERE Email IS NULL OR LTRIM(RTRIM(Email)) = ''

UNION ALL

SELECT
    'Orders with negative totals',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Orders
WHERE TotalAmount < 0

UNION ALL

SELECT
    'OrderDetails with invalid quantity',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.OrderDetails
WHERE Quantity <= 0

UNION ALL

SELECT
    'OrderDetails with negative line total',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.OrderDetails
WHERE LineTotal < 0

UNION ALL

SELECT
    'Payments with negative amount',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Payments
WHERE Amount < 0

UNION ALL

SELECT
    'Shipments with negative shipping cost',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Shipments
WHERE ShippingCost < 0

UNION ALL

SELECT
    'Inventory with negative quantity on hand',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Inventory
WHERE QuantityOnHand < 0

UNION ALL

SELECT
    'Inventory with negative reserved quantity',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Inventory
WHERE QuantityReserved < 0

UNION ALL

SELECT
    'Products with invalid price',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.Products
WHERE UnitPrice < 0 OR StandardCost < 0

UNION ALL

SELECT
    'ProductSuppliers with invalid purchase price',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.ProductSuppliers
WHERE PurchasePrice < 0

UNION ALL

SELECT
    'ProductSuppliers with invalid lead time',
    COUNT_BIG(*),
    CASE WHEN COUNT_BIG(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM dbo.ProductSuppliers
WHERE LeadTimeDays < 0;

SELECT *
FROM @DataQuality
ORDER BY CheckName;
GO