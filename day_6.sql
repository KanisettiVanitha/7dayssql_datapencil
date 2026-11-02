-- Order Fulfillment & Delivery Analysis
-- 1. How many orders belong to each order status? 
select status , sum(order_id) as total_orders
from orders
group by status;

-- 2. How many deliveries belong to each delivery status?
select d.delivery_status , sum(o.order_id) as total_orders
from orders o
join deliveries d
on o.order_id=d.order_id
group by delivery_status;

-- 3. On average, how many days does a completed delivery take?
select
    AVG(DATEDIFF(delivery_date, dispatch_date))
    as avg_delivery_days
from deliveries
where delivery_status='delivered';

-- 4.Which 10 delivered orders took the longest to arrive?
select order_id ,DATEDIFF(delivery_date, dispatch_date) as delivery_days
from deliveries
where delivery_status='delivered'
order by delivery_days desc
limit 10;

-- 5. How does order volume change month by month?
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year,order_month;

-- 6.How are payment records distributed across statuses?
SELECT payment_status, COUNT(payment_id) AS total_payments
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;

-- 7.  Which completed deliveries took longer than five days?
SELECT order_id, DATEDIFF(delivery_date, dispatch_date) AS delivery_days
FROM deliveries
WHERE delivery_status = 'delivered'
AND DATEDIFF(delivery_date, dispatch_date) > 5
ORDER BY delivery_days DESC;

-- 8. Which customer cities have the longest average delivery times?
SELECT c.city, ROUND(AVG(DATEDIFF(d.delivery_date, d.dispatch_date)), 2) AS avg_delivery_days
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN deliveries d
    ON o.order_id = d.order_id
WHERE d.delivery_status = 'delivered'
GROUP BY c.city
ORDER BY avg_delivery_days DESC;

    