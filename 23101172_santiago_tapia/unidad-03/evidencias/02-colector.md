# Evidencia 1 - configuracion inicial de registro 

**Alumno:** Santiago Jassiel Tapia Valdez
**Fecha:** 7 de Noviembre de 2026
**Despliegue:** POSTGRESQL 16 en un contenedor docker con pgAdmin4 en Ubuntu.

##Resultado de la consulta de la actividad

| name | setting | source |
| :--- | :--- | :--- |
| log_connections | off | default |
| log_destination | stderr | default |
| log_directory | log | default |
| log_disconnections | off | default |
| log_filename | postgresql-%Y-%m-%d_%H%M%S.log | default |
| logging_collector | off | default |
| log_line_prefix | %m [%p] | configuration file |
| log_min_error_statement | error | default |
| log_statement | none | default |
| log_timezone | Etc/UTC | configuration file |

## Respuestas de la preguntas de la actividad 1

1. **¿se regista quien se conecta?**
no como se puede ver en la consulta puesta arriba el log_connections esta apagado por lo que el servidor no registra cuando se conecta un usuario ni cuando se desconecta.

2. **¿se registran las sentencias UPDATE?**
no, tampoco se registran debidido a que el log_statement esta en modo none por lo que ninguna sentencia SQL se registra

3. **¿La linea de bitacora incluye el usuario o la direccion IP del cliente?**
no ya que tiene la configuracion predeterminada solo incluye la fecha y el PID del proceso

4. **¿En qué zona horaria se registran los eventos? ¿Por qué importa?**
en la configuracion esta en Etc/UTC y este dato importa al momento de investigar algun incidente al momento de construir una cronologia exacta.

5. **Con `logging_collector = off`, ¿quién decide dónde termina la bitácora?**
en mi caso al ya que esta en un docker ademas de estar en off postgres lo manda en texto y docker captura la salida y la guarda dentro del propio sistema de los logs y debido a esto la bitacora no esta en un archivo que el DBA controle y corre el riesgo de que pueda perder la informacion o leer usando sql

## Conclucion
en la configuracion actual el sistema cuenta con multiples fallas si el usuario decea hacer una auditoria.
