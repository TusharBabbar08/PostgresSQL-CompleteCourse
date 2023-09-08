--1.) Insert a new department into department table
begin transaction;
insert into department
values
(60,'IT','New');

commit;

select * from department d;

--2,) Insert an order into Orders table

insert into orders 
values
(1099,'MW97',1317,Current_date,1);

commit;


--3.) Give all employees in department 10 a pay increase of 200

update employee 
set salary = salary + 200
where department_nr = 10;
commit;

--4.) delete prospect 11

delete from prospect 
where prospect_nr =11;
commit;

--5.)
begin transaction;
select count(*) from prospect;

delete 
from prospect 
where credit_rating <10
and town = 'London';

select count(*) from prospect p ;

savepoint s1;
end transaction;

--6.)
begin transaction;
delete from prospect
where credit_rating <10
and town = 'Truro';

select count(*) from prospect p ;

rollback to s1;

select count(*) from prospect p ;

rollback;

select count(*) from prospect p ;

end transaction;

--7.)
begin transaction;
update orders 
set order_date = 
case when to_char(order_date,'Dy') = 'Sat'
then order_date +2
else order_date +1
end 
where extract(isodow from order_date)in(6,7);
end transaction;

--8.)
update customer
set credit_limit = credit_limit * case lower(town)
									when 'london' then 1.1
									when 'manchester' then 1.06
									else 1.04
									end
where lower(town) in ('london','manchester','birmingham');


--Pg 209

--1.)
create table book(
book_id varchar(6) not null constraint book_pkey primary key,
title varchar (50),
author varchar(30));


--2.) 

create table dependants(
dependant_nr smallint constraint dep_pkey primary key,
first_name varchar(15) not null,
last_name varchar (15) not null,
relationship varchar(10),
sex char constraint dep_sex
			check (sex in ('M','F','?')),
dob date,
employee_nr smallint references employee(employee_nr)
);


--3.)

create table orders2 as
select * from orders;

alter table orders2 
add column discount_per numeric(4,2) default 0
constraint not_over_50 check (discount_per<50) not null;

select * from orders2;

--4.)
alter table orders2 alter column discount_per drop not null;



--Pg 227;
--1.) Create an index on order_date

create index order_date_idx on orders(order_date);


--2.)Create index on surname and initials column of customers table

create index customer_index_idx on customer(surname, initials);

--3.)
create or replace view emp_view as 
select employee_nr, surname,initials, department_nr
from employee;

select * from emp_view where department_nr=10;


--4)

create or replace view sales_revenue as
select 
c.customer_nr,
c.surname,
sum(o.quantity*p.sales_price)
from customer c join orders o
on c.customer_nr = o.customer_nr 
join product p 
on o.product_code = p.product_code 
group by 1,2
order by 3 desc;

select * from sales_revenue;




--1.)PG 239
create sequence cust_seq
increment by 5
minvalue 2000 maxvalue 3000
start with 2000;

--2.)
insert into customer (customer_nr, surname, initials)
values (nextval('cust_seq'),'Fitzsimons','K');

--3.)
select currval('cust_seq');

--4.)
insert into prospect(prospect_nr,surname,initials,credit_rating)
values(nextval('cust_seq'),'Singh','A',12);

--5.)

select setval('cust_seq',2095);
insert into customer (customer_nr, surname, initials)
values (nextval('cust_seq'),'Babbar','T');
select currval('cust_seq');








