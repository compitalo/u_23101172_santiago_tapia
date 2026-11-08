## Actividad 3
1. **¿Puedes demostrar quién modificó el RFC?**
No tenemos forma nisiquiera de saber que hubo una modificacion por parte de la bitacora

2. **¿Puedes demostrar que el cambio no lo hizo soporte_ana?**
No. Al no haber bitácora de accesos ni de sentencias, es imposible saber cual de los usuarios que tengan los privilegios adecuados fue el responsable. Cualquiera con acceso a la contraseña de app_ventas o al servidor pudo haberlo hecho.

3. **Los privilegios de la Unidad II, ¿impidieron el cambio? ¿Debían impedirlo?**
No lo impidieron. El rol app_ventas tiene el privilegio UPDATE sobre la tabla clientes. No debía impedirlo, porque es una función legítima de la aplicación de ventas actualizar datos de clientes. El control de acceso funcionó perfectamente; lo que falló fue la auditoría.

4. **¿Qué tendría que haber estado configurado antes del incidente?**
Tendrían que haber estado activos parámetros como log_connections = on, log_disconnections = on y log_statement = 'mod' o 'all'. Además el log_line_prefix debería incluir la IP (%h) y la aplicación (%a).
