/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 06_Generate_Shipments.sql
Purpose : Generate 15 million Shipments using batch processing
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

DECLARE @TargetRows BIGINT = 15000000;
DECLARE @BatchSize INT = 10000;
DECLARE @Current BIGINT = 0;

PRINT 'Generating Shipments...';

WHILE @Current < @TargetRows
BEGIN

    ;WITH Numbers AS
    (
        SELECT TOP (@BatchSize)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    )
    INSERT INTO dbo.Shipments
    (
        OrderID,
        ShipmentDate,
        EstimatedDelivery,
        DeliveredDate,
        Carrier,
        TrackingNumber,
        ShipmentStatus,
        ShippingCost
    )
    SELECT
        ABS(CHECKSUM(NEWID())) % 15000000 + 1 AS OrderID,
        DATEADD(DAY, -(ABS(CHECKSUM(NEWID())) % 1825), GETDATE()) AS ShipmentDate,
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 10 + 1, GETDATE()) AS EstimatedDelivery,
        CASE 
            WHEN ABS(CHECKSUM(NEWID())) % 5 IN (0, 1, 2)
                THEN DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 15 + 1, GETDATE())
            ELSE NULL
        END AS DeliveredDate,
        CHOOSE
        (
            ABS(CHECKSUM(NEWID())) % 5 + 1,
            'DHL',
            'FedEx',
            'UPS',
            'USPS',
            'Local Carrier'
        ) AS Carrier,
        CONCAT('TRK-', FORMAT(@Current + N, '000000000')) AS TrackingNumber,
        CHOOSE
        (
            ABS(CHECKSUM(NEWID())) % 6 + 1,
            'Pending',
            'Processing',
            'Shipped',
            'In Transit',
            'Delivered',
            'Returned'
        ) AS ShipmentStatus,
        CAST(ABS(CHECKSUM(NEWID())) % 80 + 5 AS DECIMAL(18,2)) AS ShippingCost
    FROM Numbers;

    SET @Current += @BatchSize;

    PRINT CONCAT(@Current, ' Shipments generated');

END

PRINT 'Finished generating Shipments.';
GO

SELECT COUNT(*) AS TotalShipments
FROM dbo.Shipments;
GO