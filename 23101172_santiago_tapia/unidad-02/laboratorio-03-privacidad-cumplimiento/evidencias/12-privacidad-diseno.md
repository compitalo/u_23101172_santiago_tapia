# Evidencia 12 — Privacidad por diseño

## Objetivo
Analizar la propuesta de diseño de una nueva tabla `clientes` bajo el enfoque "guardar todo
por si acaso" y proponer un diseño que aplique privacidad desde el origen.

## Procedimiento
1. Se revisó la definición propuesta por el desarrollador.
2. Se contrastó cada campo contra una finalidad de negocio.
3. Se identificaron campos sin justificación.
4. Se propusieron controles de privacidad por diseño y por defecto.

## Resultado

# Preguntas

## 1. ¿Qué problemas identificas?

Cantidad excesiva de datos requeridos por la tabla ademas de que muchos de ellos son datos sumamente sensibles sin tener una justificacion de porque son necesarios añadiendole que los tipos de los datos no vienen sin ninguna restriccion, validacion o clasificacion, otros datos como la fehca de nacimiento pueden ser utilizados para identifacar a los usuarios, tampoco parece tener ningun tipo de cifrado y la justificacion no es valida

## 2. ¿Qué principio de privacidad se está ignorando?

Minimizacion de datos y limitación de finalidad

## 3. ¿Qué preguntas realizarías antes de aprobar el diseño?

¿para quese utilizara cada dato?

¿quien tendra acceso a cada campo de la tabla?

¿se oueen cumplir la finalidad con menos datos?

## 4. ¿Qué datos eliminarías?

Ocupación, salario, estado_civil, dirección, fecha_nacimiento

## 5. ¿Qué datos requerirían una justificación adicional?

Rfc, dirección, fecha de nacimiento, Salario, ocupación y estado civil

## 6. ¿Cómo aplicarías privacidad por defecto?

Recopilar los datos unicamente necesarios ademas de solo solicitar datos como el RFC unicamente cuando sean necesarios.
