/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 07_System_Health_Report.sql
Purpose : Generate a high-level health report for the lab database.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

------------------------------------------------------------
-- Database Overview
------------------------------------------------------------
SELECT
    DB_NAME() AS DatabaseName,
    SYSDATETIME() AS ReportGeneratedAt;
GO

------------------------------------------------------------
-- Table Health Summary
------------------------------------------------------------
SELECT
    t.name AS TableName,
    SUM(p.rows) AS RowCount,
    COUNT(i.index_id) AS IndexCount
FROM sys.tables t
INNER JOIN sys.partitions p
    ON t.object_id = p.object_id
    AND p.index_id IN (0,1)
LEFT JOIN sys.indexes i
    ON t.object_id = i.object_id
    AND i.name IS NOT NULL
WHERE
    t.is_ms_shipped = 0
GROUP BY
    t.name
ORDER BY
    RowCount DESC;
GO

------------------------------------------------------------
-- Constraint Summary
------------------------------------------------------------
SELECT
    t.name AS TableName,
    COUNT(kc.object_id) AS KeyConstraints
FROM sys.tables t
LEFT JOIN sys.key_constraints kc
    ON t.object_id = kc.parent_object_id
WHERE
    t.is_ms_shipped = 0
GROUP BY
    t.name
ORDER BY
    t.name;
GO

------------------------------------------------------------
-- Foreign Key Summary
------------------------------------------------------------
SELECT
    OBJECT_NAME(parent_object_id) AS ChildTable,
    COUNT(*) AS ForeignKeyCount
FROM sys.foreign_keys
GROUP BY parent_object_id
ORDER BY ChildTable;
GO

------------------------------------------------------------
-- Statistics Summary
------------------------------------------------------------
SELECT
    OBJECT_NAME(st.object_id) AS TableName,
    COUNT(*) AS StatisticsCount,
    MIN(STATS_DATE(st.object_id, st.stats_id)) AS OldestStatisticUpdate,
    MAX(STATS_DATE(st.object_id, st.stats_id)) AS LatestStatisticUpdate
FROM sys.stats st
INNER JOIN sys.tables t
    ON st.object_id = t.object_id
WHERE
    t.is_ms_shipped = 0
GROUP BY
    OBJECT_NAME(st.object_id)
ORDER BY
    TableName;
GO

------------------------------------------------------------
-- Largest Tables by Reserved Space
------------------------------------------------------------
SELECT
    t.name AS TableName,
    CAST(SUM(a.total_pages) * 8.0 / 1024 AS DECIMAL(18,2)) AS ReservedMB,
    CAST(SUM(a.used_pages) * 8.0 / 1024 AS DECIMAL(18,2)) AS UsedMB
FROM sys.tables t
INNER JOIN sys.indexes i
    ON t.object_id = i.object_id
INNER JOIN sys.partitions p
    ON i.object_id = p.object_id
    AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a
    ON p.partition_id = a.container_id
WHERE
    t.is_ms_shipped = 0
GROUP BY
    t.name
ORDER BY
    ReservedMB DESC;
GO