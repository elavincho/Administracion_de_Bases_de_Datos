
/* ============================
	Mostrar la fecha actual 
 ==================================*/
select curdate();

/* ============================
	Mostrar fecha y hora actual 
===================================*/
select now();

/* =============================
	Mostrar hora actual
=================================== */
select curTime();

/* ========================================================
	Mostrar año, mes, dia, hora, ultimo dia del mes de una fecha 
===============================================================*/

		select YEAR(now());  /* ==   Selecciona el año == */
		select MONTH (now()) as mes; /* == Selecciona el mes == */
		select DAY(now()) as dia;   /* == Selecciona el día == */
		select TIME(now()) as hora;  /* == Selecciona la hora == */
		Select LAST_DAY(now());  /* == Selecciona el ultimo dia del mes == */

/* =========================================================
	Dar formato a la fecha
=============================================================== */

select Date_format("2023/08/01",'%Y/%M/%d');    /* ==  '2023/August/01 == */
select Date_format("2023/3/12",'%Y-%M-%d %h:%i:%s %p');  /* == '2023-March-12 ..:..:.. AM' == */
select Date_format("2023/03/12",'%W %d %M %Y'); /* ==  'Sunday 12 March 2023' == */
select Date_format(now(),'El año actual es %Y'); /* ==  'El año actual es ....' == */


/* ===================================================
	Sumar y Restar tiempo 
====================================================== */

select DATE_ADD(Curdate(),INTERVAL 20 DAY); /* == Agrega 20 días a la fecha actual  == */
select DATE_ADD(now(),INTERVAL 30 MINUTE); /* == Agrega 30 minutos a la fecha actual == */
select DATE_ADD(Curdate(),INTERVAL 50 YEAR); /* == Agrega 50 años a la fecha actual == */
select DATE_ADD(Curdate(),INTERVAL '10-5' YEAR_MONTH); /* == Agrega 10 años 5 meses a la fecha actual == */

select DATE_SUB(Curdate(),INTERVAL 8 YEAR); /* == Resta 8 años a la fecha actual == */ 
select DATE_SUB(now(),INTERVAL 24 HOUR); /* == Resta 24 horas a la fecha actual == */
select DATE_SUB(Curdate(),INTERVAL '7-2' YEAR_MONTH); /* == Resta 7 años dos meses a la fecha actual == */


/* =================================================
	Restar dos fechas
====================================================	*/

SELECT DATEDIFF(Curdate(),'2014-11-02'); /* == cuantos días han pasado == */
SELECT DATEDIFF(Curdate(),'2025-09-21'); /* == Cuantos días faltan == */