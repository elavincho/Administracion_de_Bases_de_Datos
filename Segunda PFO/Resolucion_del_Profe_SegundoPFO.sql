use taller;
# 1-Mostrar los datos de los presupuestos cuyo monto es menor a $ 10000.

SELECT * FROM presup WHERE Monto < 10000;

# 2-Mostrar la cliente ingresada más joven considerando su documento (del conjunto de datos ingresados).
SELECT cast(dni as SIGNED) 
FROM cliente
ORDER BY cast(dni as SIGNED) DESC LIMIT 1;


# 3-Mostrar los repuestos que tengan la misma cantidad de stock que en el punto de pedido.

SELECT * FROM repuesto WHERE stock = PP;

# 4-Mostrar los mecánicos cuyo apellido comience con la letra C.

SELECT * FROM mecanico WHERE apellido LIKE 'C%';

# 5-Mostrar nombre del repuesto junto al precio ordenado alfabéticamente.

SELECT nombre,precio FROM repuesto ORDER BY nombre;

# 6-Mostrar la cantidad de presupuestos realizados en el taller.

SELECT COUNT(1) as CantidadPresupuestos FROM presup;

# 7-Mostrar por color cuantos  vehículos registrados hay.

SELECT color, COUNT(1) as cantidad FROM vehiculo 
GROUP BY color
ORDER BY 2 desc; 

# 8-Mostrar por código de ficha la cantidad de informes que tiene.

SELECT codF,COUNT(1) as cantidadInformes FROM fichamd GROUP BY codF;	

# 9-Listar ordenado por temática  a los mecánicos que diagnostican (indicar nombre, apellido y temática).

SELECT nombre,apellido,tematica 
FROM mecanico m 
INNER JOIN mecdiag md 
ON m.codMec = md.codMec 
where m.repara = 0
ORDER BY tematica; 

# 10-Mostrar los números de presupuesto que tengan al menos un repuesto cuyo precio oscile entre $ 1200 y $ 10000 inclusive.

SELECT distinct(p.Npresup) as Npresup 
FROM presurep p 
INNER JOIN repuesto r 
	ON (p.codRep = r.codRep) 
-- WHERE r.precio >= 1200 AND r.precio <= 10000
where r.precio between 1200 and 10000
order by p.npresup;

# 11-Calcular el valor promedio del costo de los repuestos del taller. 
-- El título de la columna debe decir Precio Promedio

SELECT AVG(precio) AS 'Precio Promedio' FROM repuesto;

# 12- Mostrar los datos de los clientes que tienen más de un vehículo.

SELECT c.nombre,c.apellido, count(1) 
FROM cliente c 
INNER JOIN vehiculo v 
	ON c.codC = v.codC 
GROUP BY c.nombre,c.apellido 
HAVING COUNT(1) > 1;

# 13-Identificar con nombre y apellido a los mecánicos que no hicieron ningún diagnóstico.

SELECT M.apellido, m.nombre
FROM Mecanico M 
WHERE M.Repara = 0 
AND m.CodMec NOT IN (SELECT MD.CodMec 
			FROM MecDiag MD 
			INNER JOIN FichaMD FMD 
				ON MD.CodMD=FMD.CodMD 
			GROUP BY MD.CodMec);

# 14- Mostrar por vehículo el monto final 
-- que deben abonar en concepto de presupuesto.
SELECT v.codVEH,Modelo,Marca, sum(Monto) as monto_total
FROM vehiculo v 
INNER JOIN ficha f 
	ON v.codVEH = f.codVEH 
INNER JOIN presup p 
	ON p.codF = f.codF
group by v.codVEH,Modelo,Marca
order by v.codVEH;
