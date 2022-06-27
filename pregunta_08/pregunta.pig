/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (col1:chararray, col2:BAG{A:tuple(a1:chararray)}, col3:map[]);
col_23 = FOREACH lines GENERATE FLATTEN(col2) AS C1, FLATTEN(col3) AS D2;
word1= FOREACH col_23 GENERATE(C1,C2) AS G1;
grouped = GROUP word1 BY G1;
wordcount = FOREACH grouped GENERATE group, COUNT(word1);
STORE wordcount INTO 'output' USING PigStorage(',');
