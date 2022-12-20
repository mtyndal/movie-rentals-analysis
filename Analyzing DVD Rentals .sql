/* 1. Identify the top 10 customers and their email so we can reward them
2. Identify the bottom 10 customers and their emails
3. What are the most profitable movie genres (ratings)?
4. What is the customer base in the countries where we have a presence?
5. Which countries are the most profitable for the business? Limit answer to the top 5. 
6. What is the average rental rate per movie genre (rating)? */
use sakila;
-- 1. Tables used: customer, payment
SELECT CONCAT (c.first_name, ' ' , c.last_name) full_name , c.email, sum(amount) total_spent
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY full_name, c.email
ORDER BY sum(amount) DESC
LIMIT 10;
-- 2. Tables used: customer, payment
SELECT CONCAT (c.first_name, ' ' , c.last_name) full_name , c.email, sum(amount) total_spent
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY full_name, c.email
ORDER BY sum(amount) asc
LIMIT 10;
-- 3. What are the most profitable movie genres (ratings)?
-- category > film_category > film > inventory > rental > customer
select * from category;
select * from film;
select * from customer;
select c.name genre, count(cc.customer_id) total_demanded, 
sum(p.amount) total_sales from category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN RENTAL r ON i.inventory_id = r.inventory_id
INNER JOIN customer cc ON r.customer_id = cc.customer_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY genre
ORDER BY total_demanded DESC;
-- 4. country > customer 
SELECT co.country, count(c.customer_id) total_customers
FROM country co
INNER JOIN city ci ON co.country_id = ci.country_id
INNER JOIN address a on ci.city_id = a.city_id
INNER JOIN customer c ON a.address_id = c.address_id
GROUP BY co.country
ORDER BY total_customers DESC;
-- 5. 
SELECT country, count(*) total_customers, sum(amount) total_sales
from country co
INNER JOIN city ci ON co.COUNTRY_ID = ci.country_id
INNER JOIN address a on ci.city_id = a.city_id
INNER JOIN customer cu on A.address_id = cu.address_id
inner join payment p ON cu.customer_id = p.customer_id
GROUP BY country
ORDER BY total_customers DESC
LIMIT 5;
-- 6 category > film_category > film 
select * from category;
select * from film_category;
SELECT c.name movie_genre, avg(f.rental_rate) avg_rental_rate
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg(rental_rate) desc;

