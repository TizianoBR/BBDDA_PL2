\c telpark

SET log_statement = 'all';
\o PL2_c9_salida.txt
EXPLAIN SELECT
    COUNT(DISTINCT c.clienteid) * 100.0 / (SELECT COUNT(*) FROM clientes)
    AS resultado
    FROM
    clientes c
    JOIN reservas r ON c.clienteid = r.clienteid_clientes
    JOIN pagos p ON r.reservaid = p.reservaid_reservas
    JOIN vehiculos v ON v.vehiculoid = r.vehiculoid_vehiculos
    JOIN plazas pl ON pl.plazaid = r.plazaid_plazas
    LEFT JOIN incidencias i ON i.reservaid_reservas = r.reservaid
    
    WHERE
    c.provincia IN ('Huelva', 'Cadiz', 'Sevilla', 'Malaga', 'Granada', 'Almeria', 'Jaen', 'Cordoba') 
    AND (EXTRACT(MONTH FROM r.fechainicio) BETWEEN 6 AND 8 OR EXTRACT(MONTH FROM r.fechafin) BETWEEN 6 AND 8) 
    AND p.cantidad > 150 
    AND (i IS NULL OR i.estado != 'Cerrada' OR v.color != 'Negro') 
    AND pl.nivel < -4;
SELECT
    COUNT(DISTINCT c.clienteid) * 100.0 / (SELECT COUNT(*) FROM clientes)
    AS resultado
    FROM
    clientes c
    JOIN reservas r ON c.clienteid = r.clienteid_clientes
    JOIN pagos p ON r.reservaid = p.reservaid_reservas
    JOIN vehiculos v ON v.vehiculoid = r.vehiculoid_vehiculos
    JOIN plazas pl ON pl.plazaid = r.plazaid_plazas
    LEFT JOIN incidencias i ON i.reservaid_reservas = r.reservaid
    
    WHERE
    c.provincia IN ('Huelva', 'Cadiz', 'Sevilla', 'Malaga', 'Granada', 'Almeria', 'Jaen', 'Cordoba') 
    AND (EXTRACT(MONTH FROM r.fechainicio) BETWEEN 6 AND 8 OR EXTRACT(MONTH FROM r.fechafin) BETWEEN 6 AND 8) 
    AND p.cantidad > 150 
    AND (i IS NULL OR i.estado != 'Cerrada' OR v.color != 'Negro') 
    AND pl.nivel < -4;



-- \o PL2_c9_salida_debug.txt

-- SELECT c.clienteid, c.provincia, r.fechainicio, r.fechafin, p.cantidad, pl.nivel, i.estado, v.color FROM
--     clientes c
--     LEFT JOIN reservas r ON c.clienteid = r.clienteid_clientes
--     JOIN pagos p ON r.reservaid = p.reservaid_reservas
--     JOIN vehiculos v ON v.vehiculoid = r.vehiculoid_vehiculos
--     JOIN plazas pl ON pl.plazaid = r.plazaid_plazas
--     LEFT JOIN incidencias i ON i.reservaid_reservas = r.reservaid

-- WHERE 
--     (c.provincia = 'Huelva' OR c.provincia = 'Cadiz' OR c.provincia = 'Sevilla' OR c.provincia = 'Malaga' OR c.provincia = 'Granada' OR c.provincia = 'Almeria' OR c.provincia = 'Jaen' OR c.provincia = 'Cordoba') AND (EXTRACT(MONTH FROM r.fechainicio) BETWEEN 6 AND 8 OR EXTRACT(MONTH FROM r.fechafin) BETWEEN 6 AND 8) AND p.cantidad > 150 AND (i IS NULL OR i.estado != 'Cerrada' OR v.color != 'Negro') AND pl.nivel < -4

-- ORDER BY c.clienteid;

SET log_statement = 'mod';