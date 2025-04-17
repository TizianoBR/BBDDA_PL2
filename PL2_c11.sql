\c telpark

BEGIN;

SET work_mem = '512MB';
SET effective_cache_size = '16GB';
SET temp_buffers = '256MB';

CREATE INDEX IF NOT EXISTS idx_vehiculos_cleinteid_clientes ON vehiculos(clienteid_clientes);  
CREATE INDEX IF NOT EXISTS idx_reservas_vehiculoid_vehiculos ON reservas(vehiculoid_vehiculos); 
CREATE INDEX IF NOT EXISTS idx_reservas_plazaid_plazas ON reservas(plazaid_plazas); 
CREATE INDEX IF NOT EXISTS idx_reservas_clienteid_clientes ON reservas(clienteid_clientes); 
CREATE INDEX IF NOT EXISTS idx_incidencias_reservaid_reservas ON incidencias(reservaid_reservas);   
CREATE INDEX IF NOT EXISTS idx_pagos_reservaid_reservas ON pagos(reservaid_reservas);   


CREATE TEMP TABLE IF NOT EXISTS temp_clientes_a_borrar AS
    SELECT clienteid
    FROM clientes c 
    ORDER BY random()
    LIMIT (SELECT ceil(COUNT(*) * 0.3) FROM clientes);

CREATE TEMP TABLE IF NOT EXISTS temp_reservas_a_borrar AS   
    SELECT r.reservaid
    FROM reservas r 
    JOIN temp_clientes_a_borrar tcb ON r.clienteid_clientes = tcb.clienteid;

CREATE INDEX IF NOT EXISTS idx_temp_clientes_a_borrar ON temp_clientes_a_borrar(clienteid); 
CREATE INDEX IF NOT EXISTS idx_temp_reservas_a_borrar ON temp_reservas_a_borrar(reservaid); 
\o PL2_c11_salida.txt

EXPLAIN DELETE FROM pagos p
USING temp_reservas_a_borrar trb
WHERE p.reservaid_reservas = trb.reservaid;

EXPLAIN DELETE FROM incidencias i
USING temp_reservas_a_borrar trb
WHERE i.reservaid_reservas = trb.reservaid;

EXPLAIN DELETE FROM reservas r
USING temp_reservas_a_borrar trb
WHERE r.reservaid = trb.reservaid;

EXPLAIN DELETE FROM vehiculos v
USING temp_clientes_a_borrar tcb
WHERE v.clienteid_clientes = tcb.clienteid;

EXPLAIN DELETE FROM clientes c
USING temp_clientes_a_borrar tcb
WHERE c.clienteid = tcb.clienteid;

\o

DELETE FROM pagos p
USING temp_reservas_a_borrar trb
WHERE p.reservaid_reservas = trb.reservaid;

DELETE FROM incidencias i
USING temp_reservas_a_borrar trb
WHERE i.reservaid_reservas = trb.reservaid;

DELETE FROM reservas r
USING temp_reservas_a_borrar trb
WHERE r.reservaid = trb.reservaid;

DELETE FROM vehiculos v
USING temp_clientes_a_borrar tcb
WHERE v.clienteid_clientes = tcb.clienteid;

DELETE FROM clientes c
USING temp_clientes_a_borrar tcb
WHERE c.clienteid = tcb.clienteid;

COMMIT;


VACUUM FULL ANALYZE;