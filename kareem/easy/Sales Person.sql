SELECT DISTINCT SalesPerson.name
FROM SalesPerson
LEFT OUTER JOIN Orders
ON Orders.sales_id = SalesPerson.Sales_id
LEFT OUTER JOIN Company
ON Orders.com_id = Company.com_id
WHERE (Company.name <> 'RED' AND Orders.sales_id NOT IN (SELECT Orders.sales_id FROM Orders WHERE Orders.com_id = (SELECT com_id FROM Company WHERE Company.name = 'RED'))) OR Orders.sales_id IS NULL;