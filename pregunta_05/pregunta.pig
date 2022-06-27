/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (col1:chararray, col2:BAG{A:tuple(a1:chararray)}, col3:chararray);
col2 = FOREACH lines GENERATE FLATTEN(col2.a1) AS word;
grouped = GROUP col2 BY word;
wordcount = FOREACH grouped GENERATE group, COUNT(col2);
STORE wordcount INTO 'output' USING PigStorage(',');