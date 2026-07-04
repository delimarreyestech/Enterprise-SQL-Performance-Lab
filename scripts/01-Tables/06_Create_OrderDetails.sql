/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 06_Create_OrderDetails.sql
Purpose : Create the OrderDetails table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.OrderDetails', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.OrderDetails;
END;
GO

CREATE TABLE dbo.OrderDetails
(
    OrderDetailID BIGINT IDENTITY(1,1) NOT NULL,
    OrderID       BIGINT NOT NULL,
    ProductID     INT NOT NULL,
    Quantity      INT NOT NULL,
    UnitPrice     DECIMAL(18,2) NOT NULL,
    Discount      DECIMAL(18,2) NOT NULL
        CONSTRAINT DF_OrderDetails_Discount DEFAULT (0),
    LineTotal     DECIMAL(18,2) NOT NULL,
    CONSTRAINT PK_OrderDetails
        PRIMARY KEY CLUSTERED (OrderDetailID),
    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID),
    CONSTRAINT CK_OrderDetails_Quantity
        CHECK (Quantity > 0),
    CONSTRAINT CK_OrderDetails_LineTotal
        CHECK (LineTotal >= 0)
);
GO

CREATE NONCLUSTERED INDEX IX_OrderDetails_OrderID
ON dbo.OrderDetails(OrderID);
GO

CREATE NONCLUSTERED INDEX IX_OrderDetails_ProductID
ON dbo.OrderDetails(ProductID);
GO

CREATE NONCLUSTERED INDEX IX_OrderDetails_ProductID_OrderID
ON dbo.OrderDetails(ProductID, OrderID);
GO