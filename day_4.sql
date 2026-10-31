-- CUSTOMER BEHAVIOUR & LOYALTY ANALYSIS

-- 1.total customers registered in database
select count(customer_id) as customer_count
from customers;

-- 2.cout of customers from each city & city with highest cust
select city ,count(customer_id) as customer_count
from customers
group by city
order by customer_count desc;

-- 3.top 10 customers by order count
select c.customer_id , sum(o.order_id) as order_count
from customers c
join orders o
on c.customer_id = o.customer_id
group by customer_id
order by order_count
limit 10;

-- 4.calculate the total spending of each customer based on order item values, excluding cancelled orders.
select c.customer_id , sum(oi.quantity*oi.unit_price) as spending
from customers c
join orders o
on c.customer_id= o.customer_id
join order_items oi
on o.order_id=oi.order_id
where status <> 'cancelled'
group by c.customer_id
ORDER BY spending DESC;

-- 5.avg spending of customers among customers  who have placed at least one non-cancelled order
SELECT AVG(customer_spending) AS avg_spending
FROM (
    SELECT o.customer_id,
           SUM(oi.quantity * oi.unit_price) AS customer_spending
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.status <> 'cancelled'
    GROUP BY o.customer_id
) AS total;

-- 6.customers with more than 5 non-cancelled orders
select c.customer_id , count(o.order_id) as order_count
from customers c
join orders o
on c.customer_id = o.customer_id
where status <> 'cancelled'
group by c.customer_id
having order_count>5
order by c.customer_id;

-- 7.count of customers from each customer segment
select segment ,count(customer_id) as seg_cust_count
from customers
group by segment;

-- 8.average orders per customer
select avg(total_orders) AS avg_orders_per_customer
from(
select customer_id , count(order_id) as total_orders
from orders 
group by customer_id) as total;

-- 9.top 10 customers who generated the highest item sales value from non cancelled values
SELECT
    c.customer_id,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status <> 'cancelled'
GROUP BY c.customer_id
ORDER BY total_sales DESC
LIMIT 10;


-- 10.count of new customers per month in chronological order
select date_format(signup_date , '%y-%m') as month_count,count(customer_id)
from customers
group by month_count
order by month_count;
