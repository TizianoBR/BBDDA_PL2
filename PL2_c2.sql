\c postgres

DROP DATABASE IF EXISTS investigar;
CREATE DATABASE investigar;

\c investigar
SET maintenance_work_mem = '512MB';

CREATE TABLE IF NOT EXISTS investigadores(
    codigo_investigador NUMERIC PRIMARY KEY,
    nombre TEXT,
    apellidos TEXT,
    salario NUMERIC
);

CREATE TABLE IF NOT EXISTS contratos(
    codigo_contrato NUMERIC PRIMARY KEY,
    nombre TEXT,
    entidad TEXT,
    coste NUMERIC
);

CREATE TABLE IF NOT EXISTS investigadores_contratos(
    codigo_investigador NUMERIC,
    codigo_contrato NUMERIC,
    horas NUMERIC,
    PRIMARY KEY (codigo_investigador, codigo_contrato)
);

\COPY investigadores FROM 'datos_investigadores.csv' DELIMITER ','
\COPY contratos FROM 'datos_contratos.csv' DELIMITER ','
\COPY investigadores_contratos FROM 'datos_investigadores_contratos.csv' DELIMITER ','

ALTER TABLE investigadores_contratos
ADD FOREIGN KEY (codigo_investigador) REFERENCES investigadores(codigo_investigador) ON DELETE RESTRICT;

ALTER TABLE investigadores_contratos
ADD FOREIGN KEY (codigo_contrato) REFERENCES contratos(codigo_contrato) ON DELETE RESTRICT;

ANALYZE;
SET maintenance_work_mem = '64MB';
