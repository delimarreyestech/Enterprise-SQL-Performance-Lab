/*
    Project: Enterprise SQL Performance Lab
    Script: 01_Create_Database.sql
    Purpose: Create the main database for the performance tuning lab.
*/

USE master;
GO

IF DB_ID('EnterprisePerformanceLab') IS NOT NULL
BEGIN
    ALTER DATABASE EnterprisePerformanceLab SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EnterprisePerformanceLab;
END;
GO

CREATE DATABASE EnterprisePerformanceLab;
GO

ALTER DATABASE EnterprisePerformanceLab SET RECOVERY SIMPLE;
GO

USE EnterprisePerformanceLab;
GO

SELECT
    DB_NAME() AS CurrentDatabase,
    GETDATE() AS CreatedAt;
GO