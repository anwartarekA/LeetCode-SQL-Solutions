select d.id , j.revenue as Jan_Revenue , f.revenue as Feb_Revenue , m.revenue as Mar_Revenue , a.revenue as Apr_revenue, may.revenue as May_Revenue , jun.revenue as Jun_Revenue, jul.revenue as Jul_Revenue, aug.revenue as Aug_Revenue , sep.revenue as Sep_Revenue, oct.revenue as Oct_Revenue , nov.revenue as Nov_Revenue , december.revenue as Dec_Revenue
 from (select distinct id from Department) d 
left outer join 
(select id , revenue , month from Department where month ='Jan') j
 on d.id = j.id
 left outer join
(select id , revenue , month from Department where month = 'Feb') f on d.id = f.id 
left outer join 
(select id , revenue , month from Department where month = 'Mar') m on d.id = m.id 
left outer join 
(select id , revenue , month from Department where month = 'Apr') a on d.id = a.id 
left outer join 
(select id , revenue , month from Department where month = 'May') may on d.id = may.id 
left outer join 
(select id , revenue , month from Department where month = 'Jun') jun on d.id = jun.id 
left outer join 
(select id , revenue , month from Department where month = 'Jul') jul on d.id = jul.id 
left outer join 
(select id , revenue , month from Department where month = 'Aug') aug on d.id = aug.id 
left outer join 
(select id , revenue , month from Department where month = 'Sep') sep on d.id = sep.id 
left outer join 
(select id , revenue , month from Department where month = 'Oct') oct on d.id = oct.id 
left outer join 
(select id , revenue , month from Department where month = 'Nov') nov on d.id = nov.id 
left outer join 
(select id , revenue , month from Department where month = 'Dec') december on d.id = december.id order by d.id ASC
