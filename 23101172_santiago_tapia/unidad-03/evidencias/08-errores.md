## Actividad 8
1. ¿El intento de soporte_ana causó algún daño? ¿Por qué debe auditarse de todos modos?
No causó daño porque el sistema de permisos lo bloqueó pero debe auditarse obligatoriamente porque es un indicador de comportamiento anómalo o malicioso. Un usuario que intenta borrar datos sin permiso puede ser un empleado descontento, un atacante que robó la cuenta o un error grave de la aplicación. La auditoría permite detectar intentos de escalada de privilegios antes de que tengan éxito.

2. ¿Qué diferencia hay entre un error de autorización (esta actividad) y uno de autenticación (Actividad 5)?
El usuario no pudo entrar al sistema. Es un error en la puerta de entrada.

El usuario ya entró correctamente pero el motor le denegó una acción específica porque su rol no tiene los privilegios.

3. ¿Qué indica el error de DROP ROLE sobre el orden correcto para dar de baja a un usuario?
Indica que PostgreSQL protege la integridad referencial. Antes de eliminar un rol, el administrador debe hacer una "limpieza": revocar todos sus privilegios, reasignar los objetos de los que sea dueño y terminar sus sesiones activas. Solo entonces el DROP ROLE funcionará.
