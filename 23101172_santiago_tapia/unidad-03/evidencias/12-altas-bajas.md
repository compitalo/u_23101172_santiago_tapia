## Actividad 13
1. El cliente Pedro Ruiz ya no existe en clientes. ¿Dónde queda evidencia de que existió y de sus datos?
Queda grabada permanentemente en el evento 3 de auditoria.cambios_clientes. El campo valores_antes guardó un documento JSON con toda la fila de Pedro Ruiz (nombre, correo, RFC, edad, ciudad) justo antes de ser eliminado. Si hubiera una investigación forense, la auditoría actúa como una "copia de seguridad histórica" de los datos borrados.

2. ¿Por qué ip_cliente está vacía en los eventos 2 y 3?
en mi caso debido a que estoy utilizando un docker si me aparecen ip de ambos eventos pero si estuviera conectado directamente por la terminal dentro del contenedor la conexión se hace por el socket local del propio servidor. inet_client_addr() devuelve nulo en conexiones locales porque no viajan por la red física.

3. La política de retención de la Unidad II pedía eliminar datos cuando ya no fueran necesarios. ¿Qué conflicto aparece? ¿Quién debe resolverlo?
Aparece un conflicto legal y ético muy común en la era del dato: el "Derecho al Olvido" vs. la "Obligación de Auditar". Por un lado, la ley de protección de datos puede exigir borrar la información personal de las bases de datos cuando el cliente fallece o cancela la relación comercial. Por otro lado, las normas de auditoría exigen conservar la evidencia durante años para investigaciones fiscales o penales.
¿Quién lo resuelve? Lo debe resolver un comité de gobernanza de datos la solución técnica suele ser anonimizar los datos en la tabla de auditoría después de cierto tiempo en lugar de borrar el registro de auditoría por completo.
