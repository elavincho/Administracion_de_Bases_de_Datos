
/*1) El dueño del taller quiere saber cual es el monto total que cada cliente debe abonar al asistir al taller. El informe debe mostrar nombre, apellido, teléfono y monto */

SELECT c.Nombre, c.Apellido, c.tel AS Telefono, SUM(p.monto) AS Monto_Total
FROM taller.cliente c
INNER JOIN taller.vehiculo v ON c.codc = v.codc
INNER JOIN taller.ficha f ON v.codveh = f.codveh
INNER JOIN taller.presup p ON f.codf = p.codf
GROUP BY c.Nombre, c.Apellido, c.tel
ORDER BY SUM(p.monto);

/* 2) Tomando la consulta del punto 1, se pide mostrar al cliente o clientes que abona el monto menor. */

SELECT c.Nombre, c.Apellido, c.tel AS Telefono, SUM(p.monto) as Monto_Total
FROM taller.cliente c
INNER JOIN taller.vehiculo v ON c.codc = v.codc
INNER JOIN taller.ficha f ON v.codveh = f.codveh
INNER JOIN taller.presup p ON f.codf = p.codf
GROUP BY c.Nombre, c.Apellido, c.tel
HAVING Monto_Total = (
	SELECT MIN(Monto_Total)
		FROM (
			SELECT c2.Nombre, c2.Apellido, c2.tel,SUM(p2.monto) as Monto_Total
			FROM taller.cliente c2
			INNER JOIN taller.vehiculo v2 ON c2.codC = v2.codC
			INNER JOIN taller.ficha f2 ON v2.codveh = f2.codveh
			INNER JOIN taller.presup p2 ON f2.codF = p2.codF
			GROUP BY c2.Nombre, c2.Apellido, c2.tel) as MinMonto);
       
    
/* 3) Identificar cual o cuales fueron los mecánicos que diagnostican que realizaron  la mayor cantidad de revisiones. */

SELECT m.Nombre, m.Apellido, count(fm.CodF) AS Cant_Diag
FROM taller.mecanico m
INNER JOIN taller.mecdiag md ON m.codmec = md.codmec
INNER JOIN taller.fichamd fm ON md.codmd = fm.codmd
GROUP BY m.Nombre, m.Apellido
HAVING Cant_Diag = (
	SELECT MAX(Cant_Diag)
		FROM (SELECT m2.Codmec,count(fm2.Codf) AS Cant_Diag
		FROM mecanico m2
		INNER JOIN taller.mecdiag md2 ON m2.codmec = md2.codmec
		INNER JOIN taller.fichamd fm2 ON md2.codmd = fm2.codmd
		GROUP BY m2.Codmec) AS MaxDiag);

/* 4) Mostrar los datos relevantes de los repuestos que fueron usados en todos los presupuestos. */

SELECT r.Codrep, r.Nombre AS Nombre_Repuesto, r.Stock, r.Precio, r.Unidad
FROM taller.repuesto r
INNER JOIN (SELECT DISTINCT codrep
				FROM  taller.presurep) pr 
				ON (pr.codrep = r.codrep);

/* 5) El dueño del taller debe comprar los repuestos y necesita un listado que muestre el nombre, la cantidad, el precio unitario y el total. */
/* El listado debe estar ordenado por nombre.*/

SELECT r.Nombre AS Nombre_Repuesto, pr.cant AS Cantidad, r.precio AS PrecioUnitario, (pr.cant * r.precio) AS Total
FROM taller.repuesto r
INNER JOIN taller.presurep pr ON r.codrep = pr.codrep
INNER JOIN taller.presup p ON pr.npresup = p.npresup
ORDER BY r.nombre;

/* 6) Obtener un listado que muestre nombre, apellido del cliente y una columna con el llamada mensaje. Esa columna debe decir Sin vehículo */
/* registrado y Con vehículo registrado. La lógica es la siguiente si el cliente no registro ningún vehículo o si el cliente registro por lo menos uno.*/

SELECT c.Nombre, c. Apellido, IF(v.codveh is NULL, "Sin Vehiculo registrado", "Con Vehiculo Registrado") AS Mensaje
FROM taller.cliente c
LEFT JOIN taller.vehiculo v ON c.codc = v.codc;

/* 7) Mostrar en un listado los arreglos que usan por lo menos un repuesto cuyo precio unitario es menor que el promedio de precios de todos los repuestos. */
/* El  listado debe mostrar matricula del vehículo, teléfono del cliente, y el monto a abonar en concepto de repuestos.*/

