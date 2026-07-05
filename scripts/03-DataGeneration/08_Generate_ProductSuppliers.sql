/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 08_Generate_ProductSuppliers.sql
Purpose : Generate 150,000 ProductSuppliers rows using batch processing
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

DECLARE @TargetRows BIGINT = 150000;
DECLARE @BatchSize INT = 10000;
DECLARE @Current BIGINT = 0;

PRINT 'Generating ProductSuppliers...';

WHILE @Current < @TargetRows
BEGIN

    ;WITH Numbers AS
    (
        SELECT TOP (@BatchSize)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS N
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    )
    INSERT INTO dbo.ProductSuppliers
    (
        ProductID,
        SupplierID,
        SupplierProductCode,
        PurchasePrice,
        LeadTimeDays,
        IsPreferred
    )
    SELECT
        ((@Current + N - 1) % 50000) + 1 AS ProductID,
        ((@Current + N - 1) % 500) + 1 AS SupplierID,
        CONCAT('SUP-PRD-', FORMAT(@Current + N, '000000000')) AS SupplierProductCode,
        CAST((ABS(CHECKSUM(NEWID())) % 400) + 5 AS DECIMAL(18,2)) AS PurchasePrice,
        (ABS(CHECKSUM(NEWID())) % 45) + 1 AS LeadTimeDays,
        CASE 
            WHEN ((@Current + N) % 3) = 0 THEN 1
            ELSE 0
        END AS IsPreferred
    FROM Numbers;

    SET @Current += @BatchSize;

    PRINT CONCAT(@Current, ' ProductSuppliers rows generated');

END

PRINT 'Finished generating ProductSuppliers.';
GO

SELECT COUNT(*) AS TotalProductSuppliers
FROM dbo.ProductSuppliers;
GO