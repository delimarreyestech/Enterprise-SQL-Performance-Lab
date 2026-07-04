/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 12_Create_ProductSuppliers.sql
Purpose : Create the ProductSuppliers bridge table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.ProductSuppliers', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.ProductSuppliers;
END;
GO

CREATE TABLE dbo.ProductSuppliers
(
    ProductSupplierID BIGINT IDENTITY(1,1) NOT NULL,
    ProductID         INT NOT NULL,
    SupplierID        INT NOT NULL,
    SupplierProductCode NVARCHAR(50) NULL,
    PurchasePrice     DECIMAL(18,2) NOT NULL,
    LeadTimeDays      INT NOT NULL,
    IsPreferred       BIT NOT NULL
        CONSTRAINT DF_ProductSuppliers_IsPreferred DEFAULT (0),
    CreatedDate       DATETIME2(0) NOT NULL
        CONSTRAINT DF_ProductSuppliers_CreatedDate DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_ProductSuppliers
        PRIMARY KEY CLUSTERED (ProductSupplierID),
    CONSTRAINT FK_ProductSuppliers_Product
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID),
    CONSTRAINT FK_ProductSuppliers_Supplier
        FOREIGN KEY (SupplierID)
        REFERENCES dbo.Suppliers(SupplierID),
    CONSTRAINT UQ_ProductSuppliers_Product_Supplier
        UNIQUE (ProductID, SupplierID),
    CONSTRAINT CK_ProductSuppliers_PurchasePrice
        CHECK (PurchasePrice >= 0),
    CONSTRAINT CK_ProductSuppliers_LeadTime
        CHECK (LeadTimeDays >= 0)
);
GO

----------------------------------------------------------
-- Indexes
----------------------------------------------------------

CREATE NONCLUSTERED INDEX IX_ProductSuppliers_Product
ON dbo.ProductSuppliers(ProductID);
GO

CREATE NONCLUSTERED INDEX IX_ProductSuppliers_Supplier
ON dbo.ProductSuppliers(SupplierID);
GO

CREATE NONCLUSTERED INDEX IX_ProductSuppliers_Preferred
ON dbo.ProductSuppliers(IsPreferred);
GO