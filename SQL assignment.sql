use sakila;

#1a. Display the first and last names of all actors from the table actor.
SELECT first_name, last_name
FROM actor;

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS actor_name
FROM actor;

#2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'JOE';

#2b. Find all actors whose last name contain the letters GEN:
SELECT first_name, last_name from actor
WHERE last_name ="%GEN%";

#2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT actor_id, first_name, last_name 
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

#2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id,  country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).
SELECT * FROM actor;

ALTER TABLE actor

#3a. 
ALTER TABLE actor 
MODIFY COLUMN middle_name blob;

#3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE actor
DROP COLUMN middle_name;

#4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*) AS `Count`
FROM actor
GROUP BY last_name;

#4b List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(*) AS 'Number of Actors' 
FROM actor GROUP BY last_name HAVING count(*) >=2;

#4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
UPDATE actor 
SET first_name = 'HARPO'
WHERE First_name = "Groucho" AND last_name = "Williams";

DESCRIBE sakila.address;

SELECT s.first_name, s.last_name, a.address
FROM staff s LEFT JOIN address a ON s.address_id = a.address_id;

SELECT s.first_name, s.last_name, SUM(p.amount) AS 'TOTAL'
FROM staff s LEFT JOIN payment p  ON s.staff_id = p.staff_id
GROUP BY s.first_name, s.last_name;

SELECT f.title, COUNT(a.actor_id) AS 'TOTAL'
FROM film f LEFT JOIN film_actor  a ON f.film_id = a.film_id
GROUP BY f.title;

SELECT c.first_name, c.last_name, SUM(p.amount) AS 'TOTAL'
FROM customer c LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name;

#7A
SELECT title
FROM film
WHERE (title LIKE 'K%' OR title LIKE 'Q%') 
AND language_id=(SELECT language_id FROM language where name='English');

#7B
SELECT first_name, last_name
FROM actor
WHERE actor_id
	IN (SELECT actor_id FROM film_actor WHERE film_id 
		IN (SELECT film_id from film where title='ALONE TRIP'));
        
#7C
SELECT first_name, last_name, email 
FROM customer cu
JOIN address a ON (cu.address_id = a.address_id)
JOIN city cit ON (a.city_id=cit.city_id)
JOIN country cntry ON (cit.country_id=cntry.country_id);

#7D
SELECT title from film f
JOIN film_category fcat on (f.film_id=fcat.film_id)
JOIN category c on (fcat.category_id=c.category_id);

SELECT title, COUNT(f.film_id) AS 'Count_of_Rented_Movies'
FROM  film f
JOIN inventory i ON (f.film_id= i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title ORDER BY Count_of_Rented_Movies DESC;

SELECT s.store_id, SUM(p.amount) 
FROM payment p
JOIN staff s ON (p.staff_id=s.staff_id)
GROUP BY store_id;

SELECT store_id, city, country FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country cntry ON (c.country_id=cntry.country_id);

SELECT c.name AS 'top_five', SUM(p.amount) AS 'Gross'
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

SELECT * FROM 'top_five';