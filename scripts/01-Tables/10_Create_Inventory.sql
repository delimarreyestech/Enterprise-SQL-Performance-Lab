/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 10_Create_Inventory.sql
Purpose : Create the Inventory table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.Inventory', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Inventory;
END;
GO

CREATE TABLE dbo.Inventory
(
    InventoryID        BIGINT IDENTITY(1,1) NOT NULL,
    WarehouseID        INT NOT NULL,
    ProductID          INT NOT NULL,
    QuantityOnHand     INT NOT NULL,
    QuantityReserved   INT NOT NULL
        CONSTRAINT DF_Inventory_Reserved DEFAULT (0),
    ReorderPoint       INT NOT NULL
        CONSTRAINT DF_Inventory_Reorder DEFAULT (50),
    LastStockUpdate    DATETIME2(0) NOT NULL
        CONSTRAINT DF_Inventory_LastUpdate DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_Inventory
        PRIMARY KEY CLUSTERED (InventoryID),

    CONSTRAINT FK_Inventory_Warehouse
        FOREIGN KEY (WarehouseID)
        REFERENCES dbo.Warehouses(WarehouseID),
    CONSTRAINT FK_Inventory_Product
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID),
    CONSTRAINT CK_Inventory_OnHand
        CHECK (QuantityOnHand >= 0),
    CONSTRAINT CK_Inventory_Reserved
        CHECK (QuantityReserved >= 0)
);
GO

----------------------------------------------------------
-- Indexes
----------------------------------------------------------

CREATE NONCLUSTERED INDEX IX_Inventory_Product
ON dbo.Inventory(ProductID);
GO

CREATE NONCLUSTERED INDEX IX_Inventory_Warehouse
ON dbo.Inventory(WarehouseID);
GO

CREATE NONCLUSTERED INDEX IX_Inventory_Product_Warehouse
ON dbo.Inventory(ProductID, WarehouseID);
GO

CREATE NONCLUSTERED INDEX IX_Inventory_LastUpdate
ON dbo.Inventory(LastStockUpdate);
GO
