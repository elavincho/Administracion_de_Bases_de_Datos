/*1) Cree un procedimiento almacenado llamado "pa_traje_prenda" que seleccione el codigo, nombre del traje, */
/* codigo de la prenda, nombre de la prenda y el stock de aquellas prendas que tengan un stock superior o igual */
/* al enviado como parámetro.*/
/* Ejecute el procedimiento creado anteriormente.*/

USE vestuario;

DELIMITER //

DROP PROCEDURE IF EXISTS vestuario.pa_traje_prenda//

CREATE PROCEDURE pa_traje_prenda(IN parametro_stock INT)
BEGIN
    SELECT t.idtraje AS Id_Traje, t.nombre AS Nombre, p.codprenda AS Cod_Prenda, p.nombre AS Nom_Prenda, p.stock AS Stock
    FROM traje t
    JOIN traPre tp ON t.idtraje = tp.codTraje
    JOIN prenda p ON tp.codPrenda = p.codprenda
    WHERE p.stock >= parametro_stock;
END //

DELIMITER ;

CALL pa_traje_prenda(15);


/*2) Cree un procedimiento almacenado llamado "pa_prendas_actualizar_stock" , este procedimiento debera tener dos parametros, */
/* el primero se pasara el codigo de la prenda y en el segundo el nuevo valor del stock. El prodecimiento debera actualizar la prenda */
/* con el nuevo valor de stock informado Ejecute el procedimiento creado anteriormente con algun valor de prenda y stock.*/

USE vestuario;

-- Primero hacemos un SELECT de prenda para conocer su stock inicial.
SELECT * FROM vestuario.prenda;

DELIMITER //

DROP PROCEDURE IF EXISTS vestuario.pa_prendas_actualizar_stock//

CREATE PROCEDURE pa_prendas_actualizar_stock(IN parametro_codprenda INT, IN nuevo_stock INT)
BEGIN
    UPDATE prenda
    SET stock = nuevo_stock
    WHERE codprenda = parametro_codprenda;
END //

DELIMITER ;

CALL pa_prendas_actualizar_stock(1031, 39);

-- Hacemos nuevamente un SELECT de prenda para verificar el nuevo stock.
SELECT * FROM vestuario.prenda;


/*3) Cree un procedimiento almacenado llamado "pa_obra" al cual le enviamos el codigo de una obra y que nos retorne la cantidad de trajes */
/* que tiene esa obra en un parametro de salida. Ejecute el procedimiento creado anteriormente.*/

USE vestuario;

DELIMITER //

DROP PROCEDURE IF EXISTS vestuario.pa_obra//

CREATE PROCEDURE pa_obra(IN parametro_idObra INT, OUT cantidad_trajes INT)
BEGIN
    SELECT COUNT(idTraje) INTO cantidad_trajes
    FROM ObraTraje
    WHERE idObra = parametro_idObra;
END //

DELIMITER ;

CALL pa_obra(8930, @cantidad);
SELECT @cantidad AS Cantidad;


/*4) Implementar una funcion que llamada f_codificado que recibe el nombre de la obra y que nos retorne el nombre de la obra codificado */
/* con *** al final. (Resolver utilizando alguna herramienta de IA y copiar las respuestas obtenidas hasta su resolución) Ejemplo recibe */
/* El hombre del maletin y debe devolver El hombre del male*** Ejecute la funcion.*/

USE vestuario;

DELIMITER //

DROP FUNCTION IF EXISTS vestuario.f_codificado//

CREATE FUNCTION f_codificado(nombre_obra VARCHAR(45))
RETURNS VARCHAR(45)
READS SQL DATA
BEGIN
    DECLARE longitud INT;
    DECLARE nombre_codificado VARCHAR(45);
    SET longitud = CHAR_LENGTH(nombre_obra);
    SET nombre_codificado = CONCAT(LEFT(nombre_obra, longitud - 3), "***");
    RETURN nombre_codificado;
END //

DELIMITER ;

SELECT f_codificado("La mansion misteriosa") AS Funcion_Codificada;


/*5)	Crear una “VISTA", que le permita visualizar cada obra, con el traje y la cantidad de prendas que contiene. Por ejemplo:*/

DROP VIEW IF EXISTS vestuario.obras_trajes_prendas;

CREATE VIEW obras_trajes_prendas AS
SELECT o.nombre AS Obra, t.nombre AS Traje, COUNT(p.codprenda) AS Prendas
FROM obra o
JOIN ObraTraje ot ON o.idObra = ot.idObra
JOIN traje t ON ot.idTraje = t.idtraje
JOIN traPre tp ON t.idtraje = tp.codTraje
JOIN prenda p ON tp.codPrenda = p.codprenda
GROUP BY o.nombre, t.nombre;

SELECT * FROM obras_trajes_prendas;