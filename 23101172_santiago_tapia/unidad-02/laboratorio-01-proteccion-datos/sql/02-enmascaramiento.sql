-- Actividad 2: Enmascaramiento (masking)

-- 8.1 Creación del rol
CREATE ROLE soporte_santiago NOLOGIN;

-- 8.2 Creación de la vista de acceso restringido
CREATE VIEW v_clientes_soporte AS
SELECT
    id,
    nombre,

    CONCAT(
        LEFT(correo, 2),
        '*****',
        SUBSTRING(correo FROM POSITION('@' IN correo))
    ) AS correo,

    CONCAT(
        '******',
        RIGHT(telefono, 4)
    ) AS telefono,

    CONCAT(
        '*********',
        RIGHT(rfc, 4)
    ) AS rfc

FROM clientes;

-- Consultar la vista
SELECT *
FROM v_clientes_soporte;

-- 8.3 Conceder acceso a la vista
GRANT USAGE
ON SCHEMA public
TO soporte_santiago;

GRANT SELECT
ON v_clientes_soporte
TO soporte_santiago;

-- Revocar el acceso directo a la tabla
REVOKE ALL
ON clientes
FROM soporte_santiago;

-- Permitir que mi usuario pueda probar el rol con SET ROLE
GRANT soporte_santiago TO u_23101172_santiago_tapia;

-- ==== VERIFICACIÓN (8.4) ====
-- Ejecutar cada consulta por separado: la segunda debe fallar.
SET ROLE soporte_santiago;

-- Permitido: muestra los datos enmascarados
SELECT *
FROM v_clientes_soporte;

-- Rechazado: permission denied for table clientes
SELECT *
FROM clientes;

RESET ROLE;
