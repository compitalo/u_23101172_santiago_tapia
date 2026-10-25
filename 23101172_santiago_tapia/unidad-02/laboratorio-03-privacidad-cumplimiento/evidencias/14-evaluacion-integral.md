# Evidencia 14 — Evaluación integral de riesgos

## Objetivo
Identificar al menos 10 problemas o riesgos de privacidad y cumplimiento en el escenario
descrito, asociarlos a un principio y proponer un control.

## Procedimiento
1. Se descompuso el escenario en hechos verificables.
2. Cada hecho se asoció a un principio de privacidad o seguridad.
3. Se derivó el riesgo y se propuso un control técnico o administrativo.

## Resultado

# Actividad 14

| Problema                                                                                  | Principio afectado           | riesgo                                            | Control propuesto                                  |
|-------------------------------------------------------------------------------------------|------------------------------|---------------------------------------------------|----------------------------------------------------|
| Todos los analistas tienen acceso a la tabla completa de clientes                         | Minimización de acceso       | Acceso a datos que no necesitan para su trabajo   | Aplicar control de acceso basado en roles          |
| Los analistas pueden ver nombre, correo, teléfono y RFC, aunque solo generan estadísticas | Minimización de datos        | Exposición innecesaria de datos personales        | Proporcionar vistas anonimizadas o agregadas       |
| La información se conserva durante 12 años sin justificación                              | Limitación de conservación   | Acumulación de datos innecesarios                 | Definir periodos de retención documentados         |
| No existe política de retención                                                           | Responsabilidad              | Eliminación inconsistente y conservación excesiva | Crear y documentar una política de retención       |
| Los desarrolladores reciben copias completas de la base de datos                          | Privacidad desde el diseño   | Exposición masiva de datos personales             | Utilizar datos ficticios o anonimizados en pruebas |
| Las bases de desarrollo contienen datos reales                                            | Seguridad y confidencialidad | Fuga de información en entornos menos protegidos  | Seudonimizar o anonimizar los datos                |
| No hay documentación de la finalidad de cada dato                                         | Limitación de finalidad      | Uso indebido de la información                    | Documentar la finalidad de cada campo              |
| Marketing utiliza correos electrónicos sin finalidad claramente documentada               | Transparencia y finalidad    | Posible uso no autorizado de datos personales     | Definir y registrar la finalidad de marketing      |
| Se almacena información identificable para generar estadísticas                           | Minimización de datos        | Riesgo de reidentificación y exposición           | Utilizar datos agregados o anonimizados            |
