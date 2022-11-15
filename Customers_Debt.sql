--The objective of this query is to calculate how much every customer owe. For that we must calculate the total billing and the total amount paid separatly
--and then subtracte the values.

SELECT f.customerNumber, f.customerName, Total_billing, Total_paid, Total_billing-Total_paid as Debt
FROM
(SELECT o.customerNumber, customerName, sum(quantityOrdered*priceEach) AS Total_billing
FROM classicmodels.orderdetails AS od
INNER JOIN orders AS o ON od.orderNumber=o.orderNumber
INNER JOIN customers AS c ON c.customerNumber=o.customerNumber
GROUP BY customerNumber) AS f 

INNER JOIN

(SELECT customerNumber, SUM(amount) AS Total_paid
FROM classicmodels.payments
GROUP BY customerNumber) AS d ON f.customerNumber=d.customerNumber

ORDER BY Debt DESC
