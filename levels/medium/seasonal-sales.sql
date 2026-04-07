select * from (
(select 'Fall' as season , category ,sum(quantity) as total_quantity ,ROUND(sum(price*quantity),2) as total_revenue  from sales join products on sales.product_id = products.product_id where to_char(sale_date , 'MM') in ('09','10','11') group by category order by total_quantity DESC, total_revenue DESC , category ASC limit  1) 
    union 
(select 'Spring' as season , category ,sum(quantity) as total_quantity ,ROUND(sum(price*quantity),2 )as total_revenue  from sales join products on sales.product_id = products.product_id where to_char(sale_date , 'MM') in ('03','04','05') group by category order by total_quantity DESC, total_revenue DESC , category ASC limit  1)
    union
(select 'Summer' as season , category ,sum(quantity) as total_quantity ,ROUND(sum(price*quantity),2) as total_revenue  from sales join products on sales.product_id = products.product_id where to_char(sale_date , 'MM') in ('06','07','08') group by category order by total_quantity DESC, total_revenue DESC , category ASC limit  1)
    union
(select 'Winter' as season , category ,sum(quantity) as total_quantity ,ROUND(sum(price*quantity),2) as total_revenue  from sales join products on sales.product_id = products.product_id where to_char(sale_date , 'MM') in ('12','01','02') group by category order by total_quantity DESC, total_revenue DESC , category ASC limit  1))as res order by season ASC
