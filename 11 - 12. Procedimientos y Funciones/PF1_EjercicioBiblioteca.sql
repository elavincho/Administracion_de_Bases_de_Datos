delimiter ;
use biblioteca;

drop procedure if exists CrearPrestamo;

/*
    Partiendo de la consigna del ejercicio 1 del libro “Ejercicios Resueltos” 
    se pide generar el préstamo si el socio y el autor del libro solicitado existen. 
    Crear el procedimiento con parámetros.
*/

delimiter //
create procedure CrearPrestamo(
    in nombreSocio varchar(60),
    in apellidoSocio varchar(60),
    in nombreAutor varchar(60),
    in apellidoAutor varchar(60)
)
begin
    declare codigoSocio int;
    declare codigoAutor int;
    declare ejemplar int;
    declare nprestamoRealizado int;
    set codigoSocio = (select codsocio from socio where nombre = nombreSocio and apellido = apellidoSocio);
    if codigoSocio is null then
        select concat("No existe socio con el nombre ", nombreSocio, " ", apellidoSocio) mensaje;
    else
        select a.codautor, e.idejem into codigoAutor, ejemplar from
             autor as a inner join libroautor as la on a.codautor = la.codautor
             inner join ejemplar as e on la.codlibro = e.codlibro
             where a.nombre = nombreAutor and a.apellido = apellidoAutor and e.deteriorado = false 
             limit 1;
        if codigoAutor is null or ejemplar is null then
            select "No hay ejemplar disponible para el prestamo" mensaje;
        else
            insert into prestamo (codsocio, fprestamo, fdevolucion, ftope) 
                values (codigoSocio, curdate(), DATE_ADD(curdate(), interval 7 day), DATE_ADD(curdate(), interval 9 day));
            set nprestamoRealizado = (select nprestamo from prestamo order by fprestamo desc limit 1);
            insert into detallepre (nprestamo, idejem) values (nprestamoRealizado, ejemplar);
            select "Prestamo realizado" as mensaje, ejemplar, nprestamoRealizado as nprestamo;
        end if;
    end if;
end//

call CrearPrestamo("Oscar", "Araoz", "Jose Maria", "Martin")//

-- probar error socio inexistente
call CrearPrestamo("Roberto", "Carlos", "Jose Maria", "Martin")//

-- probar error ejemplar no existente
call CrearPrestamo("Oscar", "Araoz", "Julio", "Cortazar")//