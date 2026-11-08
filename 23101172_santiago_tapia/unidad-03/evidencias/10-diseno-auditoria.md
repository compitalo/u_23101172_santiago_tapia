# Evidencia 10 — Diseño de la auditoría del dato

## Justificación de los campos de `auditoria.cambios_clientes`

| Campo propuesto | Tipo | ¿Qué pregunta responde? | ¿Puede ser nulo? ¿Por qué? |
| :--- | :--- | :--- | :--- |
| `id_evento` | `BIGSERIAL` | ¿Cómo identificamos de forma única este evento en la investigación? | **No.** Es la Llave Primaria (PRIMARY KEY) y se genera automáticamente. |
| `momento` | `TIMESTAMPTZ` | ¿Cuándo ocurrió el cambio exactamente? | **No.** Es vital para la cronología. Tiene un `DEFAULT now()` para no depender de que el usuario lo envíe. |
| `usuario_sesion` | `TEXT` | ¿Quién provocó el cambio? | **No.** Es el dato más importante para la rendición de cuentas. Usa `session_user`. |
| `usuario_efectivo` | `TEXT` | ¿Qué privilegios estaban activos en ese momento? | **No.** Ayuda a los auditores a entender si el cambio se hizo mediante una función con privilegios elevados (`SECURITY DEFINER`). Usa `current_user`. |
| `aplicacion` | `TEXT` | ¿Desde qué aplicación o software se hizo el cambio? | **Sí.** Un usuario podría conectarse sin especificar el `application_name`. En ese caso, será nulo o mostrará `[unknown]`. |
| `ip_cliente` | `INET` | ¿Desde qué equipo o dirección IP se originó la conexión? | **Sí.** Si la conexión se hace por el socket local (como cuando entras por pgAdmin localmente o scripts internos del servidor), no hay una IP de red asignada. |
| `operacion` | `TEXT` | ¿Qué acción se realizó? (INSERT, UPDATE o DELETE). | **No.** Es fundamental para saber si el dato se creó, se modificó o se destruyó. |
| `id_cliente` | `BIGINT` | ¿A qué registro de la tabla `clientes` afectó el cambio? | **No.** Permite hacer un `JOIN` o buscar todos los eventos de un cliente específico (ej. el cliente 3). |
| `valores_antes` | `JSONB` | ¿Qué valor tenía el dato antes del cambio? | **Sí.** En un `INSERT` no hay valor anterior, por lo que este campo quedará nulo. |
| `valores_despues` | `JSONB` | ¿Qué valor tiene el dato después del cambio? | **Sí.** En un `DELETE` no hay valor nuevo, por lo que este campo quedará nulo. |

---

## Respuestas a las preguntas de la actividad

**1. ¿Por qué `momento` usa `TIMESTAMPTZ` y no `TIMESTAMP`?**
Para evitar ambigüedades. `TIMESTAMP` guarda la hora "a ciegas". Si el servidor está en una zona horaria (ej. UTC) y luego se migra o se consulta desde otra (ej. America/Denver), la hora no cambia y confunde. `TIMESTAMPTZ` registra el instante exacto y absoluto, y PostgreSQL se encarga de mostrar la hora correcta dependiendo de la zona horaria de quien consulta.

**2. ¿Por qué se guarda el registro completo en JSONB y no solo la columna que cambió?**
Porque el esquema de la tabla `clientes` puede evolucionar (como de hecho hicimos agregando la columna `segmento`). Si guardáramos solo la columna `rfc`, una futura modificación a la estructura de la tabla rompería la auditoría. Al usar `to_jsonb(OLD)` y `to_jsonb(NEW)`, conservamos una "fotografía" exacta de toda la fila en ese momento, garantizando que la evidencia histórica sea inmutable ante cambios de estructura.

**3. La tabla de auditoría también contendrá RFC. ¿Qué implica eso para su clasificación y su control de acceso?**
El RFC es un dato de identificación fiscal (Dato Personal). Al contenerlo, la tabla `auditoria.cambios_clientes` se clasifica como información **altamente sensible**. Por ello, se creó un esquema aislado (`auditoria`), se le revocaron los permisos al público (`REVOKE ALL ON SCHEMA auditoria FROM PUBLIC`) y solo el superusuario o un rol de auditoría exclusivo podrán consultarla.
