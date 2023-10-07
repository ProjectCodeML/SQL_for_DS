use sakila;

# show tables;

# simplest form of select command
# this will return all data (all columns + all rows)
select *
from actor;

# let's see what are the parts of select query
select <column_names> as <new_col_name> or <*> # specify what are the columns
from < table_name >                  # where you want above column/s from
    join <how_to_combine_the_tables> # combine multiple tables
on <column_tb_1> == <column_tb_2>
having < condition > # condition for apply to groups
where < condition > # filter for normal data (when there is no grouping)
group by <column_1, column_2>
order by < column_name > < asc /desc >
limit <n>;

# how to get specific column from a table
select first_name
from customer;

# how to get multiple columns (specified) from a table
select first_name, last_name, email
from customer;

# how to limit number of rows from a tables
select first_name, last_name
from customer
limit 10;

# how to get n number of rows from a table
# which is sorted by a column
select first_name, last_name
from customer
order by first_name
limit 10;

# exercise 01: give me top 10 customer id's
# according to amount, Hint: (use payment table)
select customer_id, amount
from payment
order by amount desc
limit 10;

# how to manipulate returning data according to
# our requirements
select concat(first_name, " ", last_name) as "full_name"
from customer;

# how to manipulate numerical columns
select customer_id,
       payment_id,
       amount,
       (amount * 0.10) as "discount"
from payment;

# how to use built-in functions to change results
select upper(first_name)
from customer;

# how to take unique values only from a column
select distinct customer_id
from payment
order by customer_id;

# exercise 02: give me unique language names of films in lower case
select distinct lower(name)
from language;

# use results from select as a source
select customer_id,
       amount,
       (amount * 0.10) as "discount"
from payment;

# method 01 - (sub query)
select customer_id,
       amount,
       new_payment.discount,
       (amount - new_payment.discount) as "discounted_amount"
from (select customer_id,
             amount,
             (amount * 0.10) as "discount"
      from payment) as new_payment;

# method 02 - temporary table (only remain until current session expire)
create temporary table discount_dtl as (select customer_id,
                                               amount,
                                               (amount * 0.10) as "discount"
                                        from payment);

select customer_id,
       amount,
       discount,
       (amount - discount) as "discounted_amount"
from discount_dtl;

# method 03 - views ()
create view discount_view as
(
select customer_id,
       amount,
       (amount * 0.10) as "discount"
from payment
    );

select customer_id,
       amount,
       discount,
       (amount - discount) as "discount_amount"
from discount_view;

# how to filter data using where clause
# filter data with numerical column
select *
from payment
where amount >= 10;

select customer_id, payment_id
from payment
where amount >= 3
  and amount <= 6;

select customer_id, payment_id
from payment
where amount > 8
  and payment_date = "2006-12-31";

# filter data with date-time column
select customer_id, payment_id
from payment
where payment_date between "2005-01-01" and "2006-12-31";

# how to filter data with string column
select customer_id, first_name, last_name
from customer
where first_name like "_ab%";

# combine multiple tables to retrieve data

# join type 01: inner join
select *
from payment as p
         inner join customer as c
                    on p.customer_id = c.customer_id;

# join type 02: left join
select *
from payment as p
         left join customer as c
                   on p.customer_id = c.customer_id;

# join type 03: right join
select *
from payment as p
         right join customer as c
                    on p.customer_id = c.customer_id;

# put all together

# give me full name, email, amount and date of payment
# of customers who start their first name a and payed
# in between 2005-12-01 and 2006-12-31 and amount is
# greater than or equal 3. order by their full name
# and amount descending order
select concat(c.first_name, " ", c.last_name) as "full_name",
       c.email,
       p.amount,
       p.payment_date
from payment as p
         inner join customer as c
                    on p.customer_id = c.customer_id
where (p.amount >= 3)
  and (p.payment_date between "2005-12-01" and "2006-12-31")
  and (c.first_name like "a%")
order by "full_name", p.amount desc;

# exercise 03:
# write a query to retrieve film title, description and release
# year which are the films released before 2007. order the results
# by rental rate and title. title should be in uppercase.
# Hint: (use theses tables: film, film_text)

# exercise 04:

# write a query that will returns the title of every film in which
# an actor with the first name john.
select f.title
from film as f
         inner join (select fa.film_id
                     from actor as a
                              inner join film_actor as fa
                                         on a.actor_id = fa.actor_id
                     where a.first_name like "john") as af
                    on f.film_id = af.film_id;

# join more than two tables at once

# method 01: using sub queries
select *
from (select f.film_id, fc.category_id
      from film as f
               join film_category as fc
                    on f.film_id = fc.film_id) as fd
         join category as c
              on fd.category_id = c.category_id;

# method 02: using multiple join commands
# to use this method you need to have intermediate
# table (1 to 1 relationship in normalization) which
# have all the primary keys from tables you want to join
select *
from film_category as fc
         join film as f
              on fc.film_id = f.film_id
         join category as c
              on fc.category_id = c.category_id;

# self join (this will allow you to join same table itself
# , this possible because of self-referencing foreign key)
desc customer;

select *
from customer as c1
         join customer as c2
              on c1.first_name = c2.last_name;

# exercise 05

# write a query that will return first name, last name, address
# and city where located in 'California' district.

# as for practice do the same thing using sub-queries (optional)

# exercise 06

# write a query that returns all addresses that are in the same city.
# Hint: (you need to join address table itself - `self-join`)
select *
from (select a.address, c.city
      from address as a
               join city as c
                    on a.city_id = c.city_id) as c1
         join (select a.address, c.city
               from address as a
                        join city as c
                             on a.city_id = c.city_id) as c2
              on c1.city = c2.city;

select *
from address as a1
         join address as a2
              on a1.city_id = a2.city_id;

# for see addresses are different in same city
select *
from address as a1
         join address as a2
              on (a1.city_id = a2.city_id)
                  and (a1.address <> a2.address);