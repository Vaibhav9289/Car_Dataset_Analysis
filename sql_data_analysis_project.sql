-- using mintclassics database 
use mintclassics;

-- Getting all table names
show tables;

-- Exploratory Analysis 
select * from warehouses;

-- Number of products stored in each warehouse
select w.warehousecode,count(*) as Number_of_products
from products p
join warehouses w
on w.warehousecode=p.warehousecode
group by 1;


select count(*) from orders;

select count(*) from orderdetails;

select * from orders o join orderdetails od on o.ordernumber=od.ordernumber limit 5;

select * from products limit 5;

-- Number of Products in each Product line
select pl. productline,count(*)
from productlines pl
join products p
on pl.productLine=p.productLine
join orderdetails od
on p.productCode=od.productCode
join orders o
on od.orderNumber=o.orderNumber
group by 1
;

-- Number of orders products wise
select o.ordernumber,count(*)
from orderdetails od
join orders o
on o.orderNumber=od.orderNumber
group by 1;

select * from orderdetails order by orderNumber;
select * from offices;

select * from customers;

-- Total Orders, Total Quantity Ordered and Average Delivery Time of each warehouse
select w.warehousecode,count(*) as Total_orders,sum(quantityordered) as Total_Quantity,
	avg(priceeach) as Avg_Price,avg(DATEDIFF(shippeddate,orderdate)) as Average_delivery_days
from orderdetails od
join orders o
on o.ordernumber=od.ordernumber
join products p
on p.productcode=od.productcode
join warehouses w
on p.warehousecode=w.warehousecode
group by w.warehousecode
;

-- Found 1 product with no sales
select * from products where productcode='S18_3233';
select count(distinct productcode) from orderdetails;



select ordernumber,shippeddate,orderdate,datediff(day,orderdate,shippeddate) from orders;

SELECT ordernumber, shippeddate, orderdate, DATEDIFF(shippeddate,orderdate) as days_difference
FROM orders;

-- Number of Customers Served by each warehouse
select w.warehousecode,count(distinct o.customernumber) as total_customers_served
from customers c
right join orders o
on o.customernumber=c.customernumber
left join orderdetails od
on od.ordernumber=o.ordernumber
left join products p
on p.productcode=od.productcode
join warehouses w
on w.warehousecode=p.warehousecode
group by 1;

select count(*) from customers;

-- Total quantity in stock in each warehouse
select w.warehousecode,sum(quantityinstock) 
from products p
join warehouses w
on w.warehousecode=p.warehousecode
group by 1;

select * from offices;

-- Finding how much orders are shipped or not by each warehouse
select w.warehousecode,
case when status='Shipped' then 'Shipped' when status<>'Shipped' then 'Not Shipped' end as Status2,
count(od.ordernumber) from orders o
left join orderdetails od
on od.ordernumber=o.ordernumber
join products p
on p.productcode=od.productcode
join warehouses w
on p.warehousecode=w.warehousecode
group by 1,2;

select count(distinct ordernumber) from orderdetails;

-- Number of orders year wise of each warehouse
select w.warehousecode,year(orderdate) as y,count(distinct o.ordernumber) as Number_of_orders
from orders o
join orderdetails od
on od.ordernumber=o.ordernumber
join products p
on od.productcode=p.productcode
join warehouses w 
on w.warehousecode=p.warehousecode
group by 1,2
order by 1,2;

-- Number of orders served by each warehouse
select w.warehousecode,count(distinct o.ordernumber) 
from orders o
join orderdetails od
on od.ordernumber=o.ordernumber
join products p
on od.productcode=p.productcode
join warehouses w 
on w.warehousecode=p.warehousecode
group by 1;

-- Number of orders of each product 
select p.productcode,count(*) 
from orderdetails od
right join products p
on p.productcode=od.productcode
group by 1
order by 2;