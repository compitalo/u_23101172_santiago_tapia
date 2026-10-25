# Evidencia 15 — Propuesta de arquitectura de datos protegidos

## Objetivo
Traducir los principios de privacidad en una arquitectura conceptual que separe los datos
según su finalidad e incorpore controles en cada capa.

## Procedimiento
1. Se identificaron las finalidades (operación, fiscal, analítica, marketing).
2. Se separaron los datos por finalidad en esquemas distintos.
3. Se asignaron roles y controles por cada zona.
4. Se incorporaron controles transversales (catálogo, consentimientos, retención, auditoría).

## Resultado — Propuesta

## Controles por dimensión

| Dimensión | Control |
|---|---|
| **Acceso** | Roles funcionales (`atencion_cliente`, `facturacion`, `analista`, `auditor`, `dba`); `REVOKE ALL FROM PUBLIC`; RLS por territorio si aplica; revisión trimestral de privilegios. |
| **Minimización** | Cada esquema contiene solo los campos de su finalidad; vistas con columnas mínimas; `edad` nunca exacta fuera de operación; CP truncado en analítica. |
| **Protección de información sensible** | Cifrado en reposo (discos cifrados / TDE) y en tránsito (TLS); privilegios a nivel columna para `rfc`; enmascaramiento en vistas y reportes; MFA para roles con acceso a datos fiscales. |
| **Retención** | Plazos por conjunto documentados; jobs programados de purga; ventana de respaldos definida; política revisada anualmente. |
| **Trazabilidad** | `pgaudit` sobre accesos a datos personales; logs centralizados e inmutables; alertas sobre accesos anómalos; bitácora de solicitudes ARCO. |
| **Eliminación** | Procedimiento que cubre tabla maestra, derivadas, réplicas, exports y notificación a encargados; verificación posterior; registro de la operación. |
| **Atención de solicitudes** | Consultas predefinidas y aprobadas para acceso/rectificación; flujo de autorización; constancia de ejecución; comunicación al titular por el área de privacidad. |
| **Seudonimización** | Identificadores con hash con sal para marketing y analítica; tablas de mapeo separadas y con acceso restringido. |
