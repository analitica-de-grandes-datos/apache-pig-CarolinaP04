/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:datetime , color:chararray, number:INT);
result = GROUP lines BY GetYear(date);
wordcount = FOREACH result GENERATE group, COUNT(lines); 
STORE wordcount INTO 'output' USING PigStorage(',');
