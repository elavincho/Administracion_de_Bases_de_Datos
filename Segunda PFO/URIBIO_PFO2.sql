-- 1) Mostrar los datos de los presupuestos cuyo monto es menor a $10000.
-- Seleccionamos todos los campos (*) de la tabla "presup".
-- Filtramos los resultados para mostrar solo aquellos registros donde el campo "Monto" sea menor a 10000.
select * 
from taller.presup 
where Monto < 10000;

-- 2) Mostrar el cliente ingresado más joven considerando su documento (del conjunto de datos ingresados).
-- Seleccionamos todos los campos (*) de la tabla "cliente".
-- Ordenamos los resultados por DNI de forma descendente (DNI más alto primero) ya que, normalmente, un DNI más alto corresponde a una persona más joven.
-- Limitamos el resultado a un solo registro para obtener el cliente más joven.
select * 
from taller.cliente
order by DNI DESC
limit 1;

-- 3) Mostrar los repuestos que tengan la misma cantidad de stock que en el punto de pedido.
-- Seleccionamos todos los campos (*) de la tabla "repuesto".
-- Filtramos los resultados donde la cantidad de "stock" sea igual al "PP" (punto de pedido).
select * 
from taller.repuesto
where stock = PP;

-- 4) Mostrar los mecánicos cuyo apellido comience con la letra C.
-- Seleccionamos todos los campos (*) de la tabla "mecanico".
-- Utilizamos la cláusula "like" para buscar apellidos que comiencen con la letra "C".
-- El símbolo "%" indica que puede haber cualquier cantidad de caracteres después de la "C".
select * 
from taller.mecanico
where Apellido like 'c%';

-- 5) Mostrar nombre del repuesto junto al precio ordenado alfabéticamente.
-- Seleccionamos el nombre del repuesto y su precio de la tabla "repuesto".
-- Ordenamos los resultados por el nombre del repuesto en orden ascendente (alfabético).
select nombre, precio
from taller.repuesto
order by nombre asc;

-- 6) Mostrar la cantidad de presupuestos realizados en el taller.
-- Contamos la cantidad de presupuestos en la tabla "presup".
-- Utilizamos la función "count" para contar el número de valores en la columna "NPresup".
-- Asignamos un alias "Total_Presupuestos" para que el resultado sea más claro.
select count(NPresup) AS Total_Presupuestos
from taller.presup;

-- 7) Mostrar por color cuántos vehículos registrados hay.
-- Seleccionamos el color de los vehículos y contamos cuántos vehículos hay de cada color.
-- Utilizamos "group by" para agrupar los resultados por color.
-- Asignamos un alias "VEHICULOS_REGISTRADOS_POR_COLOR" para indicar que el conteo se hace por color.
select Color, COUNT(*) as VEHICULOS_REGISTRADOS_POR_COLOR
from taller.vehiculo
group by Color;

-- 8) Mostrar por código de ficha la cantidad de informes que tiene.
-- Seleccionamos el código de ficha (codF) y contamos cuántos informes tiene cada ficha.
-- Utilizamos la función "count" sobre la columna "informe" para contar los informes por ficha.
-- Agrupamos los resultados por el código de ficha para obtener un registro por cada ficha.
select codF, count(informe) as Cantidad_de_Informes 
from taller.fichamd
group by codF;

-- 9) Listar ordenado por temática a los mecánicos que diagnostican (indicar nombre, apellido y temática).
-- Seleccionamos el nombre, apellido del mecánico y la temática de diagnóstico de la tabla "mecdiag".
-- Hacemos un "inner join" entre las tablas "mecdiag" y "mecanico" usando "codMec" como llave.
-- Ordenamos los resultados por la columna "tematica" en orden ascendente.
Select m.Nombre, m.Apellido, md.tematica
from taller.mecdiag as md
inner join taller.mecanico as m on m.codMec = md.codMec
order by md.tematica asc;

-- 10) Mostrar los números de presupuesto que tengan al menos un repuesto cuyo precio oscile entre $1200 y $10000 inclusive.
-- Seleccionamos el número de presupuesto y el precio de los repuestos que están en el rango de 1200 a 10000.
-- Hacemos un "inner join" entre las tablas "presurep" y "repuesto" usando "codRep" como llave.
-- Utilizamos "between" para filtrar los repuestos cuyo precio está entre 1200 y 10000.
select pr.Npresup, r.precio
from taller.presurep as pr
inner join taller.repuesto as r on r.codRep = pr.codRep 
where r.precio between 1200 and 10000;

-- 11) Calcular el valor promedio del costo de los repuestos del taller. El título de la columna debe decir "Precio Promedio".
-- Calculamos el promedio del precio de los repuestos utilizando la función "avg".
-- Asignamos un alias "Precio_Promedio" a la columna resultante para que el título sea claro.
select avg(precio) as Precio_Promedio
from taller.repuesto;

-- 12) Mostrar los datos de los clientes que tienen más de un vehículo.
-- Seleccionamos todos los datos de los clientes que tienen más de un vehículo.
-- Utilizamos una subconsulta para contar cuántos vehículos tiene cada cliente.
-- La condición "having count(codC) = 2" asegura que solo seleccionamos clientes con más de un vehículo.
select * 
from taller.cliente as c
where c.codC in (
select v.codC from taller.vehiculo as v 
where v.codC
group by v.codC
having count(codC) = 2);

-- 13) Identificar con nombre y apellido a los mecánicos que no hicieron ningún diagnóstico.
-- Seleccionamos el nombre y apellido de los mecánicos que no hicieron diagnósticos.
-- Utilizamos "left join" para incluir todos los mecánicos y solo aquellos diagnósticos que coincidan.
-- Filtramos los resultados donde no hay coincidencias en "codMD" (los mecánicos sin diagnósticos).
select m.Nombre, m.apellido, md.codMD 
from taller.mecanico as m
left join taller.mecdiag as md on m.codmec = md.codMec
where md.codMD is null;

-- 14) Mostrar por vehículo el monto final que deben abonar en concepto de presupuesto.
-- Seleccionamos el número de presupuesto, fecha, matrícula, marca, modelo, color y monto de la tabla "vehiculo".
-- Hacemos "inner join" con la tabla "ficha" y luego con la tabla "presup" para obtener la información completa.
-- Ordenamos los resultados por el número de presupuesto (NPresup).
select NPresup, P.Fecha, Matricula, Marca, Modelo, Color, monto
from taller.vehiculo as V
inner join taller.ficha as F on V.codveh = F.codveh
inner join taller.presup as P on F.codF = P.codF
order by NPresup;














