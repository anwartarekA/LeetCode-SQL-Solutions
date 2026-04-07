SELECT stock_name , SUM(capital_gain_loss) AS capital_gain_loss FROM (SELECT stock_name , (CASE WHEN operation = 'Buy' THEN SUM(-price)
    ELSE SUM(price) END) AS capital_gain_loss FROM Stocks
GROUP BY stock_name , operation)
GROUP BY stock_name;