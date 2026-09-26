# ☕ Ajey's Cafe — SQL Data Analysis Project

## 📌 Project Overview

This project focuses on analyzing Ajey's Cafe order data using MySQL.

The project covers data cleaning, exploratory data analysis, business analysis, and advanced SQL techniques to generate meaningful business insights.

---

## 🎯 Project Objectives

The main objectives of this project are:

- Clean and standardize raw cafe order data
- Identify and remove duplicate records
- Handle invalid quantity and price values
- Standardize city and outlet names
- Convert different date formats into a standard DATETIME format
- Clean customer names
- Validate customer ratings
- Analyze outlet-wise revenue
- Identify top-selling items
- Analyze monthly and yearly sales trends
- Analyze payment mode distribution
- Calculate Average Order Value (AOV)
- Analyze rating and sales relationship
- Identify repeat customers
- Analyze Month-over-Month growth
- Rank outlets using Window Functions
- Identify outlets performing below average
- Create a reusable monthly reporting Stored Procedure

---

## 🛠️ Tools & Technologies

- MySQL
- SQL
- MySQL Workbench

---

## 🗂️ Dataset

The project uses cafe order data containing information such as:

- Order ID
- Outlet Name
- City
- Order Date & Time
- Item Name
- Quantity
- Price
- Payment Mode
- Customer Name
- Rating
- Franchise Owner

---

## 🧹 Data Cleaning

The following cleaning operations were performed:

1. Created a backup of the original table
2. Created a separate cleaning table
3. Checked duplicate records
4. Removed duplicate rows
5. Identified invalid quantity values
6. Identified invalid price values
7. Removed invalid quantity and price records
8. Standardized city names
9. Standardized outlet names
10. Converted multiple date formats into a standard DATETIME format
11. Cleaned customer names
12. Handled blank and NULL customer names
13. Validated rating values
14. Standardized franchise owner information

---

## 📊 Exploratory Data Analysis

The project analyzes:

### Revenue Analysis

- Overall revenue
- Outlet-wise revenue
- City-wise performance

### Product Analysis

- Most sold item overall
- Most sold item outlet-wise
- Low-rated but high-selling items

### Sales Trends

- Year-wise sales
- Month-wise sales
- Month-over-Month growth
- Year-over-Year growth

### Customer Analysis

- Repeat customers
- One-time vs repeat customers
- Customer order frequency

### Payment Analysis

- UPI transactions
- Cash transactions
- Card transactions
- Payment mode distribution

---

## 🚀 Advanced SQL Analysis

This project also demonstrates advanced SQL concepts:

- CTEs
- Subqueries
- Window Functions
- RANK()
- LAG()
- CASE statements
- EXISTS
- CROSS JOIN
- Aggregate Functions
- GROUP BY
- HAVING
- Date Functions
- Stored Procedures

---

## 📈 Business Questions Answered

Some of the key business questions answered in this project include:

1. Which outlet generates the highest revenue?
2. Which item is sold the most?
3. What are the monthly and yearly sales trends?
4. Which payment mode is used most frequently?
5. What is the Average Order Value for each outlet?
6. Is there a relationship between customer ratings and sales?
7. Which outlets show year-over-year growth?
8. Are weekends or weekdays generating more sales?
9. Which products are highly sold but poorly rated?
10. What percentage of customers are repeat customers?
11. What is the revenue ranking of outlets within each city?
12. Which outlets generate revenue below the overall outlet average?
13. Which customers have made repeat purchases?
14. Can a monthly outlet report be generated using a Stored Procedure?

---

## 🧠 SQL Concepts Demonstrated

```text
SELECT
WHERE
GROUP BY
HAVING
ORDER BY
CASE
JOIN / CROSS JOIN
Subqueries
CTEs
Window Functions
RANK()
LAG()
EXISTS
Aggregate Functions
Date Functions
Stored Procedures
