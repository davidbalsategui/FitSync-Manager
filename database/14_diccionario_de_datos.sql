USE FitSyncManager; 

-- Información general sobre las tablas 

SELECT
    TABLE_NAME AS nombre_tabla,
    TABLE_TYPE AS tipo_tabla,
    ENGINE AS motor,
    TABLE_COLLATION AS codificacion
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'FitSyncManager'
ORDER BY TABLE_NAME;

-- Información sobre las columnas

SELECT
    TABLE_NAME AS nombre_tabla,
    COLUMN_NAME AS nombre_columna,
    COLUMN_TYPE AS tipo_dato,
    IS_NULLABLE AS permite_nulos,
    COLUMN_DEFAULT AS valor_por_defecto,
    COLUMN_KEY AS tipo_clave,
    EXTRA AS informacion_adicional,
    COLUMN_COMMENT AS comentario
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'FitSyncManager'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- Claves primarias (PK) 

SELECT
    TABLE_NAME AS nombre_tabla,
    COLUMN_NAME AS columna,
    CONSTRAINT_NAME AS nombre_restriccion
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'FitSyncManager'
AND CONSTRAINT_NAME = 'PRIMARY'
ORDER BY TABLE_NAME;

-- Claves foráneas (FK) y relaciones 

SELECT
    TABLE_NAME AS tabla_origen,
    COLUMN_NAME AS columna_origen,
    REFERENCED_TABLE_NAME AS tabla_referenciada,
    REFERENCED_COLUMN_NAME AS columna_referenciada,
    CONSTRAINT_NAME AS nombre_restriccion
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'FitSyncManager'
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

-- Restricciones de las tablas

SELECT
    TABLE_NAME AS nombre_tabla,
    CONSTRAINT_NAME AS nombre_restriccion,
    CONSTRAINT_TYPE AS tipo_restriccion
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'FitSyncManager'
ORDER BY TABLE_NAME, CONSTRAINT_TYPE;

-- Índices de la BD 

SELECT
    TABLE_NAME AS nombre_tabla,
    INDEX_NAME AS nombre_indice,
    COLUMN_NAME AS columna,
    NON_UNIQUE AS no_es_unico,
    INDEX_TYPE AS tipo_indice
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'FitSyncManager'
ORDER BY TABLE_NAME, INDEX_NAME;

-- Restricciones check 

SELECT
    tc.TABLE_NAME AS nombre_tabla,
    tc.CONSTRAINT_NAME AS nombre_restriccion,
    cc.CHECK_CLAUSE AS condicion
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.CHECK_CONSTRAINTS cc
    ON tc.CONSTRAINT_SCHEMA = cc.CONSTRAINT_SCHEMA
    AND tc.CONSTRAINT_NAME = cc.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_SCHEMA = 'FitSyncManager'
AND tc.CONSTRAINT_TYPE = 'CHECK'
ORDER BY tc.TABLE_NAME;



