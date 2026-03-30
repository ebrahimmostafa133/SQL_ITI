use sakila;


-- 1. Select the title, description, and length of all films that are longer than 120
-- minutes. Sort them from the longest to the shortest

select title, description, length from film
where length > 120 
order by length desc;


-- 2. Find all films that have a rental_rate of 0.99 or 2.99, but their
-- replacement_cost is greater than 20.00

select * from film
where (rental_rate = 0.99 or rental_rate = 2.99)
	and replacement_cost > 20

-- 3. Count the total number of films available in each rating (G, PG, R, etc.)

select rating , count(*) from film 
group by rating 


-- 4. List the customer_ids who have made more than 30 separate payments in the
-- payment table.

select customer_id, count(*)
from payment
group by (customer_id)
having count(payment_id) >30

-- 5. Get all "Cities" in the database and the "Country" they belong to, but only
-- for cities located in 'Egypt'

select city.city, country.country
from city
join country on city.country_id = country.country_id
where country.country='Egypt';


-- 6. Display a list of all films and the names of the actors who starred in them.
-- (show film id, title and actor name)
select film.film_id,film.title ,actor.first_name,actor.last_name
from film
join film_actor on film_actor.film_id=film.film_id
join actor on actor.actor_id = film_actor.actor_id 

-- 7. Find all customers who have rented a movie but haven't returned it yet.
-- (show the customer name and the film title).

select first_name,last_name from customer
where customer_id in (
	select customer_id from rental
    where return_date is null
    );
    
-- 8. List the titles of all films whose length is greater than the average length of
-- all films in the database.

select title from film
where length >(
	select avg(length) from film
);

-- 9. Write a query to find the first_name, last_name, and email of customers who
-- have zero rental records

select first_name,last_name,email 
from customer
where customer_id in (
	select customer_id from rental 
    where rental_date is null
);


-- 10.Create a view named customer_spending_summary. This view should
-- display each customer's name, their total number of rentals, and the total
-- amount of money they have paid.

CREATE VIEW customer_spending_summary AS
SELECT 
    c.first_name, 
    c.last_name, 
    COUNT(r.rental_id) AS total_rentals, 
    SUM(p.amount) AS total_paid
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id;


-- 11.Use the previous view to find only customers who spent more than $100

select * 
from customer_spending_summary
where total_paid > 100;


-- Built-in Function
-- 1. Display actor names in the format: LAST_NAME, First_name (e.g., GUINESS,
-- Penelope).

SELECT LOWER(CONCAT(last_name, ', ', first_name)) AS actor_name
FROM actor;

-- 2. Display all customer emails in lowercase and replace the domain
-- @sakilacustomer.org with @iti-students.edu.

SELECT LOWER(REPLACE(email, '@sakilacustomer.org', '@iti-students.edu')) AS updated_email
FROM customer;

-- 3. Display the first 50 characters of each film's description followed by "..." and call
-- the column short_summary.
-- 4. Find all customers who registered in the month of February (any year).
--  User-Defined Functions
-- 1. Create a function that takes actor_id and returns the concatenated first and last name of
-- this actor.
-- 2. Create a function that takes customer_id and returns the total count of rentals made by
-- this customer.
-- 3. Create a function that takes a DECIMAL value and returns it as a formatted string with a
-- dollar sign (e.g., $19.99).




