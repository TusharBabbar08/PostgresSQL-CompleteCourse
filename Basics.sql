select * from employee;

select current_user, current_date ;

select supplier_nr, name, telephone
from supplier;

select distinct job,salary
from employee;

select surname,job, salary
from employee
where surname = E'O\'Neill';

select * 
from customer 
where lower(town)  not in ('london','birmingham','manchester');


select * 
from employee e 
where salary not between 2000 and 3000;


select name, telephone
from supplier s
where telephone is not null;


--N is the 5th character which may be followed by somethig or nothing 
select * from customer c 
where surname like '____n%';


select *
from customer c
where surname ilike 'm%';

select * 
from customer c 
where town in ('Birmingham','Manchester') and credit_limit > 1000;


select *
from product p
order by sales_price desc;


select department_nr, surname, initials, job, salary
from employee e 
-- order by 1,2,3;
order by 4,5,2;

select *
from employee e 
order by salary desc nulls last;



select * from employee
-- 1.) Details of Employees that are salesmen

select *
from employee 
where job='Salesman';

-- 2.)Employees with no manager

select *
from employee e 
where manager is null;


-- 3.) Suppliers not from Brighton or Birmingham

select * from supplier;

select *
from supplier s 
where town not in ('Birminghm','Brighton');

--4.)

select * from orders;

select order_nr, product_code, quantity
from orders o 
where quantity>75;

--5.) All orders for customer 1317

select * 
from orders o 
where customer_nr = 1317;

-- 6.)

select * from product p ;

select *
from product 
where (sales_price - cost_price)>=100;

--7.)
select * from customer;

select * 
from customer c 
where town not ilike '%m%';

--8.)
select * 
from employee
where job not in ('Manager','Chairman') and salary*12 > 30000;

--9.)
select * 
from employee
where salary between 1000 and 2000;

--10.)

select * from orders;

select *
from orders o 
where order_date >= '2023-01-01';

--11.)

select *
from customer c 
where surname like '__i%';

--12.)
select *
from customer 
where surname like '%l%'
and surname not like '%l%l%';

--13.)

select *
from prospect
where (surname like '_m%' or surname like '%m_')
and surname not ilike '%m%m%';


select sum(salary), avg(salary), max(salary), min(salary)
from employee e
where job <> 'Chairman';


select department_nr, sum(salary) as "Total"
from employee e 
group by rollup(department_nr)
order by 1;


select department_nr, job, sum(salary) as "Total"
from employee e 
group by cube(department_nr,job)
order by 1;



--1.) Total rows from prospect table

select count(*)
from prospect p;


--2.)How many employees have surname jones

select count(*)
from employee
where surname = 'Jones';


--3.) max, min, avg salary

select  min(salary), round(avg(salary),2),max(salary)
from employee;

--4.)how many orders for each product code
select * from orders;

select product_code, count(*) 
from orders o 
group by 1
order by 2 desc;

--5.)same as 4 but orders > 3
select * from orders;

select product_code, count(*) 
from orders o 
group by 1
having count(*) >3
order by 2 desc;


--6.) sum of salary for each job within each department

select * from employee;

select department_nr, job, sum(salary) as "Total"
from employee e 
group by 1,2;


--7.) apart from 1317 and 1223..

select product_code, customer_nr, avg(quantity)
from orders o 
where customer_nr not in (1317,1223)
group by 1,2
having avg(quantity)<10;

--8.)
select job,  min(salary), round(avg(salary),2),max(salary)
from employee
where job not in ('Analyst','Chairman')
group by 1
having avg(salary) between 1000 and 1500
order by min(salary);




















