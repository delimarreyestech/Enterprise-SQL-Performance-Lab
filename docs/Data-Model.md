# Data Model

## Overview

This project uses a transactional retail database model designed to simulate an enterprise e-commerce environment.

The model supports order processing, customer history, product catalog analysis and performance tuning scenarios.

---

## Main Entities

### Customers

Stores customer information.

### Countries

Stores country and regional information.

### Products

Stores product catalog data.

### Categories

Groups products by business category.

### Orders

Stores order header information.

### OrderDetails

Stores order line items.

### Payments

Stores payment transactions.

### Shipments

Stores shipment and delivery information.

---

## Relationships

- One country can have many customers.
- One customer can place many orders.
- One order can contain many order details.
- One product can appear in many order details.
- One category can contain many products.
- One order can have one or many payments.
- One order can have one shipment.

---

## Performance Design Intent

This model is intentionally designed to support performance tuning scenarios such as:

- Missing indexes.
- Poor join strategies.
- Parameter sniffing.
- Large table scans.
- Blocking.
- Deadlocks.
- Aggregation bottlenecks.
- Reporting query optimization.

---

## Initial Tables

- Countries
- Customers
- Categories
- Products
- Orders
- OrderDetails
- Payments
- Shipments