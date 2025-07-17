--create customer table

create database project
use project;

drop table customers

create table customers (
customerid int primary key,
Firstname varchar(50),
lastname varchar(50),
city varchar(50),
joindate date
);

insert into customers values
(1,'john','doe','mumbai','2024-01-05'),
(2,'alice','smith','delhi','2024-02-15'),
(3,'bob','brown','banglore','2024-03-20'),
(4,'sara','white','mumbai','2024-01-25'),
(5,'mike','black','chennai','2024-02-10');

select * from customers;

drop table orders

create table orders(
orderid int primary key,
customerId int foreign key references customers (customerid),
orderdate date,
product varchar(50),
quantity int,
price int);
--insert data into orders

insert into orders values
(101,1,'2024-04-10','laptop',1,55000),
(102,2,'2024-04-12','mouse',2,800),
(103,1,'2024-04-15','keyboard',1,1500),
(104,3,'2024-04-20','laptop',1,50000),
(105,4,'2024-04-22','headphones',1,2000),
(106,2,'2024-04-25','laptop',1,52000),
(107,5,'2024-04-28','mouse',1,700),
(108,3,'2024-05-02','keyboard',1,1600);


select * from customers;
select * from orders;

--part a: basic quesries
--1 get the list of all customers from mumbai
--2 show all orders for laptops
--3 find the total number of order placed
--4 find the price between 50000 and 80000

--1
select * from customers where city = 'mumbai';
-- sara anf john are from mumbai

--2
select * from orders where product = 'laptop';
-- there are 3 orders placed for laptop

--3
select count(*) as totalorders from orders;
-- there are total 8 orders placed

--4
select * from orders where price between 50000 and 80000;
-- there are three customers who shopped between 50k to 80k

---part b
--5 get the full name of customers and their product ordered
--6 find customers who have not placed any orders

select c.firstname+ '  ' + c.lastname as fullname,o.product 
from customers c join orders o on c.customerid = o.customerId

select o.orderid , f.firstname, f.lastname
from orders o join customers f on o.customerid = f.customerid
where orderid = null;

select * from customers 
where customerid not in (select distinct customerid from orders);

--part c
--6 find the total revenue earned from all orders
--7 find the total quantity of mouse sold

select SUM(price) as totalrevenue from orders


select sum(quantity) from orders
where product = 'mouse' 

--part d 
--show total sales amount per customer
--show numbers of order per city

select  sum(o.price * o.quantity),c.Firstname
from customers c join orders o on c.customerid = o.customerId
group by c.firstname;

select c.city, count(o.orderid) from customers c join orders o on c.customerid = o.customerId
group by city;

--part 
select * from orders;
select c.* 
from customers c 
where c.customerId in(
select customerId
from orders
group by customerId
having sum(price) > 50000);


select customerId, orderdate, product,
case 
when price > 50000 then 'highvalue'
else 'lowvalue'
end as value_label
from orders

--window function
---find the running total of revenue by orderdate

select orderid, orderdate, price,
sum(price) over (order by orderdate) as running
from orders;
