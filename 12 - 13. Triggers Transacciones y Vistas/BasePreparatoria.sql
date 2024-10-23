
drop database if exists preparatoria;
create database preparatoria;
use preparatoria;

create table curso(
idcurso int,
nombre varchar(40),
precio float,
cupo int,
constraint pk_curso primary key (idcurso)
)Engine = InnoDB; 

insert into curso values
(120, "Economicas", 15000,20),
(123, "Programación avanzada", 18500,25),
(125, "Anatomia básica", 21000,30),
(126, "Programacion Web I", 17500,20),
(127, "Motores II", 18000,20),
(128, "Diseño CAD ",19000,30),
(130, "Electronica", 16000,28),
(131, "Programacon básica", 10000,35);


create table aprendizaje(
codaprendiz int,
nombre varchar(40),
constraint pk_producto primary key (codaprendiz)
)Engine = InnoDB;

insert into aprendizaje values
(1020, "Cuentas patrimoniales del activo"),
(1028, "Cuentas patrmoniales del pasivo"),
(1029, "Asientos contables"),
(1030, "Ciclos de repetición"),
(1031, "Estructuras internas y externas logicas"),
(1032, "Magnitudes electricas"),
(1033, "Electronica aplicada"),
(2110, "Quimca basica"),
(2111, "Fisica basica"),
(2112, "Contabilidad I"),
(2114, "Anatomia I"),
(2115, "Biologia celular I"),
(2120, "Partes del Automovil I"),
(4785, "Archivos en profundidad"),
(4786, "Manejo de lineas y curvas"),
(4787, "Diagramacion logica"),
(4788, "Capas y configuraciones de puntas"),
(4789, "Manejo de servidores web"),
(4790, "Base de datos"),
(4791, "Vectores y matrices I"),
(4792, "Procemientos Almacenados");


create table curApren(
codcurso int,
codAprendiz int,
constraint pk_curApren primary key (codcurso, codAprendiz),
constraint fk_curApren_curso foreign key (codcurso) references curso (idcurso),
constraint fk_curApren_apren foreign key (codAprendiz) references aprendizaje (codAprendiz)
)Engine = InnoDB;

insert into curApren values
(120,1020),
(120,1028),
(120,1029),
(125,2114),
(125,2115),
(123,4785),
(123,1030),
(126,4789),
(126,4790),
(126,4792),
(127,2120),
(127,1033),
(128,4786),
(128,4788),
(130,1033),
(130,1032),
(130,2111),
(131,1031),
(131,4791),
(131,4787);


create table inscripcion(
idInsc int auto_increment,
codCurso int,
aspirante varchar(60),
fecha date,
estado boolean, 
constraint pk_inscripcion primary key (idInsc),
constraint fk_inscripcion_curso foreign key (codCurso) references curso (idcurso)
)Engine = InnoDB;

 insert into inscripcion (codCurso,aspirante,fecha,estado) values
 (125,"Juan Manuel Miralla","2023/04/15",true),
 (125,"Marianela Juarez","2023/04/15", False),
 (131,"Ursula Quiros","2023/04/20",True),
 (127,"Carlos Alieri","2023/04/20",True),
 (126,"Nicolas Venier","2023/04/22",True),
 (130,"marcos Torres","2023/04/26",False);

create table pago(
idPago int auto_increment,
fecha date,
idInsc int,
monto float,
constraint pk_pago primary key (idPago),
constraint fk_pago_ins foreign key (idInsc) references inscripcion (idinsc)

)Engine = InnoDB;

insert into pago (fecha,idInsc,monto) values 
("2023/04/15",1,15000),
("2023/04/20",3,10000),
("2023/04/20",4,18000),
("2023/04/22",5,17500);