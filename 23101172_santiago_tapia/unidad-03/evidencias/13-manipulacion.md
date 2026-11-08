## Actividad 13
1. ¿Qué evidencia permite detectar que hubo un cambio sin auditar?
La bitácora del servidor Aunque el administrador desactivó el trigger para que no se registrara en auditoria.cambios_clientes, el motor de PostgreSQL siguió registrando la sentencia UPDATE y, sobre todo, los comandos ALTER TABLE DISABLE TRIGGER en su archivo de log.

2. ¿Qué control administrativo (no técnico) reduciría este riesgo?
El principio de Separación de Funciones el DBA que tiene privilegios para modificar la tabla clientes no debería ser el mismo que tiene permisos para leer y custodiar la bitácora. Además, las organizaciones envían los logs a un servidor externo (SIEM) en tiempo real, al cual el DBA no tiene acceso de escritura ni de borrado.

3. Relaciona esta actividad con el principio de separación de funciones de la Unidad II.
En la Unidad II vimos que no se debe dar todos los permisos a un solo usuario. Aquí se aplica igual, pero para la auditoría. Si el administrador tiene control total de la base de datos y de su bitácora, la auditoría no sirve contra él. La evidencia debe estar custodiada por un área diferente.
