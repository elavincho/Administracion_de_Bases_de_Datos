USE taller;
/*ejemplo inner join*/
SELECT *
FROM taller.mecanico
INNER JOIN taller.mecdiag
ON mecanico.codmec = mecdiag.codmec;

/*ejemplo left outer join*/
SELECT *
FROM taller.mecanico
LEFT OUTER JOIN taller.mecdiag
ON mecanico.codmec = mecdiag.codmec;

/*ejemplo left outer join with exclusion*/
SELECT *
FROM taller.mecanico
LEFT OUTER JOIN taller.mecdiag
ON mecanico.codmec = mecdiag.codmec
WHERE mecdiag.codmec is null;

/*ejemplo right join*/
SELECT * 
FROM taller.mecanico
RIGHT JOIN taller.mecdiag
ON mecanico.codmec = mecdiag.codmec;

/*ejemplo right outer join*/
SELECT * 
FROM taller.mecanico
RIGHT OUTER JOIN taller.mecdiag
ON mecanico.codmec = mecdiag.codmec;

/*ejemplo con el right outer*/
SELECT *
FROM taller.fichamd
RIGHT OUTER JOIN taller.mecdiag
ON fichamd.codmd = mecdiag.codmd;

/*ejemplo con el right outer con la condicion*/
SELECT *
FROM taller.fichamd
RIGHT OUTER JOIN taller.mecdiag
ON fichamd.codmd = mecdiag.codmd
WHERE fichamd.codmd is null;

/*EJEMPLOS DE USO*/

/*el mismo resultado lo podemos obtener con la siguiente subconsulta*/
SELECT *
FROM taller.mecdiag
WHERE  codmec
NOT IN (SELECT codmd FROM fichamd);

/*buscamos los clientes que tienen mas de un vehiculo*/
SELECT nombre, apellido
FROM taller.cliente c
INNER JOIN taller.vehiculo v
ON c.codc = v.codc
GROUP BY c.codc
HAVING COUNT(c.codc) > 1;