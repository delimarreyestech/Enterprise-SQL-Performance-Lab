/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 04_Generate_OrderDetails.sql
Purpose : Generate 80 million OrderDetails using batch processing
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

DECLARE @TargetRows BIGINT = 80000000;
DECLARE @BatchSize INT = 10000;
DECLARE @Current BIGINT = 0;

PRINT 'Generating OrderDetails...';

WHILE @Current < @TargetRows
BEGIN

    ;WITH Numbers AS
    (
        SELECT TOP (@BatchSize)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    )
    INSERT INTO dbo.OrderDetails
    (
        OrderID,
        ProductID,
        Quantity,
        UnitPrice,
        Discount,
        LineTotal
    )
    SELECT
        ABS(CHECKSUM(NEWID())) % 15000000 + 1 AS OrderID,
        ABS(CHECKSUM(NEWID())) % 50000 + 1 AS ProductID,
        ABS(CHECKSUM(NEWID())) % 10 + 1 AS Quantity,
        CAST(ABS(CHECKSUM(NEWID())) % 500 + 10 AS DECIMAL(18,2)) AS UnitPrice,
        CAST(ABS(CHECKSUM(NEWID())) % 50 AS DECIMAL(18,2)) AS Discount,
        CAST(ABS(CHECKSUM(NEWID())) % 5000 + 20 AS DECIMAL(18,2)) AS LineTotal
    FROM Numbers;

    SET @Current += @BatchSize;

    PRINT CONCAT(@Current, ' OrderDetails generated');

END

PRINT 'Finished generating OrderDetails.';
GO

SELECT COUNT(*) AS TotalOrderDetails
FROM dbo.OrderDetails;
GO