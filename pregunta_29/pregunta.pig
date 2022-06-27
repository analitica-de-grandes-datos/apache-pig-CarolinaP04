/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);
fecha = FOREACH lines GENERATE date AS f1;
f2= FOREACH fecha GENERATE ToDate(f1,'yyyy-MM-dd') AS (date_time: DateTime);
column = FOREACH f2 GENERATE ToString(date_time, 'yyyy-MM-dd') AS (fecha_completa:chararray), ToString(date_time, 'MMM') AS (nombre_mes:chararray), ToString(date_time, 'MM') AS (mes:chararray), ToString(date_time, 'M') AS (month:chararray);
column = FOREACH column GENERATE fecha_completa, REPLACE (nombre_mes,'Jan','ene') AS nombre_mes, mes, month;
column = FOREACH column GENERATE fecha_completa, REPLACE (nombre_mes,'Apr','abr') AS nombre_mes, mes, month;
column = FOREACH column GENERATE fecha_completa, REPLACE (nombre_mes,'Aug','ago') AS nombre_mes, mes, month;
column = FOREACH column GENERATE fecha_completa, REPLACE (nombre_mes,'Dec','dic') AS nombre_mes, mes, month;
column = FOREACH column GENERATE fecha_completa, LOWER(nombre_mes), mes, month;
STORE column INTO 'output' USING PigStorage(',');