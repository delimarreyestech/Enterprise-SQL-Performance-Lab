/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 09_Create_Warehouses.sql
Purpose : Create the Warehouses table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.Warehouses', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Warehouses;
END;
GO

CREATE TABLE dbo.Warehouses
(
    WarehouseID    INT IDENTITY(1,1) NOT NULL,
    WarehouseCode  NVARCHAR(20) NOT NULL,
    WarehouseName  NVARCHAR(150) NOT NULL,
    CountryID      INT NOT NULL,
    City           NVARCHAR(100) NOT NULL,
    IsActive       BIT NOT NULL
        CONSTRAINT DF_Warehouses_IsActive DEFAULT (1),
    CreatedDate    DATETIME2(0) NOT NULL
        CONSTRAINT DF_Warehouses_CreatedDate DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_Warehouses
        PRIMARY KEY CLUSTERED (WarehouseID),
    CONSTRAINT UQ_Warehouses_WarehouseCode
        UNIQUE (WarehouseCode),
    CONSTRAINT FK_Warehouses_Countries
        FOREIGN KEY (CountryID)
        REFERENCES dbo.Countries(CountryID)
);
GO

CREATE NONCLUSTERED INDEX IX_Warehouses_CountryID
ON dbo.Warehouses(CountryID);
GO

CREATE NONCLUSTERED INDEX IX_Warehouses_IsActive
ON dbo.Warehouses(IsActive);
GO
