-- Registros que superan el periodo de conservación hipotético de 5 años
SELECT *
FROM clientes
WHERE fecha_alta <
      CURRENT_DATE - INTERVAL '5 years';

-- Contexto para interpretar el resultado: rango de fechas de alta existentes
SELECT
    MIN(fecha_alta) AS alta_mas_antigua,
    MAX(fecha_alta) AS alta_mas_reciente,
    COUNT(*)        AS total_clientes
FROM clientes;
