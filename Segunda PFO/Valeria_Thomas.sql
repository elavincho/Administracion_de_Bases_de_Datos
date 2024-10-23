# 1)   Mostrar los datos de los presupuestos cuyo monto es menor a $ 10000.
			select * from taller.presup 
            where Monto <10000;

# 2)   Mostrar el cliente ingresado más joven considerando su documento (del conjunto de datos ingresados).
			select * from taller.cliente
            where dni = (select max(dni) from cliente);
            
# 3)   Mostrar los repuestos que tengan la misma cantidad de stock que en el punto de pedido.
			/*select r.Nombre, r.stock, p.cant from taller.repuesto as r
            inner join presurep as p on r.codRep = p.codRep
            where cant = stock; */
            select nombre from repuesto
            where stock = pp;
            
# 4)   Mostrar los mecánicos cuyo apellido comience con la letra C.
			SELECT * FROM taller.mecanico
			where Apellido like 'c%';

# 5)   Mostrar nombre del repuesto junto al precio ordenado alfabéticamente.
			select r.nombre, r.precio from repuesto as r
            order by nombre asc;
                        
# 6)   Mostrar la cantidad de presupuestos realizados en el taller.
			select count(npresup) as Total_Presupuestos from presup;

# 7)   Mostrar por color cuantos  vehículos registrados hay.
			select color, count(*) as Vehiculos_por_color 
            from vehiculo
            group by color;

# 8)   Mostrar por código de ficha la cantidad de informes que tiene.
			select codF, count(informe) as Cantidad_de_Informes 
            from fichamd
            group by codF;
            
# 9)   Listar ordenado por temática  a los mecánicos que diagnostican (indicar nombre, apellido y temática).
			select m.nombre, m.Apellido, md.tematica from mecdiag as md
            inner join mecanico as m where m.codMec = md.codMec
            order by tematica asc;
            
# 10)  Mostrar los números de presupuesto que tengan al menos un repuesto cuyo precio oscile entre $ 1200 y $ 10000 inclusive.
			select pr.Npresup from presurep as pr
			inner join repuesto as r on r.codRep = pr.codRep 
			where r.precio between 1200 and 10000;
            
# 11)  Calcular el valor promedio del costo de los repuestos del taller. El título de la columna debe decir Precio Promedio
			select avg (precio) as Precio_Promedio from repuesto;
            
# 12)  Mostrar los datos de los clientes que tienen más de un vehículo.
			select * from cliente as c
			where c.codC in (
				select v.codC from vehiculo as v 
				where v.codC
				group by v.codC
				having count(codC) = 2);

# 13)  Identificar con nombre y apellido a los mecánicos que no hicieron ningún diagnóstico.
			select m.Nombre, m.apellido, md.codMD from taller.mecanico as m
			left join mecdiag as md on m.codmec = md.codMec
			where md.codMD is null;
        
# 14)  Mostrar por vehículo el monto final que deben abonar en concepto de presupuesto.
			select 
				v.Matricula, v.Modelo, v.Marca, v.Color, #selecciono los datos de la tabla vehículo que quiero mostrar
				f.codVEH, #selecciono los datos de la tabla ficha que quiero mostrar y se relacionan con la tabla vehículo
				p.NPresup, p.monto as Monto_Final # #selecciono los datos de la tabla presup que quiero mostrar junto con la tabla vehículo
				from vehiculo as v  
				inner join ficha as f on f.codVEH = v.codVEH  #primero hago unión interna con la tabla ficha (2da tabla)
				inner join presup as p on p.codF = f.codF; #luego hago la unión interna entre la tabla ficha y la de presupuesto (3ra tabla)