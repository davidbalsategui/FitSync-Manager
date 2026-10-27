/*

OBJETIVO:
Comprobar el estado general de la base de datos FitSync Manager y detectar
posibles problemas de estructura o integridad de los datos.

CONTENIDO:
- Consultar las tablas existentes.
- Comprobar que las tablas principales están creadas.
- Revisar las claves primarias y foráneas.
- Detectar registros que puedan incumplir las reglas de integridad.
- Comprobar posibles reservas duplicadas.
- Revisar socios, membresías y pagos para detectar inconsistencias.

CONSIDERACIONES:
- Las consultas de diagnóstico deben ser de solo lectura siempre que sea
  posible.
- No modificar ni eliminar datos durante las comprobaciones.
- Diferenciar entre una comprobación correcta y un problema detectado.

RESULTADO ESPERADO:
Obtener información útil para verificar que la base de datos funciona
correctamente y localizar errores antes de realizar otras operaciones.

*/