-- 1. count the total no-of orders
select count(order_id) as total_orders
from orders;

-- 2.order status count
select status ,count(status) as order_status_count
from orders
group by status;	

-- 3.10 most recent orders
select order_date ,order_id
from orders
order by order_date desc
limit 10;

-- 4.10 highest value orders
select product_id , cost
from products
order by cost desc
limit 10;

-- 5.count orders placed per day in chronological order
select order_date ,count(*) as total_orders
from orders
group by order_date
order by order_date asc;

-- 6.monthly order trends
select month(order_date) as month_num ,count(order_id)
from orders
group by month(order_date)
order by month(order_date);

-- 7.AVERAGE value order
select round(avg(order_amount),2) as avg_value
from (select order_id ,sum(quantity*unit_price) as order_amount
from order_items
group by order_id) as total;

-- 8. top 10 customers by order count
SELECT customer_id, total_orders, customer_rank
FROM (
    SELECT 
        customer_id, 
        COUNT(order_id) AS total_orders,
        DENSE_RANK() OVER (ORDER BY COUNT(order_id) DESC) AS customer_rank
    FROM orders
    GROUP BY customer_id
) AS subquery
WHERE customer_rank <= 10
limit 10;