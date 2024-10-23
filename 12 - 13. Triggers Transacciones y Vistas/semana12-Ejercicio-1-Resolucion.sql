
/*
1) Es política del videoclub que, al incorporar un nuevo socio, este deba llevar una película.
Se pide que al realizar el insert del nuevo socio se dispare un proceso que permita realizar la renta de UNA película.
La película a alquilar debe ser la que tenga la mayor cantidad de ejemplares disponibles.

*/

delimiter //
use peliculas //

drop trigger if exists firstRent // 

create trigger firstRent after insert on socio 
for each row 
begin 
    declare movieToRentId int;
    declare can int;
    declare copyToRentId int;
    declare rentaNextId int;

    select idPelicula, count(*) into movieToRentId, can from ejemplar where estado='disponible' group by idPelicula having count(*) = 
    (select max(cant) from (select idPelicula, count(*) as cant from ejemplar where estado='disponible' group by idPelicula) t) limit 1;

    set copyToRentId = (select idEjemplar from ejemplar where idPelicula=movieToRentId and estado='disponible' limit 1);

    set rentaNextId = (select IFNULL(max(idRenta), 0)+1 from renta);

    insert into renta(idRenta, idEjemplar, fechaRenta, fechaEntrega, identificacion) values 
        (rentaNextId, copyToRentId, curdate(), DATE_ADD(Curdate(),INTERVAL 7 DAY), new.identificacion);
end //

-- ejemplo del llamado
-- insert into socio (identificacion, nombreSocio, telefono, direccion) values ('10000004', 'socio4', null, null);
-- select * from socio;
-- select * from renta;
