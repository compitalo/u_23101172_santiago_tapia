# Informe — LAB-01 Bitácoras y auditoría del dato en PostgreSQL

- **Estudiante:** Santiago Jassiel Tapia Valdez
- **Materia:** Gestión de Seguridad y Desempeño de Bases de Datos — Unidad III

---

## 1. Despliegue y situación inicial

El servidor se desplegó con Docker, usando la imagen oficial de PostgreSQL 16. Al revisar la configuración inicial (Actividad 1) se observó que el motor tenía los valores por defecto para el registro de eventos: `logging_collector = off`, `log_connections = off`, `log_statement = none` y un `log_line_prefix` que solo incluía la fecha y el PID (`%m [%p]`).

**¿Por qué no permitía responder a Dirección?**

Con `logging_collector = off`, PostgreSQL no escribía su bitácora en un archivo propio: enviaba todo a `stderr`, y es el mecanismo de despliegue (Docker) quien decide qué hacer con esa salida y cuánto tiempo conservarla. Además, al no registrar conexiones ni sentencias, era imposible saber quién modificó el RFC de María García, cuándo lo hizo, desde qué IP o qué valor tenía el dato antes del cambio. El control de acceso de la Unidad II permitió el cambio (`app_ventas` tenía `UPDATE`), pero no dejó rastro que sirviera como evidencia.

## 2. Configuración aplicada

Los cambios se aplicaron con `ALTER SYSTEM`:

| Parámetro | Valor aplicado | Tipo de aplicación | Justificación |
|---|---|---|---|
| `logging_collector` | `on` | Reinicio | Hace que el propio motor capture `stderr` y escriba archivos `.log`, independientemente de cómo se desplegó el servidor. |
| `log_connections` / `log_disconnections` | `on` | Recarga | Registra quién entra y sale del sistema, y la duración de cada sesión. |
| `log_line_prefix` | `%m [%p] user=%u db=%d app=%a client=%h ` | Recarga | Añade el contexto necesario para saber quién, en qué base, con qué aplicación y desde dónde. |
| `log_statement` | `ddl` y después `'mod'` | Recarga | Primero se registró la definición de datos (CREATE, ALTER, DROP, GRANT, REVOKE); después se subió a `mod` para registrar también `INSERT`, `UPDATE`, `DELETE` y `TRUNCATE`. No se usó `all` para evitar el volumen y el riesgo de registrar datos sensibles. |

**Nota:** el colector requirió reiniciar el contenedor para arrancar el proceso (`pending_restart`). Los demás parámetros se aplicaron con `pg_reload_conf()`.

## 3. Eventos observados (interpretación)

Basado en la bitácora exportada (`bitacora-lab01.log`), un ejemplo interpretado de cada tipo de evento:

- **Acceso:** el usuario `app_ventas` intentó conectarse desde la IP `172.18.0.3` y falló (`FATAL: password authentication failed`). La bitácora prueba que alguien presentó ese nombre de usuario desde esa IP con una contraseña incorrecta; **no prueba** que haya sido la aplicación de ventas. Puede ser un error de configuración de la aplicación o un intento de acceso no autorizado.
- **Privilegio:** se registró `REVOKE UPDATE ON clientes FROM soporte_ana` y `GRANT UPDATE ON clientes TO app_ventas`, lo que evidencia un cambio en la matriz de permisos.
- **Estructura:** se registró `ALTER TABLE clientes ADD COLUMN segmento VARCHAR(20)`, lo que demuestra un cambio en el esquema de la tabla.
- **Datos:** se registró `UPDATE clientes SET telefono = '6679990000' WHERE id = 3`, ejecutado por `app_ventas`. La bitácora dice **qué** se hizo, **quién**, **cuándo** y **desde dónde**, pero no el valor anterior del teléfono.
- **Error:** `soporte_ana` intentó `DELETE FROM clientes WHERE id = 5` y recibió `ERROR: permission denied for table clientes`. Aunque no causó daño, el intento quedó registrado junto con su sentencia.
- **Configuración:** el proceso principal del servidor (PID 1) registró `parameter "log_statement" changed to "mod"`, evidenciando la recarga de configuración.

## 4. Auditoría del dato

Para resolver la falta de valores anteriores se creó el esquema `auditoria` (sin acceso para `PUBLIC`) y la tabla `auditoria.cambios_clientes`. Se usó `JSONB` para guardar el registro completo antes y después del cambio (así la auditoría sigue funcionando aunque `clientes` cambie de estructura) y `TIMESTAMPTZ` para evitar ambigüedades horarias al cruzar la tabla con la bitácora.

**Papel de `SECURITY DEFINER` y `session_user`:**

