DELIMITER //


CREATE PROCEDURE libro ()
BEGIN
	declare existe int;  /* no tengo tipo de dato */
	
	/* ===========================================
	La siguiente consulta SQL cuenta la cantidad de filas
	en el resultado cuando el nombre es OSCAR y el apellido ARAOZ
	Si hay fila quiere decir que el socio existe
	Si la consulta es EMPTY quiere decir que no hay un socio con
	ese nombre y apellido
	CONCLUSION ----->>>>>>   usamos el COUNT(*)
	Lo guardamos en la variable existe
	====================================================== */
	
	set existe = (select COUNT(*) from socio where nombre="Oscar" AND apellido="Araoz");
	
	IF existe = 0 THEN
		select ("Ese socio no esta registrado") mensaje;
	ELSE 
		select CONCAT("Se le prestara el libro ",l.titulo) mensaje
			from libroautor as la INNER JOIN libro as l on l.codlibro=la.codlibro
				INNER JOIN autor as a on a.codautor=la.codautor
				INNER JOIN ejemplar as e on l.codlibro=e.codlibro
				where 
					nombre="Jose Maria" and apellido="Martin"
					  and deteriorado = 0 and prestado = 0
				limit 1;
			/* **********************
			    se usa LIMIT para quedarnos
				con UNA SOLA FILA
			******************************   */		

	end if ;
END //

call libro()//