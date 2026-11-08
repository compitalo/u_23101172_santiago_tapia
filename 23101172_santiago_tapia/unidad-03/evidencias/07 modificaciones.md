07-modificaciones.md
## Actividad 7
1. ¿Qué nivel habría registrado la lectura del RFC? ¿Qué costo tendría en un servidor con miles de consultas por minuto?
El nivel all es el único que registra las lecturas (SELECT). El costo sería altísimo: el volumen de la bitácora crecería exponencialmente, consumiendo mucho espacio en disco, afectando el rendimiento del servidor y llenando la bitácora de información irrelevante o, peor aún, de datos sensibles.

2. ¿Qué le falta a esta bitácora para revertir el cambio con certeza?
A la bitácora le falta el valor anterior. La línea del log solo dice UPDATE clientes SET telefono = '6679990000' No nos dice cuál era el teléfono que tenía antes. Si alguien comete un error, no podemos saber qué valor restaurar.
