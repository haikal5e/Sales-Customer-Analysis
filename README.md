# Classic Models Database Analysis

## Overview
This project explores the **Classic Models** sample database, a fictional business selling collectible car models. Using SQL queries and Python (`pandas` + `SQLAlchemy`), we extract and present business insights in a clear, structured way.

Key tables:
- **customers**: Customer details (location, contact, assigned sales rep, credit limit)
- **employees**: Staff information (name, title, office, reporting hierarchy)
- **offices**: Office locations and contacts
- **payments**: Records of customer payment history

## Purpose
Run a series of SQL queries to uncover insights such as:
- Customer distribution by country
- Top-paying and inactive customers
- Sales performance and revenue trends
- Employee hierarchy and office staffing levels
- Identification of customers without payments or assigned reps

## Tools Used
- **SQLAlchemy**: Connect to MySQL database
- **pandas**: Load query results and display as tables

## Key Insights
- Certain countries dominate sales and have high credit usage
- Some customers lack assigned sales reps or payment records
- Office sizes and employee counts vary widely
- Monthly and per-office revenue breakdown highlights trends
