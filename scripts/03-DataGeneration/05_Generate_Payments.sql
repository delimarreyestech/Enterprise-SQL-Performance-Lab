/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 05_Generate_Payments.sql
Purpose : Generate 15 million Payments using batch processing
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

DECLARE @TargetRows BIGINT = 15000000;
DECLARE @BatchSize INT = 10000;
DECLARE @Current BIGINT = 0;

PRINT 'Generating Payments...';

WHILE @Current < @TargetRows
BEGIN

    ;WITH Numbers AS
    (
        SELECT TOP (@BatchSize)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    )
    INSERT INTO dbo.Payments
    (
        OrderID,
        PaymentDate,
        PaymentMethod,
        PaymentStatus,
        Amount,
        TransactionRef
    )
    SELECT
        ABS(CHECKSUM(NEWID())) % 15000000 + 1 AS OrderID,
        DATEADD(DAY, -(ABS(CHECKSUM(NEWID())) % 1825), GETDATE()) AS PaymentDate,
        CHOOSE
        (
            ABS(CHECKSUM(NEWID())) % 5 + 1,
            'Credit Card',
            'Debit Card',
            'Bank Transfer',
            'Digital Wallet',
            'Gift Card'
        ) AS PaymentMethod,
        CHOOSE
        (
            ABS(CHECKSUM(NEWID())) % 5 + 1,
            'Approved',
            'Pending',
            'Failed',
            'Refunded',
            'Cancelled'
        ) AS PaymentStatus,
        CAST(ABS(CHECKSUM(NEWID())) % 1200 + 20 AS DECIMAL(18,2)) AS Amount,
        CONCAT('TXN-', FORMAT(@Current + N, '000000000')) AS TransactionRef
    FROM Numbers;

    SET @Current += @BatchSize;

    PRINT CONCAT(@Current, ' Payments generated');

END

PRINT 'Finished generating Payments.';
GO

SELECT COUNT(*) AS TotalPayments
FROM dbo.Payments;
GO