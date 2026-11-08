## Actividad 5
1. La bitácora registra el usuario app_ventas en el intento fallido. ¿Eso prueba que la aplicación de ventas intentó entrar? ¿Qué prueba realmente?
Prueba que alguien o algo envió una petición de conexión usando el nombre de usuario app_ventas y falló la contraseña. Como app_ventas es un rol compartido, podría haber sido un atacante, un script automatizado o un error de configuración de la aplicación real.

2. ¿Qué información adicional registra PostgreSQL cuando el rol no existe? ¿Por qué aparece en la bitácora y no en el mensaje que recibe el cliente?
"usuario_inexistente" does not exist.. Aparece en la bitácora para que el administrador sepa qué pasó, pero se oculta en la respuesta que recibe el cliente por seguridad. Esto evita que los atacantes puedan adivinar qué usuarios existen o no en el sistema.

3. ¿Por qué app=[unknown] en el intento fallido, pero app=app-ventas-web en la desconexión?
Porque el parámetro application_name se envía en el paquete de inicio de sesión, pero el proceso de autenticación (donde ocurre el fallo) se registra antes de que el servidor procese completamente los parámetros de la conexión. Además, en pgAdmin no estamos definiendo un application_name específico para los intentos fallidos.

4. ¿Qué patrón de varias líneas te haría sospechar de un ataque de fuerza bruta? Escribe la consulta que contaría los intentos fallidos por usuario.
Un patrón de múltiples líneas FATAL: password authentication failed para el mismo usuario en un corto período de tiempo desde la misma IP.
