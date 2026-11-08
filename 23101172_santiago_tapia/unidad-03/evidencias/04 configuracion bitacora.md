04-configuracion-bitacora
## Actividad 4
1. ¿Por qué el proceso que registra el cambio es el principal y no tu sesión?
porque el unico que puede leer y aplicar los archivos de configuracion es el proceso inicial
cuando la sesión envía la señal de recarga, el proceso principal despierta, relee los archivos y es él quien escribe en el log que el valor ha cambiado para notificar al administrador. la sesión de usuario solo envía la petición.

2. ¿Qué pasaría si alguien ejecutara ALTER SYSTEM SET log_statement = 'none'? ¿Quedaría rastro?
si quedaria un regitro en la bitacora con el usuario la ip y de quien la ejecuto.

3. ¿Por qué no se recomienda editar postgresql.auto.conf a mano?
porque el ALTER SYSTEM esta diseñada para hacerlo de una forma mas segura y si editas el archivo de forma manual y se comete un error de sintaxis el servido puede fallar al arrancar o ignorar toda la configuracion y tambien da el aviso de que debe recargar.