- La función de auditoría se creó con `SECURITY DEFINER` para que `app_ventas` pueda provocar un registro en una tabla donde no tiene permisos directos, y con `search_path` fijo para que nadie pueda hacer que la función use objetos falsos con los privilegios de su propietario.
- Dentro de una función `SECURITY DEFINER`, `current_user` devuelve el propietario de la función. Por eso se registró `session_user`, el rol con el que se autenticó la sesión (`app_ventas`). Con `current_user`, todos los cambios parecerían hechos por el propietario (`admin`) y la auditoría ocultaría quién los provocó.
- `session_user` identifica un **rol**, no una persona: si varias personas comparten `app_ventas`, no se pueden distinguir.

**Resultado del incidente auditado:** cuando `app_ventas` cambió el RFC a `GAMA780912ZZZ`, la tabla de auditoría capturó el evento (usuario, aplicación, IP y hora) y, al comparar los JSON, se demostró que el valor anterior era `GAMA780912XYZ`.

## 5. Limitaciones identificadas

- **Lecturas (`SELECT`):** el nivel `mod` no registra lecturas, y no existe un disparador para `SELECT`. La consulta que hizo `soporte_ana` a datos sensibles no dejó rastro. Las alternativas son `log_statement = 'all'` (registra todo y puede convertir la bitácora en un depósito de datos sensibles), entregar el dato solo mediante una función que registre su uso, o `pgaudit` con auditoría de objeto.
- **Volumen:** un `UPDATE` masivo (`UPDATE clientes SET segmento = 'regular'`) generó **una** línea en la bitácora y **una fila por registro afectado** en la tabla de auditoría. En una tabla grande, un `UPDATE` sin `WHERE` puede llenar el almacenamiento rápidamente.
- **Administrador con control total:** si el administrador desactiva el disparador (`ALTER TABLE ... DISABLE TRIGGER`), la tabla de auditoría no registra los cambios hechos mientras tanto. La bitácora del servidor sí registró el `ALTER TABLE` y el `UPDATE`, lo que permite detectar la manipulación, pero **no** recupera el valor anterior. Ningún mecanismo dentro del propio servidor protege contra un administrador con control total.

## 6. Riesgos de la bitácora

- **Secretos expuestos:** al ejecutar `CREATE ROLE ... PASSWORD '...'`, la contraseña quedó en texto claro en la bitácora y eliminar el rol no la borra. Se mitigó exportando la bitácora con `replace(...)`, sustituyéndola por `<REDACTED>`. Además, la bitácora puede contener datos personales dentro de las sentencias y direcciones internas.
- **Pérdida:** la bitácora vive en el servidor. Si el contenedor se elimina junto con su almacenamiento, si el servidor se recrea o si el archivo rota sin que nadie lo conserve, la evidencia desaparece. Por eso se exportó el archivo vigente y se calculó su hash SHA-256. El hash no impide que alguien modifique el archivo, pero permite demostrar que no cambió desde que se calculó, siempre que se guarde en un lugar distinto al del archivo.
- **Acceso de terceros:** quien pueda leer la bitácora puede ver contraseñas, datos y direcciones. La función `pg_read_file` permite leer cualquier archivo que el proceso del servidor pueda leer, por eso está restringida a superusuarios; la vista `dba.bitacora` debe seguir el mismo criterio (solo el administrador).

## 7. Cronología y conclusión

La reconstrucción cronológica (evidencia 15) muestra que el primer cambio de RFC (Actividad 3) no tiene evidencia: es un hueco, porque la bitácora y la auditoría no existían todavía. Tras la configuración, la evidencia permite demostrar:

- **Quién cambió el teléfono:** `app_ventas`, desde `172.18.0.3`, aunque no hay evidencia del valor que tenía antes (el disparador aún no existía).
- **Los intentos de acceso fallidos:** de `app_ventas` y de `so`, ambos desde `172.18.0.3`.
- **El intento de `soporte_ana` de borrar datos**, denegado por falta de permisos.
- **El valor anterior del RFC en los cambios realizados con el disparador activo** (por ejemplo, `XYZ` antes de `ZZZ`).
- **El cambio hecho por el administrador con el disparador desactivado** (`GHI`): la bitácora demuestra quién lo hizo y cuándo, pero no el valor anterior.

**Conclusión:** con esta configuración sí puede demostrarse quién cambió un dato sensible y qué valor tenía antes, pero solo para cambios hechos mediante sesiones de usuarios o aplicaciones con el disparador activo. No cubre las lecturas, no distingue personas que comparten un rol, `application_name` lo declara el propio cliente, y un administrador con control total puede desactivar el mecanismo. Para reducir ese riesgo se requiere separación de funciones (quien opera la base no custodia la evidencia) y enviar la bitácora en tiempo real a un sistema externo administrado por otra área, por ejemplo un SIEM.
