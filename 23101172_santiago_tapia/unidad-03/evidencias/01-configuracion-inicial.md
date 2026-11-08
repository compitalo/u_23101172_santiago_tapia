
1. **¿Por qué logging_collector requiere reinicio y log_statement solo recarga?**
Porque logging_collector implica iniciar un nuevo proceso en segundo plano que intercepta la salida de error del servidor. Un proceso no puede aparecer mágicamente solo con releer un archivo de configuración; hay que reiniciar el motor para que el sistema operativo inicie el nuevo proceso y log_statement solo cambia una regla de "filtrado" dentro de los procesos que ya están corriendo, por lo que basta con recargar la configuración.

2. **¿Qué ventaja tiene que la bitácora se lea con SQL y no con una herramienta del sistema operativo o del contenedor? ¿Qué riesgo introduce?**
Ventaja: La consulta SQL funciona exactamente igual sin importar si PostgreSQL está instalado en Windows, Linux o dentro de un contenedor Docker como en mi caso. No dependes de comandos como docker logs o tail que cambian según el sistema. Además, puedes hacer cruces de datos usando JOIN con otras tablas de la base.
Riesgo: La función pg_read_file permite leer cualquier archivo al que el usuario de PostgreSQL tenga acceso en el servidor y por eso está restringida a superusuarios; si se otorga a un usuario malicioso, podría espiar el sistema operativo.

3. **¿Quién debería poder consultar dba.bitacora?**
Únicamente el DBA o un rol de auditoría estrictamente separado. La bitácora puede contener direcciones IP, nombres de usuarios, consultas SQL con datos personales y hasta contraseñas en texto claro. Ningún rol de aplicación debería tener acceso al esquema dba.
