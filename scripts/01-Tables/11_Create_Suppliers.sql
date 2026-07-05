/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 11_Create_Suppliers.sql
Purpose : Create the Suppliers table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.Suppliers', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Suppliers;
END;
GO

CREATE TABLE dbo.Suppliers
(
    SupplierID     INT IDENTITY(1,1) NOT NULL,
    SupplierCode   NVARCHAR(30) NOT NULL,
    SupplierName   NVARCHAR(200) NOT NULL,
    CountryID      INT NOT NULL,
    ContactEmail   NVARCHAR(255) NULL,
    Phone          NVARCHAR(30) NULL,
    IsActive       BIT NOT NULL
        CONSTRAINT DF_Suppliers_IsActive DEFAULT (1),
    CreatedDate    DATETIME2(0) NOT NULL
        CONSTRAINT DF_Suppliers_CreatedDate DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_Suppliers
        PRIMARY KEY CLUSTERED (SupplierID),
    CONSTRAINT UQ_Suppliers_SupplierCode
        UNIQUE (SupplierCode),
    CONSTRAINT FK_Suppliers_Countries
        FOREIGN KEY (CountryID)
        REFERENCES dbo.Countries(CountryID)
);
GO

CREATE NONCLUSTERED INDEX IX_Suppliers_CountryID
ON dbo.Suppliers(CountryID);
GO

CREATE NONCLUSTERED INDEX IX_Suppliers_IsActive
ON dbo.Suppliers(IsActive);
GO
