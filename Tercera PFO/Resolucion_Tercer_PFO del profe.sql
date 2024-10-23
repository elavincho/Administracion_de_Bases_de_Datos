use taller;


use taller;
-- 1) El dueño del taller quiere saber cual es el monto total 
-- que cada cliente debe abonar al asistir al taller. 
-- El informe debe mostrar nombre, apellido, teléfono y monto

SELECT c.Nombre, c.Apellido, c.tel, SUM(p.Monto) AS MontoTotal
FROM cliente c
INNER JOIN vehiculo v ON c.codC = v.codC
INNER JOIN ficha f ON v.codVEH = f.codVEH
INNER JOIN presup p ON f.codF = p.codF
GROUP BY c.Nombre, c.Apellido, c.tel
ORDER BY SUM(P.monto);

-- 2) Tomando la consulta del punto 1, se pide mostrar al cliente o clientes que abona el monto menor.

SELECT c.Nombre, c.Apellido, c.tel, SUM(p.Monto) as MontoTotal
FROM cliente c
JOIN vehiculo v ON c.codC = v.codC
JOIN ficha f ON v.codVEH = f.codVEH
JOIN presup p ON f.codF = p.codF
GROUP BY c.Nombre, c.Apellido, c.tel
HAVING MontoTotal = (
					SELECT MIN(MontoTotal)
						FROM (
							SELECT c2.Nombre, c2.Apellido, c2.tel,SUM(p2.Monto) as MontoTotal
							FROM cliente c2
							JOIN vehiculo v2 ON c2.codC = v2.codC
							JOIN ficha f2 ON v2.codVEH = f2.codVEH
							JOIN presup p2 ON f2.codF = p2.codF
							GROUP BY c2.Nombre, c2.Apellido, c2.tel
							) as MinMonto);

-- 3) Identificar cual o cuales fueron los mecánicos que 
-- diagnostican que realizaron  la mayor cantidad de revisiones.

SELECT m.Nombre, m.Apellido, count(fm.CodF) as Cantidad_Diagnosticos
FROM mecanico m
INNER JOIN mecdiag md on m.codMec = md.codMec
INNER JOIN fichamd fm on md.codMD = fm.codMD
GROUP BY m.Nombre, m.Apellido
HAVING Cantidad_Diagnosticos = (SELECT MAX(Cantidad_Diagnosticos)
									FROM (
											SELECT m2.CodMec,count(fm2.CodF) as Cantidad_Diagnosticos
											FROM mecanico m2
											INNER JOIN mecdiag md2 on m2.codMec = md2.codMec
											INNER JOIN fichamd fm2 on md2.codMD = fm2.codMD
											GROUP BY m2.CodMec
											) as maxDiag);

-- 4) Mostrar los datos relevantes de los repuestos que fueron usados en todos los presupuestos.
SELECT r.codRep, r.Nombre, r.stock, r.PP, r.precio, r.Unidad
FROM repuesto r
inner join (
			SELECT distinct codrep
				from  presurep 
            ) pr 
	on (pr.codrep = r.codRep);

-- 5) El dueño del taller debe comprar los repuestos 
-- y necesita un listado que muestre el nombre, la cantidad, el precio unitario y el total. 
-- El listado debe estar ordenado por nombre.

SELECT r.Nombre, pr.cant, r.precio AS PrecioUnitario, (pr.cant * r.precio) AS Total
FROM repuesto r
INNER JOIN presurep pr ON r.codRep = pr.codRep
INNER JOIN presup p ON pr.Npresup = p.NPresup
ORDER BY r.Nombre;

-- 6) Obtener un listado que muestre nombre, apellido del cliente 
-- y una columna con el llamada mensaje. 
-- Esa columna debe decir Sin vehículo registrado y Con vehículo registrado. 
-- La lógica es la siguiente si el cliente no registro ningún vehículo o si el cliente registro por lo menos uno.

SELECT c.Nombre, c. Apellido, IF(v.codVeh is NULL, "Sin Vehiculo registrado", "Con Vehiculo Registrado") as Mensaje
FROM cliente c
LEFT JOIN vehiculo v ON c.codC = v.codC;

-- 7) Mostrar en un listado los arreglos que usan por lo menos un repuesto 
-- cuyo precio unitario es menor que el promedio de precios de todos los repuestos. 
-- El  listado debe mostrar matricula del vehículo, teléfono del cliente, 
-- y el monto a abonar en concepto de repuestos.

SELECT v.Matricula, c.tel, SUM(r.precio * pr.cant) AS MontoAbonar
FROM vehiculo v
INNER JOIN cliente c ON v.codC = c.codC
INNER JOIN ficha f ON v.codVEH = f.codVEH
INNER JOIN presup p ON f.codF = p.codF
INNER JOIN presurep pr ON p.NPresup = pr.Npresup
INNER JOIN repuesto r ON pr.codRep = r.codRep
 WHERE r.precio <	(
					SELECT AVG(precio)
						FROM repuesto
					)
GROUP BY v.Matricula, c.tel;

-- 8) Mostrar los clientes registrados que aún no tienen ingreso en el taller para un diagnóstico.
select distinct  c.codC, c.dni,c.Nombre,c.Apellido 
from cliente c
inner join vehiculo v 
	on (v.codC = c.codC)
left join ficha f 
	on (f.codVEH = v.codVEH)
where f.codveh is null
order by c.Apellido,c.nombre;

-- 9) Obtener un listado ordenado por apellido de los mecánicos y el tipo. 
-- El tipo esta definido con el atributo repara. Para mostrar el listado se pide armar dos select y aplicar la función unión.

select codMec,nombre,apellido, repara  
from mecanico m
where repara = 0 
union 
select codMec,nombre,apellido, repara  
from mecanico m
where repara = 1
order by apellido;

-- 10) Utilizando una de las combinaciones de join, 
-- mostrar los repuestos que no se mencionan en los presupuestos.
select r.*, pr.* 
from repuesto r
left join presurep pr
	on (pr.codrep = r.codRep)
where pr.codrep is null;

-- 11) Identificar por fecha cuántas fichas se confeccionaron 
-- y cuántos mecánicos diagnosticaron. 
-- Recordá que una ficha puede tener más de un diagnostico; 
-- por esa razón existe la tabla “fichamd”.
select *, f.fecha
from mecanico m 
inner join mecdiag md 
	on (md.codMec = m.codMec)
inner join fichamd fmd 
	on (fmd.codMD = md.codMD)
inner join ficha f 
	on (fmd.codF = f.codF)
order by f.fecha;

-- 2023-03-30 3
-- 2023-04-01 2
-- 2023-04-05 1
select f.fecha, count(md.codMec) as cantidad_mecanico,count(distinct(fmd.codF)) as cantidad_ficha
from mecanico m 
inner join mecdiag md 
	on (md.codMec = m.codMec)
inner join fichamd fmd 
	on (fmd.codMD = md.codMD)
inner join ficha f 
	on (fmd.codF = f.codF)
group by f.fecha
order by f.fecha;



