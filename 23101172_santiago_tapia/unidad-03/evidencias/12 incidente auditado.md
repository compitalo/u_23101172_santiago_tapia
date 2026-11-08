12-incidente-auditado.md
## Actividad 12

1. Compara tu hipótesis de la Actividad 11 con este resultado.
Sin SECURITY DEFINER, el UPDATE de app_ventas fallaría porque no tiene permisos en el esquema auditoria.
Resultado: Se confirma. Al ser SECURITY DEFINER, el motor permitió escribir en la bóveda de auditoría "por debajo de la mesa". Si no lo fuera, el cambio de RFC habría fallado con un error de permisos.

2. Escribe la sentencia UPDATE que restauraría el valor anterior.

UPDATE clientes SET rfc = 'GAMA780912XYZ' WHERE id = 3;

3. ¿Qué columna conserva más valor para una investigación: aplicacion o ip_cliente? ¿Cuál puede falsificar el cliente con más facilidad?
la que tiene mas valor a la hora de hacer una investigacion es ip_cliente. A menos que el atacante use una VPN o esté dentro de la misma red interna, la IP identifica el equipo físico o la red desde donde se conectó y la mas facil de falsificar seria aplicacion. El parámetro application_name lo envía el propio cliente (quien se conecta). Cualquiera puede conectarse usando psql y decir que de parte de la aplicacion de ventas enviando application_name='app-ventas-web'. La aplicación es un indicio, no una prueba forense fuerte.
