use classicmodels;

show TABLES;

describe customers;
describe employees;
describe offices;
describe payments;

select * from customers;

select * from employees;

-- 1. List all customers by country
SELECT country, customerName FROM customers ORDER BY country;

-- 2. Get total number of customers
SELECT COUNT(*) AS total_customers FROM customers;

-- 3. List all employees and their job titles
SELECT employeeNumber, firstName, lastName, jobTitle FROM employees;

-- 4. Show employees and their office city
SELECT e.firstName, e.lastName, o.city 
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode;

-- 5. List all customers and their assigned sales rep (employee)
SELECT c.customerName, e.firstName AS salesRepFirstName, e.lastName AS salesRepLastName 
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber;

-- 6. Show each office and number of employees in it
SELECT o.city, COUNT(e.employeeNumber) AS num_employees 
FROM offices o
LEFT JOIN employees e ON o.officeCode = e.officeCode
GROUP BY o.city;

-- 7. List employees and who they report to
SELECT e1.firstName AS employee, e2.firstName AS reportsTo 
FROM employees e1
LEFT JOIN employees e2 ON e1.reportsTo = e2.employeeNumber;

-- 8. Get total payments made by each customer
SELECT customerNumber, SUM(amount) AS total_payments 
FROM payments 
GROUP BY customerNumber;

-- 9. Find customers with no payments
SELECT c.customerName 
FROM customers c
LEFT JOIN payments p ON c.customerNumber = p.customerNumber
WHERE p.customerNumber IS NULL;

-- 10. List top 5 customers by total payment amount
SELECT c.customerName, SUM(p.amount) AS total_paid
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName
ORDER BY total_paid DESC
LIMIT 5;

-- 11. Find customers from a specific country (e.g., USA)
SELECT customerName FROM customers WHERE country = 'USA';

-- 12. Count number of customers per country
SELECT country, COUNT(*) AS total_customers 
FROM customers 
GROUP BY country
ORDER BY total_customers DESC;

-- 13. List all employees by office location
SELECT o.city, e.firstName, e.lastName 
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode
ORDER BY o.city;

-- 14. List all payments made in a specific year (e.g., 2024)
SELECT * FROM payments WHERE YEAR(paymentDate) = 2003;

-- 15. Get monthly payment summary
SELECT MONTH(paymentDate) AS month, SUM(amount) AS total_amount
FROM payments
GROUP BY MONTH(paymentDate)
ORDER BY month;

-- 16. Find customers with credit limit above a certain threshold
SELECT customerName, creditLimit 
FROM customers 
WHERE creditLimit > 50000;

-- 17. Find employees who are managers (i.e., are listed in `reportsTo`)
SELECT DISTINCT e2.employeeNumber, e2.firstName, e2.lastName 
FROM employees e1
JOIN employees e2 ON e1.reportsTo = e2.employeeNumber;

-- 18. Get total number of offices per country
SELECT country, COUNT(*) AS office_count 
FROM offices 
GROUP BY country;

-- 19. Find the average credit limit by country
SELECT country, ROUND(AVG(creditLimit),2) AS avg_credit 
FROM customers 
GROUP BY country;

-- 20. List employees without a manager
SELECT firstName, lastName 
FROM employees 
WHERE reportsTo IS NULL;

-- 21. Customers Who Paid Above Their Credit Limit
SELECT c.customerName, c.creditLimit, SUM(p.amount) AS totalPaid
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
HAVING totalPaid > c.creditLimit;

-- 22. Top-Selling Employees by Customer Payments
SELECT e.employeeNumber, e.firstName, e.lastName, SUM(p.amount) AS totalSales
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber
ORDER BY totalSales DESC
LIMIT 3;

-- 23. Monthly Revenue Breakdown by Office
SELECT o.city AS officeCity, MONTH(p.paymentDate) AS month, SUM(p.amount) AS monthlyRevenue
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY o.city, MONTH(p.paymentDate)
ORDER BY o.city, month;

-- 24. Customers Without Assigned Sales Rep
SELECT customerName, country 
FROM customers 
WHERE salesRepEmployeeNumber IS NULL;

-- 25. Hierarchy: Employees with Their Managers and Office Location
SELECT 
    e.employeeNumber AS empID,
    e.firstName AS employeeFirstName,
    e.lastName AS employeeLastName,
    m.firstName AS managerFirstName,
    m.lastName AS managerLastName,
    o.city AS officeCity
FROM employees e
LEFT JOIN employees m ON e.reportsTo = m.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode;