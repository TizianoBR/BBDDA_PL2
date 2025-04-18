\c telpark

SET log_statement = 'all';
ANALYZE;
\o PL2_c12_salida.txt
EXPLAIN SELECT COUNT(DISTINCT c.clienteid)  * 100.0 / (SELECT COUNT(*) FROM clientes) AS resultado
    FROM
    clientes c
        JOIN reservas r ON c.clienteid = r.clienteid_clientes
        JOIN pagos p ON r.reservaid = p.reservaid_reservas
        JOIN plazas pl ON pl.plazaid = r.plazaid_plazas
    WHERE
    c.provincia IN ('Huelva', 'Cadiz', 'Sevilla', 'Malaga', 'Granada', 'Almeria', 'Jaen', 'Cordoba') 
        AND (EXTRACT(MONTH FROM r.fechainicio) BETWEEN 6 AND 8 OR EXTRACT(MONTH FROM r.fechafin) BETWEEN 6 AND 8) 
        AND p.cantidad > 150 
        AND pl.nivel < -4
    AND NOT EXISTS(
        SELECT 1
        FROM incidencias i
            JOIN reservas r2 ON i.reservaid_reservas = r2.reservaid
            JOIN vehiculos v ON r2.vehiculoid_vehiculos = v.vehiculoid
        WHERE i.estado = 'Cerrada' AND v.color = 'Negro'
            AND r2.clienteid_clientes = c.clienteid
    );
SELECT COUNT(DISTINCT c.clienteid)  * 100.0 / (SELECT COUNT(*) FROM clientes) AS resultado
    FROM
    clientes c
        JOIN reservas r ON c.clienteid = r.clienteid_clientes
        JOIN pagos p ON r.reservaid = p.reservaid_reservas
        JOIN plazas pl ON pl.plazaid = r.plazaid_plazas
    WHERE
    c.provincia IN ('Huelva', 'Cadiz', 'Sevilla', 'Malaga', 'Granada', 'Almeria', 'Jaen', 'Cordoba') 
        AND (EXTRACT(MONTH FROM r.fechainicio) BETWEEN 6 AND 8 OR EXTRACT(MONTH FROM r.fechafin) BETWEEN 6 AND 8) 
        AND p.cantidad > 150 
        AND pl.nivel < -4
    AND NOT EXISTS(
        SELECT 1
        FROM incidencias i
            JOIN reservas r2 ON i.reservaid_reservas = r2.reservaid
            JOIN vehiculos v ON r2.vehiculoid_vehiculos = v.vehiculoid
        WHERE i.estado = 'Cerrada' AND v.color = 'Negro'
            AND r2.clienteid_clientes = c.clienteid
    );



-- \o PL2_c9_salida_debug.txt

-- SELECT c.clienteid, c.provincia, r.fechainicio, r.fechafin, p.cantidad, pl.nivel, i.estado, v.color
--     FROM
--     clientes c
--         JOIN reservas r ON c.clienteid = r.clienteid_clientes
--         JOIN pagos p ON r.reservaid = p.reservaid_reservas
--         JOIN plazas pl ON pl.plazaid = r.plazaid_plazas
--         JOIN vehiculos v ON v.vehiculoid = r.vehiculoid_vehiculos
--         LEFT JOIN incidencias i ON i.reservaid_reservas = r.reservaid
--     WHERE
--     c.provincia IN ('Huelva', 'Cadiz', 'Sevilla', 'Malaga', 'Granada', 'Almeria', 'Jaen', 'Cordoba') 
--         AND (EXTRACT(MONTH FROM r.fechainicio) BETWEEN 6 AND 8 OR EXTRACT(MONTH FROM r.fechafin) BETWEEN 6 AND 8) 
--         AND p.cantidad > 150 
--         AND pl.nivel < -4
--     AND NOT EXISTS(
--         SELECT 1
--         FROM incidencias i
--             JOIN reservas r2 ON i.reservaid_reservas = r2.reservaid
--             JOIN vehiculos v ON r2.vehiculoid_vehiculos = v.vehiculoid
--         WHERE i.estado = 'Cerrada' AND v.color = 'Negro'
--             AND r2.clienteid_clientes = c.clienteid
--     )
--     ORDER BY c.clienteid;
\o
SET log_statement = 'mod';