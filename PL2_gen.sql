\c investigar

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

-- \COPY investigadores FROM 'investigadores.csv' DELIMITER ','
-- \COPY contratos FROM 'contratos.csv' DELIMITER ','
-- \COPY investigadores_contratos FROM 'investigadores_contratos.csv' DELIMITER ','

ALTER TABLE investigadores_contratos
ADD FOREIGN KEY (codigo_investigador) REFERENCES investigadores(codigo_investigador) ON DELETE RESTRICT;

ALTER TABLE investigadores_contratos
ADD FOREIGN KEY (codigo_contrato) REFERENCES contratos(codigo_contrato) ON DELETE RESTRICT;