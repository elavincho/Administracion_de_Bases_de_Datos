
drop database if exists Peliculas;
create database Peliculas;
use Peliculas;

CREATE TABLE Nacionalidad(
idNacionalidad INT,
nombreNacionalidad VARCHAR(30),
CONSTRAINT PK_Nacionalidad PRIMARY KEY(idNacionalidad)
);

CREATE TABLE Actor(
idActor INT,
idNacionalidad INT,
nombreActor CHAR(40),
CONSTRAINT PK_Actor PRIMARY KEY (idActor),
CONSTRAINT FK_Actor FOREIGN KEY (idNacionalidad) REFERENCES Nacionalidad(idNacionalidad)
);

CREATE TABLE Genero(
idGenero INT,
nombreGenero CHAR(30),
CONSTRAINT PK_Genero PRIMARY KEY(idGenero)
);

CREATE TABLE Rol(
idRol INT,
nombreRol CHAR(20),
CONSTRAINT PK_Rol PRIMARY KEY (idRol)
);

CREATE TABLE Socio(
identificacion CHAR(13),
nombreSocio CHAR(50),
direccion CHAR(50),
telefono CHAR(13),
CONSTRAINT PK_Socio PRIMARY KEY(identificacion)
);

CREATE TABLE Pelicula(
idPelicula INT,
idNacionalidad INT,
nombrePelicula CHAR(40),
anio CHAR(4),
idGenero INT,
productora CHAR(40),
CONSTRAINT PK_Pelicula PRIMARY KEY (idPelicula),
CONSTRAINT FK_Pelicula_Genero FOREIGN KEY (idGenero) REFERENCES Genero(idGenero),
CONSTRAINT FK_Pelicula_Nacionalidad FOREIGN KEY (idNacionalidad) REFERENCES Nacionalidad(idNacionalidad)
);


CREATE TABLE Ejemplar(
idEjemplar INT,
idPelicula INT,
estado CHAR(18),
CONSTRAINT PK_Ejemplar PRIMARY KEY(idEjemplar),
CONSTRAINT FK_Ejemplar_Pelicula FOREIGN KEY(idPelicula) REFERENCES Pelicula(idPelicula)
);

CREATE TABLE Actua(
idActor INT,
idPelicula INT,
idRol INT,
CONSTRAINT PK_Actual PRIMARY KEY (idActor,idPelicula,idRol),
CONSTRAINT FK_Actua_Actor FOREIGN KEY (idActor) REFERENCES Actor(idActor),
CONSTRAINT FK_Actua_Peli FOREIGN KEY (idPelicula) REFERENCES Pelicula(idPelicula),
CONSTRAINT FK_Actua_Rol FOREIGN KEY (idRol) REFERENCES Rol(idRol)
);

CREATE TABLE Renta(
idRenta INT,
identificacion CHAR(13),
idEjemplar INT,
fechaRenta DATE,
fechaEntrega DATE,
CONSTRAINT PK_Renta PRIMARY KEY(idRenta),
CONSTRAINT FK_Renta_IFE FOREIGN KEY (identificacion) REFERENCES Socio(identificacion),
CONSTRAINT FK_Renta_Ejemplar FOREIGN KEY (idEjemplar) REFERENCES Ejemplar(idEjemplar)
);



insert into Nacionalidad values
(65,'Alemana'),
(12,'Estadounidense'),
(43,'Argentina'),
(25,'Australiana'),
(06,'Suiza'),
(31,'Austriaca'),
(998,'Española'),
(997,'Francesa'),
(995,'Italiana'),
(13,"Mexicana"),
(14,'Britanica'),
(15,'Portuguesa'),
(64,"Boliviana"),
(34,'Holandesa'),
(55,'Uruguaya'),
(44,'Brasilera'),
(66,'Peruana'),
(87,'Venezolana'),
(127,'Colombiana'),
(128,'Chilena'),
(130,"Canadiense");


