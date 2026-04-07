select buy.stock_name , (sell.sellingPrice - buy.buyingPrice) as capital_gain_loss from (
(select stock_name , operation , sum(price) as buyingPrice from Stocks group by stock_name , operation having operation = 'Buy' ) as buy 
inner join
(select stock_name , operation , sum(price) as sellingPrice from Stocks group by stock_name , operation having operation = 'Sell' ) as sell on buy.stock_name = sell.stock_name
) 
