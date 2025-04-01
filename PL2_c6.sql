\c investigar

\o PL2_c6_salida.txt

EXPLAIN SELECT DISTINCT c.nombre, c.entidad FROM contratos c
JOIN investigadores_contratos ic ON c.codigo_contrato = ic.codigo_contrato 
JOIN investigadores i ON i.codigo_investigador = ic.codigo_investigador
WHERE 
    c.coste BETWEEN 10001 AND 19999 
    AND ic.horas = 5 
    AND i.salario > 16000; 

--SELECT * FROM pg_stats WHERE (tablename = 'investigadores' AND attname = 'salario') OR  (tablename = 'investigadores_contratos' AND attname = 'horas');