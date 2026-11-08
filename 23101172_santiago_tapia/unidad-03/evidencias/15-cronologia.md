# Evidencia 15 — Reconstrucción de la cronología y respuestas a Dirección

- **Estudiante:** Santiago Jassiel Tapia Valdez
- **Laboratorio / Actividad:** LAB-01 Bitácoras y auditoría del dato en PostgreSQL — Actividad 17
- **Fuente:** `bitacora-lab01.log` (exportado el 08-11-2026)

---

## 1. Tabla cronológica de eventos (línea de tiempo)

| # | Fecha y hora (UTC) | Usuario | Cliente / IP | Tipo de evento | Qué ocurrió | ¿Exitoso? | Fuente (línea del log) |
|---|---|---|---|---|---|---|---|
| 1 | 01:52:28 | `admin` | `[local]` | Configuración | Se recarga la configuración: `log_connections = on`, `log_statement = 'ddl'` | Sí | Líneas 21–24 |
| 2 | 02:20:04 | `app_ventas` | `172.18.0.3` | Acceso (error) | Fallo de autenticación (contraseña incorrecta) | No | Línea 706 |
| 3 | 02:20:52 | `so` | `172.18.0.3` | Acceso (error) | Fallo de autenticación (el rol no existe) | No | Línea 728 |
| 4 | 02:48:11 | `admin` | `172.18.0.3` | Privilegio / Estructura | `REVOKE`, `GRANT` y `ALTER TABLE clientes ADD COLUMN segmento` | Sí | Línea 954 (aprox.) |
| 5 | 02:48:36 | `admin` | `172.18.0.3` | Seguridad | Creación de `rol_temporal` con contraseña (queda `<REDACTED>`) y `DROP ROLE` | Sí | Línea 958 |
| 6 | 03:01:18 | `admin` | `[local]` | Configuración | El servidor recarga y cambia `log_statement` a `'mod'` | Sí | Línea 964 |
| 7 | 03:01:36 | `app_ventas` | `172.18.0.3` | Datos | `UPDATE` al teléfono del cliente 3 y lectura del mismo | Sí | Línea 965 |
| 8 | 03:08:54 | `soporte_ana` | `172.18.0.3` | Error (permisos) | Intento de `DELETE` en la tabla `clientes` (denegado) | No | Línea 1120 |
| 9 | 03:10:36 | `soporte_ana` | `172.18.0.3` | Error (permisos) | Intento de `DROP ROLE soporte_ana` (denegado) | No | Línea 1121 |
| 10 | 04:13:52 | `admin` | `172.18.0.3` | Estructura | Creación del esquema `auditoria` y de la tabla `cambios_clientes` | Sí | Línea 1290 |
| 11 | 04:16:00 | `admin` | `172.18.0.3` | Estructura | Creación de la función de auditoría y del `TRIGGER` | Sí | Línea 1300 |
| 12 | 04:23:59 | `app_ventas` | `172.18.0.3` | Datos (auditado) | `UPDATE` del RFC a `GAMA780912ZZZ` | Sí | Línea 1420 |
| 13 | 04:24:16 | `app_ventas` | `172.18.0.3` | Error (permisos) | Intento de leer `auditoria.cambios_clientes` (denegado) | No | Línea 1421 |
| 14 | 04:29:12 | `admin` | `172.18.0.3` | Datos | `UPDATE` del RFC a `GAMA780912XYZ` (restauración manual) | Sí | Línea 1500 |
| 15 | 05:04:24 | `admin` | `172.18.0.3` | Datos | `INSERT` y `DELETE` del cliente "Pedro Ruiz" | Sí | Línea 1650 |
| 16 | 05:19:06 | `app_ventas` | `172.18.0.3` | Error / Manipulación | Intenta borrar la auditoría y desactivar el trigger (ambos denegados) | No | Línea 1780 |
| 17 | 05:19:42 | `admin` | `172.18.0.3` | Manipulación | Desactiva el trigger, cambia el RFC a `GAMA780912GHI` y reactiva el trigger | Sí | Línea 1785 |
| 18 | 05:30:57 | `admin` | `172.18.0.3` | Datos | `UPDATE` masivo: `SET segmento = 'regular'` | Sí | Línea 1950 |

---

## 2. Respuestas a las preguntas de Dirección

### 1. ¿Quién cambió el RFC la primera vez (Actividad 3)? ¿Y en las Actividades 7, 12 y 14?

- **Actividad 3 (primer cambio):** **No hay evidencia.** En ese momento el servidor tenía la configuración por defecto (sin bitácora). Ocurrió "en el vacío".
- **Actividad 7:** No hubo cambio de RFC en esta actividad; se cambió el teléfono (realizado por `app_ventas`).
- **Actividad 12:** El usuario `app_ventas`, desde la IP `172.18.0.3`, usando pgAdmin 4. El cambio fue auditado correctamente en la tabla de auditoría.
- **Actividad 14:** El usuario `admin`, desde la IP `172.18.0.3`. Se sabe porque la bitácora registra la desactivación del trigger, el `UPDATE` a `GHI` y la reactivación del trigger. La tabla de auditoría no lo vio, pero la bitácora del servidor sí.

### 2. ¿Quién cambió el teléfono?

El usuario `app_ventas`, el día 2026-11-08 a las 03:01:36 UTC, desde la IP `172.18.0.3` (aplicación pgAdmin 4).

### 3. ¿Hubo intentos de acceso fallidos? ¿De qué usuarios y desde dónde?

Sí, hubo dos intentos fallidos (líneas 706 y 728 del log). Ambos provinieron de la IP interna de Docker (`172.18.0.3`):

- El usuario `app_ventas` (contraseña incorrecta).
- El usuario `so` (el rol no existe en la base de datos).

### 4. ¿Qué valor tenía el RFC antes de cada cambio?

- **Cambio de la Actividad 3:** **No hay evidencia.** No se registró nada.
- **Cambio de la Actividad 12 (a `ZZZ`):** el valor anterior era `GAMA780912XYZ`. Se demuestra consultando `auditoria.cambios_clientes`, donde el trigger guardó el JSON antes y después.
- **Cambio de la Actividad 14 (a `GHI`):** **No hay evidencia directa** en la tabla de auditoría, porque el administrador desactivó el trigger. La línea 1785 del log demuestra la sentencia `UPDATE clientes SET rfc = 'GAMA780912GHI'`, pero al no haber trigger activo no se guardó el valor que tenía antes de esa sentencia.

### 5. ¿Desde qué aplicación o equipo?

- Las conexiones de `app_ventas` y `soporte_ana` provienen de la IP `172.18.0.3` (red interna de Docker) y usaron la aplicación pgAdmin 4.
- La conexión del administrador (`admin`) se hizo desde la misma IP (`172.18.0.3`) usando pgAdmin 4, y también se registraron conexiones locales (`[local]`) por `psql` y el chequeo de salud `pg_isready`.
