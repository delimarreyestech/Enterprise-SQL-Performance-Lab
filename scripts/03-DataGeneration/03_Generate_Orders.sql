/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 03_Generate_Orders.sql
Purpose : Generate 15 million Orders using batch processing
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

DECLARE @TargetRows BIGINT = 15000000;
DECLARE @BatchSize INT = 10000;
DECLARE @Current BIGINT = 0;

PRINT 'Generating Orders...';

WHILE @Current < @TargetRows
BEGIN

    ;WITH Numbers AS
    (
        SELECT TOP (@BatchSize)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    )

    INSERT INTO dbo.Orders
    (
        OrderNumber,
        CustomerID,
        OrderDate,
        OrderStatus,
        SalesChannel,
        CurrencyCode,
        SubTotal,
        TaxAmount,
        ShippingAmount,
        TotalAmount
    )

    SELECT

        CONCAT(
            'ORD-',
            FORMAT(@Current + N,'000000000')
        ),
        ABS(CHECKSUM(NEWID())) % 1000000 + 1,
        DATEADD
        (
            DAY,
            -(ABS(CHECKSUM(NEWID())) % 1825),
            GETDATE()
        ),
        CHOOSE
        (
            ABS(CHECKSUM(NEWID())) % 5 + 1,
            'Pending',
            'Processing',
            'Completed',
            'Cancelled',
            'Returned'
        ),
        CHOOSE
        (
            ABS(CHECKSUM(NEWID())) % 4 + 1,
            'Web',
            'Mobile',
            'Store',
            'Marketplace'
        ),
        'USD',
        CAST(ABS(CHECKSUM(NEWID())) % 1000 + 50 AS DECIMAL(18,2)),
        CAST(ABS(CHECKSUM(NEWID())) % 100 AS DECIMAL(18,2)),
        CAST(ABS(CHECKSUM(NEWID())) % 40 AS DECIMAL(18,2)),
        CAST(ABS(CHECKSUM(NEWID())) % 1200 + 60 AS DECIMAL(18,2))
    FROM Numbers;
    SET @Current += @BatchSize;
    PRINT CONCAT(@Current,' Orders generated');
END

PRINT 'Finished.';
GO
