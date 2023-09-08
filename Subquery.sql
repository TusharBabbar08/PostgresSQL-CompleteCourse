select * 
from employee e 
where salary = 
		(select max(salary) from employee e2 );
	
	

select * 
from employee e 
where salary > 
		(select avg(salary) from employee e2 );
	
	
	
select * 
from orders o 
where customer_nr in 
	(select customer_nr
	from customer c
	where town = 'London');



--SET OPERATORS

select surname, initials, street, town, county, post_code
from prospect p 

except

select surname, initials, street, town, county, post_code
from customer c;


select surname, initials, street, town, county, post_code
from prospect p 
union
select surname, initials, street, town, county, post_code
from customer c
order by surname;



select *
from employee e
order by salary desc 
limit 4;

select *
from employee e
order by salary desc 
fetch first 4 rows only;


--1.) details of employees with lowest salary
select *
from employee e 
where salary = (select min(salary) from employee);


--2.) orders where quantity > avg(quantity)

select * 
from orders o 
where quantity > 
	(select avg(quantity)
	from orders o2 );

--3.)Details of suppliers who do not supply any products
select * 
from supplier s
where supplier_nr not in (select supplier_nr from product);

--left join


--4.)
select * 
from product p 
where supplier_nr in ( select supplier_nr from supplier where county != 'London');



--5.)

select * 
from orders o 
where product_code in (select product_code from product where description ilike '%draw%' )


--6.)
select surname, initials,post_code
from prospect p 
union
select surname, initials,post_code
from customer c
order by surname;

--7.)
select surname, initials,post_code
from prospect p 
union all
select surname, initials,post_code
from customer c
order by surname;

--8)

select surname 
from employee e 
intersect
select surname 
from customer c ;

--9)

select surname 
from employee e 
except
select surname 
from customer c ;



select employee_nr, surname, salary, (salary - (select avg(salary) from employee e))
from employee e 
group by 1;


--1.) Pg 163

select town, avg(credit_limit)
from customer c 
group by town 
having avg(credit_limit)>(select avg(credit_limit) from customer); 


--2.)

select * from customer c ;

select surname, credit_limit
from customer c 
where credit_limit > all (select max(credit_limit) from customer where town='London');

--3.)
select * from department d ;
select * from employee;

select * 
from employee e 
where e.salary = (select min(salary) from employee where e.department_nr =department_nr  );

--4.)

select o.order_nr , p.description , (o.quantity * p.sales_price) as "Value"
from orders o join product p 
on o.product_code = p.product_code 
where (o.quantity * p.sales_price) > 
	(select avg(o.quantity * p.sales_price) from orders o join product p 
	on o.product_code = p.product_code );


--5.)
select surname, job, salary
from employee e 
where salary in (select distinct salary
				from employee e2
				order by salary desc
				limit 3)
order by salary desc;

--6.)

select department_nr, count(*)
from employee e 
group by 1
having count(*) in (select count(*) 
					from employee e2 
					group by department_nr 
					order by count(*) desc
					limit 1);
				
select department_nr, count(*) as "Staff"
from employee e 
group by 1
having count(*)=
(select max(headcount) 
from 
(select count(*) as headcount
					from employee e2 
					group by department_nr)a);
























