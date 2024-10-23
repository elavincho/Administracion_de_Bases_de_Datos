delimiter ;
use negocio;
drop procedure if exists CrearBalance;


/*
1) Construir un procedimiento que permita, obtener a la fecha de hoy los locales que realizaron la mayor venta.
    El resultado obtenido deberá ser almacenado en la estructura Balance. 
*/
delimiter //
create procedure CrearBalance()
begin
    declare localMax int;
    declare montoMaximo float;
    declare idUltBalance int;
    declare varHandler boolean default false;
    declare locales cursor for select idlocal, monto from ventas where monto = (select max(monto) from ventas);
    declare continue handler for not found set varHandler = true;
    open locales;
    fetch locales into localMax, montoMaximo;
    set idUltBalance = (select idbalan from balance order by fecha desc limit 1);
    while varHandler = false do
        insert into balance (idbalan, fecha, montomax, idlocal)
            values (idUltBalance + 1, curdate(), montoMaximo, localMax);
        set idUltBalance = idUltBalance + 1;
        fetch locales into localMax, montoMaximo;
    end while;
    close locales;
end//

call CrearBalance()//