insert into Actor values 
(126,65, 'Michael Fassbender'),
(281,25, 'Heath Ledger'),
(327,06, 'Bruno Ganz'),
(215,31, 'Christoph Waltz'),
(244,12, 'Mila Kunis'),
(368,43, 'Ricardo Darin'),
(369,43, "Erica Rivas"),
(741,12,'Patrick Dempsey'),
(742,997,'Jean Reno'),
(743,12,'Justin Chambers'),
(745,998,'Antonio Banderas'),
(12,43,"Luciano Caseres"),
(13,43,"Diego Peretti"),
(14,43,"Luisana Lopilato"),
(15,43,"Guillermo francella"),
(28,12, "Adam Sandler"),
(30,130, "Jim Carrey"),
(31,64, "Marcelino Yanahuaya"),
(38,12, "Owen Wilson"),
(40,12, "Vince Vaughn"),
(100,14,"Will Smith"),
(200,13,"Gerard Butler"),
(300,998,"Orlando Bloom"),
(400,25,"Sam Neil"),
(500,12,"Emma Watson"),
(135,12,'Tom Cruise'),
(136,12,'Cameron Diaz'),
(137,12,'Brad pitt'),
(138,12,'Jennifer Lopez'),
(139,43,'Luciano Caceres'),
(53,12,"Paul Walker"),
(58,12,"Vin Diesel"),
(60,12,"Michelle Rodriguez"),
(73,12,"Ana Faris"),
(74,12,"Shawn Wayans"),
(80,12,"Mike Tyson"),
(81,12,"Cleo King"),
(86,12,"Leonardo Di caprio"),
(87,14,"Kate Winslet"),
(88,12,"Elsa Raven"),
(90,12,"Harrinson Ford"),
(91,12,"Gary Kurtz"),
(93,12,"Glenn Close"),
(95,14,"Hugh Laurie"),
(94,12, "Laura Dern"),
(96,12 ,"Patrick Wilson"),
(97,12,"Joey King"),
(20,43,"Eugenia Suarez"),
(22,43,"Pablo Rago"),
(282,14,"Jason Statham"),
(511,12,"Sandra Bullock");


insert into Genero values 
(9,'Accion'),
(5,'Drama'),
(7,'Belico'),
(8,'Comedia Negra'),
(4,'Comedia'),
(12,'Ciencia Ficcion'),
(2,'Policiaco'),
(3, "Historico"),
(11, "Aventura"),
(15, "Romantica"),
(18, "Terror"),
(20, "Fantasia"),
(17, "Musical"),
(16, "Suspenso"),
(19, "Zombies"),
(22, "Guerra"),
(23, "Horror"),
(14, "Animacion"),
(6, "Comedia Infantil"),
(25,"Comedia Romantica");




INSERT INTO Rol VALUES
(250,'Director'),
(251,'Iluminador'),
(252,'Camarografo'),
(253,'Escenografo'),
(254,'Ambientador'),
(241,"Actor Principal"),
(242,"Actor Secundario"),
(243, "Extra"),
(244,"Actor de Reparto"),
(245,"Part. Especial"),
(248,'Actriz Secundaria'),
(249,'Actriz Principal');


INSERT INTO Socio VALUES
('A001','Lucas Daglio','Francisco Madero 1172','46544361'),
('A002','Rocio Amadeo','Bosque Alegre 242','02921496585'),
('A003','Julio Rodriguez','Baigorria 5400','48759568'),
('A004','Matias Lopez','Av Lope de Vega 1254','65487952'),
('A005','Gianluca Perez','Cramer 8574','44880130'),
('B842','Julian Martinez', 'America 582', '20653245'),
('B621','Marcos Lescano', 'Garrazo 13', '44852648'),
('B209','Julieta Zanata', 'Coromillo 2468', '25891002'),
('B333','Maria Ana Schmaka', 'Caleupa 396', '49630021'),
('B088','Nicolai Zurpeti', 'Soralpo 489', '35681200'),
('B145','Ivan Spalozka', 'Jurasirca 888', '20558878'),
("C567","Rodrigo Gomez","Rivadavia 1950","46891264"),
("C123","Rocio Moser","Virgilio 1950","46893542"),
("C890","Alejandra Laudini","Lima 1120","46899876"),
("C267","Pablo Belmont","Lozano 1650","46894785"),
("C978","Miguel Arrono","Canada 2450","46893695"),
("G456","Juan García", "Bacacay 5066", "46728665"),
("G234","Esteban Rodriguez", "Bogotá 2457", "46375923"),
("G719","Nicolas Fernández", "Loper de Vega 1206", "46528931"),
("G491","Lucas Martínez", "Moliere 259", "49724711"),
("G250","Agustín Gómez", "San Blas", "49123418"),
('A043','Gonzalo Altochurro', 'Calle Verdadera 123', '4788-2314'),
('B389','Charlie Gee', 'Calle Trucha 456', '4567-9076'),
('C321','Lalo Juggernaut', 'Calle Zarpadin 789', '15-5327-7543'),
('D456','Rick janmes', 'Calle Teladejo 1000', '4866-1245'),
('E789','Lee sing', 'Calle Rotin 4000', '15-4323-6578'),
("E675","Luis Rodriguez","AvFrancisco Beiro 5321","47572005"),
("T456","Jose Martinez","Ezeiza 341","44880082"),
("E183","Alonso Lopez","Florida 1100","46001292"),
("F665","Maria Sanchez","Blasco Ibañez","00214523"),
("G553","Isabel Garcia","AvLope de vega","47778203"),
('C934','Juan Carlos','Ingeniero Pereyra 5024','46571525'),
('M488','Jose Pablo','Francisco Madero 1762','49852585'),
('M231','Ramiro Ibañez','Calderon de Barca 1234','46578585'),
('L657','Federico Fernandez','Corrientes 4054','46571212'),
('L278','Francisco Amadeo','Estero Bellaco 4564','44884546');



