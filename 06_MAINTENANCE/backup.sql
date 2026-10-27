/*

OBJETIVO:
Documentar y preparar el procedimiento para realizar copias de seguridad
de la base de datos FitSync Manager.

CONTENIDO:
- Indicar qué base de datos se va a respaldar.
- Documentar cómo exportar la estructura de las tablas.
- Documentar cómo exportar los datos almacenados.
- Explicar cómo guardar la copia de seguridad en un archivo externo.
- Indicar las precauciones para no sobrescribir copias anteriores.

CONSIDERACIONES:
- En MySQL, las copias completas suelen realizarse mediante herramientas
  como mysqldump o MySQL Workbench.
- Un archivo SQL con comentarios no genera por sí solo una copia de seguridad.
- La copia debe almacenarse fuera de la base de datos original.

RESULTADO ESPERADO:
Disponer de una copia recuperable de la estructura y los datos de la base
de datos FitSync Manager.

*/