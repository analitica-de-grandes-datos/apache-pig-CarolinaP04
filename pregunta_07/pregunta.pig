/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (col1:chararray, col2:BAG{A:tuple(a1:chararray)}, col3:map[]);
col_123 = FOREACH lines GENERATE col1, col2, col3;
r = FOREACH col_123 GENERATE (col1,col2) AS G1 , FLATTEN(col3) AS word;
grouped = GROUP r BY G1;
wordcount = FOREACH grouped GENERATE group, COUNT(r) AS C3;
word2= FOREACH wordcount GENERATE group.$0 AS C1, COUNT(group.$1) AS C2, C3;
ordered = ORDER word2 BY C1,C2,C3 ASC;
STORE ordered INTO 'output' USING PigStorage(',');