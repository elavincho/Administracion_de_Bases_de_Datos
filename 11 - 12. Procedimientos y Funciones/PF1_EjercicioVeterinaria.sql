delimiter ;
use canamigo;
drop procedure if exists MostrarInfoPorDuenio;
drop function if exists perrosPorRaza;
drop procedure if exists AsignarAdiestrador;
drop procedure if exists AsignarAdopciones;

/*
1)  Una vez por mes se le entrega a los dueños de los perros la rutina, la frecuencia semanal y el adiestrador que tendrá su mascota.
	Para ello debe construir un procedimiento que dado el nombre del dueño muestre la información mencionada de cada uno de sus perros.
*/
delimiter //
create procedure MostrarInfoPorDuenio(in nombreDuenio varchar(50))
begin
	declare existe int;
    set existe = (select count(*) from duenio where d_nombre = nombreDuenio);
    if existe = 0 then
		select ("Dueño no encontrado") mensaje;
    else
		select p_nombre as nombrePerro, frecuenciaSemanal, a_nombre as adiestrador from (select * from duenio where d_nombre = nombreDuenio) d
			inner join perro as p on d.d_dni = p.d_dni
            inner join adiestramiento as a on p.p_codigo = a.p_codigo
            inner join adiestrador on adiestrador.a_nrolegajo = a.a_nrolegajo;
    end if;
end //

call MostrarInfoPorDuenio("Mansilla Delia")//
-- probar mensaje de error
call MostrarInfoPorDuenio("Elon Musk")//
/*
2) La veterinaria cuenta con adiestradores especializados en cada raza. 
	Por esa razón necesita saber cuántos adiestradores y cuantos perros tiene según sea la raza 
    Para ello debe crear una Función que permita ingresar una raza e informe lo solicitado 
    y en el caso de no contar con perros de esa raza le muestre un mensaje al usuario “No hay perros de la raza xxxxxx.”
*/
create function perrosPorRaza (raza varchar(20)) returns int
begin
	declare cuenta int;
    set cuenta = (select count(*) from perro as p where p.P_raza = raza);
    if cuenta = 0 then
		-- No me deja hacer un select dentro de una funcion
		return (concat('No hay perros de la raza ', raza));
	end if;
    return cuenta;
end//

/*
3) En los próximos meses cada perro que ingrese a la veterinaria se le asignará al adiestrador que tenga menos perros a su cargo
  para que adquiera práctica. Para ello debe construir un procedimiento que permita ingresar 
  código, nombre, raza, peso y Dni del dueño en la estructura perros, y la tupla correspondiente de adiestramiento
  sabiendo que la PK de adiestramiento debe ser el correlativo al último ingresado.
  Los datos que no se cuenta con información deben ser nulos. Se debe controlar que el Dni del dueño sea válido para realizar el insert en la estructura. 
  En caso de NO existir el Dni en la estructura “Dueño” se debe CANCELAR la operación de alta hasta que se solucione el problema,
  obviamente se debe informar de dicha situación al usuario mediante un mensaje.
*/
create procedure AsignarAdiestrador(
  in codigo varchar(8),
  in nombre varchar(30),
  in raza varchar(20),
  in peso decimal(5,2),
  in DNI varchar(10)
)
begin
  declare existeDuenio int;
  declare nroLegajoAsignado int;
  set existeDuenio = (select count(*) from duenio where d_dni = DNI);
  set nroLegajoAsignado = (select t1.a_nrolegajo from 
    (select a_nrolegajo, count(*) as cant from adiestramiento group by a_nrolegajo order by cant limit 1) t1);
  if (existeDuenio = 0) then
    select "DNI de Dueño no registrado" mensaje;
  else
    insert into perro (p_codigo, p_nombre, p_raza, p_peso, d_dni) values (codigo, nombre, raza, peso, DNI);
    insert into adiestramiento (a_nrolegajo, p_codigo) values (nroLegajoAsignado, codigo);
  end if;
end//

call AsignarAdiestrador("CORG1527", "Leon", "Corgi", 12.50, "23879456")//
-- probar el mensaje de error
call AsignarAdiestrador("CORG1527", "Leon", "Corgi", 12.50, "XXXXXXX")//

/*
4) La veterinaria cuenta con un Club de perros abandonados.
  Esta situación fue comentada a todos los clientes de la veterinaria y decidieron adoptarlos entre ellos.
  Los perros abandonados están en la estructura “Abandono” y a medida que son adoptados se eliminan de dicha estructura.
  Para asegurarle una buena atención solo podrán adoptar aquellos que tengan UN solo perro.
  Debe crear un procedimiento que permita la adopción de los perros. Informar si fueron adoptados todos,
  en caso contrario cuantos quedaron sin adoptar.
*/
create procedure AsignarAdopciones()
begin
  declare idPerro int;
  declare codPerro varchar(8);
  declare nomPerro varchar(30);
  declare razaPerro varchar(20);
  declare varHandler boolean default false;
  declare dniAdoptante varchar(10);

  declare abandonados cursor for select id, codigo, nombre, raza from abandono;
  declare continue handler for not found set varHandler = true;
  open abandonados;
  fetch abandonados into idPerro, codPerro, nomPerro, razaPerro;
  while varHandler = false do
    set dniAdoptante = (select d.d_dni from duenio as d inner join perro as p on d.d_dni = p.d_dni group by p.d_dni having count(p.p_codigo) <= 1 limit 1);
    if dniAdoptante is not null then
      insert into perro (p_codigo, p_nombre, p_raza, d_dni) values (codPerro, nomPerro, razaPerro, dniAdoptante);
      delete from abandono where id = idPerro;
      fetch abandonados into idPerro, codPerro, nomPerro, razaPerro;
    else
      set varHandler = true;
    end if;
  end while;
  close abandonados;
  select concat("Cantidad de perros sin adoptar: ", count(*)) as mensaje from abandono;
end//

call AsignarAdopciones()//