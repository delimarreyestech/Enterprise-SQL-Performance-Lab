# Data Generation Strategy

## Objective

Generate realistic enterprise-scale datasets that allow the reproduction of SQL Server performance issues.

---

# Business Scenario

A multinational retail company operates across North America, South America and Europe.

The platform receives approximately:

- 25,000 orders/day
- 120,000 order lines/day
- 15,000 payments/day
- 15,000 shipments/day

Historical data is retained for five years.

---

# Target Dataset Size

Countries             30

Categories            25

Warehouses            40

Suppliers            500

Products          50,000

Customers      1,000,000

Orders        15,000,000

OrderDetails  80,000,000

Payments      15,000,000

Shipments     15,000,000

Inventory        500,000

ProductSuppliers 150,000

## Design Intent

The data volume is intentionally large enough to create realistic performance problems, including:

- Table scans
- Expensive joins
- Key lookups
- Large aggregations
- Date range filtering
- Parameter-sensitive queries
- Blocking scenarios
- Deadlock scenarios

---

## Data Generation Rules

- All foreign key relationships must remain valid.
- Order dates should span multiple years.
- Customers should be distributed across countries.
- Products should be distributed across categories.
- Orders should contain multiple order details.
- Payments and shipments should be linked to orders.
- Inventory should be distributed across warehouses and products.
- Data should support both OLTP and reporting workloads.

---

## Performance Scenarios Supported

This dataset will support the following scenarios:

1. Slow customer order searches.
2. Missing index analysis.
3. Key lookup optimization.
4. Parameter sniffing.
5. Blocking.
6. Deadlocks.
7. Reporting query optimization.
8. Wait statistics analysis.
9. Before vs After performance comparison.

---

## Success Criteria

The generated data should allow measurable performance analysis using:

- Execution time
- Logical reads
- Execution plans
- Wait statistics
- Index usage
- Query Store
- Before vs After metrics