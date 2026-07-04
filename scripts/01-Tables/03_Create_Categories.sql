/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 03_Create_Categories.sql
Purpose : Create the Categories reference table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Categories;
END;
GO

CREATE TABLE dbo.Categories
(
    CategoryID    INT IDENTITY(1,1) NOT NULL,
    CategoryName  NVARCHAR(100) NOT NULL,
    Description   NVARCHAR(500) NULL,
    IsActive      BIT NOT NULL
        CONSTRAINT DF_Categories_IsActive DEFAULT (1),
    CreatedDate   DATETIME2(0) NOT NULL
        CONSTRAINT DF_Categories_CreatedDate DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_Categories
        PRIMARY KEY CLUSTERED (CategoryID),

    CONSTRAINT UQ_Categories_CategoryName
        UNIQUE (CategoryName)
);
GO