insert into Pelicula values
(1438, 12,'X-Men: First Class','2011', 12,'20th Century Fox'),
(1363, 12,'Inglourious Basterds','2009', 5,'Universal Pictures'),
(1255, 12,'The Dark Knight','2008', 9, 'Legendary Pictures'),
(1520, 43,'Relatos Salvajes','2014', 8, 'Kramer & Sigman Films'),
(1282, 65,'Der Untergang','2004', 7, 'Newmarket Capital Group'),
(1491, 12,'Ted', '2012', 4,'Universal Pictures'),
(2216,998,'El inmortal','2010',23,'Luc Besson'),
(2217,12,'Encantada','2007',14,'Disney'),
(2218,12,'Bob Esponja: héroe fuera del agua','2022',14,'Paramount Pictures'),
(2219,997,'Matador','1986',5,'Vicente Gómez'),
(2220,12,'X-Men: primera generación','2011',12,'FOX'),
(1111,998,"Rapido y furioso","2005",9,"SONY"),
(1212,14,"scary movie","2008",4,"Warner"),
(1313,14,"Que paso ayer","2011",4,"Pixar"),
(1414,998,"Titanic","2000",5,"Paramount"),
(1515,15,"Star Wars","2005",12,"Lucas Films"),
(1435,998,"101 Dalmatas","1995",14,'Universal Pictures'),
(1280,13,"Bajo la misma estrella","2014",15,'Luc Besson'),
(2564,14,"El conjuro","2014",18,"Fox"),
(2108,12,"El transportador","2005",9,'Universal Pictures'),
(3065,25,"Juntos y revueltos","2014",4,'Luc Besson');


insert into Actua values
(126,1438,241),
(126,1363,242),
(215,1363,241),
(281,1255,241),
(368,1520,241),
(369,1520,249),
(327,1282,241),
(244,1491,249),
(742,2216,241),
(741,2217,242),
(126,2220,241),
(745,2218,242),
(745,2219,242),
(137,1363,242),
(53,1111,241),
(58,1111,241),
(60,1111,248),
(73,1212,248),
(74,1212,241),
(282,2108,241),
(80,1313,245),
(81,1313,250),
(86,1414,241),
(87,1414,249),
(88,1414,250),
(90,1515,241),
(91,1515,244),
(93,1435,249),
(95,1435,242),
(94,1280,248),
(96,2564,241),
(97,2564,248);


insert into Ejemplar values
(1101,1255,"disponible"),
(1102,1255,"disponible"),
(1103,1255,"alquilada"),
(1104,1255,"disponible"),
(1105,1255,"disponible"),
(1106,1255,"disponible"),
(1107,1255,"disponible"),
(1108,1255,"disponible"),
(1109,1363,"disponible"),
(1110,1363,"disponible"),
(1111,1363,"disponible"),
(1112,1363,"inutilizada"),
(1113,1363,"disponible"),
(1114,1438,"alquilada"),
(1115,1438,"alquilada"),
(1116,1491,"disponible"),
(1117,1491,"disponible"),
(1118,2218,"disponible"),
(1119,2218,"disponible"),
(1120,2218,"disponible"),
(1121,1212,"alquilada"),
(1122,1212,"inutilizada"),
(1123,1212,"inutilizada"),
(1124,1212,"disponible"),
(1125,2564,"disponible"),
(1126,2564,"alquilada"),
(1127,2564,"disponible"),
(1128,3065,"alquilada"),
(1129,3065,"alquilada"),
(1130,3065,"alquilada"),
(1131,2219,"inutilizada"),
(1132,1520,"inutilizada"),
(1133,1111,"disponible"),
(1134,1111,"inutilizada"),
(1135,1414,"alquilada"),
(1136,1435,"disponible"),
(1137,1435,"disponible"),
(1138,2216,"alquilada"),
(1139,2216,"disponible");

insert into renta values
(5001,"L278",1103,"2022/06/13","2022/06/27"),
(5006,"B145",1114,"2022/06/22","2022/06/27"),
(5008,"G250",1138,"2022/06/03","2022/06/29"),
(5009,"A043",1135,"2022/06/17","2022/06/24"),
(6001,"E183",1130,"2022/06/16","2022/06/30"),
(6002,"A001",1126,"2022/06/23","2022/06/23"),
(6003,"E183",1121,"2022/06/19","2022/06/24"),
(6004,"A001",1138,"2022/06/20","2022/07/09"),
(6005,"A002",1135,"2022/06/25","2022/07/19"),
(6006,"A003",1114,"2022/06/28","2022/07/29"),
(6007,"G250",1115,"2022/07/03","2022/07/13"),
(6008,"L278",1128,"2022/07/03","2022/07/13"),
(6009,"A043",1129,"2022/07/03","2022/07/13");

