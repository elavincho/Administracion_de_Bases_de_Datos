-- Crear los objetos según la siguiente estructura:
/*Tabla: Clientes*/
-- Columnas:
-- Codigo: entero y autoincrementable, no admite nulos
-- Nombre: cadena de caracteres máximo: 30 caracteres, no admite nulo
-- Domicilio: cadena de caracteres máximo: 30 caracteres, admite nulo
-- Ciudad: cadena de caracteres máximo: 20 caracteres, admite nulo
-- CodigoProvincia: entero no admite nulo
/*Tabla: Provincias*/
-- Columnas:
-- codigo: entero, no admite nulo
-- nombre: cadena de caracteres máximo: 20 caracteres, no admite nulo
-- a) Crear las tablas
-- b) Establezca una restricción primary key al campo código de la tabla provincias y en el campo codigo de la tabla clientes.
-- c) Establezca una restricción foreign key a la tabla clientes que haga referencia al campo código de provincias.
-- USE parcial;

/*Primero creamos la tabla provincia porque hace refencia a la tabla clientes*/

CREATE TABLE provincias (
codigo INT NOT NULL,
nombre VARCHAR(20) NOT NULL,
CONSTRAINT PK_provincias PRIMARY KEY(codigo));

CREATE TABLE clientes (
codigo INT AUTO_INCREMENT NOT NULL,
nombre VARCHAR(30) NOT NULL,
domicilio VARCHAR(30),
ciudad VARCHAR(20),
codigoProvincia INT NOT NULL,
CONSTRAINT PK_clientes PRIMARY KEY(codigo),
CONSTRAINT PK_provincias FOREIGN KEY(codigo) REFERENCES provincias(codigo));


/* ------------------------------------------------------------------------------ */

-- a) Ingrese los siguientes registros en ambas tablas

INSERT INTO provincias VALUES
(1, 'Cordoba'),
(2, 'Buenos Aires'),
(3, 'Mendoza'),
(4, 'Rio Negro');

INSERT INTO clientes VALUES
(1, 'Perez Juan', 'San Martin 123', 'Carlos Paz', 1),
(2, 'Moreno Marcos', 'Colon 234', 'Rosario', 2),
(3, 'Solari Ana', 'Belgrano 567', 'Mendoza', 3);

/*b) Actualice el domicilio del cliente Moreno Marcos a Union 234*/
UPDATE clientes
SET domicilio = 'Union 234'
WHERE nombre = 'Moreno Marcos';

/*c) Elimine los clientes de la ciudad Mendoza*/
DELETE FROM clientes
WHERE ciudad = 'Mendoza';