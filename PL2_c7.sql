\c postgres

DROP DATABASE IF EXISTS telepark;
CREATE DATABASE telepark;

\c telepark

CREATE TABLE IF NOT EXISTS clientes(
    clienteid INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    telefono INTEGER UNIQUE NOT NULL,
    provincia TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS vehiculos(
    vehiculoid INTEGER PRIMARY KEY,
    matricula TEXT UNIQUE NOT NULL,
    marca TEXT NOT NULL,
    modelo TEXT NOT NULL,
    color TEXT NOT NULL,
    clienteid_clientes INTEGER
);

CREATE TABLE IF NOT EXISTS plazas(
    plazaid INTEGER PRIMARY KEY,
    numero INTEGER NOT NULL,
    nivel INTEGER NOT NULL,
    seccion TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS reservas(
    reservaid INTEGER PRIMARY KEY,
    fechainicio TIMESTAMP NOT NULL,
    fechafin TIMESTAMP NOT NULL,
    vehiculoid_vehiculos INTEGER,
    plazaid_plazas INTEGER,
    clienteid_clientes INTEGER
);

CREATE TABLE IF NOT EXISTS incidencias(
    incidenciaid INTEGER PRIMARY KEY,
    descripcion TEXT NOT NULL,
    fechaincidencia TIMESTAMP NOT NULL,
    estado TEXT NOT NULL,
    reservaid_reservas INTEGER
);

CREATE TABLE IF NOT EXISTS pagos(
    pagoid INTEGER PRIMARY KEY,
    cantidad NUMERIC(10, 2) NOT NULL,
    fechapago TIMESTAMP NOT NULL,
    metodo_pago TEXT NOT NULL,
    reservaid_reservas INTEGER
);

\COPY

ALTER TABLE vehiculos
ADD FOREIGN KEY (clienteid_clientes) REFERENCES clientes(clienteid) ON DELETE RESTRICT;

ALTER TABLE reservas
ADD FOREIGN KEY (vehiculoid_vehiculos) REFERENCES vehiculos(vehiculoid) ON DELETE RESTRICT;
ALTER TABLE reservas
ADD FOREIGN KEY (plazaid_plazas) REFERENCES plazas(plazaid) ON DELETE RESTRICT;
ALTER TABLE reservas
ADD FOREIGN KEY (clienteid_clientes) REFERENCES clientes(clienteid) ON DELETE RESTRICT;

ALTER TABLE incidencias
ADD FOREIGN KEY (reservaid_reservas) REFERENCES reservas(reservaid) ON DELETE RESTRICT;

ALTER TABLE pagos
ADD FOREIGN KEY (reservaid_reservas) REFERENCES reservas(reservaid) ON DELETE RESTRICT;