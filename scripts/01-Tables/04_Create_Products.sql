/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 04_Create_Products.sql
Purpose : Create the Products table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Products;
END;
GO

CREATE TABLE dbo.Products
(
    ProductID           INT IDENTITY(1,1) NOT NULL,
    ProductCode         NVARCHAR(30) NOT NULL,
    ProductName         NVARCHAR(200) NOT NULL,
    CategoryID          INT NOT NULL,
    UnitPrice           DECIMAL(18,2) NOT NULL,
    StandardCost        DECIMAL(18,2) NOT NULL,
    CurrentStock        INT NOT NULL
        CONSTRAINT DF_Products_CurrentStock
        DEFAULT (0),
    ReorderLevel        INT NOT NULL
        CONSTRAINT DF_Products_ReorderLevel
        DEFAULT (10),
    IsActive            BIT NOT NULL
        CONSTRAINT DF_Products_IsActive
        DEFAULT (1),
    CreatedDate         DATETIME2(0) NOT NULL
        CONSTRAINT DF_Products_CreatedDate
        DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_Products
        PRIMARY KEY CLUSTERED (ProductID),
    CONSTRAINT UQ_Products_ProductCode
        UNIQUE (ProductCode),
    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES dbo.Categories(CategoryID)
);
GO

----------------------------------------------------------
-- Nonclustered Indexes
----------------------------------------------------------

CREATE NONCLUSTERED INDEX IX_Products_CategoryID
ON dbo.Products(CategoryID);
GO

CREATE NONCLUSTERED INDEX IX_Products_ProductName
ON dbo.Products(ProductName);
GO

CREATE NONCLUSTERED INDEX IX_Products_IsActive
ON dbo.Products(IsActive);
GO