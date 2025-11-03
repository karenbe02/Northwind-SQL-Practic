# Northwind-SQL-Practic
SQL Server exercises using the Northwind database for data analysis and reporting

# 📊 Northwind SQL Practice

This project contains SQL Server exercises using the **Northwind** sample database.  
It’s designed to demonstrate SQL skills for data analysis, reporting, and database design.

## 🧠 Topics Covered
- Database creation and normalization
- INNER, LEFT, and RIGHT JOINs
- Aggregations: SUM, AVG, COUNT, GROUP BY
- Views, Stored Procedures, and Triggers
- Data cleaning and transformation in SQL Server

## 🧾 Example Queries
```sql
-- 1️⃣ Total de ventas por cliente
SELECT 
    c.CompanyName AS Cliente,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Total_Ventas
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
ORDER BY Total_Ventas DESC;

