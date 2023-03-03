--1. List all customers who live in Texas (use JOINs)

SELECT customer.first_name, customer.last_name, customer.email, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

--2. Get all payments above $6.99 with the Customer's Full Name

SELECT customer.first_name, customer.last_name, payment.amount
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

--3. Show all customers names who have made payments over $175(use subqueries)

SELECT distinct(customer_id), first_name, last_name 
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

--4. List all customers that live in Nepal (use the city table)

SELECT customer.first_name, customer.last_name, country.country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
full join country
on city.country_id = country.country_id
WHERE country.country = 'Nepal';

--5. Which staff member had the most transactions?

SELECT first_name, last_name, COUNT(payment.staff_id) as transactions
FROM staff
FULL JOIN payment
ON payment.staff_id = staff.staff_id
group by first_name, last_name
order by COUNT(payment.staff_id) desc;

--6. How many movies of each rating are there?

select rating, count(title) from film f group by rating

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT distinct(customer_id), first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id, amount
	HAVING amount > 6.99
);

--8. How many free rentals did our store give away?

select count(rental.rental_id) - count(payment.payment_id) as rental_vs_payment_difference
from rental
FULL JOIN payment
ON payment.rental_id = rental.rental_id;
