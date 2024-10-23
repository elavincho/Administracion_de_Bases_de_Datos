/*1) Mostrar los datos de los presupuestos cuyo monto es menor a $ 10000.*/
-- Primero listamos todos los registros de la tabla presupuesto
SELECT 	* 
FROM taller.presup;
-- Ahora hacemos la consulta de los presupuestos menores a $10000
SELECT * 
FROM taller.presup
WHERE monto < 10000;

/*2) Mostrar el cliente ingresado más joven considerando su documento (del conjunto de datos ingresados).*/
-- Primero mostramos todos los datos del cliente
SELECT *
FROM taller.cliente;
-- Ahora ordenamos los datos del cliente por su DNI de forma descendente con limite de 1 resultado para obtener los datos del cliente más joven
SELECT *
FROM taller.cliente
ORDER BY DNI DESC
LIMIT 1;

/*3) Mostrar los repuestos que tengan la misma cantidad de stock que en el punto de pedido.*/
-- Primero mostramos todos los datos de la tabla de repuestos
SELECT *
FROM taller.repuesto;
-- Ahora buscamos todos los repuestos que tengan el mismo stock que en el punto de pedido.
SELECT *
FROM taller.repuesto
WHERE stock = pp;

/*4) Mostrar los mecánicos cuyo apellido comience con la letra C.*/
-- Primero mostramos todos los datos de los mecanicos
SELECT *
FROM taller.mecanico;
-- Ahora hacemos la consulta con la condicion de que nos muestre solo los mecanicos cuyos apellidos comiencen con la letra C.
SELECT *
FROM taller.mecanico
WHERE apellido
LIKE "C%";

/*5) Mostrar nombre del repuesto junto al precio ordenado alfabéticamente.*/
-- Primero mostramos todos los datos de los repuestos
SELECT *
FROM taller.repuesto;
-- Ahora solo mostramos el nombre del repuesto y el precio ordenado alfabeticamente.
SELECT nombre, precio
FROM taller.repuesto
ORDER BY nombre ASC;

/*6) Mostrar la cantidad de presupuestos realizados en el taller.*/
-- Primero mostramos todos los datos de los presupuestos.
SELECT *
FROM taller.presup;
-- Ahora utilizamos la funcion COUNT para poder saber la cantidad de presupuestos y le colocamos un alias para el titulo de la columna.
SELECT COUNT(*)
AS Cant_de_Presupuestos
FROM taller.presup;

/*7) Mostrar por color cuantos  vehículos registrados hay.*/
-- Primero mostramos todos los datos de los vehiculos.
SELECT *
FROM taller.vehiculo;
-- Ahora hacemos la consulta por color, hacemos la cuenta de los colores con la función 
-- COUNT y le damos un alias a la cuenta para que quede como nombre de la columna y por ultimo
-- agrupamos la consulta por colores.
SELECT Color, COUNT(*)
AS Cantidad
FROM taller.vehiculo
GROUP BY color;

/*8) Mostrar por código de ficha la cantidad de informes que tiene.*/
-- Primero mostramos todos los datos de la ficha
SELECT *
FROM taller.fichamd;
-- Ahora seleccionamos el código de ficha y lo contamos con la funcion COUNT
-- y les damos un alias para el nombre de las columnas y finalmente lo agrupamos
-- por código de ficha.
SELECT codF AS Cod_Ficha, COUNT(*) AS Cant_Informes
FROM taller.fichamd
GROUP BY codF;

/*9) Listar ordenado por temática  a los mecánicos que diagnostican (indicar nombre, apellido y temática).*/
-- Tenemos una SubConsulta
-- Primeramente listamos a todos los mecanicos y luego al diagnostico mecanico para saber como estan relacionados.
SELECT * 
FROM taller.mecanico;
SELECT *
FROM taller.mecdiag;
-- Ahora hacemos una consulta de la Temática en la tabla mecdiag y del Nombre y Apellido de los mecanicos en la tabla
-- mecanico, les asignamos un alias a ambas tablas para poder hacer una SubConsulta. Para poder hacer la SubConsulta
-- hacemos un INNER JOIN y le damos la condicion de que el código mecánico sea igual en ambas tablas. Finalmente lo
-- ordenamos por la temática como pide el ejercicio.
SELECT Tematica, Nombre, Apellido
FROM taller.mecdiag AS TMD
INNER JOIN taller.mecanico AS TM
ON TMD.codMec = TM.codMec
ORDER BY tematica;

