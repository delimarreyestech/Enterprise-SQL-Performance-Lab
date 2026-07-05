/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 08_Create_Shipments.sql
Purpose : Create the Shipments table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.Shipments', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Shipments;
END;
GO

CREATE TABLE dbo.Shipments
(
    ShipmentID          BIGINT IDENTITY(1,1) NOT NULL,
    OrderID             BIGINT NOT NULL,
    ShipmentDate        DATETIME2(0) NULL,
    EstimatedDelivery   DATETIME2(0) NOT NULL,
    DeliveredDate       DATETIME2(0) NULL,
    Carrier             NVARCHAR(100) NOT NULL,
    TrackingNumber      NVARCHAR(100) NOT NULL,
    ShipmentStatus      NVARCHAR(30) NOT NULL,
    ShippingCost        DECIMAL(18,2) NOT NULL,
    CreatedDate         DATETIME2(0) NOT NULL
        CONSTRAINT DF_Shipments_CreatedDate DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_Shipments
        PRIMARY KEY CLUSTERED (ShipmentID),
    CONSTRAINT FK_Shipments_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID),
    CONSTRAINT UQ_Shipments_TrackingNumber
        UNIQUE (TrackingNumber),
    CONSTRAINT CK_Shipments_ShippingCost
        CHECK (ShippingCost >= 0)
);
GO
