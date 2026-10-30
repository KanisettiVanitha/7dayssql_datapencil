-- 1.total sales value
select sum(oi.quantity*oi.unit_price) as total_sales_values
from orders o 
join order_items oi
on  o.order_id = oi.order_id
where status <> 'cancelled';         --  <> - not equal

-- 2.revenue by product categorey , which category produce generate the most sales
select category ,sum(cost) 
from products
group by category
order by sum(cost) desc;

select p.category , sum(oi.quantity*oi.unit_price) as revenue
from orders o
join order_items oi
on o.order_id = oi.order_id
join products p
on oi.product_id =p.product_id
where status <> 'cancelled'
group by p.category
order by revenue asc;


-- 3.top 10 products by revenue
select p.product_name ,sum(oi.quantity*oi.unit_price) as revenue
from products p
join order_items oi
on p.product_id =oi.product_id
group by product_name
order by revenue desc
limit 10;

-- 4.monthly revenue trend
select month(order_date) as month_num ,sum(oi.quantity*oi.unit_price) as revenue
from orders o
join order_items oi
on o.order_id =oi.order_id
group by month(order_date)
order by month(order_date);

-- 5. revenue by sales channel
select o.channel,sum(oi.quantity*oi.unit_price) as revenue
from orders o
join order_items oi
on o.order_id =oi.order_id
where status <> 'cancelled'
group by o.channel;

-- 6.total quantity of products sold in each category
select p.category , sum(oi.quantity) as pro_quant
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.category;

-- 7.count how many payments were made using each payment method
select p.payment_method , count(payment_id) as payments_count
from payments p
join orders o
on p.order_id = o.order_id
group by payment_method
order by payments_count desc ;

-- 8.count payments by their status
select p.payment_status , count(payment_id) as status_count
from payments p
join orders o
on p.order_id = o.order_id
group by payment_status;

-- 9.average recorded payment amout
select avg(amount) as avg_amount
from payments;

-- 10.total recorded payment amt for each payment method
select p.payment_method , sum(amount) as total_amt
from payments p
join orders o
on p.order_id = o.order_id
group by payment_method
order by total_amt desc ;