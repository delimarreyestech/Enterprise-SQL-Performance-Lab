USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

------------------------------------------------------------
-- Customers: 1,000,000
------------------------------------------------------------

;WITH Numbers AS
(
    SELECT TOP (1000000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
    FROM sys.objects a
    CROSS JOIN sys.objects b
    CROSS JOIN sys.objects c
    CROSS JOIN sys.objects d
)
INSERT INTO dbo.Customers
(
    CustomerNumber,
    FirstName,
    LastName,
    Email,
    Phone,
    CountryID,
    RegistrationDate,
    IsActive
)
SELECT
    CONCAT('CUST-', FORMAT(RowNum, '00000000')) AS CustomerNumber,
    CONCAT('FirstName', RowNum) AS FirstName,
    CONCAT('LastName', RowNum) AS LastName,
    CONCAT('customer', RowNum, '@example.com') AS Email,
    CONCAT('+1-555-', FORMAT(RowNum % 10000, '0000')) AS Phone,
    ((RowNum - 1) % 30) + 1 AS CountryID,
    DATEADD(DAY, -1 * (RowNum % 1825), SYSDATETIME()) AS RegistrationDate,
    CASE WHEN RowNum % 20 = 0 THEN 0 ELSE 1 END AS IsActive
FROM Numbers;
GO

------------------------------------------------------------
-- Validation
------------------------------------------------------------

SELECT COUNT(*) AS TotalCustomers
FROM dbo.Customers;
GO