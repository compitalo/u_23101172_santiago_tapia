-- Actividad 5: Anonimización  |  Actividad 6: Análisis de reidentificación

-- 12.1 Generalizar la edad
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,
    COUNT(*) AS total
FROM clientes
GROUP BY 1;

-- 12.2 Generalizar la región
SELECT
    LEFT(codigo_postal, 2) AS region,
    COUNT(*) AS total
FROM clientes
GROUP BY 1;

-- 12.3 Combinar atributos
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,

    LEFT(codigo_postal, 2) AS region,

    COUNT(*) AS total

FROM clientes

GROUP BY 1, 2;

-- 12.4 Suprimir grupos pequeños (umbral didáctico k = 5)
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,

    LEFT(codigo_postal, 2) AS region,

    COUNT(*) AS total

FROM clientes

GROUP BY 1, 2

HAVING COUNT(*) >= 5;

-- ============================================================
-- Actividad 6 · RETO: reducir aún más el riesgo de reidentificación
-- ============================================================
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 39 THEN '18-39'
        ELSE '40+'
    END AS rango_edad,

    LEFT(codigo_postal, 1) AS region,

    COUNT(*) AS total

FROM clientes

GROUP BY 1, 2

HAVING COUNT(*) >= 5;

-- Comparación (sin umbral) para documentar el tamaño real de los grupos del reto
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 39 THEN '18-39'
        ELSE '40+'
    END AS rango_edad,

    LEFT(codigo_postal, 1) AS region,

    COUNT(*) AS total

FROM clientes

GROUP BY 1, 2

ORDER BY 1, 2;
