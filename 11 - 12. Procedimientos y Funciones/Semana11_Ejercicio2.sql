
delimiter //

create procedure Muestra()
begin 
   
   declare nomLibro varchar(90);
   declare isbnLibro varchar(15);
   declare ediLibro varchar(20);
   declare fechaEscri date;
   declare fechaEdi date;
   declare varHandler boolean default false;  
   declare contador int default 0;  /* para saber si estan los 6 */
   declare HayLibros boolean default false; /* para saber si esta vacia */
   
   declare datos cursor for select titulo,isbn,editorial,aescritura,aedicion
									from libro
									limit 6;
						/* ***************************
                             El limit 6 permite proyectar
								solamente 6 TUPLAS
						**********************************  */
	declare continue handler for not found Set varHandler = True;	

	open datos;
	fetch datos into nomLibro,isbnLibro,ediLibro,fechaEscri,fechaEdi;
	while varHandler = false do
		/* *************************
			entramos por lo tanto por lo
			menos UN libro tiene la tabla
		************************************** */	
	     set HayLibros = true;
	
		/* *******************************
			los datos estan sueltos en variables por lo tanto
			los concatenamos en un mensaje
		************************************************************** */
		select concat(nomLibro,'  ', isbnLibro,'  ',ediLibro,'  ',fechaEscri,'  ',fechaEdi) as mensaje;
		/* **********************
			sumamos 1 a la variable del contador
		********************************************* */	
		set contador = contador + 1;
		
		/* **  leemos nuevamente  */
	    fetch datos into nomLibro,isbnLibro,ediLibro,fechaEscri,fechaEdi;
		
	end while;
	
	if HayLibros = false then
		select 'No hay libros para mostrar' as Mensaje;
	else
        if contador < 6 then
			select concat('Son','  ',contador,'  ''libros','  ','menos de 6') as mensaje;
		end if;
			/* **********************************
				observa que este bloque IF solo tiene codigo por
				el verdadero
			*************************************************************** */	
	end if;
	close datos;
	
end //	