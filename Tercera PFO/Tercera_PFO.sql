/*1) El dueño del taller quiere saber cual es el monto total que cada cliente debe abonar al asistir al taller. El informe debe mostrar nombre, apellido, teléfono y monto*/
-- Primero vamos a hacer una consulta a la tabla clientes y a la tabla presup.
SELECT * FROM taller.cliente;
SELECT * FROM taller.presup;
-- En este caso vamos a utilizar la convinacion de 2 tablas. La tabla cliente y la tabla presup. Con un INNER JOIN podemos convinar las tablas y obtner los resultados.
SELECT nombre, apellido, tel, monto
FROM taller.cliente
INNER JOIN taller.presup;

/*2) Tomando la consulta del punto 1, se pide mostrar al cliente o clientes que abona el monto menor.*/
-- Tomando el ejercicio anterior en este caso solo tenemos que agragar la condicion a travez de una subconsulta y decirle que el monto sea igual al minimo de monto de la
-- tabla presupuesto.
SELECT nombre, apellido, tel, monto
FROM taller.cliente
INNER JOIN taller.presup
WHERE monto = (SELECT MIN(monto) FROM taller.presup);

/*3) Identificar cual o cuales fueron los mecánicos que diagnostican que realizaron  la mayor cantidad de revisiones.*/

SELECT * FROM taller.mecanico;