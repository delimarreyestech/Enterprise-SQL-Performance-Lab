/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 01_Create_Countries.sql
Purpose : Create the Countries reference table.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

IF OBJECT_ID('dbo.Countries', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Countries;
END;
GO

CREATE TABLE dbo.Countries
(
    CountryID    INT IDENTITY(1,1) NOT NULL,
    CountryCode  CHAR(2) NOT NULL,
    CountryName  NVARCHAR(100) NOT NULL,
    Region       NVARCHAR(100) NOT NULL,
    IsActive     BIT NOT NULL
        CONSTRAINT DF_Countries_IsActive DEFAULT (1),
    CreatedDate  DATETIME2(0) NOT NULL
        CONSTRAINT DF_Countries_CreatedDate DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_Countries
        PRIMARY KEY CLUSTERED (CountryID),

    CONSTRAINT UQ_Countries_CountryCode
        UNIQUE (CountryCode)
);
GO