select *
from customer cross join orders;

select *
from customer, orders;

select surname, initials, order_date, product_code, quantity
from customer c inner join orders o 
on c.customer_nr = o.customer_nr
order by 1;

select surname, initials, name
from department d join employee e 
on d.department_nr = e.department_nr 
where salary >2000;

-- FOr best performance, join the smaller table to the bigger table
select c.surname,c.initials, o.order_date, p.description,o.quantity*p.sales_price as "Value", s.name as "Supplier"
from customer c join orders o 
on c.customer_nr = o.customer_nr 
join product p
on o.product_code = p.product_code 
join supplier s 
on s.supplier_nr = p.supplier_nr 
order by 1,4;


select *
from salgrade s;


select s.grade, e.surname, e.initials, e.salary
from employee e join salgrade s
on e.salary between s.low_salary and s.high_salary 
order by 1 desc, 4 desc;


--1.)

select * from employee e ;
select * from department d ;


select e.employee_nr, e.surname, e.job, d.name, d.location
from employee e join department d
on d.department_nr = e.department_nr;

--2.)
select * from product p ;
select * from supplier s ;


select p.product_code, p.description, p.sales_price, s.name
from product p inner join supplier s 
on p.supplier_nr = s.supplier_nr 
order by 4;


--3.)
select p.product_code, p.description, p.sales_price, s.name
from product p inner join supplier s 
on p.supplier_nr = s.supplier_nr
where s.name = 'London Computers Ltd.'
order by 4;


--4.) 

select * from supplier s ;
select * from product p ;


select s.*,p.*
from supplier s left join product p 
on s.supplier_nr = p.supplier_nr ;

--5.) 
select * from orders o ;
select * from customer c ;

select c.customer_nr, c.credit_limit, o.order_nr, p.product_code, s.supplier_nr
from customer c join orders o 
on c.customer_nr = o.customer_nr 
join product p 
on o.product_code = p.product_code 
join supplier s 
on p.supplier_nr = s.supplier_nr 
where c.credit_limit > 1000;


--6.) 

select c.customer_nr, c.surname, sum(o.quantity*p.sales_price) as "Value"
from customer c join orders o 
on c.customer_nr = o.customer_nr 
join product p 
on o.product_code = p.product_code 
group by 1,2
having sum(o.quantity*p.sales_price) > 40000;


--7.)

select * from supplier s ;
select * from product p ;

select s.name as "Supplier", sum((p.sales_price - p.cost_price)*p.instock) as "Profit"
from product p join supplier s 
on p.supplier_nr =s.supplier_nr 
group by 1;


--8.)

select c.surname, count(o.order_nr)
from customer c
left join orders o s
on c.customer_nr = o.customer_nr 
group by 1;


--9.)

select s.name, p.description, sum(o.quantity*p.sales_price) as "Total Sales"
from supplier s join product p
on s.supplier_nr = p.supplier_nr 
join orders o 
on p.product_code = o.product_code 
group by 1,2;


