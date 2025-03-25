\c investigar

\o PL2_c4_salida.txt

EXPLAIN SELECT * FROM investigadores WHERE salario < 24000;

SELECT * FROM pg_stats WHERE tablename = 'investigadores' AND attname = 'salario';