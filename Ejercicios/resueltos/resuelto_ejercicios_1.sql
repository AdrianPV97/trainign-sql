/*

Utilizando SAKILA resuelve los siguientes ejercicios


1.- Muestra el número de rentas totales en cada tienda */
select s.store_id, COUNT(r.rental_id) AS "numero_rentas" FROM store s
INNER JOIN staff b ON b.store_id = s.store_id 
INNER JOIN rental r ON r.staff_id = b.staff_id
GROUP BY s.store_id;

/* 2.- Muestra el monto total de los pagos recibidos en cada tienda (los pagos deben tener el formato $ monto MXN) */
select s.store_id, CONCAT("$", SUM(p.amount), " MXN" ) AS "total_pagos" FROM store s
INNER JOIN staff b ON b.store_id = s.store_id 
INNER JOIN rental r ON r.staff_id = b.staff_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id
ORDER BY total_pagos DESC
;

/*3.- Necesitamos encontrar a los mejores clientes de la tienda, para ello debes listar el id, nombre, apellido, correo (todo en minusculas), tienda, dinero gastado y numero de rentas*/
SELECT c.customer_id, c.first_name, c.last_name,  lower(c.email), store_id,  
SUM(p.amount) AS "dinero_gastado" ,
COUNT(r.rental_id) AS "numero_de_rentas"
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
INNER JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY dinero_gastado DESC LIMIT 10;

/*4.- Se requiere un reporte que muestre en una consulta el título y el total de ventas de las 5 películas mas vendidas ordenadas de mayor a menor */
SELECT f.title, SUM(p.amount) AS "ventas" FROM payment p
INNER JOIN rental r ON r.rental_id = p.rental_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id
GROUP BY title 
ORDER BY ventas DESC LIMIT 5;

