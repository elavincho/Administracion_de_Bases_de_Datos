drop database if exists negocio;
create database negocio;
use negocio;

create table local (
idlocal int,
nombre varchar(30),
constraint pk_local primary key (idlocal)
)Engine=innoDB;

create table ventas (
codVta int,
idlocal int,
monto float,
fecha date,
constraint pk_ventas primary key (codVta),
constraint fk_ventas foreign key (idlocal) references local(idlocal)
)Engine=innoDB;

create table balance (
idbalan int,
fecha date,
montomax float,
idlocal int,
constraint pk_balance primary key (idbalan),
constraint fk_balance foreign key (idlocal) references local(idlocal)
)Engine=innoDB;


insert into local values
(38,"Floresta"),
(39,"Villa Luro"),
(47,"Liniers"),
(53,"Once"),
(55,"Flores"),
(58,"Caballito"),
(62,"Urquiza"),
(63,"Centro"),
(65,"Devoto"),
(69,"Retiro"),
(70,"Congreso");

insert into ventas values
(3874,38,2379,"2023/03/30"),
(3875,39,1830.50,"2023/04/11"),
(3876,53,2747,"2023/04/11"),
(3877,47,1378,"2023/04/15"),
(3879,38,1000,"2023/05/05"),
(3880,55,1284.50,"2023/05/05"),
(3882,58,1896,"2023/05/10"),
(3883,55,2200,"2023/05/11"),
(3884,47,1300,"2023/05/11"),
(3885,47,806.50,"2023/05/11"),
(3886,58,780,"2023/05/18"),
(3887,62,3484.50,"2023/05/18"),
(3888,63,2880,"2023/05/20"),
(3889,69,2750.50,"2023/05/20"),
(3890,70,3300,"2023/05/20"),
(3891,69,734,"2023/05/23"),
(3892,65,2650,"2023/05/23");

insert into balance values
(44772,"2023/03/15",2540,39);

