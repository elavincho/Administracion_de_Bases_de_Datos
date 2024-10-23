
		delimiter //
		drop procedure if exists inscripto// /* por si ya existe y quiero reeplazarlo */
		
		create procedure inscripto(in cur int, in alumno varchar(60))
		begin
		
			declare pkIncripta int;  /* para usarla en el registro del pago */
			declare valorCurso float;
			
			/* ===================================0==========
				La PK de inscripcion es auto incrementable
			================================================== */

			insert into inscripcion values('',cur, alumno, curdate(),null);
/* **********************************************************************************
				Este insert desencadena el trigger
				el trigger verifica si hay cupo en el curso
				setea el valor del atributo estado convirtiendolo a false o true
				El momento debe ser ANTES ----->>>>>>>    BEFORE
														-----------
				Cuando termina de ejecutar el trigger vuelve a ESTE PROCESO
Debe traer en una variable de usuario un verdadero o un falso para saber si hay que
generar una fila en la tabla PAGO				
***************************************************************************************** */
			if @Hay = true then
				/* ==============================
				se registra el pago del curso
				La PK de pago es autoincrementable
				Hay que buscar cual es la pk de la inscripciom (en este caso es la ultima)
				y el precio del curso
			================================================================================ */

				set pkIncripta = (select max(idInsc) from inscripcion);
				set valorCurso = (select precio from curso where idCurso = cur); /* cur es elparametro de entrada */
				
				insert into pago values('',curdate(), pkIncripta,valorCurso); 
				
				select concat('Se inscribio a  ',alumno,'   en el curso   ',cur,'  Costo:  ',valorcurso) as MENSAJE;
			else
				select concat('No hay vacante para el curso   ', cur) as MENSAJE;

			end if;		
		
		end//
		
		
		create trigger VerCupo before insert on inscripcion for each row
		begin
		
			declare cantCupo int default 0;
			declare anotados int default 0;
			
			
			set cantCupo = (select cupo from curso where idcurso = NEW.codCurso);
			set anotados = (select count(*) from inscripcion where codcurso = NEW.codCurso);
			
			if anotados < cantCupo then
				set @Hay = true;
				set NEW.estado = true;
			
			else
				set @Hay = false;
				set NEW.estado = false;
			
			end if;
		
		end //