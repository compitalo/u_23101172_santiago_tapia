## Actividad 6
1. ¿Qué tipo de evento es cada una de las tres primeras sentencias (privilegio o estructura)?
    REVOKE y GRANT son eventos de Privilegio o tambien dichos control de acceso y ALTER TABLE es un cambio en el esquema de la base de datos.

2. ¿Por qué GRANT y REVOKE quedan registrados con log_statement = 'ddl'?
Porque en PostgreSQL, los comandos de control de acceso (DCL - Data Control Language) se agrupan bajo la categoría ddl para efectos de la bitácora, ya que modifican la estructura de seguridad de la base de datos.

3. Si la bitácora contiene contraseñas, ¿quién debería poder leerla? Relaciónalo con la gestión de secretos de la Unidad II.
Únicamente el DBA o el rol de auditoría. Esto se relaciona directamente con la gestión de secretos: nunca se deben escribir contraseñas en texto plano en scripts SQL. Para crear usuarios, se debe usar el comando \password en psql o la interfaz gráfica de pgAdmin y en producción las credenciales deben rotarse mediante gestores de secretos.