/*10) Mostrar los números de presupuesto que tengan al menos un repuesto cuyo precio oscile entre $ 1200 y $ 10000 inclusive.*/
-- Tenemos una SubConsulta
-- Primero hacemos una consulta de todos los presupuestos de repuestos y repuestos.
-- SELECT *
-- FROM taller.presup;
SELECT *
FROM taller.presurep;
SELECT *
FROM taller.repuesto;
-- Ahora hacemos una consulta del número de presupuesto de la tabla presupuesto repuesto y de precio de la tabla repuesto, le asignamos
-- un alias a ambos para el titulo de la columna e indicamos de que tabla y columna va a hacer la columna y también le asignamos un alias
-- ya que lo vamos a necesitar para la condición. Hacemos un INNER JOIN  de la tabla repuesto al que también le asignamos un alias que vamos
-- a utilizar para indicar que la columna que tienen en común sean iguales. Finalmente le indicamos que el precio de la tabla repuesto tiene
-- que tener un rango de precios entre 1200 y 10000 inclusive.
-- SELECT *  /*Con esta consulta tenemos todos los datos*/
SELECT npresup AS Nro_Presupuesto, precio AS Precio
FROM taller.presurep AS PR
INNER JOIN taller.repuesto AS R
ON PR.codrep = R.codrep
WHERE R.precio
BETWEEN 1200 AND 10000;

/*11) Calcular el valor promedio del costo de los repuestos del taller. El título de la columna debe decir Precio Promedio*/
-- Primeramente vamos a hacer una consulta a la tabla repuesto.
SELECT *
FROM taller.repuesto;
-- Ahora vamos a utilizar la función AVG que nos devuelve el valor promedio del atributo indicado, como el ejercicio pide que
-- el nombre de la columna diga Precio promedio le asignamos un alias.
SELECT AVG(precio) AS Precio_Promedio
FROM taller.repuesto;

/*12) Mostrar los datos de los clientes que tienen más de un vehículo.*/
-- Primero vamos a hacer una consulta en la tabla clientes y vehiculos.
SELECT *
FROM taller.cliente;
SELECT *
FROM taller.vehiculo;
-- Tenemos una SubConsulta. Primeramente selecionamos todos los datos del cliente y le damos un alias. Para la condición le indicamos que el
-- código de cliente tiene que tener más de un vehiculo. Para eso hacemos una SubConsulta en la tabla vehiculo donde seleccionamos
-- el código de cliente y lo agrupamos por el código de cliente y de esa consulta filtramos los resultados que tengan solo más de 
-- un vehiculo.
SELECT *
FROM taller.cliente AS C
WHERE C.codc IN (
SELECT codc
FROM taller.vehiculo AS V
WHERE V.codc
GROUP BY V.codc
HAVING COUNT(codc) > 1);

/*13)  Identificar con nombre y apellido a los mecánicos que no hicieron ningún diagnóstico.*/
-- Hacemos una consulta en la tabla mecánico
SELECT *
FROM taller.mecanico;
-- Hacemos una consulta en la tabla mecanico diagnostico
SELECT *
FROM taller.mecdiag;
-- Primeramente seleccionamos los nombres y apellidos de los mecanicos de la tabla mecánico y le damos un alias,
-- hacemos un INNER JOIN con la tabla mecánico diagnostico y le damos la condición que el código mecánico sean iguales en ambas tablas
-- y agrupamos la tabla mecánico diagnostico por el código mecánico.
SELECT Nombre, Apellido
FROM taller.mecanico AS M
INNER JOIN taller.mecdiag AS MD
ON M.codmec = MD.codmec
GROUP BY MD.codmec;
-- ************************  otro metodo *************************************************************************************
SELECT CodMec, Nombre, Apellido
FROM taller.mecanico AS M
WHERE M.codmec IN (
SELECT codmec
FROM taller.mecdiag AS MC
WHERE MC.codmec
GROUP BY codmec
HAVING COUNT(codmec));
-- ******************************** otro metodo ****************************************************************************
SELECT Nombre, Apellido
FROM taller.mecanico AS M
WHERE M.repara = 0;

/*14) Mostrar por vehículo el monto final que deben abonar en concepto de presupuesto.*/
-- Hacemos una consulta en la tabla vehiculo.
SELECT *
FROM taller.vehiculo;
-- Hacemos una consulta en la tabla presupuesto.
SELECT *
FROM taller.presup;
-- Hacemos una consulta en la tabla ficha.
SELECT *
FROM taller.ficha;
-- Tenemos una consulta en 3 tablas distintas. Primeramente seleccionamos el Nro de Presupuesto, Matricula, Modelo, Marca, Color, de la
-- tabla vehiculo y la fecha, el monto a pagar de la tabla presupuesto. La tabla que relaciona a estas 2 tablas es la tabla ficha. En el
-- primer INNER JOIN relacionamos la tabla vehiculo con la tabla ficha y le damos la condicion que el código de vehiculo sean iguales en 
-- ambas tablas, luego hacemos un segundo INNER JOIN en la que relacionamos las tablas ficha con la tabla presupuesto en la que le damos 
-- la condición de que el código de ficha sean iguales en ambas tablas. Por último ordenamos la tabla por el número de presupuesto.
SELECT NPresup, P.Fecha, Matricula, Marca, Modelo, Color, monto
FROM taller.vehiculo AS V
INNER JOIN taller.ficha AS F
ON V.codveh = F.codveh
INNER JOIN taller.presup AS P
ON F.codf = P.codf
ORDER BY NPresup;