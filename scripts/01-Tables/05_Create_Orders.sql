/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 05_Create_Orders.sql
Purpose : Create the Orders table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Orders;
END;
GO

CREATE TABLE dbo.Orders
(
    OrderID        BIGINT IDENTITY(1,1) NOT NULL,
    OrderNumber    NVARCHAR(30) NOT NULL,
    CustomerID     INT NOT NULL,
    OrderDate      DATETIME2(0) NOT NULL,
    OrderStatus    NVARCHAR(30) NOT NULL,
    SalesChannel   NVARCHAR(30) NOT NULL,
    CurrencyCode   CHAR(3) NOT NULL,
    SubTotal       DECIMAL(18,2) NOT NULL,
    TaxAmount      DECIMAL(18,2) NOT NULL,
    ShippingAmount DECIMAL(18,2) NOT NULL,
    TotalAmount    DECIMAL(18,2) NOT NULL,
    CreatedDate    DATETIME2(0) NOT NULL
        CONSTRAINT DF_Orders_CreatedDate DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_Orders
        PRIMARY KEY CLUSTERED (OrderID),
    CONSTRAINT UQ_Orders_OrderNumber
        UNIQUE (OrderNumber),
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES dbo.Customers(CustomerID),
    CONSTRAINT CK_Orders_TotalAmount
        CHECK (TotalAmount >= 0)
);
GO

CREATE NONCLUSTERED INDEX IX_Orders_CustomerID
ON dbo.Orders(CustomerID);
GO

CREATE NONCLUSTERED INDEX IX_Orders_OrderDate
ON dbo.Orders(OrderDate);
GO

CREATE NONCLUSTERED INDEX IX_Orders_Status_OrderDate
ON dbo.Orders(OrderStatus, OrderDate);
GO

CREATE NONCLUSTERED INDEX IX_Orders_SalesChannel_OrderDate
ON dbo.Orders(SalesChannel, OrderDate);
GO