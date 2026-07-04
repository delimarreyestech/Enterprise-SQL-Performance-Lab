# Countries Table

## Purpose

The 'Countries' table stores reference data used to classify customers by country and region.

This table supports customer segmentation, regional reporting and performance scenarios involving joins between customers, orders and geographic dimensions.

---

## Design Decisions

### Identity Primary Key

`CountryID` is defined as an integer identity column and used as the primary key.

This provides a compact and efficient surrogate key for joins with related tables.

---

### Country Code

`CountryCode` uses `CHAR(2)` to store ISO-style country codes.

A fixed-length data type is appropriate because country codes have a predictable length.

---

### Country Name and Region

`CountryName` and `Region` use `NVARCHAR` to support international characters.

This is important in enterprise systems that operate across multiple countries.

---

### Created Date

`CreatedDate` uses `DATETIME2(0)` instead of `DATETIME`.

`DATETIME2` provides better precision and is the recommended modern date/time data type in SQL Server.

---

### Unique Constraint

A unique constraint is created on `CountryCode` to prevent duplicate country records.

This improves data quality and supports reliable joins.

---

## Best Practices Applied

- Surrogate primary key.
- Unique business identifier.
- Explicit constraints.
- Default values.
- Unicode support.
- Modern date/time data type.

