\c investigar

\o PL2_c5_salida.txt

EXPLAIN SELECT COUNT(*) FROM investigadores i JOIN investigadores_contratos ic ON i.codigo_investigador = ic.codigo_investigador WHERE i.salario = 20000 AND ic.horas = 8;

SELECT * FROM pg_stats WHERE (tablename = 'investigadores' AND attname = 'salario') OR  (tablename = 'investigadores_contratos' AND attname = 'horas');