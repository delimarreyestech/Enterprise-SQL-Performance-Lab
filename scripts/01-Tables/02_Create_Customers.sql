/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 02_Create_Customers.sql
Purpose : Create the Customers table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Customers;
END;
GO

CREATE TABLE dbo.Customers
(
    CustomerID      INT IDENTITY(1,1) NOT NULL,
    CustomerNumber  NVARCHAR(20) NOT NULL,
    FirstName       NVARCHAR(100) NOT NULL,
    LastName        NVARCHAR(100) NOT NULL,
    Email           NVARCHAR(255) NOT NULL,
    Phone           NVARCHAR(30) NULL,
    CountryID       INT NOT NULL,
    RegistrationDate DATETIME2(0) NOT NULL
        CONSTRAINT DF_Customers_RegistrationDate
        DEFAULT (SYSDATETIME()),
    IsActive        BIT NOT NULL
        CONSTRAINT DF_Customers_IsActive
        DEFAULT (1),
    CONSTRAINT PK_Customers
        PRIMARY KEY CLUSTERED (CustomerID),
    CONSTRAINT UQ_Customers_CustomerNumber
        UNIQUE (CustomerNumber),
    CONSTRAINT UQ_Customers_Email
        UNIQUE (Email),
    CONSTRAINT FK_Customers_Countries
        FOREIGN KEY (CountryID)
        REFERENCES dbo.Countries(CountryID)
);
GO

------------------------------------------------------------
-- Nonclustered Indexes
------------------------------------------------------------

CREATE NONCLUSTERED INDEX IX_Customers_LastName
ON dbo.Customers (LastName);
GO

CREATE NONCLUSTERED INDEX IX_Customers_CountryID
ON dbo.Customers (CountryID);
GO

CREATE NONCLUSTERED INDEX IX_Customers_RegistrationDate
ON dbo.Customers (RegistrationDate);
GO