/*
==========================================================
Project : Enterprise SQL Performance Lab
Script  : 04_Index_Validation.sql
Purpose : Validate indexes created in the performance lab database.
Author  : Delimar Reyes
==========================================================
*/

USE EnterprisePerformanceLab;
GO

SET NOCOUNT ON;

------------------------------------------------------------
-- Index Inventory
------------------------------------------------------------
SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    i.is_unique AS IsUnique,
    i.is_primary_key AS IsPrimaryKey,
    i.is_unique_constraint AS IsUniqueConstraint
FROM sys.indexes i
INNER JOIN sys.tables t
    ON i.object_id = t.object_id
INNER JOIN sys.schemas s
    ON t.schema_id = s.schema_id
WHERE
    i.name IS NOT NULL
ORDER BY
    t.name,
    i.name;
GO

------------------------------------------------------------
-- Index Columns
------------------------------------------------------------
SELECT
    t.name AS TableName,
    i.name AS IndexName,
    c.name AS ColumnName,
    ic.key_ordinal AS KeyOrdinal,
    ic.is_included_column AS IsIncludedColumn
FROM sys.indexes i
INNER JOIN sys.index_columns ic
    ON i.object_id = ic.object_id
    AND i.index_id = ic.index_id
INNER JOIN sys.columns c
    ON ic.object_id = c.object_id
    AND ic.column_id = c.column_id
INNER JOIN sys.tables t
    ON i.object_id = t.object_id
WHERE
    i.name IS NOT NULL
ORDER BY
    t.name,
    i.name,
    ic.key_ordinal,
    ic.index_column_id;
GO

------------------------------------------------------------
-- Heap Check
------------------------------------------------------------
SELECT
    t.name AS TableName,
    CASE
        WHEN i.index_id IS NULL THEN 'FAIL'
        ELSE 'PASS'
    END AS ClusteredIndexStatus
FROM sys.tables t
LEFT JOIN sys.indexes i
    ON t.object_id = i.object_id
    AND i.index_id = 1
WHERE
    t.is_ms_shipped = 0
ORDER BY
    t.name;
GO

------------------------------------------------------------
-- Index Count by Table
------------------------------------------------------------
SELECT
    t.name AS TableName,
    COUNT(i.index_id) AS IndexCount
FROM sys.tables t
LEFT JOIN sys.indexes i
    ON t.object_id = i.object_id
    AND i.name IS NOT NULL
WHERE
    t.is_ms_shipped = 0
GROUP BY
    t.name
ORDER BY
    IndexCount DESC,
    t.name;
GO