USE FitSyncManager; 

-- Creación de roles 

CREATE ROLE IF NOT EXISTS 'rol_administrador';
CREATE ROLE IF NOT EXISTS 'rol_recepcionista';
CREATE ROLE IF NOT EXISTS 'rol_entrenador';
CREATE ROLE IF NOT EXISTS 'rol_consulta';

-- =====================================================
-- PERMISOS DE ADMINISTRADOR 
-- =====================================================
GRANT ALL PRIVILEGES
ON FitSyncManager.*
TO 'rol_administrador';

-- =====================================================
-- PERMISOS DE RECEPCIÓN
-- =====================================================

-- Consultar y gestionar socios

GRANT SELECT, INSERT, UPDATE
ON FitSyncManager.SOCIO
TO 'rol_recepcionista';

-- Gestionar reservas

GRANT SELECT, INSERT, UPDATE
ON FitSyncManager.RESERVA
TO 'rol_recepcionista';

-- Consultar membresías y pagos 

GRANT SELECT, INSERT, UPDATE
ON FitSyncManager.MEMBRESIA
TO 'rol_recepcionista';

GRANT SELECT, INSERT, UPDATE
ON FitSyncManager.PAGO
TO 'rol_recepcionista';

-- Consultar horarios y clases 

GRANT SELECT
ON FitSyncManager.HORARIO
TO 'rol_recepcionista';

GRANT SELECT
ON FitSyncManager.CLASE
TO 'rol_recepcionista';

GRANT SELECT
ON FitSyncManager.SALA
TO 'rol_recepcionista';

-- =====================================================
-- PERMISOS DE ENTRENADORES 
-- =====================================================

-- Consultar sus clases y horarios  

GRANT SELECT
ON FitSyncManager.CLASE
TO 'rol_entrenador';

GRANT SELECT
ON FitSyncManager.HORARIO
TO 'rol_entrenador';

-- Consultar reservas

GRANT SELECT
ON FitSyncManager.RESERVA
TO 'rol_entrenador';

-- Consultar salas 

GRANT SELECT
ON FitSyncManager.SALA
TO 'rol_entrenador';

-- COnsultar y actualizar incidencias

GRANT SELECT, INSERT, UPDATE
ON FitSyncManager.INCIDENCIA
TO 'rol_entrenador';

-- =====================================================
-- PERMISOS DE CONSULTA 
-- =====================================================

GRANT SELECT
ON FitSyncManager.*
TO 'rol_consulta';

-- =====================================================
-- COMPROBACIÓN DE PERMISOS
-- =====================================================

SHOW GRANTS FOR 'rol_administrador';

SHOW GRANTS FOR 'rol_recepcionista';

SHOW GRANTS FOR 'rol_entrenador';

SHOW GRANTS FOR 'rol_consulta';
