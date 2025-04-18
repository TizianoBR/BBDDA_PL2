\c telpark

-- SHOW work_mem;
-- SHOW effective_cache_size;
-- SHOW shared_buffers;
-- SHOW temp_buffers;

-- SET work_mem = '512MB';
-- SET effective_cache_size = '16GB';
-- SET temp_buffers = '256MB';

-- CREATE INDEX IF NOT EXISTS idx_clientes_provincia ON clientes(provincia);
-- CREATE INDEX IF NOT EXISTS idx_reserva_reservaid ON reservas(reservaid);
-- CREATE INDEX IF NOT EXISTS idx_reservas_fechainicio ON reservas(EXTRACT(MONTH FROM fechainicio));
-- CREATE INDEX IF NOT EXISTS idx_reservas_fechafin ON reservas(EXTRACT(MONTH FROM fechafin));
-- CREATE INDEX IF NOT EXISTS idx_pagos_cantidad ON pagos(cantidad);
-- CREATE INDEX IF NOT EXISTS idx_plazas_nivel ON plazas(nivel);
-- CREATE INDEX IF NOT EXISTS idx_incidencias_reservaid ON incidencias(reservaid_reservas);



-- CLUSTER clientes USING idx_clientes_provincia;
-- CLUSTER reservas USING idx_reservas_fechainicio;
-- CLUSTER pagos USING idx_pagos_cantidad;
-- CLUSTER plazas USING idx_plazas_nivel;
-- CLUSTER incidencias USING idx_incidencias_reservaid;
-- \q

SET work_mem = '4MB';
SET effective_cache_size = '4GB';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
SET temp_buffers = '8MB';
DROP INDEX IF EXISTS idx_clientes_provincia;
DROP INDEX IF EXISTS idx_reserva_reservaid;
DROP INDEX IF EXISTS idx_reservas_fechainicio;
DROP INDEX IF EXISTS idx_reservas_fechafin;
DROP INDEX IF EXISTS idx_pagos_cantidad;
DROP INDEX IF EXISTS idx_plazas_nivel;
DROP INDEX IF EXISTS idx_incidencias_reservaid;
ALTER TABLE clientes SET WITHOUT CLUSTER;
ALTER TABLE reservas SET WITHOUT CLUSTER;
ALTER TABLE pagos SET WITHOUT CLUSTER;
ALTER TABLE plazas SET WITHOUT CLUSTER;
ALTER TABLE vehiculos SET WITHOUT CLUSTER;
ALTER TABLE incidencias SET WITHOUT CLUSTER;
