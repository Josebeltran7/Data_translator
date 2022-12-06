-- ACTIVIDAD 3.1 SQL

-- Parte 1
--Mostrar los nombres y apellidos de todos los actores de la tabla actor.
--Mostrar el nombre y el apellido de cada actor en una sola columna en mayúsculas. Nombre la columna Actor Name.
--Encontrar el número de identificación, el nombre y el apellido de un actor, del que sólo se conoce el nombre, "Joe". ¿Qué consulta utilizarías para obtener esta información?
--Encontrar todos los actores cuyo apellido contenga las letras GEN
--Encontrar todos los actores cuyos apellidos contengan las letras LI. Esta vez, ordena las filas por apellido y nombre, en ese orden:
--Utilizar IN, para mostrar las columnas country_id y country de los siguientes países: Afganistán, Bangladesh y China:

-- 1.1
SELECT  first_name, last_name
FROM actor;

--1.2
SELECT UPPER(first_name)||' '||UPPER(last_name) AS 'Actor Name'
FROM actor;

--1.3
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'JOE';

--1.4
SELECT actor_id,first_name,last_name
FROM actor
WHERE last_name LIKE '%GEN%';

--1.5
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name ASC, first_name ASC;


--1.6
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan','Bangladesh','China');

--Parte 2

--Enumera los apellidos de los actores, así como cuántos actores tienen ese apellido.
--Enumere los apellidos de los actores y el número de actores que tienen ese apellido, pero sólo para los nombres que comparten al menos dos actores.
--Utilice JOIN para mostrar los nombres y apellidos, así como la dirección, de cada miembro del personal. Utilice las tablas staff y address:
--Utilice JOIN para mostrar el importe total recaudado por cada miembro del personal en agosto de 2005. Utilice las tablas personal y pago.
--Enumere cada película y el número de actores que figuran en ella. Utilice las tablas actor_película y película. Utilice la unión interna.
--¿Cuántas copias de la película Jorobado Imposible existen en el sistema de inventario?
--Utilizando las tablas payment y customer y el comando JOIN, enumera el total pagado por cada cliente. Enumera los clientes alfabéticamente por su apellido.

--2.1
SELECT last_name,count(last_name) AS 'Contador'
FROM actor
GROUP BY last_name
HAVING Contador;

--2.2
SELECT last_name,count(last_name) AS 'Contador'
FROM actor
GROUP BY last_name
HAVING Contador>1;

--2.3
SELECT st.first_name, st.last_name,ad.address
FROM staff st
INNER JOIN address ad
ON st.address_id=ad.address_id;

--2.4
SELECT st.staff_id, st.first_name, st.last_name,sum(pa.amount)
FROM staff st
INNER JOIN payment pa
ON st.staff_id=pa.staff_id
GROUP BY st.staff_id;

--2.5

SELECT fi.title,count(ac.actor_id)
FROM film fi
INNER JOIN film_actor ac
ON fi.film_id=ac.film_id
GROUP BY fi.title;

--2.6
SELECT fi.film_id,fi.title,count(inv.film_id)
FROM film fi
INNER JOIN inventory inv
ON fi.film_id=inv.film_id
WHERE fi.film_id=439
GROUP BY fi.film_id;

--2.7
SELECT cu.customer_id,cu.first_name,cu.last_name,sum(pa.amount)
FROM customer cu
INNER JOIN payment pa
ON cu.customer_id=pa.customer_id
GROUP BY cu.customer_id
ORDER BY cu.last_name ASC;

--PARTE 3

--La música de Queen ha experimentado un improbable resurgimiento. Como consecuencia involuntaria, las películas que empiezan por la letra Q también han aumentado su popularidad. Utilice subconsultas para mostrar los títulos de las películas que empiezan por la letra Q y cuyo idioma es el inglés.
--Utiliza las subconsultas para mostrar todos los actores que aparecen en la película Alone Trip.
--Desea realizar una campaña de marketing por correo electrónico en Canadá, para lo cual necesitará los nombres y las direcciones de correo electrónico de todos los clientes canadienses. Utilice uniones para recuperar esta información.
--Las ventas han disminuido entre las familias jóvenes, y usted desea dirigirse a todas las películas familiares para una promoción. Identifique todas las películas categorizadas como familiares.
--Muestre las películas más alquiladas en orden descendente.
--Escriba una consulta para mostrar el volumen de negocio, en dólares, de cada tienda.
--Escribir una consulta para mostrar para cada tienda su ID de tienda, ciudad y país.
--Enumere los cinco géneros más importantes en ingresos brutos en orden descendente. (Sugerencia: es posible que tenga que utilizar las siguientes tablas: categoría, film_category, inventario, pago y alquiler).

--3.1
SELECT title
FROM film
WHERE title LIKE 'Q%' 
AND (SELECT language_id FROM language WHERE name='English');

--3.2
SELECT ac.first_name,ac.last_name, fi.title
FROM actor ac
INNER JOIN film_actor fia ON ac.actor_id=fia.actor_id
INNER JOIN film fi ON fi.film_id=fia.film_id
WHERE fi.title in (SELECT fi.title FROM film WHERE fi.title='ALONE TRIP');

--3.3
SELECT cu.first_name,cu.last_name,cu.email,co.country
FROM customer cu
INNER JOIN address ad ON cu.address_id=ad.address_id
INNER JOIN city ci ON ad.city_id=ci.city_id
INNER JOIN country co ON ci.country_id=co.country_id
WHERE co.country='Canada';

--3.4

SELECT fi.title, ca.name
FROM film fi
INNER JOIN film_category fc ON fi.film_id=fc.film_id
INNER JOIN category ca ON ca.category_id=fc.category_id
WHERE ca.name='Family';

--3.5
SELECT fi.title, count(fi.title)
FROM film fi
INNER JOIN inventory inV ON fi.film_id=inV.film_id
INNER JOIN rental re ON re.inventory_id=inV.inventory_id
GROUP BY re.inventory_id
ORDER BY fi.title ASC;

--3.6
SELECT st.store_id as Tienda, sum(pa.amount) as Monto
FROM store st
INNER JOIN customer cu ON cu.store_id=st.store_id
INNER JOIN payment pa ON pa.customer_id=cu.customer_id
GROUP BY st.store_id

--3.7
SELECT st.store_id as TiendaID, ci.city as Ciudad, co.country as Pais
FROM store st
INNER JOIN address ad ON st.address_id=ad.address_id
INNER JOIN city ci ON ad.city_id=ci.city_id
INNER JOIN country co ON ci.country_id=co.country_id

--3.8
SELECT cat.name as Categoria, sum(pa.amount) as Ingresos
FROM category cat
INNER JOIN film_category fc ON fc.category_id=cat.category_id
INNER JOIN inventory inv ON inv.film_id=fc.film_id
INNER JOIN rental re ON re.inventory_id=inv.inventory_id
INNER JOIN payment pa ON pa.rental_id=re.rental_id
GROUP BY cat.name
ORDER BY sum(pa.amount) DESC;
