use sakila;

select customer_id
from rental;

select customer_id, staff_id
from rental
group by customer_id;

# count how many times each customer_id appeared in
# rental table
select customer_id, count(*)
from rental
group by customer_id;

# customer id's where they rent more than 40 times
# using where clause
# this can not be execute successfully because of
# Unknown column 'count_' in 'where clause'
select customer_id, count(*) as "count_"
from rental
where count_ > 40
group by customer_id;

# using having
# if you use having without group by clause
# you will get an error msg because having is
# only there for filtering data after group by
select customer_id, count(*)
from rental
group by customer_id
having count(*) > 40;

# ex - 01
# construct a query that counts the number of rows
# in the payment table for a individual customer

# homework - 01
# test what are the other aggregation functions
# we can use in sql queries (use the references,
# or search on web)

# construct a query to find total sales for each unique
# customer by a unique staff member
select staff_id, customer_id, sum(amount)
from payment
group by customer_id, staff_id;

# write a query to find how many films done in each
# language and group them according to category of each
select f.language_id, fc.category_id, count(*) as `film_count`
from film as f
         join film_category as fc
              on f.film_id = fc.film_id
group by f.language_id, fc.category_id;

# practice 01
# use result table from above query and create a
# result table more readable by adding string
# values to language id's and category ids's

# ex 02-
# construct a query to return how many films done
# by a each actor in each film rating

# ex 03-
# find average rental rate renting movies
# according to their film category

# ex 03.1-
# find average rental rate and total amount earn by
# renting movies according to their film category
select c.name,
       avg(dtl.rental_rate) as "avg rental rate",
       sum(p.amount) as "total earnings"
from (select f.film_id,
             f.rental_rate,
             fc.category_id,
             r.rental_id
      from film as f
               join film_category as fc
                    on f.film_id = fc.film_id
               join inventory as i
                    on f.film_id = i.film_id
               join rental as r
                    on i.inventory_id = r.inventory_id) as dtl
         join payment as p
              on p.rental_id = dtl.rental_id
         join category as c
              on dtl.category_id = c.category_id
group by 1;

# ex 04-
# show me average rental rate of films has deleted
# scenes among special features according to their
# film category and rating