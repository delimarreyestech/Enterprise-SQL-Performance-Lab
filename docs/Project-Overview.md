# Enterprise SQL Performance Lab

## Project Vision

This project simulates a real-world enterprise SQL Server environment where database performance has become a critical business issue.

Instead of demonstrating isolated SQL examples, the objective is to reproduce realistic production scenarios involving large transactional volumes, slow queries, blocking, deadlocks, parameter sniffing and indexing challenges.

The project documents the complete engineering process used to investigate, analyze and optimize SQL Server workloads using industry best practices.

---

# Business Scenario

A multinational retail company operates an e-commerce platform serving customers across multiple countries.

During periods of high demand, users begin reporting slow response times when searching orders, viewing customer history and generating operational reports.

Database CPU usage increases significantly, blocking sessions become frequent and several critical stored procedures exceed acceptable execution times.

The engineering team has been tasked with diagnosing the root causes and implementing performance improvements while maintaining data integrity and system availability.

---

# Project Goals

- Simulate an enterprise transactional database.
- Generate realistic production-sized datasets.
- Analyze execution plans.
- Optimize indexes.
- Reduce query execution time.
- Investigate wait statistics.
- Simulate blocking scenarios.
- Reproduce deadlocks.
- Demonstrate parameter sniffing.
- Measure improvements before and after optimization.

---

# Technologies

- Microsoft SQL Server
- T-SQL
- SQL Server Management Studio
- Execution Plans
- DMVs
- Query Store
- Extended Events
- Git
- GitHub

---

# Expected Outcome

This repository demonstrates practical SQL Server performance engineering techniques using realistic enterprise scenarios rather than isolated SQL exercises.