\c investigar

\o PL2_estadisticas_investigar.txt
SELECT * FROM pg_stats
WHERE tablename IN ('investigadores', 'investigadores_contratos', 'contratos');

SELECT * FROM pg_class
WHERE relname IN ('investigadores', 'investigadores_contratos', 'contratos');
\o