1. Si clientes tuviera un millón de registros, ¿qué ocurriría con la auditoría tras un UPDATE sin WHERE?
Ocurriría una explosión de volumen. El trigger se dispararía un millón de veces insertando un millón de registros con sus respectivos JSON en la tabla auditoria.cambios_clientes. Esto consumiría gigabytes de disco, haría que la transacción tardara muchísimo en completarse y podría llenar el disco del servidor, tumbando la base de datos.

2. Propón quién podría autorizar la depuración de auditoria.cambios_clientes.
La depuración de la auditoría nunca debe ser autorizada por el DBA que opera la base de datos, ni por el área de TI. Debe ser autorizada por un comité de Gobernanza de Datos, Auditoría Interna o el Oficial de Privacidad (DPO), basándose en las políticas de retención de la empresa La separación de funciones exige que quien opera no sea quien borra la evidencia.

3. ¿Por qué log_statement = 'all' puede convertir la bitácora en un nuevo depósito de datos sensibles?
Porque all registra absolutamente todas las sentencias, incluyendo los SELECT. Si un usuario busca a un cliente esa sentencia queda escrita en el log con el RFC en texto plano. Si además se leen contraseñas o datos médicos, la bitácora se convierte en un archivo gigante lleno de Información Personal Identificable violando las leyes de protección de datos y siendo un blanco atractivo para atacantes.
