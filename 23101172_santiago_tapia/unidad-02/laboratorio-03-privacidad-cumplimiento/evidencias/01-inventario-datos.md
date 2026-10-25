# Actividad 1

## Objetivo
Identificar qué campos de la tabla `clientes` son datos personales, asignarles una
finalidad, justificar su necesidad y proponer un nivel de acceso y un periodo de retención.

## Procedimiento
1. Se inspeccionó la estructura de la tabla con `\d+ clientes`.
2. Se clasificó cada campo según si identifica o hace identificable a una persona física.
3. Se contrastó cada campo contra los procesos de negocio (atención, facturación, analítica).
4. Se asignó nivel de acceso y retención propuestos.

| Campo | Es dato personal | finalidad | Es necesario | Nivel de acceso | Retención |
|---|---|---|---|---|---|
| Id | No | Identificar registros en la base de datos | si | Administrador del sistema | Mientras exista el registro |
| Nombre | si | Identificar al cliente | si | Personal autorizado | Mientras dure la relación comercial |
| Correo | si | Contactar al cliente | si | Personal autorizado | Mientras dure la relación comercial |
| Teléfono | si | Contactar al cliente | si | Personal autorizado | Mientras dure la relación comercial |
| Rfc | si | Facturación y impuestos | si | Finanzas | Según obligaciones fiscales |
| Edad | si | Segmentación o validación de mayoría de edad | Depende | Personal autorizado | Mientras sea necesaria |
| Cuidad | si | Análisis geográfico y para envíos | Si | Personal autorizado | Mientras dure la relación comercial |
| Código postal | si | Ubicación para envíos | Depende | Personal autorizado | Mientras sea necesaria |
| Fecha alta | si | Historial de datos | Si | Administrador del sistema | Mientras exista el registro |

## Justificación

la id es necesaria para poder identificar un resgistro dentro de una base de datos ya que es un valor unico para cada uno por lo cual debemos mantenerlo mientras el registro siga existiendo

tanto el nombre como el correo y el telefono son necesarios al momento de dar atencion al cliente para poder identificar que el usuario al que se esta atendiendo sera realmente el y no alguna persona que se este haciendo pasar por el por lo que mientras el usuario solicite los servicios de la compañía es necesario mantener la informacion

el RFC es necesario para poder hacer las obligaciones fiscales por lo que se mientras estas continuen se debe de mantener el dato

la edad puede tener 2 situaciones ya que puede ser solo para poder verifiacar que el usuario cumple con el requisito o la otra situacion que seria para poder hacer un perfil comun para los usuarios ver de que edad a que edad es mas normal que los usuarios requieran de los servicios de la empresa por lo que debe de ser mantenida hasta que el dato sea innecesario

tanto la ciudad como el codigo postal sirven para poder tener una estadisitica de en que region es mas solicitado el servicio que la empresa este ofreciendo y el codigo postal ademas si la empresa cuenta con envios a domicilio es necesario para poder completar estos envios y se deben de mantener hasta que el usuario deje de solicitar los servicos de la empresa

la fecha de alta debe de mantenerse para poder tener un historial de datos y que quede registrado cuando se añadio al sistema
