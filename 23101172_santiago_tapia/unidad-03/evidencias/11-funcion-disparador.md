## Actividad 11
1. ¿Por qué se ejecuta REVOKE ALL ON FUNCTION ... FROM PUBLIC si el disparador seguirá funcionando para app_ventas?
Porque REVOKE evita que un usuario pueda llamar a la función manualmente usando un SELECT auditoria.registrar_cambio_cliente(). El motor de PostgreSQL ejecuta el disparador internamente cuando detecta un cambio en la tabla, y para esas ejecuciones internas, los permisos de la función no son bloqueados por este REVOKE. Es una medida de seguridad para evitar que se inyecten registros falsos en la auditoría.

2. ¿Qué pasaría si la función no fuera SECURITY DEFINER?
Si fuera una función normal cuando app_ventas intentara hacer un UPDATE, la función intentaría insertar en la tabla auditoria.cambios_clientes. Como app_ventas no tiene permisos sobre el esquema auditoria, la función fallaría, y por lo tanto, el UPDATE completo se cancelaría y fallaría. SECURITY DEFINER le dice al motor: "Ejecuta esto con los permisos de mi dueño para que pueda escribir en la bóveda de auditoría".

3. Consulta dba.bitacora. ¿Quedó registrada la creación del esquema, la tabla, la función y el disparador? ¿Por qué?
Sí quedaron registrados porque en la actividad 7 cambiamos log_statement a 'mod'
