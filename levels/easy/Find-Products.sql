select product_id , product_name , description from products where description ~ '(^| )SN[0-9]{4}-[0-9]{4}($| )' order by product_id ASC;
