/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 07_Create_Payments.sql
Purpose : Create the Payments table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.Payments', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Payments;
END;
GO

CREATE TABLE dbo.Payments
(
    PaymentID      BIGINT IDENTITY(1,1) NOT NULL,
    OrderID        BIGINT NOT NULL,
    PaymentDate    DATETIME2(0) NOT NULL,
    PaymentMethod  NVARCHAR(50) NOT NULL,
    PaymentStatus  NVARCHAR(30) NOT NULL,
    Amount         DECIMAL(18,2) NOT NULL,
    TransactionRef NVARCHAR(100) NULL,
    CreatedDate    DATETIME2(0) NOT NULL
        CONSTRAINT DF_Payments_CreatedDate DEFAULT (SYSDATETIME()),
    CONSTRAINT PK_Payments
        PRIMARY KEY CLUSTERED (PaymentID),
    CONSTRAINT FK_Payments_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID),
    CONSTRAINT CK_Payments_Amount
        CHECK (Amount >= 0)
);
GO

CREATE NONCLUSTERED INDEX IX_Payments_OrderID
ON dbo.Payments(OrderID);
GO

CREATE NONCLUSTERED INDEX IX_Payments_PaymentDate
ON dbo.Payments(PaymentDate);
GO

CREATE NONCLUSTERED INDEX IX_Payments_Status_PaymentDate
ON dbo.Payments(PaymentStatus, PaymentDate);
GO

CREATE NONCLUSTERED INDEX IX_Payments_Method_Status
ON dbo.Payments(PaymentMethod, PaymentStatus);
GO