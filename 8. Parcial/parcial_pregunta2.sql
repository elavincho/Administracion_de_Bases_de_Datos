DROP DATABASE IF EXISTS primerparcialbbdd2;
CREATE DATABASE primerparcialbbdd2;
USE primerparcialbbdd2;

CREATE TABLE fabricantes (
codigo INT AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
CONSTRAINT PK_fabricantes PRIMARY KEY(codigo));

CREATE TABLE articulos (
codigo INT AUTO_INCREMENT,
nombre VARCHAR(10),
precio INT,
fabricante INT,
CONSTRAINT PK_articulos PRIMARY KEY(codigo);
-- CONSTRAINT PK_articulos FOREIGN KEY(codigo) REFERENCES fabricantes(codigo));

/*a) Obtener todos los datos de los artículos cuyo precio esté entre los $60 los $120 (ambas cantidades incluidas).*/
SELECT *
FROM articulos
WHERE precio
BETWEEN 60 AND 120;

/*b) Obtener el precio promedio de los artículos de cada fabricante, mostrando solo los códigos de fabricante:*/
SELECT fabricante, AVG(precio) AS PM
FROM articulos
GROUP BY fabricante;

/*c) Añadir un nuevo artículo: Altavoces de $70 para el fabricante 2:*/
INSERT INTO articulos (nombre, precio, fabricante) VALUES ('Altavoces', 70, 2);