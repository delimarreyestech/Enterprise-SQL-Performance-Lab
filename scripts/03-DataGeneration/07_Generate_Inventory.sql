/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 07_Generate_Inventory.sql
Purpose : Generate 500,000 Inventory rows using batch processing
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

DECLARE @TargetRows BIGINT = 500000;
DECLARE @BatchSize INT = 10000;
DECLARE @Current BIGINT = 0;

PRINT 'Generating Inventory...';

WHILE @Current < @TargetRows
BEGIN

    ;WITH Numbers AS
    (
        SELECT TOP (@BatchSize)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    )
    INSERT INTO dbo.Inventory
    (
        WarehouseID,
        ProductID,
        QuantityOnHand,
        QuantityReserved,
        ReorderPoint,
        LastStockUpdate
    )
    SELECT
        ABS(CHECKSUM(NEWID())) % 40 + 1 AS WarehouseID,
        ABS(CHECKSUM(NEWID())) % 50000 + 1 AS ProductID,
        ABS(CHECKSUM(NEWID())) % 5000 AS QuantityOnHand,
        ABS(CHECKSUM(NEWID())) % 500 AS QuantityReserved,
        ABS(CHECKSUM(NEWID())) % 200 + 20 AS ReorderPoint,
        DATEADD(DAY, -(ABS(CHECKSUM(NEWID())) % 365), GETDATE()) AS LastStockUpdate
    FROM Numbers;

    SET @Current += @BatchSize;

    PRINT CONCAT(@Current, ' Inventory rows generated');

END

PRINT 'Finished generating Inventory.';
GO

SELECT COUNT(*) AS TotalInventory
FROM dbo.Inventory;
GO