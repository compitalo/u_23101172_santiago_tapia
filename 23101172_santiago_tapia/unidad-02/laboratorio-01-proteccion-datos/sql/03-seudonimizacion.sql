-- Actividad 3: Seudonimización  |  Actividad 4: Separación de funciones

-- 9.1 Crear los esquemas
CREATE SCHEMA pii;

CREATE SCHEMA analitica;

-- 9.2 Crear la tabla de correspondencia
CREATE TABLE pii.mapa_cliente (
    token UUID PRIMARY KEY,
    cliente_id BIGINT UNIQUE
        REFERENCES public.clientes(id)
);

-- 9.3 Generar los tokens
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Generar un token para cada cliente
INSERT INTO pii.mapa_cliente
(token, cliente_id)
SELECT
    gen_random_uuid(),
    id
FROM clientes;

-- Verificación
SELECT *
FROM pii.mapa_cliente;

-- 10. Crear el conjunto de datos para analítica (sin nombre, correo, teléfono ni RFC)
CREATE TABLE analitica.clientes AS
SELECT
    m.token AS cliente_token,
    c.edad,
    c.ciudad,
    c.codigo_postal,
    c.fecha_alta
FROM pii.mapa_cliente m
JOIN clientes c
    ON c.id = m.cliente_id;

-- Verificación
SELECT *
FROM analitica.clientes;

-- ============================================================
-- Actividad 4: Separación de funciones
-- ============================================================

-- Crear el rol
CREATE ROLE analista_santiago_tapia NOLOGIN;

-- Conceder acceso al conjunto de datos analítico
GRANT USAGE ON SCHEMA analitica
TO analista_santiago_tapia;

GRANT SELECT ON analitica.clientes
TO analista_santiago_tapia;

-- Restringir el acceso al mapa y a los datos originales
REVOKE ALL ON SCHEMA pii
FROM analista_santiago_tapia;

REVOKE ALL ON ALL TABLES IN SCHEMA pii
FROM analista_santiago_tapia;

REVOKE ALL ON ALL TABLES IN SCHEMA public
FROM analista_santiago_tapia;

-- Permitir que mi usuario pueda probar el rol con SET ROLE
GRANT analista_santiago_tapia TO u_23101172_santiago_tapia;

-- ==== VERIFICACIÓN (11.1) ====
-- Ejecutar cada consulta por separado: la primera funciona, las otras dos deben fallar.
SET ROLE analista_santiago_tapia;

-- Permitido
SELECT *
FROM analitica.clientes;

-- Rechazado: permission denied for schema pii
SELECT *
FROM pii.mapa_cliente;

-- Rechazado: permission denied for table clientes
SELECT *
FROM public.clientes;

RESET ROLE;
