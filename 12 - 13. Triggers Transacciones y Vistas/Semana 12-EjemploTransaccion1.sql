
	
	delimiter //
	
    use taller //
    
    drop procedure if exists ingresoConTrans //
	
	create procedure ingresoConTrans(in presupuesto int, in repuesto int, in cantidad int)
	begin
	
		start transaction;
		insert into presurep values(presupuesto, repuesto, cantidad);
		
		if @Hay = true then
		/* ====  CONFIRMAMOS EL INSERT ==== */
			commit; 
			select 'se actualizo presurep satisfactoriamente' as MENSAJE;
		else
		/* ====  DESHACEMOS  EL INSERT ==== */
			rollback;
			select 'No hay stock suficiente, confeccionar orden de compra' as MENSAJE;
		end if;	
	
	
	end //
	
	drop trigger if exists ActualizaConTrans // 
	
	create trigger ActualizaConTrans before insert on presurep
	for each row
	begin
		declare disponibles int; /* variable para conocer el stock existente */
		
		set disponibles = (select stock from repuesto where codrep = NEW.codrep);
		
		if NEW.cant <= disponibles then
			update repuesto set stock = stock - NEW.cant where codrep = NEW.codrep;
			
			set @Hay = true; /* variable de usuario para evaluar la transacción */
		else
			set @Hay = false;
		end if;
		
	end//