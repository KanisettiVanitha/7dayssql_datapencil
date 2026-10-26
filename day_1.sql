create database sql7challenge;
use sql7challenge;

-- 1.customer tablee
create table customers(
customer_id int primary key,
full_name varchar(100) not null,
email varchar(100) not null,
city varchar(50) not null,
signup_date date not null,
segment varchar(20) not null);

-- 2. products tablee
create table products(
product_id int primary key,
product_name varchar(100) ,
category varchar(100) ,
price decimal(10,2),
cost decimal(10,2));

-- 3.  orders tablee
create table orders(
order_id int primary key,
customer_id int not null,
order_date date not null,
status varchar(20),
channel varchar(20),
foreign key (customer_id) references customers(customer_id));