# Evidencia 11 — Matriz de gobierno de datos

## Objetivo
Demostrar que el acceso a cada dato se relaciona con una necesidad funcional y que existe un
responsable identificable para cada uno.

## Procedimiento
1. Se partió del inventario de datos (evidencia 01).
2. Se asignó un data owner por dominio funcional.
3. Se determinaron los usuarios autorizados por necesidad de negocio.
4. Se definió protección, retención y acción al finalizar para cada campo.

## Resultado


| Dato          | Finalidad                                    | responsable         | Usuarios autorizados           | Protección                  | Retención                                | Acción al finalizar      |
|---------------|----------------------------------------------|---------------------|--------------------------------|-----------------------------|------------------------------------------|--------------------------|
| Nombre        | Identificar al cliente                       | Atención al cliente | Atención al cliente            | Control de acceso           | Mientras exista relación comercial       | Eliminar o anonimizar    |
| Correo        | Comunicación con el cliente                  | Atención al cliente | Atención al cliente            | Control de acceso y cifrado | Mientras exista relación comercial       | Eliminar                 |
| Teléfono      | Comunicación con el cliente                  | Atención al cliente | Atención al cliente            | Control de acceso y cifrado | Mientras exista relación comercial       | Eliminar                 |
| Rfc           | Obligaciones fiscales                        | Facturación         | Facturación                    | Control de acceso y cifrado | Según los requisitos fiscales            | Eliminar                 |
| Edad          | Segmentación o validación de mayoría de edad | Analítica           | Analítica                      | Acceso restringido          | Mientras sea necesaria para la finalidad | anonimizar               |
| Ciudad        | Análisis geográfico y para envíos            | Analítica           | Analítica                      | Control de acceso           | Mientras sea necesaria para la finalidad | Anonimizar               |
| Código postal | Análisis geográfico y para envíos            | Analítica           | Analítica, Atención al cliente | Control de acceso           | Mientras sea necesaria para la finalidad | Generalizar o anonimizar |
