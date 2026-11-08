## Actividad 9
1. ¿Qué columna permite relacionar una sesión con sus líneas de bitácora?
La columna pid en pg_stat_activity es el número de proceso, y en la bitácora aparece en el prefijo como [PID] gracias al marcador %p. Es el identificador único de la sesión.

2. Después de que termina el reporte, ¿qué fuente conserva evidencia de que existió?
La bitácora cuando la sesión termina, pg_stat_activity elimina esa fila la bitácora conserva el registro histórico de la conexión, la sentencia y la desconexión.

3. ¿Por qué client_addr aparece vacío en la sesión del administrador?
Porque la sesión de administrador se conectó usando el socket local de Unix no a través de la red TCP/IP. El socket local no tiene dirección IP
