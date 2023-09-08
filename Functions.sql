--1.) 5 raised to power 3

select power(5,3);

--2.) Select square root of 2

select sqrt(2);

--3.)Surname and salary of employee round to nearest 100

select surname, round(salary,-2)
from employee;

--4.) Avg salary, rounded to 2 decimal places

select round(avg(salary),2) from employee;

--5.) Select town from customer in upper case

select upper(town) from customer c ;

--6.)Select the first initial and the following dot concatenated with surname of custmers

select concat(substring(initials from 1 for 2),rtrim(surname)) from customer;

--7.)surame right padded to 10 characters, concatenated with initials

select rpad(surname,10,'*')|| initials
from employee e ;


--8.) Todays date

select current_date;

--9.) select the date 5 days from now 

select current_date + interval '5' day ;

--10.)Date 4 months from now
select current_date + interval '4' month;


--11.)

select employee_nr, surname, job, round((salary*12)/52,2) as "Weekly SALARY"
from employee e ;

--12.)

select product_code, description, cost_price, sales_price, instock 
from product p 
order by length(description) desc;

--13.)

select concat(substring(initials from 1 for 2),rtrim(surname)), street, town  from customer;

--14.)

select upper(surname), substring(street from position(' ' in street)+1)
from customer;


--15.)

select order_date,round((o.quantity*p.sales_price),-3)
from orders o 
join product p ON o.product_code = p.product_code 
where order_date>current_date - interval '6' month;




--Pg 145 
--1.) Today's date and time in format of own choice 

select to_char(current_timestamp, 'HH24:MI:SS Day DDth Month, yyyy');


--2.)Select cost price and show pounds symbol

select to_char(cost_price,'L999.99')
from product p ;

--3.)select surname and country.

select surname, coalesce (county,'NONE')
from prospect;

--4.)

select surname, credit_limit,
case when credit_limit < 750 then 'Small'
	when credit_limit between 750 and 1000 then 'Medium'
	when credit_limit>1000 then 'Large'
	end as "Credit Band"
from customer c ;


--5.)

select concat(initials, ltrim(surname)) as "Name", start_date 
from employee e 
where extract('dow' from start_date)=3;

--6.)

select to_char(order_date,'Day') as "Day",count(*)
from orders o 
group by 1, to_char(order_date,'D')
order by to_char(order_date,'D');

--7.)

select 
case when sex = 'M' then 'Mr.'
	when sex = 'F' then 'Ms.'
end as "Title",
concat(initials, ltrim(surname)) as "Name",
start_date
from employee e 
where date_part('year', current_date)-date_part('year',start_date)=1; 
where to_number(to_char(start_date,'YYYY'),'9999') = to_number(to_char(current_date,'YYYY'),'9999')-1;





