SELECT v.Matricula, c.tel AS Telefono, SUM(r.precio * pr.cant) AS Monto_a_Abonar
FROM taller.vehiculo v
INNER JOIN taller.cliente c ON v.codc = c.codc
INNER JOIN taller.ficha f ON v.codveh = f.codveh
INNER JOIN taller.presup p ON f.codf = p.codf
INNER JOIN taller.presurep pr ON p.npresup = pr.npresup
INNER JOIN taller.repuesto r ON pr.codrep = r.codrep
 WHERE r.precio < (SELECT AVG(precio)
						FROM taller.repuesto)
GROUP BY v.Matricula, c.tel;

/* 8) Mostrar los clientes registrados que aún no tienen ingreso en el taller para un diagnóstico. */

SELECT DISTINCT  c.codC, c.Dni AS DNI, c.Nombre, c.Apellido 
FROM taller.cliente c
INNER JOIN vehiculo v
	ON (v.codc = c.codc)
	LEFT JOIN ficha f 
	ON (f.codveh = v.codveh)
	WHERE f.codveh IS NULL
ORDER BY c.apellido,c.nombre;

/* 9) Obtener un listado ordenado por apellido de los mecánicos y el tipo. El tipo esta definido con el atributo repara. */
/* Para mostrar el listado se pide armar dos select y aplicar la función unión. */

SELECT codMec, Apellido, Nombre, Repara  
FROM taller.mecanico m
WHERE repara = 0
UNION 
SELECT codMec, Apellido, Nombre, Repara  
FROM taller.mecanico m
WHERE repara = 1
ORDER BY apellido;

/* 10) Utilizando una de las combinaciones de join, mostrar los repuestos que no se mencionan en los presupuestos. */

SELECT r.codrep AS Codigo_Repuesto, r.nombre AS Nombre_Repuesto
FROM taller.repuesto r
LEFT JOIN taller.presurep p
ON (r.codrep = p.codrep)
WHERE p.codrep IS NULL;

/* 11) Identificar por fecha cuántas fichas se confeccionaron y cuántos mecánicos diagnosticaron. Recordá que una ficha */
/* puede tener más de un diagnostico por esa razón existe la tabla “fichamd”.*/

SELECT f.Fecha, COUNT(DISTINCT f.codf) AS Cant_Fichas, COUNT(DISTINCT md.codmec) AS Cant_Diacnosticadores
FROM taller.ficha f
INNER JOIN taller.fichamd fm ON (f.codf = fm.codf)
INNER JOIN taller.mecdiag md ON (fm.codmd = md.codmd)
GROUP BY f.fecha;

/* 12) Construir una consulta para cada combinación de join. Se debe redactar la consigna, identificar la combinación utilizada */
/* y proponer una alternativa de resolución.*/

/* CONSIGNA: Identificar Nombre, Apellido, Dirección y teléfono de los Clientes que no ingresaron al Taller ningún vehiculo */
/* y ordenarlos por Apellido*/

-- Primera Solución: Seleccionamos los datos solicitados de la Tabla Clientes y agregamos la Columna Matricula solo para verificar que ese
-- Cliente no ingresó ningún Vehículo. En este caso utilizamos un RIGH JOIN para asociar los datos de la Tabla de la derecha, en este caso
-- es la Tabla Cliente donde le indicamos que el Código Cliente de la Tabla Vehículo y la Tabla Cliente deben ser iguales. Agregamos la
-- condición de que en la Tabla Vehículo el Código de Cliente debe ser Nulo ya que el Cliente aún no ingresó ningun Vehiculo. Finalmente lo
-- ordenamos por Apellido.

SELECT c.Nombre, c.Apellido, c.Direccion, c.tel AS Telefono, v.Matricula
FROM taller.vehiculo v
RIGHT JOIN taller.cliente c
ON (v.codc = c.codc)
WHERE v.codc IS NULL
ORDER BY c.apellido; 

-- Solución Alternativa: En este caso hacemos el caso opuesto para poder utilizar el LEFT JOIN. Primeramente seleccionamos los datos solicitados
--  y nuevamente agregamos la Columna Matricula solamente para verificar que esos Clientes aun no ingresaron Vehículos en el Taller. En este 
-- ejercicio invertimos el orden de las tablas, ahora la Tabla Clientes es el de la izquierda y Vehículo el de la derecha. Utilizamos LEFT JOIN 
-- para asociar la tabla de la izquierda que en este caso también es la Tabla Cliente. Le indicamos que el Código Cliente deben ser iguales en 
-- ambas Tablas y le damos la condición de que el Código Cliente en la Tabla Vehículo debe ser nula ya que el Cliente aún no ingreso ningún Vehículo.
-- Luego ordenamos por Apellido.

SELECT c.Nombre, c.Apellido, c.Direccion, c.tel AS Telefono, v.Matricula
FROM taller.cliente c
LEFT JOIN taller.vehiculo v 
ON (c.codc = v.codc)
WHERE v.codc IS NULL
ORDER BY c.apellido; 