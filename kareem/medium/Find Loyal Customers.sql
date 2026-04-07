SELECT customer_id FROM customer_transactions
GROUP BY customer_id
HAVING MAX(transaction_date) - MIN(transaction_date) >= 30 AND COUNT(transaction_type) FILTER (where transaction_type = 'purchase') >= 3 AND ((COUNT(transaction_type) FILTER (WHERE transaction_type = 'refund') * 100) / COUNT(transaction_type)) < 20 ORDER BY customer_id ASC;