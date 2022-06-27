/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (letter:chararray, date:chararray, number:int);
numeros = FOREACH lines GENERATE number;
ordered = ORDER numeros By number asc;
ordered = LIMIT ordered 5;
STORE ordered INTO 'output' USING PigStorage(',');